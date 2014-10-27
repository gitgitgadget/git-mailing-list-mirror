From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][RFC] grep: add color.grep.matchcontext and color.grep.matchselected
Date: Mon, 27 Oct 2014 12:29:34 -0700
Message-ID: <xmqqy4s1s44h.fsf@gitster.dls.corp.google.com>
References: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
	<544D3A3C.4080906@web.de> <544E8D89.3030201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 27 20:29:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xipz6-0002ZC-IK
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 20:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbaJ0T3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 15:29:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754461AbaJ0T3i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2014 15:29:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0DAA1A9C9;
	Mon, 27 Oct 2014 15:29:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vTgT9sggz/YI
	ZcXEXgeXTCnNZEI=; b=ZqknTUk1Le9gMOParaF4tyTUvGKu05zIIMdDofnb9Fzw
	VER3K99my0fQffJOmJAMkmAV2WWRP0ydjCvM7N0ZuMn0EIaeExHWIilbIu13jLes
	6A+LHE8QyoQ5/RTg8FZy7LH4jJUdpQ9GQfc12ihqAMTyeeoqy2FHEY3OIxKG5As=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sWA6wT
	xlxOQwfisL888BHxFVUOcHm+9I8sPd0dmcDARXmUSwuSYKFJNvEMr4qjL7TMQPgM
	7u810VS2RZ+bCJsoeYAjwA72MAICjfsn8WNiDBLUE1A+IISBEO4uAbd+M4JClpNR
	UXVktUj9JFJf0RPbFI3QdrMhPJ7IIBn/wt0nY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6E541A9C8;
	Mon, 27 Oct 2014 15:29:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22F941A9C7;
	Mon, 27 Oct 2014 15:29:37 -0400 (EDT)
In-Reply-To: <544E8D89.3030201@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Mon, 27
	Oct 2014 19:23:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9690CABA-5E0F-11E4-A1DE-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The config option color.grep.match can be used to specify the highlig=
hting
> color for matching strings.  Add the options matchContext and matchSe=
lected
> to allow different colors to be specified for matching strings in the
> context vs. in selected lines.  This is similar to the ms and mc spec=
ifiers
> in GNU grep's environment variable GREP_COLORS.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Only *very* lightly tested, and a test for t/is missing anyway.  Just
> wanted to quickly show what I meant.  You'd set color.grep.matchConte=
xt=3D""
> to turn off highlighting in context lines.  What do you think?

I didn't realize that people wanted to see pieces on non-matching
lines highlighted.  It makes certain sense, e.g. it would allow you
to spot near-misses, but that is only true for lines that neighbour
real hits, so...

I like this approach better in that it makes those who want a
different behaviour to do the work without breaking the expectation
of those who are used to the established behaviour.

Zoltan?



