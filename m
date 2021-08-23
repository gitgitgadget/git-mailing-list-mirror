Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,TRACKER_ID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDC5C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6DD61073
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 14:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhHWO0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhHWO0n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 10:26:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF8C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 07:26:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u14so12608909ejf.13
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=yWQ1cMhgGUAMzzcSZzD/ZJNovDm8fKK6Yrn5YfweRkM=;
        b=d5wDt2wauzjvszDlyfeSxWeekF4JAMyPebvCjCluxDVGTHgbd3dNXFIi2MU5ZQSoOQ
         v5ex7HZBkzdDSL2YEyrILVyWXzSQNDcyANYALmXUmwOdopVB8WXT98EYzkyAKyLEkYYd
         mwxbKB32VS9zKalTjh7WX5lb2/K79cFwi63BTMxH+a+1sKqmA+kH58dupY+KKA1Km1ai
         4Xktu3y44T5QlKL3XEwAtZqQFQNXSx4F/wlF8FwEP+WFHruL69VHkI0/5YQD2dEsn5tT
         l5kuteUX0hyDUc2t8XatLVmwoToanb2ZcoIK2gaxn0AvWGNcBMp22YVRxxnWJUZUiKcs
         Z7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=yWQ1cMhgGUAMzzcSZzD/ZJNovDm8fKK6Yrn5YfweRkM=;
        b=Qg8XN3DYLAX3ejujrCHyXp3whwLAfLpsa3kBcBY5IfTjRQxgdr68v1TIhaghvCTTIk
         aQqdvGfPQQUlJleyPayjWEFNKpxbTVPuPbjiX4yXhmkuEx3s2RE7AWx3HJH5G9jxr1cG
         e4DgI9OFxKSCSVRT86A00Fi7+kSuq/4/nfFSrRRAQgfZbAdsR9eGSdC+sVhRcXnqaKDM
         tVN/LgIV33NM2vFuNd9gLUYiLq2psFcmglTena18GSQy/D7Vif7I3pr0/9coLKSu/0tE
         5fFWpwPCwtdQiR8zfzTqCRQFi3dfnrxKDWKhsG/189LDuaKde34hwYDyBYLMaLZdlIU3
         c1Fg==
X-Gm-Message-State: AOAM5323Gh+CFNDxqI7G6x20AZBkYD69mPdeCoGs6DE0fcODBlgnAPMh
        dV1c5rMKP+7f46PkDmvZl7X8POE3344lY89j
X-Google-Smtp-Source: ABdhPJxzFPB32aEK+qxg2E9wXZtsAwraqIZGvuEZ74lpkrWeQEvcL36oD6jfEWpd6hzhJx1Bo6Q1Gw==
X-Received: by 2002:a17:906:9b53:: with SMTP id ep19mr11155478ejc.86.1629728759163;
        Mon, 23 Aug 2021 07:25:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c6sm7526429eje.105.2021.08.23.07.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:25:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        newren@gmail.com, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] sparse-index: copy dir_hash in ensure_full_index()
Date:   Mon, 23 Aug 2021 16:25:15 +0200
References: <pull.1017.git.1629136135286.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <pull.1017.git.1629136135286.gitgitgadget@gmail.com>
Message-ID: <87h7fgfdah.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 16 2021, Derrick Stolee via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Copy the 'index_state->dir_hash' back to the real istate after expanding
> a sparse index.
>
> A crash was observed in 'git status' during some hashmap lookups with
> corrupted hashmap entries.  During an index expansion, new cache-entries
> are added to the 'index_state->name_hash' and the 'dir_hash' in a
> temporary 'index_state' variable 'full'.  However, only the 'name_hash'
> hashmap from this temp variable was copied back into the real 'istate'
> variable.  The original copy of the 'dir_hash' was incorrectly
> preserved.  If the table in the 'full->dir_hash' hashmap were realloced,
> the stale version (in 'istate') would be corrupted.
>
> The test suite does not operate on index sizes sufficiently large to
> trigger this reallocation, so they do not cover this behavior.
> Increasing the test suite to cover such scale is fragile and likely
> wasteful.

How large does the index need to be to trigger this? I don't know if a
test here is useful, but FWIW if we had such a test then the EXPENSIVE
prereq + GIT_TEST_LONG=true might be a good fit for it.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     sparse-index: copy dir_hash in ensure_full_index()
>     
>     This fix is an issue we discovered in our first experimental release of
>     the sparse index in the microsoft/git fork. We fixed it in the latest
>     experimental release [1] and then I almost forgot about it until we
>     started rebasing sparse-index work on top of the 2.33.0 release
>     candidates.
>     
>     [1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.exp
>     
>     This is a change that can be taken anywhere since 4300f8 (sparse-index:
>     implement ensure_full_index(), 2021-03-30), but this version is based on
>     v2.33.0-rc2.
>     
>     While the bug is alarming for users who hit it (seg fault) it requires
>     sufficient scale and use of the optional sparse index feature. We are
>     not recommending wide adoption of the sparse index yet because we don't
>     have a sufficient density of integrated commands. For that reason, I
>     don't think this should halt progress towards the full v2.33.0 release.
>     I did want to send this as soon as possible so that could be at the
>     discretion of the maintainer.
>     
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1017%2Fderrickstolee%2Fsparse-index%2Ffix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1017/derrickstolee/sparse-index/fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1017
>
>  sparse-index.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index c6b4feec413..56eb65dc349 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -283,6 +283,7 @@ void ensure_full_index(struct index_state *istate)
>  
>  	/* Copy back into original index. */
>  	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
> +	memcpy(&istate->dir_hash, &full->dir_hash, sizeof(full->dir_hash));
>  	istate->sparse_index = 0;
>  	free(istate->cache);
>  	istate->cache = full->cache;
>
> base-commit: 5d213e46bb7b880238ff5ea3914e940a50ae9369

