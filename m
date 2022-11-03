Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1472EC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 23:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiKCXbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 19:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKCXbL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 19:31:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E87A1F2F0
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 16:31:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a2510d5000000b006be7970889cso3444391ybq.21
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 16:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OiIQ77Qhf1hhtmXewdRVEruCnDxQgTgDoFQoO8Yem8=;
        b=KmH8+8qMJ5RnxKSIH/VujLkoidLU+p9kR0h0hOAa10Uy/qNdII4YqH/zew0YTlyKpg
         taK8HF0l16GEU6Q2G31Z+aUb8LVYv61UR3TXsbKhRRZfW/wUNg18d9Vb9VX0ml77wLR1
         GysYb7lp7OrpKkHNTRL5KHFtj5JHC7w9zK12IBI5YQimy95/7ywr3esOgkh2UpdimCsL
         0Ydu+sjdYDOyOnXy2RCLxN3lge7WEOZn9FW0FxnCmKQBh7Q9YOXgAbXM3Om0W1ePG3oW
         CGY9pw7H6yfs5lDioDhGTsHCz7mgyOb2SrMtprJoUni1n4AdKYHIQwX5655kgvmPOaOt
         GEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8OiIQ77Qhf1hhtmXewdRVEruCnDxQgTgDoFQoO8Yem8=;
        b=fCeyzYw/l9e4Ws6lVzqOLfSiFpVN5ydHNjD6XyK6HT1jys2qV1RiEgLMfOvJIiKNOz
         TxPKso/VVFojvZ/iq4rCA/43vwPIP5ngqcSpRCuvHKuAj9Mj2YX88F55KCNMEXmG1Nan
         +nC+GB08Dtq45t+ujtzrRsMW+FsoXmQ2EPs6+iX9Pje3pC2uCePxT6+sHnBOCPD30KHl
         RQISDGV8ZT3zw5Um3gDA0ntQzNIYJ11ybrhyQaKndW0m5QmTbTXruiZDoWh4MHmblUZx
         ArlzjIy/4r+XYAC4qlVeKTAiSRPWnRyFJxlCGDkTWmgGLTGV/xFP+7eJoZT04VN25nOF
         +SqQ==
X-Gm-Message-State: ACrzQf333NEnmWY3OdvUuU3AoBE2qLwaXE6u/mfYK2t+ZR40kvz/0PxN
        VNcxZtC4gfKH9yd7N4x1aXHu1dzCJ+zAVg==
X-Google-Smtp-Source: AMsMyM7xJW0labePnOm8pZc1P8ACeVhx0sMUPWAXaIjUBg/XeVsowgzzD9MhieJFZdCL3rWewnznLEhXntC8/A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6902:919:b0:6ca:e3de:f401 with SMTP
 id bu25-20020a056902091900b006cae3def401mr205023ybb.236.1667518268608; Thu,
 03 Nov 2022 16:31:08 -0700 (PDT)
Date:   Thu, 03 Nov 2022 16:31:07 -0700
In-Reply-To: <patch-8.8-105853cd358-20221102T074148Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <patch-8.8-105853cd358-20221102T074148Z-avarab@gmail.com>
Message-ID: <kl6l7d0bobt0.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 8/8] submodule--helper: use OPT_SUBCOMMAND() API
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Have the cmd_submodule__helper() use the OPT_SUBCOMMAND() API
> introduced in fa83cc834da (parse-options: add support for parsing
> subcommands, 2022-08-19).
>
> This is only a marginal reduction in line count, but once we start
> unifying this with a yet-to-be-added "builtin/submodule.c" it'll be
> much easier to reason about those changes, as they'll both use
> OPT_SUBCOMMAND().

Even if nothing else, this is a nice standardization change :)

