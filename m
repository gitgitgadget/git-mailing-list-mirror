Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EAFC43217
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 13:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbiDGOBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 10:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiDGOB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 10:01:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ACE1B53A6
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 06:59:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fu5so5705859pjb.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aivuxSGn3nLGAl3sQSQbTRKtrpK5+rtzTqEr2gonT5w=;
        b=KG/Z+dsUb2kVdz/RZcFcI84JlArzmq38hVo1LPWgxi0sVNOsy1KnqqdKS4w4X5yAN4
         wegzQSfxiBV9kin5sUt8AP2jEg+s5RNd0U5Eno8tCs+xmbdKxGZVo+hoVWvQn8cu1nhT
         Hwrw/nWmhKY1r8w+fd+PVzLeEy6hyeaJ+LZeu7gbGt014VND++PsCtI9Jb3NKVX7o5Jo
         oWEa9tv8Bittxe2n2AaCezxV/525z1/pTRRHhXixFmJJ+7L1dA920fyK0QBVXFrPjNK6
         rhtFgPqrMQsdMHdIOWUoc1OSV/fIroHN59wdvjfWsSBWQGg9t9o+GDJeiQNeh/RKzbi0
         z9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aivuxSGn3nLGAl3sQSQbTRKtrpK5+rtzTqEr2gonT5w=;
        b=luFdeH6mKzeODErERb/9J/VXcAxpE90yb131Gb3Iol4HWlS4kxnhW2TRaUfF7uEvkZ
         /8JL7HdV2KhQGS+16Wcco4OcWvKTSJafwCfT7WmSxtDaOqlUzjKor6hJR92qdQckooLU
         yJJHs024xHvSgtTLrHtNbWWxII+5LmMnP5om8qaHumZofedBBT22rIHaEL7vuljuX0ps
         Exv4nd9itKhA9ZOVeh8blqqNAfhp0S58uYl5jRvSTB8UWejfR+P2PFwInxwfnbCx2zwG
         ni1t0vLSO1vGVKLZd+gC87r1uzQpdgKslim3GWkK3GX5mazFmv6LmcrUuODak9Nj84q4
         0t/g==
X-Gm-Message-State: AOAM532WgHdBo7i/niBQzHjNP9stO+7DPhcPAohXQjEX3JHN1oIebqhT
        v6+4HC8hG4csMhARVT6ADpOcPNeLm4Eo8LYbhUtyfvpW3g0=
X-Google-Smtp-Source: ABdhPJywG8ZWTVunhVnIxs8JFaZxwX/m95ECTCj7CuDMC15TZb56Ab99aZORf9gSk164EABv2xL7WHw5RqC9MkPkslU=
X-Received: by 2002:a17:902:c407:b0:156:c367:9246 with SMTP id
 k7-20020a170902c40700b00156c3679246mr14093655plk.165.1649339966907; Thu, 07
 Apr 2022 06:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com> <58c560d0e19a3fa6dd5de547821c9642089de3fb.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <58c560d0e19a3fa6dd5de547821c9642089de3fb.1645441854.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Apr 2022 15:59:15 +0200
Message-ID: <CAP8UFD3dx_Mv=X1y11LDy6NOcV0eDq5s92PqdC3LnbBFCi1kxg@mail.gmail.com>
Subject: Re: [PATCH 4/7] rebase --apply: respect GIT_REFLOG_ACTION
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 6:41 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The reflog messages when finishing a rebase hard code "rebase" rather
> than using GIT_REFLOG_ACTION.

Yeah, but GIT_REFLOG_ACTION is something like "pick" or "continue" ...

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c          | 7 ++++---
>  t/t3406-rebase-message.sh | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 36863117fba..e50361fc2a9 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -580,10 +580,11 @@ static int move_to_original_branch(struct rebase_options *opts)
>         if (!opts->onto)
>                 BUG("move_to_original_branch without onto");
>
> -       strbuf_addf(&branch_reflog, "rebase finished: %s onto %s",
> +       strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
> +                   getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>                     opts->head_name, oid_to_hex(&opts->onto->object.oid));

... so this will say "pick finished..." instead of "rebase
finished..." while it may be better to have something like "rebase
(pick) finished...", or am I missing something?

> -       strbuf_addf(&head_reflog, "rebase finished: returning to %s",
> -                   opts->head_name);
> +       strbuf_addf(&head_reflog, "%s finished: returning to %s",
> +                   getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);

In patch 2/7 GIT_REFLOG_ACTION, instead of
GIT_REFLOG_ACTION_ENVIRONMENT, is used.

It looks like GIT_REFLOG_ACTION_ENVIRONMENT is defined in reset.h
while GIT_REFLOG_ACTION is defined in sequencer.c. Maybe we could get
rid of one of these two, and use the same everywhere?

>         ropts.branch = opts->head_name;
>         ropts.flags = RESET_HEAD_REFS_ONLY;
>         ropts.branch_msg = branch_reflog.buf;
