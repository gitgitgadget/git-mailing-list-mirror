From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config --global --edit: generate correct .gitconfig template
Date: Wed, 06 May 2015 10:56:31 -0700
Message-ID: <xmqqzj5htws0.fsf@gitster.dls.corp.google.com>
References: <1430934077-20724-1-git-send-email-pchpublic88@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu.Moy@imag.fr
To: Pete Harlan <pchpublic88@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 19:56:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq3Yl-00036N-FX
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 19:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbbEFR4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 13:56:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751511AbbEFR4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 13:56:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A68834F924;
	Wed,  6 May 2015 13:56:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tafw7qHWycAJQQu5N/ak+OYo+d4=; b=RHU6Yn
	4I6N4fD3s2AyhB+tWRLk++YdF9kJpX2FvxLMfy8v2OGboLH0twbsr068+PahG95M
	2T1gQPmhSvksJXgGo6I6/YMTXH8iaX8aWawLScXAr40mr7DtI5IzqOI6VGYiIIHO
	de5EaqXbi1fR2J+aD+b30SNX/tIjFBQPmbX9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k83OgVyWvfINF0A0qS8LAX+m2zu4fKAB
	cphlrGGTLQCsLF47iRGkgUixSbCmabte/YDR1SbmGB4qH6fg7vicpxIV2Ie+BMLS
	SfD4zwERLRaf5c/QNChF2q+zKrmz4mVEsJy1ALCXTO8XZOjIz/+M8QO84WGTjwFL
	SMc9PGAlqrM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FA814F923;
	Wed,  6 May 2015 13:56:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A8284F920;
	Wed,  6 May 2015 13:56:33 -0400 (EDT)
In-Reply-To: <1430934077-20724-1-git-send-email-pchpublic88@gmail.com> (Pete
	Harlan's message of "Wed, 6 May 2015 10:41:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B1F4094-F419-11E4-8601-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268477>

Pete Harlan <pchpublic88@gmail.com> writes:

> When the user asks to edit an empty .gitconfig file, we learned to
> generate a default version in 9830534e (config --global --edit: create
> a template file if needed, 2014-07-25), but the generated config
> mistakenly set core.user and core.email instead of user.name and
> user.email.  Fix this.
>
> Signed-off-by: Pete Harlan <pchpublic88@gmail.com>
> ---

Thanks, I think this was already done in 7e110524 (config: fix
settings in default_user_config template, 2015-04-17).

>
> I ran up against this yesterday and it is easy enough to fix, but I
> don't have time right now to write tests for it.
>
>  builtin/config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index d32c532..bfd3016 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -455,9 +455,9 @@ static char *default_user_config(void)
>  	struct strbuf buf = STRBUF_INIT;
>  	strbuf_addf(&buf,
>  		    _("# This is Git's per-user configuration file.\n"
> -		      "[core]\n"
> +		      "[user]\n"
>  		      "# Please adapt and uncomment the following lines:\n"
> -		      "#	user = %s\n"
> +		      "#	name = %s\n"
>  		      "#	email = %s\n"),
>  		    ident_default_name(),
>  		    ident_default_email());
