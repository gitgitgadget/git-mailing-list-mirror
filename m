Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787D6C38A02
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 03:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiJZDQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 23:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiJZDQu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 23:16:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C7C8990D
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 20:16:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g16so8584452pfr.12
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 20:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mmhs3qLrBK4WuBqZqDvkvMVmNNA8ocmyaqWVsYbhf4I=;
        b=hpYtzz3YWWqy47NVq87l5UGYRiWHIfP2VuLAy9ZSTL4B83FXV3G0xWfj7j3Iy2vb/T
         Q6bLQQAiW4hGvDPKyqfAN6RQ3k5qArXyidjaKlaIQsAuKQwawQ59LlA9W+GUYHTW7I5u
         C41tX849p1bIqPGKf28oFFVwBnE7NJi7B3oj3fb89e2AUUHOyQfALU9danYEm+Oixbak
         pOLbYW5+ufeQTTCxuP3houEePzx6REsq2dQ961JGHdc6EI0wD3vAhDYs13HG0qATqGvD
         +kO+hy4/v17QRdgGEnSIGAyWkgzjJbApq8mOV4zZuax88mRJ8T5i2tXRrppDzHdjMp+g
         lVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmhs3qLrBK4WuBqZqDvkvMVmNNA8ocmyaqWVsYbhf4I=;
        b=ppVZHGFVaWdM7iayebP4PS8+gP84CBZSK48EX3N1gjtnH0vTiuDIB0Gc0eqYxPtqwX
         iGGsW0cHey7Ul4LSQaxId5QS23wNLNzxl64PQfXeyUamRfaaCajwPEy9r1vSSLYaAs8o
         sbDwP5eoQSCggmP2n0qDV1/X8NrrBGhuh1hoJ27aOGueCWukAUjQa7679Tsn7DwripFI
         ZoC950RoUM8SmeBH8VmYmEBxiUYHUE2Q0etBqaGHGuS30AUiFdLLZnhTEhHACtgl4HFT
         6cq3odAqFZNEx1Rk5EWkeMJTx5b+Xt1Xir7dlSCXcoXQpMrBgKcq7OSrzp0hl3V2Ycen
         2Mgg==
X-Gm-Message-State: ACrzQf2zGfvrPbcbWOKSoYcMs7XoqS+zomeUbSTCl6XsNCZtl2cKPomY
        OdksztNoW433Q4G2gzsuiT44AMAr0Q8=
X-Google-Smtp-Source: AMsMyM4QFfIDa2kPor/CTkSoe3gYOp461OKtiLJsJikkBB0LIuuaMtB40bsKZ12c3U46/McqVngYqg==
X-Received: by 2002:a63:7:0:b0:45b:693e:7d86 with SMTP id 7-20020a630007000000b0045b693e7d86mr36108661pga.319.1666754206050;
        Tue, 25 Oct 2022 20:16:46 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a7f8b00b0020ad7678ba0sm315801pjl.3.2022.10.25.20.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 20:16:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Anh Le via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, Anh Le <anh@canva.com>
Subject: Re: [PATCH] index: add trace2 region for clear skip worktree
References: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
Date:   Tue, 25 Oct 2022 20:16:45 -0700
Message-ID: <xmqq35bbmfz6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Anh Le via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Anh Le <anh@canva.com>
>
> In a large repository using sparse checkout, checking
> whether a file marked with skip worktree is present
> on disk and its skip worktree bit should be cleared
> can take a considerable amount of time. Add a trace2
> region to surface this information.
>
> Signed-off-by: Anh Le <anh@canva.com>
> ---
>     index: add trace2 region for clear skip worktree
>     
>     In large repository using sparse checkout, checking whether a file
>     marked with skip worktree is present on disk and its skip worktree bit
>     should be cleared can take a considerable amount of time. Add a trace2
>     region to surface this information.

It is easy to see that the change is no-op from functionality's
standpoint.  The condition under which ce->ce_flags loses the
CE_SKIP_WORKTREE bit is the same as before, and the only change is
that in the iteration a couple of variables are incremented, which
may (or may not) have performance impact, but shouldn't break
correctness.

I am not sure about the value of these counters, honestly.

If we hit a sparse dir just once, we fully flatten the index and go
back to the restart state, and it would be a bug if we still see a
sparsified directory in the in-core index after that point, so
restart_count would be at most one, wouldn't it?  Why do we even
need to count with intmax_t?

Similarly, path_count is bounded by istate->cache_nr.  As you know
the approximate size of your project, I am not sure what extra
information you want to get by counting the paths with the skip bit
set before the first sparsified directory in the in-core index
twice, and the other paths with the skip bit set just once, and
adding these numbers together.  Also again, I am not quite sure what
the point is to count the paths in intmax_t.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1368%2FHaizzz%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1368/Haizzz/master-v1
> Pull-Request: https://github.com/git/git/pull/1368
>
>  sparse-index.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index e4a54ce1943..d11049c8aeb 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -493,24 +493,33 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
>  	int dir_found = 1;
>  
>  	int i;
> +	intmax_t path_count = 0;
> +	intmax_t restart_count = 0;
>  
>  	if (!core_apply_sparse_checkout ||
>  	    sparse_expect_files_outside_of_patterns)
>  		return;
>  
> +	trace2_region_enter("index", "clear_skip_worktree_from_present_files", istate->repo);
>  restart:
>  	for (i = 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce = istate->cache[i];
>  
> -		if (ce_skip_worktree(ce) &&
> -		    path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
> -			if (S_ISSPARSEDIR(ce->ce_mode)) {
> -				ensure_full_index(istate);
> -				goto restart;
> +		if (ce_skip_worktree(ce)) {
> +			path_count++;
> +			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
> +				if (S_ISSPARSEDIR(ce->ce_mode)) {
> +					ensure_full_index(istate);
> +					restart_count++;
> +					goto restart;
> +				}
> +				ce->ce_flags &= ~CE_SKIP_WORKTREE;
>  			}
> -			ce->ce_flags &= ~CE_SKIP_WORKTREE;
>  		}
>  	}
> +	trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/path_count", path_count);
> +	trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/restart_count", restart_count);
> +	trace2_region_leave("index", "clear_skip_worktree_from_present_files", istate->repo);
>  }
>  
>  /*
>
> base-commit: 1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886
