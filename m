Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C944AC433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbhLGU0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbhLGU0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:26:31 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1497FC061D60
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:22:57 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z5so674743edd.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWsWOWzNfHDaMiFTLDPKW4LriX2XAxCTkytG+CP2bVc=;
        b=U1gp4s7H7j8O9p37so8N++6qkRREhRMB5WpFIIyZDsHBYYJM5NE0YAE2tov3JI+6TG
         ZpXUxRUxbX7EJAUOWFeyLjCyKXSbJD+9tfgA3IONrjsoiN0P2tT8mAx0nFL2URgQpinB
         /+J2O/I/pMaqQfocvwhwmXpyhNSMCPMOH4bS0PKQUJZczMWBR7wguNpuF4bAv5Jm75q7
         MphLyR6bfRhkEY2V1fx7HydtmqycpjaS8+emgI9aEJjegW5mpiazxDI7oJ36+/gU+WPc
         UFTNAGDhdcEZBqFq7u5Ft2xHYXvImMv+EkOBQrkyb3FjUhpdPS2GgOfrwwWw6YNCmGOs
         JDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWsWOWzNfHDaMiFTLDPKW4LriX2XAxCTkytG+CP2bVc=;
        b=anIw09JZB1XfCGnpRpjVOSiiIsLjoJDAlkCY5Y+jwgmoCjlQZa3inlVkicwm/Z++7c
         tByNA2FPQD/HkHzaF2mBMpt++EatdTCQyUh2dte+UIKCQ7KcJniSVJe9MgjptPbPux/a
         JIlKEPplk82gf76QL2asUgXFpuPpzeNUU+wwgzmuFC7bSmnrqDDQzL7O2r304nmMZrOq
         KJ4eSvNgcIhnOml6IchQOavjVMs3ZAZpV/Djz6Gfy8+xD3xKA5kQPoO1bb2IbT5+Dt4e
         EHyip7SWALKFt4RQlq7yXMvLlywYJVxDIGTj8BqMQO+33/m4g0eGfVwQzFvb9wrML1bF
         +DRw==
X-Gm-Message-State: AOAM530f9p4YIRjfiPYiwq/KP05cGVUeoIM1QTwc/b0hxVFt363q6UvU
        riXxtKL7hlVrzIv0UPRAZqDcDNrx22rwwAXZR4Q=
X-Google-Smtp-Source: ABdhPJwVin2DJEfO/Ocy0UMZPK1ik7/zIurpidjLMCzm1eRtrGP9qgzvoMxiveo43m7Wiu7AWcOhQkOIsaww62MV3yM=
X-Received: by 2002:a17:907:3fa0:: with SMTP id hr32mr1878682ejc.443.1638908575402;
 Tue, 07 Dec 2021 12:22:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1069.git.1638907336.gitgitgadget@gmail.com> <becbee16d2ee503a7f698364aef672d4cadf5079.1638907336.git.gitgitgadget@gmail.com>
In-Reply-To: <becbee16d2ee503a7f698364aef672d4cadf5079.1638907336.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Dec 2021 12:22:44 -0800
Message-ID: <CABPp-BF0VkL0VQYWu1SObVGVQA7TkHXT67vHQVQpkvmc3xMa8g@mail.gmail.com>
Subject: Re: [PATCH 1/3] sparse-checkout: fix segfault on malformed patterns
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 12:02 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Then core.sparseCheckoutCone is enabled, the sparse-checkout patterns are
> used to populate two hashsets that accelerate pattern matching. If the user
> modifies the sparse-checkout file outside of the 'sparse-checkout' builtin,
> then strange patterns can happen, triggering some error checks.
>
> One of these error checks is possible to hit when some special characters
> exist in a line. A warning message is correctly written to stderr, but then
> there is additional logic that attempts to remove the line from the hashset
> and free the data. This leads to a segfault in the 'git sparse-checkout
> list' command because it iterates over the contents of the hashset, which is
> no invalid.

s/no invalid/now invalid/ ?

>
> The fix here is to stop trying to remove from the hashset. Better to leave
> bad data in the sparse-checkout matching logic (with a warning) than to
> segfault. If we are in this state, then we are already traversing into
> undefined behavior, so this change to keep the entry in the hashset is no
> worse than removing it.
>
> Add a test that triggers the segfault without the code change.
>
> Reported-by: John Burnett <johnburnett@johnburnett.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.c                              |  3 ---
>  t/t1091-sparse-checkout-builtin.sh | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 5aa6fbad0b7..0693c7cb3ee 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -819,9 +819,6 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
>                 /* we already included this at the parent level */
>                 warning(_("your sparse-checkout file may have issues: pattern '%s' is repeated"),
>                         given->pattern);
> -               hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
> -               free(data);
> -               free(translated);
>         }
>
>         return;
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 272ba1b566b..c72b8ee2e7b 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -708,4 +708,19 @@ test_expect_success 'cone mode clears ignored subdirectories' '
>         test_cmp expect out
>  '
>
> +test_expect_success 'malformed cone-mode patterns' '
> +       git -C repo sparse-checkout init --cone &&
> +       mkdir -p repo/foo/bar &&
> +       touch repo/foo/bar/x repo/foo/y &&
> +       cat >repo/.git/info/sparse-checkout <<-\EOF &&
> +       /*
> +       !/*/
> +       /foo/
> +       !/foo/*/
> +       /foo/\*/
> +       EOF
> +       cat repo/.git/info/sparse-checkout &&
> +       git -C repo sparse-checkout list
> +'
> +
>  test_done
> --
> gitgitgadget
>