> We don't need to worry about "argv[0]" being NULL in the die() because
> we'd have errored out in parse_options() as we're not using
> "PARSE_OPT_SUBCOMMAND_OPTIONAL".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 78 ++++++++++++++++++-------------------
>  git.c                       |  2 +-
>  2 files changed, 39 insertions(+), 41 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2012ad31d7f..0bc25dcf5ae 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -3350,47 +3350,45 @@ static int module_add(int argc, const char **argv=
, const char *prefix)
>  	return ret;
>  }
> =20
> -#define SUPPORT_SUPER_PREFIX (1<<0)
> -
> -struct cmd_struct {
> -	const char *cmd;
> -	int (*fn)(int, const char **, const char *);
> -	unsigned option;
> -};
> -
> -static struct cmd_struct commands[] =3D {
> -	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
> -	{"add", module_add, 0},
> -	{"update", module_update, SUPPORT_SUPER_PREFIX},
> -	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
> -	{"init", module_init, 0},
> -	{"status", module_status, SUPPORT_SUPER_PREFIX},
> -	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
> -	{"deinit", module_deinit, 0},
> -	{"summary", module_summary, 0},
> -	{"push-check", push_check, 0},
> -	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
> -	{"set-url", module_set_url, 0},
> -	{"set-branch", module_set_branch, 0},
> -	{"create-branch", module_create_branch, 0},
> -};
> -
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefi=
x)
>  {
> -	int i;
> -	if (argc < 2 || !strcmp(argv[1], "-h"))
> -		usage("git submodule--helper <command>");
> -
> -	for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
> -		if (!strcmp(argv[1], commands[i].cmd)) {
> -			if (get_super_prefix() &&
> -			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
> -				die(_("%s doesn't support --super-prefix"),
> -				    commands[i].cmd);
> -			return commands[i].fn(argc - 1, argv + 1, prefix);
> -		}
> -	}
> +	const char *cmd =3D argv[0];
> +	const char *subcmd;
> +	parse_opt_subcommand_fn *fn =3D NULL;
> +	const char *const usage[] =3D {
> +		N_("git submodule--helper <command>"),
> +		NULL
> +	};
> +	struct option options[] =3D {
> +		OPT_SUBCOMMAND("clone", &fn, module_clone),
> +		OPT_SUBCOMMAND("add", &fn, module_add),
> +		OPT_SUBCOMMAND("update", &fn, module_update),
> +		OPT_SUBCOMMAND("foreach", &fn, module_foreach),
> +		OPT_SUBCOMMAND("init", &fn, module_init),
> +		OPT_SUBCOMMAND("status", &fn, module_status),
> +		OPT_SUBCOMMAND("sync", &fn, module_sync),
> +		OPT_SUBCOMMAND("deinit", &fn, module_deinit),
> +		OPT_SUBCOMMAND("summary", &fn, module_summary),
> +		OPT_SUBCOMMAND("push-check", &fn, push_check),
> +		OPT_SUBCOMMAND("absorbgitdirs", &fn, absorb_git_dirs),
> +		OPT_SUBCOMMAND("set-url", &fn, module_set_url),
> +		OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
> +		OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
> +		OPT_END()
> +	};
> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +	subcmd =3D argv[0];
> +
> +	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
> +	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
> +	    strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
> +	    get_super_prefix())
> +		/*
> +		 * xstrfmt() rather than "%s %s" to keep the translated
> +		 * string identical to git.c's.
> +		 */
> +		die(_("%s doesn't support --super-prefix"),
> +		    xstrfmt("'%s %s'", cmd, subcmd));

FYI I'm preparing a series to get rid of the SUPPORT_SUPER_PREFIX checks
in both the top level and in submodule--helper (i.e. revisiting my
complaints from [1]), but I haven't sent it out yet because I haven't
found the right way to motivate that change. Feel free to chime in on
that series when it comes out.

[1] https://lore.kernel.org/git/20220630221147.45689-5-chooglen@google.com/

> -	die(_("'%s' is not a valid submodule--helper "
> -	      "subcommand"), argv[1]);
> +	return fn(argc, argv, prefix);
>  }
> diff --git a/git.c b/git.c
> index ee7758dcb0e..fb69e605912 100644
> --- a/git.c
> +++ b/git.c
> @@ -610,7 +610,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
>  	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>  	{ "stripspace", cmd_stripspace },
> -	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER=
_PREFIX | NO_PARSEOPT },
> +	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER=
_PREFIX },
>  	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
>  	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
>  	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
> --=20
> 2.38.0.1280.g8136eb6fab2
