Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D7ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 22:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJaWeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJaWee (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 18:34:34 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA65FB3
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:34:32 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id l127so10992937iof.12
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JhGVVhhRQUNDPVrjNePKsSBojan7lTY54HFy/+djgbQ=;
        b=UfXl1S9c/ce9NiShG4/aKdF6wAendoKRvTwzhOrt6gIQHwhyWI2CYc22B75DxVBCxq
         9epmpoB1YoxyQ2k89jJtVSabSN/WqIRC1s2NuoU71BpF7VF4Dgh/zlzqkgoodxLgw0Dr
         O0D1nGrZP+/qWhk8qN4cObr/OXqe3yJ0xd8rTHcJfAuDc/uiiOBqMvoPgYkUZOS/DWJL
         TRx6CbHQimqdzGlMVyqkP4yZdN8DUppDWnvZXWf1CZaNXCyGKqXZXa0mUbXo4LatS8Jn
         LRqJV7lw17/VMx3abhgnv2YB0Qfus4XPNE9DBB6D6Ym07F/47DRDSyClRUZK5aXqQfaF
         T4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhGVVhhRQUNDPVrjNePKsSBojan7lTY54HFy/+djgbQ=;
        b=xZub4qQpPAu0lyblS2P9uEaXR82jQFS2+AvSuaIof4RVFnfeja26mgZNTBdJuVJuKe
         89g9ekMmXiekUiAGtxxCPRFQTahwsKa55rVzQ7t8RoAXMfeUtP8V7/zG5nCIcFylDSo8
         v2M88DrYXOf1SnmEANf11jU4mkitdf3QNEEA9CRRd/LHqNzpZhh8p/eczXwTGKxIX/v9
         GQIKFrpUCLOF+PklflvIEtMEdyaWhWFxV5W5aaBFomVm5QXAlvzWKSY/0fTclPns6gwn
         SW5nrsiWyb/D2V1eXFKeB8YNs6OoWYLBoGsBVBhCS1+sV2YBVtSfmhkbZRuuRsSQ2WDC
         Yo6A==
X-Gm-Message-State: ACrzQf3apa9q0RUAnBr74m3zTr+w8d78tVdLLXws44ox+yJpwZFKDexA
        l81ZszmQhUFiB7Z1k2ANql7pZRuaAeXmq6GB
X-Google-Smtp-Source: AMsMyM7r1epIZCovOPT5zfAJj3X3LDVLjsSNxvRFP6ykMXhbrxlIrxWEYmAJgFVINu2GLCenBYHR3A==
X-Received: by 2002:a05:6602:2c47:b0:6bf:df74:fa5e with SMTP id x7-20020a0566022c4700b006bfdf74fa5emr8368404iov.177.1667255672180;
        Mon, 31 Oct 2022 15:34:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q83-20020a6b8e56000000b006bc48537658sm3270403iod.0.2022.10.31.15.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:34:31 -0700 (PDT)
Date:   Mon, 31 Oct 2022 18:34:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Anh Le via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Anh Le <anh@canva.com>
Subject: Re: [PATCH v3] index: add trace2 region for clear skip worktree
Message-ID: <Y2BNdvgCw/mxgV1M@nand.local>
References: <pull.1368.v2.git.git.1666917961644.gitgitgadget@gmail.com>
 <pull.1368.v3.git.git.1667177791591.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1368.v3.git.git.1667177791591.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 12:56:31AM +0000, Anh Le via GitGitGadget wrote:
> From: Anh Le <anh@canva.com>
>
> In a large repository using sparse checkout, checking whether a file marked
> with skip worktree is present on disk and its skip worktree bit should be
> cleared can take a considerable amount of time. Add a trace2 region to
> surface this information, keeping a count of how many paths have been
> checked and separately keep counts for after a full index is materialised.

I think the text you wrote here is fine, but it did take me a couple of
passes to make sure I understood it correctly.

Perhaps the following might be clearer:

    When using sparse checkout, clear_skip_worktree_from_present_files()
    must enumerate index entries to find ones with the SKIP_WORKTREE bit
    to determine whether those index entries exist on disk (in which
    case their SKIP_WORKTREE bit should be removed).

    In a large repository, this may take considerable time depending on
    the size of the index.

    Add a trace2 region to surface this information, keeping a count o
    fhow many paths have been checked. Separately, keep counts after a
    full index is materialized.

Is that accurate?

> diff --git a/sparse-index.c b/sparse-index.c
> index e4a54ce1943..8301129bf8f 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -493,24 +493,42 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
>  	int dir_found = 1;
>
>  	int i;
> +	int path_count[2] = {0, 0};
> +	int restarted = 0;

Looks good.

>  	if (!core_apply_sparse_checkout ||
>  	    sparse_expect_files_outside_of_patterns)
>  		return;
>
> +	trace2_region_enter("index", "clear_skip_worktree_from_present_files",
> +											istate->repo);

Here and below, there is some funky indentation. When I apply the patch
locally, I find that I need to squash this in:

--- >8 ---
diff --git a/sparse-index.c b/sparse-index.c
index 8301129bf8..23f997e103 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -501,7 +501,7 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 		return;

 	trace2_region_enter("index", "clear_skip_worktree_from_present_files",
-											istate->repo);
+			    istate->repo);
 restart:
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
--- 8< ---

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
> +			path_count[restarted]++;
> +			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
> +				if (S_ISSPARSEDIR(ce->ce_mode)) {
> +					if (restarted)
> +						BUG("ensure-full-index did not fully flatten?");
> +					ensure_full_index(istate);
> +					restarted = 1;
> +					goto restart;
> +				}
> +				ce->ce_flags &= ~CE_SKIP_WORKTREE;
>  			}
> -			ce->ce_flags &= ~CE_SKIP_WORKTREE;

Looks fine, though the "if (restarted) BUG(...)" is new. It's not wrong,
per-se, but seeing it in a separate commit either before or after the
main change would be appreciated.

>  		}
>  	}
> +
> +	if (path_count[0])
> +		trace2_data_intmax("index", istate->repo,
> +											 "sparse_path_count", path_count[0]);
> +	if (restarted)
> +		trace2_data_intmax("index", istate->repo,
> +											 "sparse_path_count_full", path_count[1]);
> +	trace2_region_leave("index", "clear_skip_worktree_from_present_files",
> +										  istate->repo);

Same note about indentation here.

Thanks,
Taylor
