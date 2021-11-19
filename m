Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F8EC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 06:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C33E61AD2
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 06:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhKSHAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 02:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhKSHAA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 02:00:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04B5C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 22:56:58 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x6so26804463edr.5
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 22:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4kMVYem0JU39S0jMUUUxoyuN8WJ2bPFNqk3Y7jl70zA=;
        b=ZzxBfXRDrz7+dE8bNdc/s4MpLFsG5PBWRsw3zAShPxILpwwUZ5uGMdnP5iLblMYIeA
         YeockFgagcf99OsEerAsc1br/q9O7xykN8TWeMfAd2iHD505caB9ooqB3+rpPOh/Yhch
         XEUGTg/nE6xtdzDvmwrgyP6+corYebk+VPUOHtBza7k7oWbiJzhH93sMV3VcVOMTQW3W
         DEzkiy0Q+CWhsaTiVTcehg0tEoU8Wv9V/7C1eIxQMJO0mQ7jqd3bnriubF+7sV0Yz/A4
         OBa5qZoM8JUkAS2E+xoVO24I5C8kiQzqnoTp5KTXY/od0Iw6ybS5+xCKQIVM/b9kvzVU
         AnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4kMVYem0JU39S0jMUUUxoyuN8WJ2bPFNqk3Y7jl70zA=;
        b=4v21mZQ/YnbO6MCCv8WzUCFvrhTpNrddvOy3L/o/n4hGxL2B8msUc10ZTZeQe0zz9e
         Y+rp7raDdE3FnNtk2Hy4BPSLPn/9K0ywkmXGZmMf0d65VtdoD0EMs6wtFzxdC11A1mkW
         els1g6xS7GzKPn48xICjknjMt7SBfUQrvSZRoVS8dUXzSp0aflTopnAOhldQqNuv8BMS
         4KQA6M5eZDa/ARyoZ5U4YWm8EChWil0g6hwDr+KDgCJDw5UuraGq1Y6x3amkixUPihbH
         nQmbrxsMjvBsXHY1/2HvSdjpUNF95cwy5GHjiYP0ME8RUsi2DB9/RaGWL2O64ISkOVEN
         k3/w==
X-Gm-Message-State: AOAM530ksH80IKTXubJ8nFapyleDdc1YVouqjG1V3/H794r33vP0RmEg
        NGkGNqLVvO/xsfh0ObTk/eW/6haHgxo=
X-Google-Smtp-Source: ABdhPJzbTWNEvu9yFkR7zWLcTxNcYcNmO11VS/HLoaej+rxyjj/T6rNYIwnfTr/5cuDOEzonD957QQ==
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr4673193ejp.373.1637305016984;
        Thu, 18 Nov 2021 22:56:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w7sm974286ede.66.2021.11.18.22.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 22:56:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnxpP-000ZtJ-Sn;
        Fri, 19 Nov 2021 07:56:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, chooglen@google.com
Subject: Re: [PATCH v4] branch: add flags and config to inherit tracking
Date:   Fri, 19 Nov 2021 07:47:30 +0100
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <7ad7507f183332cb2b5fdf2eb76fbbc9dd7199ef.1637085915.git.steadmon@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <7ad7507f183332cb2b5fdf2eb76fbbc9dd7199ef.1637085915.git.steadmon@google.com>
Message-ID: <211119.86v90o4oqw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Josh Steadmon wrote:

> I've addressed Glen's feedback from V3. However, this brings up a new
> issue that was not obvious before: "branch.<name>.merge" can be
> specified more than once. On the other hand, the existing tracking setup
> code supports only a single merge entry. For now I'm defaulting to use
> the first merge entry listed in the branch struct, but I'm curious what
> people think the best solution would be. This may be another point in
> favor of =C3=86var's suggestion to reuse the copy-branch-config machinery.

I haven't looked in any detail now at the "should we copy the config?"
questions. Just some quick comments/nits below:


