From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there some way to suppress Cc email only to stable?
Date: Mon, 09 Feb 2015 12:57:11 -0800
Message-ID: <xmqq386eby6w.fsf@gitster.dls.corp.google.com>
References: <20150209194224.GA27482@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mingo@kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 21:57:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKvOQ-0003c1-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 21:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759674AbbBIU5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 15:57:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759332AbbBIU5O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 15:57:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C465F35451;
	Mon,  9 Feb 2015 15:57:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kb1eoUC7R3y345QYxB/NdPFbs1A=; b=ldpdz1
	boVLvkzagYUidjD1ocKjjvcjTvLZzKSKDc2FqkWoBk7xxRGGUS39PgcZiq9I3D28
	AdURdLp8VTWjBsBF25pMUzQPGgn+zq0BFjOQchymSbWgmNe9lu0gVu8Mx3js7uf9
	09Qk1Qfhf29Jp4SD6pn1+gmPxKctfV59z2WSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kHmhe4pRqTuTChpHKHq72d39XaH/Caq5
	aijvqPqeMpJlp3jdCjT940F21tMvI0x0KX8nYSAbA4U4UHcSDiZi/h5f6zOale3c
	MfXS7KJ/NS/HiaVKC6uQiCiDNKPwdIg6UzY2T5P5idxF7M/HP2MujkQ6rcCe92a3
	UP2Pzhl9gEE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC58235450;
	Mon,  9 Feb 2015 15:57:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE72B35449;
	Mon,  9 Feb 2015 15:57:12 -0500 (EST)
In-Reply-To: <20150209194224.GA27482@linux.vnet.ibm.com> (Paul E. McKenney's
	message of "Mon, 9 Feb 2015 11:42:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 38812050-B09E-11E4-BE30-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263597>

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:

> I need to be able to put the following Cc in a git commit:
>
> Cc: <stable@vger.kernel.org>
>
> Yet I cannot allow git-send-email to actually send email to that address,
> lest I get an automated nastygram in response.  I found the --to-cmd=
> option to git-send-email, but it looks to only add email addresses, never
> delete them.  I also found the --suppress-cc= option to git-send-email,
> but it appears to suppress all Cc emails, not just selected ones.
>
> One approach that occurred to me is to hand-edit the files produced
> by git-format-patch, removing stable@vger.kernel.org entirely prior to
> using git-send-email.  However, this is a bit error-prone.  Yes, I could
> script it, but with my luck, I will eventually end up having my script
> mangle some patch, for example to the Linux kernel's MAINTAINERS file.
> Furthermore, this approach means that people reviewing the patches
> cannot see the Cc stable entries (though I could presumably comment them
> out somehow).
>
> Another approach is to add the stable Ccs just before doing the pull
> request, by my upstream maintainer is not fond of that approach.  Nor am
> I, as it would be all to easy to forget to add the stable Ccs.  Or to
> get them wrong.
>
> I can't be the only person wanting to do something like this.  So is
> there some git option that I am missing here?

No, I do not think we have a way to blacklist certain recipient
addresses from getting passed to the MTA, and I do not object to
addition of such a mechanism if there is a valid need to do so.

It feels a bit too convoluted to say "Cc: to this address" in the
log message and then "nonono, I do not want to send there", though.
Why do you want to have Cc: in the log message if you do not want to
send e-mail to that address in the first place?  Allowing the
behaviour you are asking for would mean that those who see that the
commit appeared on a branch would not be able to assume that the
patch has already been sent to the stable review address, no?
