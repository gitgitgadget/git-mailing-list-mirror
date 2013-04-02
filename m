From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V3 2/5] Help.c use OPT_BOOL and refactor logic
Date: Tue, 02 Apr 2013 16:15:49 -0700
Message-ID: <7v62048qxm.fsf@alter.siamese.dyndns.org>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
 <1364942392-576-3-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, "W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 01:16:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNARQ-0000C4-Ka
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 01:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758323Ab3DBXPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 19:15:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757321Ab3DBXPv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 19:15:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 784B112C4F;
	Tue,  2 Apr 2013 23:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=R9L+kAajZGYlu9hPKPW+1qcytKE=; b=DyM25fUItr8LgW1iAZ75
	P6gf9Ckwb+MqQNF0bxO5bmQZoRJl52iyXky3Z9yv7Jnxb/VtM2FJDuo/9MTxqCid
	bmau9hyY09bs96d/DAqW91ik7iDCronEqbmChrdiIC3MG+npX9GmOnW9n93KVGoy
	TLJQywLYGjZBHJcrdavHp0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=nW/KomGO2aU2F4PEfWiK3CxaQiwy9VHY4EyDuXzFlRehc/
	O5Xbp1f6gau1cXwoKmABR3acHcP5azpbNJa8Xh6mqY8UaKsp4+3Y66tETTqJx1YP
	70/5DZNaQaFZfytzNEf+pEI6lSPQD7FN6VrJr2P5xQogzoBI1rXYhdxMVVZ9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D47212C4E;
	Tue,  2 Apr 2013 23:15:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA43E12C4D; Tue,  2 Apr
 2013 23:15:50 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 425FC87A-9BEB-11E2-A2D9-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219904>

Philip Oakley <philipoakley@iee.org> writes:

> Rename deprecated OPT_BOOLEAN option to OPT_BOOL in preparation for
> 'git help --guides'. The former OPT_BOOLEAN would now be OPT_COUNTUP,
> but that capability is not required.
>
> Separate out the show_all 'return(0)' and git_more_info_string logic
> ready for inclusion of show_guides.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---

You are creating a gap in the output so that you can add some more
stuff in later patches, which is fine, but I do not think we call
that kind of change a "refactor" ;-).

The change looks fine.

>  builtin/help.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index d1d7181..8969d3b 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -39,7 +39,7 @@ static int show_all = 0;
>  static unsigned int colopts;
>  static enum help_format help_format = HELP_FORMAT_NONE;
>  static struct option builtin_help_options[] = {
> -	OPT_BOOLEAN('a', "all", &show_all, N_("print all available commands")),
> +	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
>  	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
>  	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
>  			HELP_FORMAT_WEB),
> @@ -428,7 +428,13 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  		git_config(git_help_config, NULL);
>  		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
>  		list_commands(colopts, &main_cmds, &other_cmds);
> +	}
> +
> +	if (show_all) {
>  		printf("%s\n", _(git_more_info_string));
> +		/*
> +		* We're done. Ignore any remaining args
> +		*/
>  		return 0;
>  	}