> +static int inherit_tracking(struct tracking *tracking, const char *orig_=
ref)
> +{
> +	const char *bare_ref;
> +	struct branch *branch;
> +
> +	bare_ref =3D orig_ref;
> +	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
> +
> +	branch =3D branch_get(bare_ref);
> +	if (!branch->remote_name) {
> +		warning(_("asked to inherit tracking from %s, but no remote is set"),
> +			bare_ref);
> +		return -1;
> +	}
> +
> +	if (branch->merge_nr < 1 || !branch->merge_name || !branch->merge_name[=
0]) {
> +		warning(_("asked to inherit tracking from %s, but no merge configurati=
on is set"),
> +			bare_ref);

Should quote ('%s') the %s in both here.

> +		return -1;
> +	}
> +
> +	tracking->remote =3D xstrdup(branch->remote_name);
> +	tracking->src =3D xstrdup(branch->merge_name[0]);
> +	tracking->matches =3D 1;
> +	return 0;
> +}
> +
>  /*
>   * This is called when new_ref is branched off of orig_ref, and tries
>   * to infer the settings for branch.<new_ref>.{remote,merge} from the
> @@ -139,7 +166,9 @@ static void setup_tracking(const char *new_ref, const=
 char *orig_ref,
>=20=20
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst =3D (char *)orig_ref;
> -	if (for_each_remote(find_tracked_branch, &tracking))
> +	if (track !=3D BRANCH_TRACK_INHERIT) {
> +		for_each_remote(find_tracked_branch, &tracking);
> +	} else if (inherit_tracking(&tracking, orig_ref))
>  		return;

Style: Dangling braces, can just skip the braces here.

> @@ -632,8 +632,10 @@ int cmd_branch(int argc, const char **argv, const ch=
ar *prefix)
>  		OPT__VERBOSE(&filter.verbose,
>  			N_("show hash and subject, give twice for upstream branch")),
>  		OPT__QUIET(&quiet, N_("suppress informational messages")),
> -		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-p=
ull(1))"),
> -			BRANCH_TRACK_EXPLICIT),
> +		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
> +			N_("set up tracking mode (see git-pull(1))"),

Hrm, should we say "git help pull" here, on just not reference it at all
and have a linkgit:git-pull[1]?

Or maybe git-branch.txt and git-pull.txt should be including a template?
As we do with Documentation/rev-list-options.txt, then this
cross-reference wouldn't be needed.

> +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
> +			parse_opt_tracking_mode),
>  		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
>  			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
>  		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("=
change the upstream info")),
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index b5d477919a..45dab414ea 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1532,8 +1532,10 @@ static struct option *add_common_switch_branch_opt=
ions(
>  {
>  	struct option options[] =3D {
>  		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named =
commit")),
> -		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new=
 branch"),
> -			BRANCH_TRACK_EXPLICIT),
> +		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",
> +			N_("set up tracking mode (see git-pull(1))"),
> +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
> +			parse_opt_tracking_mode),
>  		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifica=
tions)"),
>  			   PARSE_OPT_NOCOMPLETE),
>  		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_=
("new unparented branch")),
> diff --git a/config.c b/config.c
> index cb4a8058bf..4bd5a18faf 100644
> --- a/config.c
> +++ b/config.c
> @@ -1580,6 +1580,9 @@ static int git_default_branch_config(const char *va=
r, const char *value)
>  		if (value && !strcasecmp(value, "always")) {
>  			git_branch_track =3D BRANCH_TRACK_ALWAYS;
>  			return 0;
> +		} else if (value && !strcasecmp(value, "inherit")) {
> +			git_branch_track =3D BRANCH_TRACK_INHERIT;
> +			return 0;
>  		}

Looks like an existing issue, but we just document "inherit", not
"INHERIT", "iNhErIt" etc. I.e. should it being strcasecmp()
v.s. strcmp() be documented?

> +		return error(_("option `--track' expects \"direct\" or \"inherit\""));

Already commented-on by Junio.

> +test_expect_success 'checkout --track -b overrides autoSetupMerge=3Dinhe=
rit' '
> +	# Set up tracking config on main
> +	git config branch.main.remote origin &&
> +	git config branch.main.merge refs/heads/main &&
> +	test_config branch.autoSetupMerge inherit &&
> +	# With --track=3Dinherit, we copy the tracking config from main
> +	git checkout --track=3Dinherit -b b1 main &&
> +	test_cmp_config origin branch.b1.remote &&
> +	test_cmp_config refs/heads/main branch.b1.merge &&
> +	# With branch.autoSetupMerge=3Dinherit, we do the same
> +	git checkout -b b2 main &&
> +	test_cmp_config origin branch.b2.remote &&
> +	test_cmp_config refs/heads/main branch.b2.merge &&
> +	# But --track overrides this
> +	git checkout --track -b b3 main &&
> +	test_cmp_config . branch.b3.remote &&
> +	test_cmp_config refs/heads/main branch.b3.merge &&
> +	# And --track=3Ddirect does as well
> +	git checkout --track=3Ddirect -b b4 main &&
> +	test_cmp_config . branch.b4.remote &&
> +	test_cmp_config refs/heads/main branch.b4.merge
> +'
> +

This is the last test, we can use test_config instead of "git config"
there I think, i.e. it's not setting up config for subseuent tests.
