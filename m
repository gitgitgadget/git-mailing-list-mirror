From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Corrected return values in
 post-receive-email.prep_for_email
Date: Tue, 07 Dec 2010 11:34:02 -0800
Message-ID: <7v1v5tqswl.fsf@alter.siamese.dyndns.org>
References: <002501cb962c$5fa3aa40$1eeafec0$@me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, "Kevin P. Fleming" <kpfleming@digium.com>
To: "Alan Raison" <alan@theraisons.me.uk>
X-From: git-owner@vger.kernel.org Tue Dec 07 20:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ3Ip-0001MG-2C
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 20:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab0LGTeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 14:34:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab0LGTeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 14:34:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE0A03152;
	Tue,  7 Dec 2010 14:34:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=ZKxAUo9dDZgjPIPeeP4l97ybzWY=; b=UhybMl
	v2Vqh2tJHPfiLVElSlHTrKHdVAnqbvn0dm0QQVSXMct5Iua/Z+auJyQakoo5YGEo
	6IPGMrmEpPG00TCAj+uBGkMN6S7gogxTypscfTR54t2j+vZ4Va0CjDcMnfLXxA2M
	b2rpqi7P4+eLG14tDjM35O0UCNFA6unOBypCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pmYFxSOsPfgGH4dv8HGv0b0bNZXu3s9K
	QIR/ZK3RiuAROLGYZ5cW2xH3vsYhdaPODerTFOwMGFPXN+gpHy9ktVQWJg4EF+44
	NJlVkwRWS0QwCFjFdGTYv2YkF6PdpIOrv9hgVSUBhyE6nZHqLYSWi+CC7ToE5BR8
	ZENUrFT/w4k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D1C9314D;
	Tue,  7 Dec 2010 14:34:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 57BD9314C; Tue,  7 Dec 2010
 14:34:26 -0500 (EST)
In-Reply-To: <002501cb962c$5fa3aa40$1eeafec0$@me.uk> (Alan Raison's message
 of "Tue\, 7 Dec 2010 16\:32\:43 -0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02E1FFC2-0239-11E0-8D7E-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163118>

"Alan Raison" <alan@theraisons.me.uk> writes:

> ---
>  contrib/hooks/post-receive-email |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

No sign-off, no description.

This is a regression introduced by 53cad69 (post-receive-email: ensure
sent messages are not empty, 2010-09-10), I think.

> diff --git a/contrib/hooks/post-receive-email
> b/contrib/hooks/post-receive-email
> index 85724bf..020536d 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -150,7 +150,7 @@ prep_for_email()
>  			# Anything else (is there anything else?)
>  			echo >&2 "*** Unknown type of update to $refname
> ($rev_type)"
>  			echo >&2 "***  - no email generated"
> -			return 0
> +			return 1

This used to "exit 1" before 53cad69 and I agree with the patch that
signalling error with "return 1" is the right thing to do here.

>  			;;
>  	esac
>  
> @@ -166,10 +166,10 @@ prep_for_email()
>  		esac
>  		echo >&2 "*** $config_name is not set so no email will be
> sent"
>  		echo >&2 "*** for $refname update $oldrev->$newrev"
> -		return 0
> +		return 1

This used to "exit 0" before 53cad69 to cause the program stop before
sending mails.  Again, I agree with the patch that signalling error is the
right thing to do here.

>  	fi
>  
> -	return 1
> +	return 0

And this obviously is correct.

Kevin, care to review and Ack?  Alan, care to add a few lines of patch
description and sign-off?

Thanks.
