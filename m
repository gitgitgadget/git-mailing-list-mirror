From: Junio C Hamano <gitster@pobox.com>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up
 hard right after logging in)
Date: Fri, 13 May 2011 11:48:54 -0700
Message-ID: <7vliya77xl.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com>
 <BANLkTikMeyRTOB9q4PEAYWnZRZfk3wg=kQ@mail.gmail.com>
 <BANLkTi=dL+KyQ3Bm58_Uj4LP9WSpbzAfJA@mail.gmail.com>
 <BANLkTi=NdVUUZ=_bACzyeMGS3JWs0EMbWA@mail.gmail.com>
 <BANLkTimE2GkkhcFZtNrYZASWp0LDhUx=GQ@mail.gmail.com>
 <BANLkTinyzBnksHk_rt8K2pmg90q5WyZX3w@mail.gmail.com>
 <BANLkTinVT=9+-HhwXcyLBwrnhX9F9Qz3ww@mail.gmail.com>
 <4DCD79A0.7000500@kdbg.org>
 <BANLkTi=smoaARKyzWxFjid-E7qehmyAX8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Andrew Lutomirski <luto@mit.edu>,
	Christian Couder <christian.couder@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	git@vger.kernel.org, Shuang He <shuang.he@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 13 20:49:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKxQQ-0003H4-IL
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 20:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757765Ab1EMStR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 14:49:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab1EMStQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 14:49:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D67CE5715;
	Fri, 13 May 2011 14:51:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=42J//DOyVgyffWp3BxckUOHouvs=; b=aGjYKR
	k72PIqi0CrplYea1mQkA2Y7GhlpInF5AbUjSxGgCYftNG0WMPC5RGkxcH7RfOWTR
	CDoUIrV4/bqM9WC1KRFph9uU8Wf5qwKTj/ZazDsEefiR5e5WrVe8jfcUCJQ5DZNi
	jVbPikqNk7Do9JS/5fnNRr6PdG5veICqS5V8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HjSxq2gTFm8yUgEQSuIBmZ2KHElsB7HN
	bF8D1Hkb/zVP6srHISs1bBmEm0T6xBB6ademaSJ16BFb/clvNsQAOauSu8lhWlaA
	7NrKM8LYtj+0xPZkwwe1SB1I5EzgERPuJftC6foE9OKuICDrMIODFRsU1VzSsixc
	3ijjVhFuEeI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A5FA5711;
	Fri, 13 May 2011 14:51:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 340AD5710; Fri, 13 May 2011
 14:51:00 -0400 (EDT)
In-Reply-To: <BANLkTi=smoaARKyzWxFjid-E7qehmyAX8w@mail.gmail.com> (Linus
 Torvalds's message of "Fri, 13 May 2011 11:41:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F86D10F2-7D91-11E0-8636-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173561>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> When you say that v2.6.38 is good, that means that everything that can
> be reached from 2.6.38 is good.
>
> NOT AT ALL the same thing as "git bisect requires v2.6.38" would be.
>
> The "requires v2.6.38" would basically say that anything that doesn't
> contain v2.6.38 is "off-limits". It's fine to call them "good", but
> that's not the same thing as "git bisect good v2.6.38".
>
> Why?
>
> Think about it. It's the "reachable from v2.6.38" vs "cannot reach
> v2.6.38" difference. That's a HUGE difference.

Could you please clarify "off-limits"?

Do you mean "anything before v2.6.38 did not even have this feature, so
the result of testing a version in that range does not give us any
information"?  The feature didn't even exist, so a bug can never trigger,
and seeing "good" from such a version does not mean everything reachable
from it is good?  Upon seeing "bad" result from a version before v2.6.38,
what can we conclude?  The breakage cannot possibly come from the feature
that is being checked, so the procedure to check itself is busted?
