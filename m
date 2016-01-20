From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] diff.c: take "prefix" argument in diff_opt_parse()
Date: Wed, 20 Jan 2016 12:23:38 -0800
Message-ID: <xmqqr3hc57at.fsf@gitster.mtv.corp.google.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
	<1453287968-26000-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:23:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLzIB-0005p4-5C
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 21:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935120AbcATUXn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 15:23:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935059AbcATUXl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 15:23:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 273463C15C;
	Wed, 20 Jan 2016 15:23:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DBvyWM2cr3dS
	iv62CMoU7vaS1sc=; b=VTaQI9RtXtpav1iDtvzjYt+jVmOsnYShqpVLdhoJbFwj
	MG+rdD9/xu/3EkzkcilnjgF00oa2P8GSEbUuKbHdNsaUCn1wvyeOACG79G6n1LjB
	qu89z0+J2K+y/KHSXlv5v8fD0WmWi3BrcMerwqyxnFCjm6tK/j/c/b2eU8R7pZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Tl6vNC
	H+v9HbewQ58It2hf7+lErgk56dPoxLL8kylri4oEBxNQTpkswqqVtoWHStDsachb
	yOpLyX9Uw1GRMMK1diupQyD4MOYETqLv8nXRBQ+zVpQn4m5GtdeyextXMJ3jcMWm
	LOA6qICH3oohJfL5XkyojpwCbwMmbwSX1apsg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D2523C15B;
	Wed, 20 Jan 2016 15:23:40 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7E8423C152;
	Wed, 20 Jan 2016 15:23:39 -0500 (EST)
In-Reply-To: <1453287968-26000-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 20
 Jan 2016 18:06:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B10FDB54-BFB3-11E5-85C5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284460>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This will be important later when diff_opt_parse() accepts paths as
> arguments. Paths must be prefixed before access because setup code
> moves cwd but does not (and cannot) update command line options.

The above sounds like a sensible thing to do (note: I didn't read
the patch or remainder of the series), but makes me wonder how the
existing --orderfile option works without this support.  Perhaps it
is not working and needs to be updated to take advantage of this
change, too?

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/am.c    | 2 +-
>  diff-no-index.c | 3 ++-
>  diff.c          | 3 ++-
>  diff.h          | 2 +-
>  revision.c      | 2 +-
>  5 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 9fb42fd..f009b6c 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1657,7 +1657,7 @@ static int fall_back_threeway(const struct am_s=
tate *state, const char *index_pa
> =20
>  		init_revisions(&rev_info, NULL);
>  		rev_info.diffopt.output_format =3D DIFF_FORMAT_NAME_STATUS;
> -		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1);
> +		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.pr=
efix);
>  		add_pending_sha1(&rev_info, "HEAD", our_tree, 0);
>  		diff_setup_done(&rev_info.diffopt);
>  		run_diff_index(&rev_info, 1);
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 491e842..03daadb 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -252,7 +252,8 @@ void diff_no_index(struct rev_info *revs,
>  		else if (!strcmp(argv[i], "--"))
>  			i++;
>  		else {
> -			j =3D diff_opt_parse(&revs->diffopt, argv + i, argc - i);
> +			j =3D diff_opt_parse(&revs->diffopt, argv + i, argc - i,
> +					   revs->prefix);
>  			if (j <=3D 0)
>  				die("invalid diff option/value: %s", argv[i]);
>  			i +=3D j;
> diff --git a/diff.c b/diff.c
> index 80eb0c2..8d38fe8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3693,7 +3693,8 @@ static int parse_ws_error_highlight(struct diff=
_options *opt, const char *arg)
>  	return 1;
>  }
> =20
> -int diff_opt_parse(struct diff_options *options, const char **av, in=
t ac)
> +int diff_opt_parse(struct diff_options *options,
> +		   const char **av, int ac, const char *prefix)
>  {
>  	const char *arg =3D av[0];
>  	const char *optarg;
> diff --git a/diff.h b/diff.h
> index f61ee54..76b5536 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -268,7 +268,7 @@ extern int parse_long_opt(const char *opt, const =
char **argv,
>  extern int git_diff_basic_config(const char *var, const char *value,=
 void *cb);
>  extern int git_diff_ui_config(const char *var, const char *value, vo=
id *cb);
>  extern void diff_setup(struct diff_options *);
> -extern int diff_opt_parse(struct diff_options *, const char **, int)=
;
> +extern int diff_opt_parse(struct diff_options *, const char **, int,=
 const char *);
>  extern void diff_setup_done(struct diff_options *);
> =20
>  #define DIFF_DETECT_RENAME	1
> diff --git a/revision.c b/revision.c
> index 0a282f5..14daefb 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2049,7 +2049,7 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--ignore-missing")) {
>  		revs->ignore_missing =3D 1;
>  	} else {
> -		int opts =3D diff_opt_parse(&revs->diffopt, argv, argc);
> +		int opts =3D diff_opt_parse(&revs->diffopt, argv, argc, revs->pref=
ix);
>  		if (!opts)
>  			unkv[(*unkc)++] =3D arg;
>  		return opts;
