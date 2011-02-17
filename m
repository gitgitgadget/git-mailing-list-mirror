From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Reduce url_len variable scope
Date: Wed, 16 Feb 2011 17:43:54 -0800
Message-ID: <7vhbc3fnad.fsf@alter.siamese.dyndns.org>
References: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
 <1297550311-17723-2-git-send-email-vvavrychuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 02:44:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppsuj-0004mY-Hx
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 02:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862Ab1BQBoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 20:44:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab1BQBoG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 20:44:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D48204107;
	Wed, 16 Feb 2011 20:45:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=kZ2MkCsIdz9YPhm94Ih5OwZi4lA=; b=TeS7+5nMBzHEV9RDIUO5sQ8
	NOCbm+xUSPpXoMTxk5X79tCS0C1gpWMkwM6sWE6eKuigyoc9r5XzIwm3JE3RV47R
	duUTbmlAjvgEwoaMDR3HLQERhZL4LsAtA7jKI968uiKuHxLr6rrfIkGJRUc9QDm6
	bPjNSsgZJEgJCcIu/JxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ISPXlfhRGyD1btMkRDCDRxxXZFdFqTj6PscXOWfWXZUrOXT9R
	CDaX2cR1rE4oB2EWQSVrACNVH0CBzoY5XjixnS4j0SJZCkHsnno3DxmqZkQ973WN
	t6PhuwY+GWtKeHa7QRgU+4YQwIVrNgNMpaECe4oocJcJCDeang8mHIdUUQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2F724104;
	Wed, 16 Feb 2011 20:45:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 61E8D4103; Wed, 16 Feb 2011
 20:45:03 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C8B6818-3A37-11E0-BB48-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167026>

Vasyl' Vavrychuk <vvavrychuk@gmail.com> writes:

> Subject: Re: [PATCH 1/4] Reduce url_len variable scope

Please mark the patch in such a way that the readers can tell what
file/function this patch is about by reading "git shortlog" output
without anything else, i.e.

	Subject: builtin/fetch.c: shorten lifetime of the url_len variable

Hmph.  While this does not bring in any new bug to the code, what benefit
do we gain from it?

The scope is not reduced (even though the variable's lifespan is shortened
in the scope).  Are we so short of registers that this change matters?

>  builtin/fetch.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 357f3cd..2b0b11e 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -385,6 +385,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  		url_len = i + 1;
>  		if (4 < i && !strncmp(".git", url + i - 3, 4))
>  			url_len = i - 3;
> +		url[url_len] = '\0';
>  
>  		note_len = 0;
>  		if (*what) {
> @@ -399,7 +400,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  				    rm->old_sha1),
>  			rm->merge ? "" : "not-for-merge",
>  			note);
> -		for (i = 0; i < url_len; ++i)
> +		for (i = 0; url[i]; ++i)
>  			if ('\n' == url[i])
>  				fputs("\\n", fp);
>  			else
> @@ -415,8 +416,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  				 REFCOL_WIDTH, *what ? what : "HEAD");
>  		if (*note) {
>  			if (verbosity >= 0 && !shown_url) {
> -				fprintf(stderr, "From %.*s\n",
> -						url_len, url);
> +				fprintf(stderr, "From %s\n", url);
>  				shown_url = 1;
>  			}
>  			if (verbosity >= 0)
> -- 
> 1.7.1
