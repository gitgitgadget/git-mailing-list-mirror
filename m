Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA67C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 05:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279D161360
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 05:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhGOFDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 01:03:06 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:36767 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGOFDA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 01:03:00 -0400
Received: by mail-ed1-f51.google.com with SMTP id h2so6296551edt.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 22:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMvFOZq2nVINfMwcPWIwXlrWO7YdUI9powvFdwklWCQ=;
        b=TMVLt7n1/RRFHsDSUK7wSqvFIOreQNouiYuzLvQO/eApwjq5dwLCAFcr9V27Sd87Rv
         8vh0fBp2+2Seac1wHCg6ocF4xMP3dhS2XAgoNtnv143YsRrJToKXH6azSDmhJQM89Fu/
         dVdCAB9FqlRuMNvRVDWHOig0Z+fz+nSO4iSJjxEYLI3ArarXU3xrewXhr4rQGpZCYdxZ
         jdScUZ6aiutlFjsNWYQ0Re8MdXoXN5EBLVOjQ32ErXEBnWcJAxcu7GepH3iZb04VIgzj
         st1QvklQCaaG2Wc8Ko4i/Q9plrNqfdAjPSubNJcgIla/tZlAroCtvrks8nlzF4tpPoP3
         QPfA==
X-Gm-Message-State: AOAM530chKfapaXNzHjsspXGGxtlUznUfOpiLdXIE6Dfstin1pLc79YB
        f4rywzM8DgPeL/ZDHKy+SpGrvtE1WNXeOnI5grA=
X-Google-Smtp-Source: ABdhPJy2MsFSz5VdMsWaVu3shYetaISzCQMDrPEyl1szFKSBNr+wqkdK/QkOlnLi/v3DlIL141fTg6fEWaoqafIcWtw=
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr3697787edu.221.1626325205631;
 Wed, 14 Jul 2021 22:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com> <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
In-Reply-To: <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Jul 2021 00:59:54 -0400
Message-ID: <CAPig+cRZ7gFACO9eNtGmXjt_SG2oviXR7JjuW2w0wZeV7pMjkQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:41 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The --rebase[=...] flags and the various ff flags are incompatible,
> except that --no-rebase (or --rebase=false) work with any of the ff
> flags, and --ff works with any of the rebase flags.
> [...]
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> +test_expect_success 'report conflicting configuration' '
> +       git reset --hard c2 &&
> +       test_must_fail git -c pull.ff=false -c pull.rebase=true pull . c1 2>err &&
> +       test_i18ngrep "pull.rebase and pull.ff are incompatible; please unset one" err
> +
> +'

nit: unnecessary and inconsistent blank line at end of test
