Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F0592022D
	for <e@80x24.org>; Fri, 24 Feb 2017 01:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbdBXBQZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 20:16:25 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:37919 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdBXBQX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 20:16:23 -0500
Received: by mail-it0-f48.google.com with SMTP id y135so6404652itc.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 17:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F7vyU0WKxHnI+Lxq8sfoZzasFo2BveDH5GatqMflVBI=;
        b=EUxF9KrwRRpbZobtsE4GoKmVgT8r+lslfbFKRkV5h28Bh4cSXMcqs8yB6b2fzzOMwL
         whtKjPF0HDE5Uz1cssOx4k54wImP1FxUlRPboktIEJd4NIYigTSjsaeNPwRpmrpPjvKm
         vq9YKc+PDDE+kVFqjkklrXNaXawr+0PMX+b9z5sZ/f7a/cZUM7qTFxAo7sa3nogD0QYf
         nzIBN933xtt14CAEwiIFlix+Hl4gYKqVQZ3iAAOaktQhSmG7AqdIWxu6T7OHvoVR7ei1
         yf0rJjg6Xkv6/2t0XIH2zkx1gbQ6cYsMY1+ljkB/MeTkFQ1umhz5PBfnym0WF88S0nAm
         CELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F7vyU0WKxHnI+Lxq8sfoZzasFo2BveDH5GatqMflVBI=;
        b=Ov9MNWl+gXmZW7O/gjPInB2oPjVZU56q1KFXmnkq86Bu6IzkO/gKtJ14FgZ+PzAuF0
         LZ7O7FJZyvOTRbX7/8UQlk5ydpIFRbUIOCeBK0s2s0ym2t6C4TsDNXAD25/ldOM7fNEj
         k/BUIVpD3aYq88kdDnh+HfjCCqa2xne9bUqnjvqws+mSkiYFIVRIvLBOaFrPpyKoMpQR
         5Z0PtqNS87T44si1Ous/bze06q8GYEH+Haw11AsJUqYK8JCG2eDdJxJ8yrW+YEnEKwzm
         IeU3B9HFnXvVaRfuAWq2IEuafzVuj5xmUw9oLmuHoquPPtyknLUUmbZRwNNeC26ZcfYj
         YHmQ==
X-Gm-Message-State: AMke39kg2fafK51a49auCup4F6EARfIWuDyBO/q0EOVy73WMskKn0AjkPgyUzi3YnMvsmelpazMKPe/boKuqXTkO
X-Received: by 10.107.16.14 with SMTP id y14mr535608ioi.164.1487898935093;
 Thu, 23 Feb 2017 17:15:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Thu, 23 Feb 2017 17:15:34 -0800 (PST)
In-Reply-To: <20170223234728.164111-6-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com> <20170223234728.164111-6-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Feb 2017 17:15:34 -0800
Message-ID: <CAGZ79kZKH_e2NLd=A=og452f-1bfFcSoi5=SM5oetu87TT766Q@mail.gmail.com>
Subject: Re: [PATCH 05/10] submodule--helper: add is_active command
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 3:47 PM, Brandon Williams <bmwill@google.com> wrote:
> There are a lot of places where an explicit check for
> submodule."<name>".url is done to see if a submodule exists.  In order
> to more easily facilitate the use of the submodule.active config option
> to indicate active submodules, add a helper which can be used to query
> if a submodule is active or not.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/submodule--helper.c    | 11 ++++++++
>  t/t7413-submodule-is-active.sh | 63 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100755 t/t7413-submodule-is-active.sh
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index df0d9c166..dac02604d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1128,6 +1128,16 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +static int is_active(int argc, const char **argv, const char *prefix)
> +{
> +       if (argc != 2)
> +               die("submodule--helper is-active takes exactly 1 arguments");
> +
> +       gitmodules_config();
> +
> +       return !is_submodule_initialized(argv[1]);
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>
>  struct cmd_struct {
> @@ -1147,6 +1157,7 @@ static struct cmd_struct commands[] = {
>         {"init", module_init, 0},
>         {"remote-branch", resolve_remote_submodule_branch, 0},
>         {"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
> +       {"is-active", is_active, 0},
>  };
>
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
> new file mode 100755
> index 000000000..683487020
> --- /dev/null
> +++ b/t/t7413-submodule-is-active.sh
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +
> +test_description='Test submodule--helper is-active
> +
> +This test verifies that `git submodue--helper is-active` correclty identifies
> +submodules which are "active" and interesting to the user.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       git init sub &&
> +       test_commit -C sub initial &&
> +       git init super &&
> +       test_commit -C super initial &&
> +       git -C super submodule add ../sub sub1 &&
> +       git -C super submodule add ../sub sub2 &&
> +       git -C super commit -a -m "add 2 submodules at sub{1,2}"
> +'
> +
> +test_expect_success 'is-active works with urls' '
> +       git -C super submodule--helper is-active sub1 &&
> +       git -C super submodule--helper is-active sub2 &&
> +
> +       git -C super config --unset submodule.sub1.URL &&
> +       test_must_fail git -C super submodule--helper is-active sub1 &&
> +       git -C super config submodule.sub1.URL ../sub &&
> +       git -C super submodule--helper is-active sub1
> +'
> +
> +test_expect_success 'is-active works with basic submodule.active config' '
> +       git -C super config --add submodule.active "." &&
> +       git -C super config --unset submodule.sub1.URL &&
> +       git -C super config --unset submodule.sub2.URL &&

I think we'd want to unset only one of them here

> +
> +       git -C super submodule--helper is-active sub1 &&
> +       git -C super submodule--helper is-active sub2 &&

to test 2 different cases of one being active by config setting only and
the other having both.

I could not spot test for having the URL set but the config setting set, not
including the submodule, e.g.

    git -C super config  submodule.sub1.URL ../sub &&
    git -C super submodule.active  ":(exclude)sub1" &&

which would be expected to not be active, as once the configuration
is there it takes precedence over any (no)URL setting?
