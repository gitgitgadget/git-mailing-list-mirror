Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A24C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C769C22C7C
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbhAWUZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 15:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbhAWUZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 15:25:22 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C541C0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 12:24:42 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id w8so10316790oie.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 12:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=966qefSPPcptIbtUJEbapgPgxQzc4B1SOEgnYqUdWQU=;
        b=O0mY24ZF0ej/p+xgMQCIiCtM/MkL0YSNWGz2pkxbegI9Plc9jDzkLQzj6uVLj5Csjs
         5PyfO4WCoOeEU3gPzM2PFTeC4nd1vA9DA3DpL3YXHVnZsjsuX1LurHi5zPXOAD+VJfr8
         fMechgp6DK2pHHKlO2KpTeUfgKQN9vWBfCK8gRWLT4+fbdR/D1tZP1+yPUlt3H10CBiy
         8kTKRDjMsFP4y6AtYopyUyx7mC7NJocv0/yOWhSMX2DLnOAb7srQ85EDos1VzoFkNcVU
         2H0JKwokwscJgyNTPWCqxuZDAQaU2UaoY/RDUz0ovYW4DGrD+nRmiCRSRTpVIzRs1UFh
         EWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=966qefSPPcptIbtUJEbapgPgxQzc4B1SOEgnYqUdWQU=;
        b=WNO1WCe+p/Q2ELI5Q26gr3XTQZWucW+MmJ9x3LZaqk+o40IPD70qYRxzscTz4tfl6e
         vTT8mu7mNOGv/6928e5VipPCbTdVf8QOWgr+HeC/3mB/8H115PJC5ISodnIxp40Ex/EE
         77NlXQP1MjgJezxwlJGtaHXcyOF/L9ZMTGNzOLVFOi4rxlCYgSVzlwKhMJkyWPWz0DJ9
         tBPsh69lV70Cx0a06TXMpDcVlpcHiow26VrKmXhO8Lq4MQTclDK3H5DjjnrY3m2aB2Gt
         z2l5HTP/WHCHd+FVIGkK6DgasAZnEZel1k79a56S4XP+iURltRa5MNZSPRnrGOLNNkk+
         35JA==
X-Gm-Message-State: AOAM533b4zc5lB95sjXc5mXkJY/deoAmHVawz7t2+vm8sNqBKGqfQVyl
        fOpgop8v4Q+bfuEx6dGHgddli07IH35/Z63hLEPW+swxpGA=
X-Google-Smtp-Source: ABdhPJxOeoWydHykSQZMc7J9zJs7maNJAGRNTEAr9MiyAwu8YNJK5jA7sYHQWMt7DkH6Dv9hX2jCMx7jkdVdpogpvrU=
X-Received: by 2002:aca:cf03:: with SMTP id f3mr6930959oig.39.1611433481522;
 Sat, 23 Jan 2021 12:24:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
 <pull.839.v3.git.1611431899.gitgitgadget@gmail.com> <1b8b56800948339c0e0387555698bdfdc80a19ad.1611431900.git.gitgitgadget@gmail.com>
In-Reply-To: <1b8b56800948339c0e0387555698bdfdc80a19ad.1611431900.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 23 Jan 2021 12:24:30 -0800
Message-ID: <CABPp-BEsoWs5ZEhS0KTHankzc8eUdmpn0uoF7t1ZtN8b2gwvBA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] cache-tree: simplify verify_cache() prototype
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 23, 2021 at 11:58 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The verify_cache() method takes an array of cache entries and a count,
> but these are always provided directly from a struct index_state. Use
> a pointer to the full structure instead.
>
> There is a subtle point when istate->cache_nr is zero that subtracting
> one will underflow. This triggers a failure in t0000-basic.sh, among
> others. Use "i + 1 < istate->cache_nr" to avoid these strange
> comparisons. Convert i to be unsigned as well, which also removes the
> potential signed overflow in the unlikely case that cache_nr is over 2.1
> billion entries. The 'funny' variable has a maximum value of 11, so

AND a minimum value of 0 (which is important for the type change to be valid).

> making it unsigned does not change anything of importance.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache-tree.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 60b6aefbf51..acac6d58c37 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -151,16 +151,15 @@ void cache_tree_invalidate_path(struct index_state *istate, const char *path)
>                 istate->cache_changed |= CACHE_TREE_CHANGED;
>  }
>
> -static int verify_cache(struct cache_entry **cache,
> -                       int entries, int flags)
> +static int verify_cache(struct index_state *istate, int flags)
>  {
> -       int i, funny;
> +       unsigned i, funny;
>         int silent = flags & WRITE_TREE_SILENT;
>
>         /* Verify that the tree is merged */
>         funny = 0;
> -       for (i = 0; i < entries; i++) {
> -               const struct cache_entry *ce = cache[i];
> +       for (i = 0; i < istate->cache_nr; i++) {
> +               const struct cache_entry *ce = istate->cache[i];
>                 if (ce_stage(ce)) {
>                         if (silent)
>                                 return -1;
> @@ -180,13 +179,13 @@ static int verify_cache(struct cache_entry **cache,
>          * stage 0 entries.
>          */
>         funny = 0;
> -       for (i = 0; i < entries - 1; i++) {
> +       for (i = 0; i + 1 < istate->cache_nr; i++) {
>                 /* path/file always comes after path because of the way
>                  * the cache is sorted.  Also path can appear only once,
>                  * which means conflicting one would immediately follow.
>                  */
> -               const struct cache_entry *this_ce = cache[i];
> -               const struct cache_entry *next_ce = cache[i + 1];
> +               const struct cache_entry *this_ce = istate->cache[i];
> +               const struct cache_entry *next_ce = istate->cache[i + 1];
>                 const char *this_name = this_ce->name;
>                 const char *next_name = next_ce->name;
>                 int this_len = ce_namelen(this_ce);
> @@ -438,7 +437,7 @@ int cache_tree_update(struct index_state *istate, int flags)
>  {
>         int skip, i;
>
> -       i = verify_cache(istate->cache, istate->cache_nr, flags);
> +       i = verify_cache(istate, flags);
>
>         if (i)
>                 return i;
> --
> gitgitgadget

Makes sense.  Thanks for explaining the i + 1 < istate->cache_nr bit
in the commit message; made it easier to read through quickly.  I'm
curious if it deserves a comment in the code too, since it does feel
slightly unusual.
