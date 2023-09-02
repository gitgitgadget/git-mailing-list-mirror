Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029BCCA0FFC
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 07:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346039AbjIBHer (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjIBHeq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 03:34:46 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570D090
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693640073; x=1694244873; i=l.s.r@web.de;
 bh=t+ldyDDh0117MXS3RJ9cvNn41eMrKgnPwoy4m8l4jSI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=L2Fgbn99VQEx9laHCT2aV8C5jVq62gCEcgBXPTfCu5eZkBU0CBFoGOSZvz5cVSrAtEdJPEW
 B3F+S61A1xuJAStBI8G8msQvGNau14yO8qq6kC5p+92UsbI/5obOttyvvKOmRTkYNSeinaWj1
 QTarRyFuGB4XMcrkrW4pq63UB/LJl0uwwZwMK0rrnXFVMmaobzRwn2nncZvQvvUsjH++3PZ9E
 w6qRrz3UieoLy/+LgZFhXj6JxmczokCzs4XsD2vhKxO1cTLYeZozCHX8Jyn+ANSGvoIVcq+je
 8eTTl4YrcSV2SGiE/ElpbDZLW7Y51NiQMyoOCXzqt9FT74FU/PhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.246]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mho0A-1pyccT0fOS-00dntR; Sat, 02
 Sep 2023 09:34:33 +0200
Message-ID: <8f03fa13-11b3-1f9f-1e1f-8f7d8ce74a23@web.de>
Date:   Sat, 2 Sep 2023 09:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 05/10] parse-options: prefer opt->value to globals in
 callbacks
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20230831211637.GA949188@coredump.intra.peff.net>
 <20230831212107.GE949469@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230831212107.GE949469@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HxnjorrAL1HMWd5v9ytKm0GmBs/4o8sghyakhwQUja0C2UHozJJ
 ZYMR8DMQN3y8cfTJxWrS9es03T7TFOZZcCwaj/nNpaezf092BD/QHd9r0T9IKGAHz5ehifG
 YD8wJqxAK9DWA+ewqGqVvY+BstNl/TInymNJMqURlnXmp0jyvftLZQk1UVFh8Lp5+gzwvzN
 UOOLI7+VvKoWWeciVYI7w==
UI-OutboundReport: notjunk:1;M01:P0:EmA9d58imVY=;rADHJj3AiIuW7/4QlMmufIctgDg
 7PK51CM4ykjFoywmYvC0qh+h5D7qJNmYNI6L3EZJz3vEKG+wtlefL46qdAG+bgbzEoludLyVs
 jwlCTAX51xqXaRcqh1vZChWMH5gq53kWnHXEtr+PUdqMiifDdJNmQHyEZYAE31mp4UV20JPhw
 fhOHxFscPZPgVPfvvlOAZwn+XCoA2tQWpHN8tCj3bUzpLJcIXglKLJpjiuH29sLvoQ8OdhpB0
 Rg0W/XfyHuDGuIafIUYxXKG38okZx8b9VVqeamEHMf8bmXcAMoq2y1+4RCCjV+s7AsBStw/Xv
 2xQrMLWs/EnmHSQFji8z5pWCVTzAqqSLS6AuQUAMQXJVkjTvtyHy2D8nD1++yS01Q2CT3xL/E
 SJMLxeyp7vfF0KNBsUiHJUU7jqmQ4ta5fXVS6RcJoMA1NUYYWx9fm4VSbOn5b8CcP9w1p5HbX
 MwlUogdfViC60UIZSLoAQ1ncVPh2QmfD0SeN22sudsyuDFPMg1psChQ+pSdFVBJ7sp4RgbBSW
 BuTWHHxqoYVGo/KrVU4iOSwEgy7w6ACB43yVX46JKLtvA8NfOLGLAHWyWaNSsBxvsDATOLKWf
 MwcJNVJd+Nbg8e2FuB+IfQdNshO7RsnAUIH7ApkmBj0X/EOLcVbiBw3c7jJwe7fOitaKGx9UC
 yywrely3jJzX4jKs1PAVPjGtl1dG2aTAwQjveGfKR+Dlk2lv8trSiJqQ9F4hZSLfXHEY12/Ym
 UtLxX2Xw4a7DBXcxWOPlOykr7DlK7KCpvpJMhO4YdGyA1OfhzLXH8PILhG8wNhnfbxLu5KRBN
 k5/xYaBZ3o/J41WVf7HIfEVfn5E+zcn7LSdRBFLRJNvCl4epFcVXbazoIrYOyaBD8WXMiXSMU
 zoLdynP6c9BPx9fgn24oUDzIfqVUPtYTd9UAL9HSiKC8szPXFyPz3+RvhTVx4PM1ozjTSVuNW
 QulPRES4r+3YVMO6xWUV5OoPVec=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.08.23 um 23:21 schrieb Jeff King:
