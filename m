From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: Add auto-cc to all body signatures
Date: Thu, 08 Dec 2011 11:37:07 -0800
Message-ID: <7v8vmmj1ng.fsf@alter.siamese.dyndns.org>
References: <b2937bc06d1bff456b84e51d6edee0bb1afc5f31.1311902983.git.joe@perches.com>
 <1311903782.20837.42.camel@jtkirshe-mobl>
 <1323313119.1762.58.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jeffrey.t.kirsher@intel.com
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 20:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYjmQ-0002w5-8E
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 20:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab1LHThM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 14:37:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338Ab1LHThK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 14:37:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C54326220;
	Thu,  8 Dec 2011 14:37:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6PkK7ImLflUptkjOIXl9tNWFSDY=; b=ElBWSA
	mBTS4wph/TRvsBfNdtKGmI6VJvejLoO5yb9ZfXfyLDtsok6uzXRqpLoAn3Vj0eGC
	wFWvSqjFw9yRtVAnISIgYsEwuqPcpjAKqPcytOnIvkAX5S3D8htFgEJ+ews1X3tU
	d/7kis91NHrX4LrhHPmH5BpSyXqwKqbc0Z/xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ip6d89kIdRnH92fb4qEXWbe/nvwwSPfx
	cIBy9X1BtCQ4ShOkwdVLdeAmOOqA4NAypIo5Lq0xNLuC1nmNleK5EdEB+Fyp/bDX
	ZCulQixrmT9XrhAli1EVntL3jI49xCRSL4JTJAbi0HprYql3nA2Xasu7aJT4VGFw
	VNacX25M64U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC293621F;
	Thu,  8 Dec 2011 14:37:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4132C621E; Thu,  8 Dec 2011
 14:37:09 -0500 (EST)
In-Reply-To: <1323313119.1762.58.camel@joe2Laptop> (Joe Perches's message of
 "Wed, 07 Dec 2011 18:58:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04A8CC62-21D4-11E1-BED3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186586>

Joe Perches <joe@perches.com> writes:

> Many types of signatures are used by various projects.
>
> The most common type is formatted:
> 	"[some_signature_type]-by: First Last <email@domain.tld>"
> e.g:
> 	"Reported-by: First Last <email@domain.tld>" (no quotes are used)

This is just a phrasing issue, but I am a bit reluctant about the name
"signature". "Acked-by:", "Tested-by:" and "Reviewed-by:" are originally
written in the message sent to the author by the person who is giving an
Ack, a successful test report, and a review comment, and the author (at
least in spirit) copies & pastes them to the final text used in the commit
log message, so it would not be incorrect to call them "signatures". But
other "Random-by:" would not fall into that pattern.

"Reported-by:" certainly does not.  It is almost always added by the
author of the patch that is different from the reporter, and the reporter
wouldn't have written "Reported-by: me" in the original bug report that
triggered the discussion and resulted in the commit to fix the bug. Such a
line is certainly not a signature of/by the reporter. Same can be said for
"Helped-by:" for the author to share credits.

Also I've seen these "Random-by:", especially the ones that the author
adds on his own initiative like "Reported-by:", followed by just a name
but not an addresses [*1*].

Does your change do the right thing on such an address-less entry?  The
answer to this question must start with the definition of "the right thing
to do is X", of course.

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 327233c..17ea825 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -246,8 +246,9 @@ Automating
>    patch body (commit message) except for self (use 'self' for that).
>  - 'sob' will avoid including anyone mentioned in Signed-off-by lines except
>     for self (use 'self' for that).
> +- 'signatures' will avoid including anyone mentioned in any "<foo>-by:" lines.
>  - 'cccmd' will avoid running the --cc-cmd.
> -- 'body' is equivalent to 'sob' + 'bodycc'
> +- 'body' is equivalent to 'sob' + 'bodycc + signatures'

The quotes do not match quite well.


[Footnote]

*1* This seems to be done deliberately so; I understand that this is to
avoid running afoul of EU privacy legislation or something.
