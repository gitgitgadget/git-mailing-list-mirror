Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EE0C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 23:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiBHXDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiBHXDa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 18:03:30 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED064C06173B
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 15:03:27 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k25so2014381ejp.5
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 15:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rl2pcbyahNa7ffvxsCNdez0malCgTL3EFfXYWPa9J2M=;
        b=CAjsxVybs3l6c/QiX71fbioMFeDi/u8Gif0oYokAxHRqkL3S+GOnnMFi/qlMwdAV+s
         DdopdjOes5IkDFuWKwGAUSmxVC5yZKGMY3H5ckfFXLzl+loDSbtd0NxElhfCPwf01r0S
         wNCkLv/qcPcO6SGFhQDwwaRtgmHB2DQz4gwdSZq9v+ByFsiMyZyGHCRuD2QmlrtTsE3+
         IlEmRpbcyU349GcyXIg+36zeNaozNOIGukprCGUGAaoP6UMwuDZu/kteIrb34es6Fa88
         Yu/kTGW/zjIm0Jz2D9tlFgGmW7GnxRXHL0fv4se35cIjzDUN5j0FaLCXzQXPDATLIZjK
         Cp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rl2pcbyahNa7ffvxsCNdez0malCgTL3EFfXYWPa9J2M=;
        b=ZjhhuJ9VgrJabx51d3z7MjLcL9zEyv0XiEGxNuIiyM1iubkaxujg6CWetBKR1Hxz02
         AApPhMl2jDrSFjNYMe3gHcFKtiuguomDyBOIprTCVkiATxvUq3n2eKwBb063qBcgAxLe
         PJzpfQXpb2A9DNvM9otCPDwK8hbZwpLQCfmBaW89U4l/2p8qjqNNaHK23hIaCDXzVIyT
         Jr8qG6SrF9H7xUmqwe8aDTKJurdXchsRsTHwKN7+Autc1DKbrXDGDrmRskMHeV318sqc
         cEYjzW+XskoaJdNDoTpfjN+QVp7HSda3Bkh3lr8r1ESpJ9pWbJE+BAVlyapCrKMg6UeE
         t2yA==
X-Gm-Message-State: AOAM533iSrZn1XGXyLQgWiB7YV2m3sF8j+U05nGTl28wlDXtfh09TKDb
        QUv7cusKzfePFqNPraXZEVhCkUFi/mej35hwOKQ=
X-Google-Smtp-Source: ABdhPJwJOEp5J5Dep+dHH8D3NN/lQ3gtXf8cD2Uy740WDj2RiB0oY2Wgix75Areziw+dHbJzzx3HGiX400L5gQDsoHE=
X-Received: by 2002:a17:907:1115:: with SMTP id qu21mr5545897ejb.192.1644361406264;
 Tue, 08 Feb 2022 15:03:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <eddbdde222a01113d8facdcb17d6ec85676edbe7.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <eddbdde222a01113d8facdcb17d6ec85676edbe7.1643328752.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Feb 2022 15:03:14 -0800
Message-ID: <CABPp-BHvGOH5copWukeTy55dXDz1yq47VJcrZRj_b8cZgTy_VQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] bisect--helper: make `--bisect-state` optional
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 3:52 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In preparation for making `git bisect` a real built-in, let's prepare
> the `bisect--helper` built-in to handle `git bisect--helper good` and
> `git bisect--helper bad`, i.e. do not require the `--bisect-state`
> option to be passed explicitly.
>
> To prepare for converting `bisect--helper` to a full built-in
> implementation of `git bisect` (which must not require the
> `--bisect-state` option to be specified at all), let's move the handling
> toward the end of the `switch (cmdmode)` block.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/bisect--helper.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index cc5a9ca41b9..219fa99cd0b 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -26,8 +26,8 @@ static const char * const git_bisect_helper_usage[] = {
>         N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
>                                             " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
>         N_("git bisect--helper --bisect-next"),
> -       N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
> -       N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
> +       N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
> +       N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
>         N_("git bisect--helper --bisect-replay <filename>"),
>         N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
>         N_("git bisect--helper --bisect-visualize"),
> @@ -1210,6 +1210,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>                              git_bisect_helper_usage,
>                              PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
>
> +       if (!cmdmode && argc > 0) {
> +               set_terms(&terms, "bad", "good");
> +               get_terms(&terms);
> +               if (!check_and_set_terms(&terms, argv[0]))
> +                       cmdmode = BISECT_STATE;
> +       }
> +
>         if (!cmdmode)
>                 usage_with_options(git_bisect_helper_usage, options);
>
> @@ -1218,11 +1225,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>                 set_terms(&terms, "bad", "good");
>                 res = bisect_start(&terms, argv, argc);
>                 break;
> -       case BISECT_STATE:
> -               set_terms(&terms, "bad", "good");
> -               get_terms(&terms);
> -               res = bisect_state(&terms, argv, argc);
> -               break;
>         case BISECT_TERMS:
>                 if (argc > 1)
>                         return error(_("--bisect-terms requires 0 or 1 argument"));
> @@ -1265,6 +1267,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>                 get_terms(&terms);
>                 res = bisect_run(&terms, argv, argc);
>                 break;
> +       case BISECT_STATE:
> +               if (!terms.term_good) {
> +                       set_terms(&terms, "bad", "good");
> +                       get_terms(&terms);
> +               }
> +               res = bisect_state(&terms, argv, argc);
> +               break;
>         default:
>                 BUG("unknown subcommand %d", cmdmode);
>         }
> --
> gitgitgadget

Does it make sense to also include something like this:

diff --git a/git-bisect.sh b/git-bisect.sh
index 405cf76f2a..fbf56649d7 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -60,7 +60,7 @@ case "$#" in
        start)
                git bisect--helper --bisect-start "$@" ;;
        bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-               git bisect--helper --bisect-state "$cmd" "$@" ;;
+               git bisect--helper "$cmd" "$@" ;;
        skip)
                git bisect--helper --bisect-skip "$@" || exit;;
        next)

to prove that you've made it optional?  (Well, assuming one has run
the tests with that change, but I did...)