> We have several parse-options callbacks that ignore their "opt"
> parameters entirely. This is a little unusual, as we'd normally put the
> result of the parsing into opt->value. In the case of these callbacks,
> though, they directly manipulate global variables instead (and in
> most cases the caller sets opt->value to NULL in the OPT_CALLBACK
> declaration).
>
> The immediate symptom we'd like to deal with is that the unused "opt"
> variables trigger -Wunused-parameter. But how to fix that is debatable.
> One option is to annotate them with UNUSED. But another is to have the
> caller pass in the appropriate variable via opt->value, and use it. That
> has the benefit of making the callbacks reusable (in theory at least),
> and makes it clear from the OPT_CALLBACK declaration which variables
> will be affected (doubly so for the cases in builtin/fast-export.c,
> where we do set opt->value, but it is completely ignored!).

Which allows turning global variables into local ones later, so unlocks
more cleanup potential.

> The slight downside is that we lose type safety, since they're now
> passing through void pointers.
>
> I went with the "just use them" approach here. The loss of type safety
> is unfortunate, but that is already an issue with most of the other
> callbacks. If we want to try to address that, we should do so more
> consistently (and this patch would prepare these callbacks for whatever
> we choose to do there).

Makes sense.  The types used below look OK to me.

> Note that in the cases in builtin/fast-export.c, we are passing
> anonymous enums. We'll have to give them names so that we can declare
> the appropriate pointer type within the callbacks.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/checkout-index.c     |  8 +++++---
>  builtin/describe.c           |  6 ++++--
>  builtin/fast-export.c        | 36 +++++++++++++++++++++---------------
>  builtin/fetch.c              |  4 ++--
>  builtin/interpret-trailers.c | 12 ++++++------
>  builtin/pack-objects.c       | 21 ++++++++++++---------
>  6 files changed, 50 insertions(+), 37 deletions(-)
>
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 6687a495ff..6ef6ac4c2e 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -193,14 +193,16 @@ static const char * const builtin_checkout_index_u=
sage[] =3D {
>  static int option_parse_stage(const struct option *opt,
>  			      const char *arg, int unset)
>  {
> +	int *stage =3D opt->value;
> +
>  	BUG_ON_OPT_NEG(unset);
>
>  	if (!strcmp(arg, "all")) {
> -		checkout_stage =3D CHECKOUT_ALL;
> +		*stage =3D CHECKOUT_ALL;
>  	} else {
>  		int ch =3D arg[0];
>  		if ('1' <=3D ch && ch <=3D '3')
> -			checkout_stage =3D arg[0] - '0';
> +			*stage =3D arg[0] - '0';
>  		else
>  			die(_("stage should be between 1 and 3 or all"));
>  	}
> @@ -238,7 +240,7 @@ int cmd_checkout_index(int argc, const char **argv, =
const char *prefix)
>  			N_("write the content to temporary files")),
>  		OPT_STRING(0, "prefix", &state.base_dir, N_("string"),
>  			N_("when creating files, prepend <string>")),
> -		OPT_CALLBACK_F(0, "stage", NULL, "(1|2|3|all)",
> +		OPT_CALLBACK_F(0, "stage", &checkout_stage, "(1|2|3|all)",
>  			N_("copy out the files from named stage"),
>  			PARSE_OPT_NONEG, option_parse_stage),
>  		OPT_END()
> diff --git a/builtin/describe.c b/builtin/describe.c
> index b28a4a1f82..718b5c3073 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -561,9 +561,11 @@ static void describe(const char *arg, int last_one)
>  static int option_parse_exact_match(const struct option *opt, const cha=
r *arg,
>  				    int unset)
>  {
> +	int *val =3D opt->value;
> +
>  	BUG_ON_OPT_ARG(arg);
>
> -	max_candidates =3D unset ? DEFAULT_CANDIDATES : 0;
> +	*val =3D unset ? DEFAULT_CANDIDATES : 0;
>  	return 0;
>  }
>
> @@ -578,7 +580,7 @@ int cmd_describe(int argc, const char **argv, const =
char *prefix)
>  		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
>  		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first pare=
nt")),
>  		OPT__ABBREV(&abbrev),
> -		OPT_CALLBACK_F(0, "exact-match", NULL, NULL,
> +		OPT_CALLBACK_F(0, "exact-match", &max_candidates, NULL,
>  			       N_("only output exact matches"),
>  			       PARSE_OPT_NOARG, option_parse_exact_match),
>  		OPT_INTEGER(0, "candidates", &max_candidates,
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 56dc69fac1..70aff515ac 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -33,9 +33,9 @@ static const char *fast_export_usage[] =3D {
>  };
>
>  static int progress;
> -static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } sig=
ned_tag_mode =3D SIGNED_TAG_ABORT;
> -static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode=
 =3D TAG_FILTERING_ABORT;
> -static enum { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode=
 =3D REENCODE_ABORT;
> +static enum signed_tag_mode { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_ST=
RIP, STRIP } signed_tag_mode =3D SIGNED_TAG_ABORT;
> +static enum tag_of_filtered_mode { TAG_FILTERING_ABORT, DROP, REWRITE }=
 tag_of_filtered_mode =3D TAG_FILTERING_ABORT;
> +static enum reencode_mode { REENCODE_ABORT, REENCODE_YES, REENCODE_NO }=
 reencode_mode =3D REENCODE_ABORT;
>  static int fake_missing_tagger;
>  static int use_done_feature;
>  static int no_data;
> @@ -53,16 +53,18 @@ static struct revision_sources revision_sources;
>  static int parse_opt_signed_tag_mode(const struct option *opt,
>  				     const char *arg, int unset)
>  {
> +	enum signed_tag_mode *val =3D opt->value;
> +
>  	if (unset || !strcmp(arg, "abort"))
> -		signed_tag_mode =3D SIGNED_TAG_ABORT;
> +		*val =3D SIGNED_TAG_ABORT;
>  	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
> -		signed_tag_mode =3D VERBATIM;
> +		*val =3D VERBATIM;
>  	else if (!strcmp(arg, "warn"))
> -		signed_tag_mode =3D WARN;
> +		*val =3D WARN;
>  	else if (!strcmp(arg, "warn-strip"))
> -		signed_tag_mode =3D WARN_STRIP;
> +		*val =3D WARN_STRIP;
>  	else if (!strcmp(arg, "strip"))
> -		signed_tag_mode =3D STRIP;
> +		*val =3D STRIP;
>  	else
>  		return error("Unknown signed-tags mode: %s", arg);
>  	return 0;
> @@ -71,12 +73,14 @@ static int parse_opt_signed_tag_mode(const struct op=
tion *opt,
>  static int parse_opt_tag_of_filtered_mode(const struct option *opt,
>  					  const char *arg, int unset)
>  {
> +	enum tag_of_filtered_mode *val =3D opt->value;
> +
>  	if (unset || !strcmp(arg, "abort"))
> -		tag_of_filtered_mode =3D TAG_FILTERING_ABORT;
> +		*val =3D TAG_FILTERING_ABORT;
>  	else if (!strcmp(arg, "drop"))
> -		tag_of_filtered_mode =3D DROP;
> +		*val =3D DROP;
>  	else if (!strcmp(arg, "rewrite"))
> -		tag_of_filtered_mode =3D REWRITE;
> +		*val =3D REWRITE;
>  	else
>  		return error("Unknown tag-of-filtered mode: %s", arg);
>  	return 0;
> @@ -85,21 +89,23 @@ static int parse_opt_tag_of_filtered_mode(const stru=
ct option *opt,
>  static int parse_opt_reencode_mode(const struct option *opt,
>  				   const char *arg, int unset)
>  {
> +	enum reencode_mode *val =3D opt->value;
> +
>  	if (unset) {
> -		reencode_mode =3D REENCODE_ABORT;
> +		*val =3D REENCODE_ABORT;
>  		return 0;
>  	}
>
>  	switch (git_parse_maybe_bool(arg)) {
>  	case 0:
> -		reencode_mode =3D REENCODE_NO;
> +		*val =3D REENCODE_NO;
>  		break;
>  	case 1:
> -		reencode_mode =3D REENCODE_YES;
> +		*val =3D REENCODE_YES;
>  		break;
>  	default:
>  		if (!strcasecmp(arg, "abort"))
> -			reencode_mode =3D REENCODE_ABORT;
> +			*val =3D REENCODE_ABORT;
>  		else
>  			return error("Unknown reencoding mode: %s", arg);
>  	}
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 8f93529505..fd134ba74d 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -176,7 +176,7 @@ static int parse_refmap_arg(const struct option *opt=
, const char *arg, int unset
>  	 * "git fetch --refmap=3D'' origin foo"
>  	 * can be used to tell the command not to store anywhere
>  	 */
> -	refspec_append(&refmap, arg);
> +	refspec_append(opt->value, arg);
>
>  	return 0;
>  }
> @@ -2204,7 +2204,7 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
>  			   PARSE_OPT_HIDDEN, option_fetch_parse_recurse_submodules),
>  		OPT_BOOL(0, "update-shallow", &update_shallow,
>  			 N_("accept refs that update .git/shallow")),
> -		OPT_CALLBACK_F(0, "refmap", NULL, N_("refmap"),
> +		OPT_CALLBACK_F(0, "refmap", &refmap, N_("refmap"),
>  			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg=
),
>  		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-spe=
cific"), N_("option to transmit")),
>  		OPT_IPVERSION(&family),
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index c5e8345265..6aadce6a1e 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -26,19 +26,19 @@ static enum trailer_if_missing if_missing;
>  static int option_parse_where(const struct option *opt,
>  			      const char *arg, int unset)
>  {
> -	return trailer_set_where(&where, arg);
> +	return trailer_set_where(opt->value, arg);
>  }
>
>  static int option_parse_if_exists(const struct option *opt,
>  				  const char *arg, int unset)
>  {
> -	return trailer_set_if_exists(&if_exists, arg);
> +	return trailer_set_if_exists(opt->value, arg);
>  }
>
>  static int option_parse_if_missing(const struct option *opt,
>  				   const char *arg, int unset)
>  {
> -	return trailer_set_if_missing(&if_missing, arg);
> +	return trailer_set_if_missing(opt->value, arg);
>  }

Not your fault, but these all silently exit if "arg" contains an
unrecognized value.  Reporting the error would be better.

>  static void new_trailers_clear(struct list_head *trailers)
> @@ -97,11 +97,11 @@ int cmd_interpret_trailers(int argc, const char **ar=
gv, const char *prefix)
>  		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
>  		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")=
),
>
> -		OPT_CALLBACK(0, "where", NULL, N_("action"),
> +		OPT_CALLBACK(0, "where", &where, N_("action"),
>  			     N_("where to place the new trailer"), option_parse_where),
> -		OPT_CALLBACK(0, "if-exists", NULL, N_("action"),
> +		OPT_CALLBACK(0, "if-exists", &if_exists, N_("action"),
>  			     N_("action if trailer already exists"), option_parse_if_exists)=
,
> -		OPT_CALLBACK(0, "if-missing", NULL, N_("action"),
> +		OPT_CALLBACK(0, "if-missing", &if_missing, N_("action"),
>  			     N_("action if trailer is missing"), option_parse_if_missing),

And I wonder if "action" should be replaced by "(after|before|end|start)",
"(addIfDifferent|addIfDifferentNeighbor|add|replace|doNothing)" and
"(doNothing|add)", respectively.  Gets a bit long in the middle, but would
be more helpful.  #leftoverbits

>  		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the=
 trailers")),
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index d2a162d528..492372ee5d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4120,29 +4120,32 @@ static void add_extra_kept_packs(const struct st=
ring_list *names)
>  static int option_parse_quiet(const struct option *opt, const char *arg=
,
>  			      int unset)
>  {
> +	int *val =3D opt->value;
> +
>  	BUG_ON_OPT_ARG(arg);
>
>  	if (!unset)
> -		progress =3D 0;
> -	else if (!progress)
> -		progress =3D 1;
> +		*val =3D 0;
> +	else if (!*val)
> +		*val =3D 1;
>  	return 0;
>  }
>
>  static int option_parse_index_version(const struct option *opt,
>  				      const char *arg, int unset)
>  {
> +	struct pack_idx_option *popts =3D opt->value;
>  	char *c;
>  	const char *val =3D arg;
>
>  	BUG_ON_OPT_NEG(unset);
>
> -	pack_idx_opts.version =3D strtoul(val, &c, 10);
> -	if (pack_idx_opts.version > 2)
> +	popts->version =3D strtoul(val, &c, 10);
> +	if (popts->version > 2)
>  		die(_("unsupported index version %s"), val);
>  	if (*c =3D=3D ',' && c[1])
> -		pack_idx_opts.off32_limit =3D strtoul(c+1, &c, 0);
> -	if (*c || pack_idx_opts.off32_limit & 0x80000000)
> +		popts->off32_limit =3D strtoul(c+1, &c, 0);
> +	if (*c || popts->off32_limit & 0x80000000)
>  		die(_("bad index version '%s'"), val);
>  	return 0;
>  }
> @@ -4190,7 +4193,7 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
>  		LIST_OBJECTS_FILTER_INIT;
>
>  	struct option pack_objects_options[] =3D {
> -		OPT_CALLBACK_F('q', "quiet", NULL, NULL,
> +		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
>  			       N_("do not show progress meter"),
>  			       PARSE_OPT_NOARG, option_parse_quiet),
>  		OPT_SET_INT(0, "progress", &progress,
> @@ -4200,7 +4203,7 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
>  		OPT_BOOL(0, "all-progress-implied",
>  			 &all_progress_implied,
>  			 N_("similar to --all-progress when progress meter is shown")),
> -		OPT_CALLBACK_F(0, "index-version", NULL, N_("<version>[,<offset>]"),
> +		OPT_CALLBACK_F(0, "index-version", &pack_idx_opts, N_("<version>[,<of=
fset>]"),
>  		  N_("write the pack index file in the specified idx format version")=
,
>  		  PARSE_OPT_NONEG, option_parse_index_version),
>  		OPT_MAGNITUDE(0, "max-pack-size", &pack_size_limit,
