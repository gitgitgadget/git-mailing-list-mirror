From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git auto-repack is broken...
Date: Fri, 02 Dec 2011 09:35:52 -0800
Message-ID: <7vobvqoozr.fsf@alter.siamese.dyndns.org>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 02 18:36:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWX1k-0002RY-Fg
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 18:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214Ab1LBRf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 12:35:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757170Ab1LBRfz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 12:35:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3D215E2B;
	Fri,  2 Dec 2011 12:35:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0gSS/8kv2RqyOHbQGkbtEpy0pFc=; b=AG6roh
	PPpgEyDx1S9ABNn3jKNI7lzCyUxQJzPw9YARzGnVHfkbnqAirJ++CjIhBKbO+4Sh
	IXNUUmSCLJg4X8ML/POmu8m+484NI5Mnm/H/Q2ZE9QnIid9eQ1fRiKSi66N1AUkN
	fUw2GnPkyVtCxa5ONVTk8IGnprEn6a+ywQPB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yIH7CvaVPrIO3/tTRYDlHhPCtIRSLRl/
	9u9GBVRRA0iaWPhuhXgicAj+2ggwaXYBcYxB2ZR/UW5Z0m+HVXXLkwFR7U3LUIyq
	FOJ50ury5WPn1/m31uctcMApMRTowqU83txrCC7TPnAmCwBfPwESaJdDE4ESGFv0
	E8l6empj4cE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB1535E2A;
	Fri,  2 Dec 2011 12:35:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C91E5E29; Fri,  2 Dec 2011
 12:35:54 -0500 (EST)
In-Reply-To: <20111202171017.GB23447@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 2 Dec 2011 12:10:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15EE91AE-1D0C-11E1-B4E4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186232>

Jeff King <peff@peff.net> writes:

> When the objects become unreferenced, we eject them from the pack into
> loose form again. If they don't become referenced in the 2-week window,
> they get pruned then. So yes, you drop the age information, but they do
> eventually go away.

If you update gc/repack -A to put them in a separate pack, then you would
never be able to get rid of them, no? You pack, then eject (which gives
them a fresher timestamp), then notice that you are within the 2-week window
and pack them again,...
