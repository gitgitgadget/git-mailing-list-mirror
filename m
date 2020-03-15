Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A0BC10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 14:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60991206B1
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 14:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpHdgBod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgCOOjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 10:39:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37385 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCOOjS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 10:39:18 -0400
Received: by mail-qk1-f193.google.com with SMTP id z25so16673216qkj.4
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xTkn2w/gjEZ59IxJe5v59Y36SnpDUu1LraBn50+93d4=;
        b=GpHdgBodHQlxoF2wpVc0uxpVm46smGqT7o4j40LRDplO4HTkxQsvmS/R+W0QZezvyw
         AMLECxDarKCL++3gl/J5hj3jMxqdFKq+JgGpBNwiQT7hpMWWzL5wp44iIYfH7maVPTbE
         NQ/or7z3JLyur6VmRlHk5ddAJwhdNqFoMypE9QPKlnfWOAEXzLBMXSAt1j39pD8MnAt7
         fygdeECpBVscsxcikD+jeHa3YCYDt1xAoyq/8MiqLYsX0FVs3b/DtmQdAYVSyjUMqXmc
         eCeqsnA3y9aCIef3Nu4q2+KWjbjBrs3a4QtYwppDJKGNu2a4To3C84CqopaiNEB1UCDt
         RK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xTkn2w/gjEZ59IxJe5v59Y36SnpDUu1LraBn50+93d4=;
        b=XrkItinXrcgyq1y+aiEJuGcRQX0XAS2rLFMcanNT1ArGVRs/B6Jyw00MxopkR/ZIBN
         vi3zIRRhZMO74PKpbaQPmTuHVOiuNx7scZ0Bc7cPgarOHZ0BvMNzvtCoAvDg/L7P5IK8
         f+sMnWoCVoYXxaunzVwm6V2mp74IRdVDXo7patSZYCQYizua/nWSLAC4pZrkNInYiIdF
         17JfoPsBTyzx/2XwAOgMcg2dxuHEqdhJiHbz5FG0oCd9V2k5fdqLQsMZ/KDUGTr/Ax+P
         4srEZNl1ARAmoiO5ab2LgNU7mQskUmcUt/aquz7Hf68+ucxfsvUW+QrYl1UyaHxS9zYn
         bf5g==
X-Gm-Message-State: ANhLgQ2j8C2+OF/bVWcTwS2m+Pcxe4h8OV7cODsUTm6zdR9mUGlCZkB2
        h3IsUpkFwDUeaA8ol0DifJ0=
X-Google-Smtp-Source: ADFU+vv/HDmgUK+oBYiDInCVNh9K7tDUHctJeebKguLTNpWYXBoyTD7zdht3QeA2izNhwOcX21QT4A==
X-Received: by 2002:a37:546:: with SMTP id 67mr21494491qkf.272.1584283156559;
        Sun, 15 Mar 2020 07:39:16 -0700 (PDT)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x127sm12151854qke.135.2020.03.15.07.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 07:39:16 -0700 (PDT)
Subject: Re: [PATCH 4/7] unpack-trees: do not mark a dirty path with
 SKIP_WORKTREE
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <baa4f23421b6bc245b790cdfc1fc64f5e064bca0.1584169893.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <76845bbf-720f-114a-6941-fcdde536732f@gmail.com>
Date:   Sun, 15 Mar 2020 10:39:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <baa4f23421b6bc245b790cdfc1fc64f5e064bca0.1584169893.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cOn 3/14/2020 3:11 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> If a path is dirty, removing from the working tree risks losing data.
> As such, we want to make sure any such path is not marked with
> SKIP_WORKTREE.  While the current callers of this code detect this case
> and re-populate with a previous set of sparsity patterns, we want to
> allow some paths to be marked with SKIP_WORKTREE while others are left
> unmarked without it being considered an error.  The reason this
> shouldn't be considered an error is that SKIP_WORKTREE has always been
> an advisory-only setting; merge and rebase for example were free to
> materialize paths and clear the SKIP_WORKTREE bit in order to accomplish
> their work even though they kept the SKIP_WORKTREE bit set for other
> paths.  Leaving dirty working files in the working tree is thus a
> natural extension of what we have already been doing.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  unpack-trees.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 853d843b17a..8f10ac91ce1 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -504,8 +504,11 @@ static int apply_sparse_checkout(struct index_state *istate,
>  		 * also stat info may have lost after merged_entry() so calling
>  		 * verify_uptodate() again may fail
>  		 */
> -		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
> +		if (!(ce->ce_flags & CE_UPDATE) &&
> +		    verify_uptodate_sparse(ce, o)) {
> +			ce->ce_flags &= ~CE_SKIP_WORKTREE;
>  			return -1;
> +		}
>  		ce->ce_flags |= CE_WT_REMOVE;
>  		ce->ce_flags &= ~CE_UPDATE;
>  	}

I initially thought that you needed to update some
blocks in clear_ce_flags_dir() around cone mode where
we skip sections that are outside of the cone. However,
this seems to be working on the results after the
clear_ce_flags() has completed. Should work.

Thanks,
-Stolee