>  Documentation/config.txt |  6 +++++-
>  grep.c                   | 29 ++++++++++++++++++++++-------
>  grep.h                   |  3 ++-
>  3 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 8b49813..78832ae 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -885,7 +885,11 @@ color.grep.<slot>::
>  `linenumber`;;
>  	line number prefix (when using `-n`)
>  `match`;;
> -	matching text
> +	matching text (same as setting `matchContext` and `matchSelected`)
> +`matchContext`;;
> +	matching text in context lines
> +`matchSelected`;;
> +	matching text in selected lines
>  `selected`;;
>  	non-matching text in selected lines
>  `separator`;;
> diff --git a/grep.c b/grep.c
> index 4dc31ea..6e085f8 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -35,7 +35,8 @@ void init_grep_defaults(void)
>  	strcpy(opt->color_filename, "");
>  	strcpy(opt->color_function, "");
>  	strcpy(opt->color_lineno, "");
> -	strcpy(opt->color_match, GIT_COLOR_BOLD_RED);
> +	strcpy(opt->color_match_context, GIT_COLOR_BOLD_RED);
> +	strcpy(opt->color_match_selected, GIT_COLOR_BOLD_RED);
>  	strcpy(opt->color_selected, "");
>  	strcpy(opt->color_sep, GIT_COLOR_CYAN);
>  	opt->color =3D -1;
> @@ -101,12 +102,22 @@ int grep_config(const char *var, const char *va=
lue, void *cb)
>  		color =3D opt->color_function;
>  	else if (!strcmp(var, "color.grep.linenumber"))
>  		color =3D opt->color_lineno;
> -	else if (!strcmp(var, "color.grep.match"))
> -		color =3D opt->color_match;
> +	else if (!strcmp(var, "color.grep.matchcontext"))
> +		color =3D opt->color_match_context;
> +	else if (!strcmp(var, "color.grep.matchselected"))
> +		color =3D opt->color_match_selected;
>  	else if (!strcmp(var, "color.grep.selected"))
>  		color =3D opt->color_selected;
>  	else if (!strcmp(var, "color.grep.separator"))
>  		color =3D opt->color_sep;
> +	else if (!strcmp(var, "color.grep.match")) {
> +		int rc =3D 0;
> +		if (!value)
> +			return config_error_nonbool(var);
> +		rc |=3D color_parse(value, opt->color_match_context);
> +		rc |=3D color_parse(value, opt->color_match_selected);
> +		return rc;
> +	}
> =20
>  	if (color) {
>  		if (!value)
> @@ -144,7 +155,8 @@ void grep_init(struct grep_opt *opt, const char *=
prefix)
>  	strcpy(opt->color_filename, def->color_filename);
>  	strcpy(opt->color_function, def->color_function);
>  	strcpy(opt->color_lineno, def->color_lineno);
> -	strcpy(opt->color_match, def->color_match);
> +	strcpy(opt->color_match_context, def->color_match_context);
> +	strcpy(opt->color_match_selected, def->color_match_selected);
>  	strcpy(opt->color_selected, def->color_selected);
>  	strcpy(opt->color_sep, def->color_sep);
>  }
> @@ -1084,7 +1096,7 @@ static void show_line(struct grep_opt *opt, cha=
r *bol, char *eol,
>  		      const char *name, unsigned lno, char sign)
>  {
>  	int rest =3D eol - bol;
> -	char *line_color =3D NULL;
> +	const char *match_color, *line_color =3D NULL;
> =20
>  	if (opt->file_break && opt->last_shown =3D=3D 0) {
>  		if (opt->show_hunk_mark)
> @@ -1123,6 +1135,10 @@ static void show_line(struct grep_opt *opt, ch=
ar *bol, char *eol,
>  		int eflags =3D 0;
> =20
>  		if (sign =3D=3D ':')
> +			match_color =3D opt->color_match_selected;
> +		else
> +			match_color =3D opt->color_match_context;
> +		if (sign =3D=3D ':')
>  			line_color =3D opt->color_selected;
>  		else if (sign =3D=3D '-')
>  			line_color =3D opt->color_context;
> @@ -1135,8 +1151,7 @@ static void show_line(struct grep_opt *opt, cha=
r *bol, char *eol,
> =20
>  			output_color(opt, bol, match.rm_so, line_color);
>  			output_color(opt, bol + match.rm_so,
> -				     match.rm_eo - match.rm_so,
> -				     opt->color_match);
> +				     match.rm_eo - match.rm_so, match_color);
>  			bol +=3D match.rm_eo;
>  			rest -=3D match.rm_eo;
>  			eflags =3D REG_NOTBOL;
> diff --git a/grep.h b/grep.h
> index eaaced1..95f197a 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -124,7 +124,8 @@ struct grep_opt {
>  	char color_filename[COLOR_MAXLEN];
>  	char color_function[COLOR_MAXLEN];
>  	char color_lineno[COLOR_MAXLEN];
> -	char color_match[COLOR_MAXLEN];
> +	char color_match_context[COLOR_MAXLEN];
> +	char color_match_selected[COLOR_MAXLEN];
>  	char color_selected[COLOR_MAXLEN];
>  	char color_sep[COLOR_MAXLEN];
>  	int regflags;
