Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7122C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 21:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiBAVOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiBAVOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 16:14:40 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEC8C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 13:14:40 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id d10so58213995eje.10
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 13:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Uhi5OeHK6MDkwtEXk3TcCeowIC9YeEhg1FCA62J7coM=;
        b=NyvnvGvKRJxS98hV10Tr3Xm3vFw2+vGn9Kusp6ycbOWejmA0gU2X+MIYWSXEnqkqEm
         BCNGmoFME+XhJR9LhmB3OaHuF73NVQ0/Gt7KNtZ4tdkKO+1kPJvC3xxmEw51UDh2WMPH
         F0YSPCOjzPuQ+D8x7pMo0FuF8j/zupJNq7S6CTwmTmaQxE6PXlE2EXdKbivMNsFQNSLn
         cLXO3cim0eBB0/5epcZiSlaKnJ8ftLueHeFLuUAOW/Sxd531TkrrbAKCuPvlsFk8/kpL
         FCtCxpKGtmUui5sKK1Zgf2ffe5PAw34+Eg/MdL6PXyCKb/fwFbePaALQ0eI7csDv+twV
         fanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Uhi5OeHK6MDkwtEXk3TcCeowIC9YeEhg1FCA62J7coM=;
        b=KcHx8G3qXfWBi3lGxn+9OwSjaBx11PmgvfEwZo0EBs9Vesz7b3Z9ieteWRKkyfYvkS
         do2jXyK1VjMzKLo8UVCzaqKRDYTZdHUmCb8kv7KbLNpwEuFErN2W132F7Tbg7Jpgjb2o
         gV+oTmhztu9AZwwTVpR/VxKqZHBwoHs/trTJPlOoC71x/vFlxSL3pa80BObpqGy7FCj9
         PN77FkwO3DF/3eHsHF8CulE/3q9W3trVFYB5sq9YUXHTNR4KSReEAFHqqErCqHPpui8H
         RF8XNeR0FW7aGw2xpTEOUOUUqaHS8XCoRHAhwKlawmDGO0Ylp8TDuytASbXdA/wHa0bK
         yMjQ==
X-Gm-Message-State: AOAM530/mYUAo6AqZmzp77X+cwN4NGJ5VMGyo1TBXDWIr9VJzCZSXR1i
        98hSTSz90u1fgl1ZyCgUgE1IOupNh76h0A==
X-Google-Smtp-Source: ABdhPJwm0mBmZqo9RG8Iv63UAJJ7yggj0jJph3O5uV62O08kqji4lOeahBSQKq2e3auIixcT6TgBLA==
X-Received: by 2002:a17:907:868d:: with SMTP id qa13mr22984283ejc.508.1643750078085;
        Tue, 01 Feb 2022 13:14:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i6sm15135191eja.132.2022.02.01.13.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:14:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nF0U0-004MoV-TV;
        Tue, 01 Feb 2022 22:14:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 1/4] i18n: factorize more 'incompatible options'
 messages
Date:   Tue, 01 Feb 2022 22:01:52 +0100
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
 <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
 <844e01391e1198960072844536d736f51573cac6.1643408644.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <844e01391e1198960072844536d736f51573cac6.1643408644.git.gitgitgadget@gmail.com>
