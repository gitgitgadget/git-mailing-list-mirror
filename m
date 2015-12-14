From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bisect with temporary commits
Date: Mon, 14 Dec 2015 13:17:03 -0800
Message-ID: <xmqqegeoivcg.fsf@gitster.mtv.corp.google.com>
References: <20151214163726.GY13519@tonks> <87si34hphr.fsf@igel.home>
	<20151214210936.GD14788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Florian Bruhin <me@the-compiler.org>, git@vger.kernel.org,
	r.seitz@beh.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:17:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8aUa-0004Nn-VG
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbbLNVRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:17:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753498AbbLNVRG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:17:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5337234D5E;
	Mon, 14 Dec 2015 16:17:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gB8byOy9b5E1j0TUiZ4UeAOOGSQ=; b=u586gK
	yOJXXdL/HuiHLvTMjtVAri5/zIcjauvmVx3Ke2pM7F2Hbsy780NU+00vcK7G7gJd
	ccJgHsxQLfOM56/kZe1UAc24fsxgq8K4o425nzWrhllKqcgOMnrua9YIdQzQIA1K
	3MZ5MIJTEZGZR2iUJUag4SqvBIjNA1fj6G08M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y75JhoSSo0huGfclsIHYzfsFFOe8M5jm
	JG+N0aeEs5tlWvAYT0so4oxFVxSfyvbw+L7mCTH1r9S+Ukb4OnILHAcEfi1qHymb
	FqfpWJra1aW6MR+KO9A6IxYOnT/IsmJ0akTSjzKLp6mL5bjC8q7EnyXGkh9R1Jwk
	g7ORYDm5fwc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AF6134D5D;
	Mon, 14 Dec 2015 16:17:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 916B334D5C;
	Mon, 14 Dec 2015 16:17:04 -0500 (EST)
In-Reply-To: <20151214210936.GD14788@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 14 Dec 2015 16:09:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 06318C46-A2A8-11E5-8D00-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282419>

Jeff King <peff@peff.net> writes:

>> You should instead tell git that HEAD^ is good, since that is what git
>> asked you to test.
>
> Another alternative is to use "git cherry-pick -n" to create a working
> tree state that you can test, but leave HEAD at the original commit.
> Then "git bisect good" does the right thing.

I was about to say the same, and "bisect good" at that point does
mark the correct commit, but does it always do the right thing?  I
think the procedure must be

	git cherry-pick -n $the_fixup
        test
        git reset --hard
        git bisect good (or bad)

for it to always work, which is not all that different from

	git cherry-pick $the_fixup
        test
        git reset --hard HEAD^
        git bisect good (or bad)
