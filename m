From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff.c: fix a graph output bug
Date: Thu, 08 Jul 2010 17:15:05 -0700
Message-ID: <7vhbk9o6ie.fsf@alter.siamese.dyndns.org>
References: <y> <4c35eb6c.21078e0a.1455.ffffe42d@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: struggleyb.nku@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 09 02:15:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX1FS-0001tW-Rz
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 02:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747Ab0GIAPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 20:15:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab0GIAPN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 20:15:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6047FC2889;
	Thu,  8 Jul 2010 20:15:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aa7MqM6i7F0VRPZBS0tJB7DK16A=; b=Comr2t
	A/7b5x2hPbb1C/i0EgKH8sPDU2KLI2qv0/1h6sF2lDM4R4tu0E0S3+L0MxerH0hE
	UtREBGyWm9i14/NsGR6G51ujREFPT+XeKuZIizph3mxngnVC7YMRd5PQPiZLNCv7
	PFTEmSau/KJRWvTpv3bD49Rzn0wRV+pVv7s5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NIZHFkOBe/TWtMu0fiIhXikF1XB/RV6O
	ISVjIi09QGe37L76Fpkdaz18CH4NQg0gGOFNlcHbue41yuH8QwxWB53x0oLKkyS/
	50zUsSZBZe2YWlrmZro9E7TkfyefhFsghZ3oa9YvD9hPKmX+6tC19hEXOJNw2ZCa
	QM6kwgTViK0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF24C2886;
	Thu,  8 Jul 2010 20:15:11 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FDF9C2884; Thu,  8 Jul
 2010 20:15:07 -0400 (EDT)
In-Reply-To: <4c35eb6c.21078e0a.1455.ffffe42d@mx.google.com> (struggleyb
 nku's message of "Thu\,  8 Jul 2010 23\:12\:34 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 09E41CD6-8AEF-11DF-9D58-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150623>

struggleyb.nku@gmail.com writes:

> From: Bo Yang <struggleyb.nku@gmail.com>
>
> Ouput the line_prefix ahead of color sequence.

Justification for the patch, and/or a better bug description ("when run
with this combination of options, X gets painted in that color that is not
meant to be used for X") please?

>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---
>  diff.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 3aa695d..17873f3 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2627,8 +2627,7 @@ static void fill_metainfo(struct strbuf *msg,
>  			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
>  				abbrev = 40;
>  		}
> -		strbuf_addf(msg, "%s%sindex %s..", set,
> -			    line_prefix,
> +		strbuf_addf(msg, "%s%sindex %s..", line_prefix, set,
>  			    find_unique_abbrev(one->sha1, abbrev));
>  		strbuf_addstr(msg, find_unique_abbrev(two->sha1, abbrev));
>  		if (one->mode == two->mode)
> -- 
> 1.7.0.2.273.gc2413.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