Message-ID: <220201.86a6fa9tmr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 28 2022, Jean-No=C3=ABl Avila via GitGitGadget wrote:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> [...]
> +void die_if_incompatible_opt3(int opt1, const char *opt1_name,
> +							  int opt2, const char *opt2_name,
> +							  int opt3, const char *opt3_name)
> +{
> +	int count =3D 0;
> +	const char *options[3];
> +
> +	if (opt1)
> +		options[count++] =3D opt1_name;
> +	if (opt2)
> +		options[count++] =3D opt2_name;
> +	if (opt3)
> +		options[count++] =3D opt3_name;
> +	if (count > 2)
> +		die(_("options '%s', '%s', and '%s' cannot be used together"), opt1_na=
me, opt2_name, opt3_name);
> +	else if (count > 1)
> +		die(_("options '%s' and '%s' cannot be used together"), options[0], op=
tions[1]);
> +}
> +
> +void die_if_incompatible_opt4(int opt1, const char *opt1_name,
> +							  int opt2, const char *opt2_name,
> +							  int opt3, const char *opt3_name,
> +							  int opt4, const char *opt4_name)
> +{
> +	int count =3D 0;
> +	const char *options[4];
> +
> +	if (opt1)
> +		options[count++] =3D opt1_name;
> +	if (opt2)
> +		options[count++] =3D opt2_name;
> +	if (opt3)
> +		options[count++] =3D opt3_name;
> +	if (opt4)
> +		options[count++] =3D opt4_name;
> +	switch (count) {
> +	case 4:
> +		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"), o=
pt1_name, opt2_name, opt3_name, opt4_name);
> +		break;
> +	case 3:
> +		die(_("options '%s', '%s', and '%s' cannot be used together"), options=
[0], options[1], options[2]);
> +		break;
> +	case 2:
> +		die(_("options '%s' and '%s' cannot be used together"), options[0], op=
tions[1]);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> diff --git a/parse-options.h b/parse-options.h
> index e22846d3b7b..cf393839ac4 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -339,4 +339,13 @@ int parse_opt_tracking_mode(const struct option *, c=
onst char *, int);
>  #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_=
("with --pathspec-from-file, pathspec elements are separated with NUL chara=
cter"))
>  #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically s=
tash/stash pop before and after"))
>=20=20
> +void die_if_incompatible_opt3(int opt1, const char *opt1_name,
> +							  int opt2, const char *opt2_name,
> +							  int opt3, const char *opt3_name);
> +
> +void die_if_incompatible_opt4(int opt1, const char *opt1_name,
> +							  int opt2, const char *opt2_name,
> +							  int opt3, const char *opt3_name,
> +							  int opt4, const char *opt4_name);
> +
>  #endif
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-t=
emplate-squash-signoff.sh
> index 91964653a0b..5fcaa0b4f2a 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -442,7 +442,7 @@ test_expect_success '--fixup=3Dreword: give error wit=
h pathsec' '
>  '
>=20=20
>  test_expect_success '--fixup=3Dreword: -F give error message' '
> -	echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
> +	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used toge=
ther" >expect &&
>  	test_must_fail git commit --fixup=3Dreword:HEAD~ -F msg  2>actual &&
>  	test_cmp expect actual
>  '

I've really wanted (and have been meaning to find time to work on) some
expansion of what we can get from the "these are incompatible" that
OPT_CMDMODE gives us for a while.

But I think doing it like this is really going in the wrong direction,
i.e. we have no need to run all of parse_options(), callbacks and all,
and populate all the variables, only to after the fact die when we
notice both "a" and "b" were set, and those are incompatible.

I.e. to have the API work like something resembling this:
=09
	diff --git a/builtin/grep.c b/builtin/grep.c
	index 75e07b5623a..80ea323f957 100644
	--- a/builtin/grep.c
	+++ b/builtin/grep.c
	@@ -849,8 +849,11 @@ int cmd_grep(int argc, const char **argv, const char =
*prefix)
	 	struct option options[] =3D {
	 		OPT_BOOL(0, "cached", &cached,
	 			N_("search in index instead of in the work tree")),
	+		OPT_INCOMPATIBLE("cached", "untracked"),
	 		OPT_NEGBIT(0, "no-index", &use_index,
	 			 N_("find in contents not managed by git"), 1),
	+		OPT_INCOMPATIBLE("no-index", "untracked"),
	+		OPT_INCOMPATIBLE("no-index", "cached"),
	 		OPT_BOOL(0, "untracked", &untracked,
	 			N_("search in both tracked and untracked files")),
	 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
	@@ -1167,12 +1170,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
	 	if (!show_in_pager && !opt.status_only)
	 		setup_pager();
=09=20
	-	if (!use_index && (untracked || cached))
	-		die(_("--cached or --untracked cannot be used with --no-index"));
	-
	-	if (untracked && cached)
	-		die(_("--untracked cannot be used with --cached"));
	-
	 	if (!use_index || untracked) {
	 		int use_exclude =3D (opt_exclude < 0) ? use_index : !!opt_exclude;
	 		hit =3D grep_directory(&opt, &pathspec, use_exclude, use_index);
=09
I.e. to have this be a new parse_opt_type. Then we'd just make note of
what's incompatible with what other stuff, and in parse_options_step()
check if the option we're currently looking at (e.g. --no-index) is
still the only one set out of a list-of-lists incompatible options.

And for i18n I really don't think we need to spend effort on detecting a
case where --foo --bar and --baz are all incompatible, and saying one
of:

    --bar is incompatible with --foo

Or:

    --bar is incompatible with --foo and --baz

Depending on whether the command-line is "--foo --bar" or "--foo --bar
--baz", let's just in both cases say:

    --bar is incompatible with --foo

Then if the user adjusts "--foo --bar --baz" to "--foo --baz" we'll just
show them a new error, using the same template:

    --baz is incompatible with --foo

I.e. doing this as we iterate options is Good Enough, it's not worth the
complexity or translator time to try to exhaustively list all
conflicting options at once.
