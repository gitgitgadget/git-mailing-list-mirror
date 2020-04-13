Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0233C2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DDF62063A
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tsRg932a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgDMQMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbgDMQMr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 12:12:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A620C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:12:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l1so4671504pff.10
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gkxbyBIJO6pXnp8rV+W1ffgR1B7K+wGIRJfPPfFqODE=;
        b=tsRg932a1+onoPIC75NGcNJCuBpAHcwi4QM2SXDdpmVTDPJAnEcaoBc6VU18DnUdeJ
         sTOTOD1H0XXpHXbsnDcD42f2n+nYVEx3cuxyLI/lFwA+Np6C9urSeWVpAHERNmfsrORz
         uEgP5K6GdmVqH8agFbpYwYzapVHJn7KU1VPPLgLNP4oL0ks9ptpKwKO31aj3wGPdmy4x
         k9Cz6V4RAF8BNRVYtKuA2IPu6O7XwLwPsTmcy3445OTwW6cylVRCPYb+X+YtGCaUoy9o
         OzEiXNbPWi7fZjHj6LynDrN+SIXKvC5etXAVnL0vAiSLMeZCugrVZ02p8C48Y4L9Rkje
         6h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gkxbyBIJO6pXnp8rV+W1ffgR1B7K+wGIRJfPPfFqODE=;
        b=XdtOdXyoRGSNCornduUW1aWEEEwaxf/1DLomg1xpbxuJnLJFL2OmcD2OjkGSCsSCr7
         lYi8k7J5NQmzdCgcp3JyewO82attNaMWdhJ7/EaLbpARuCRakQ535S9qtw6oNi8sSnmu
         Qckq3UaVc/2uiJQUJ3Zoea93umWK+9NO9CIUIZLnltXSTyKAiYXjIanJu8k7EqEp4nuk
         8xmzf5U/KicUj6Wn/5azbiuXpVMZLc/+To0zuDYbyfkLkeeUfr2lyvQ6o0dMwced45sq
         RqhJUO47U8E5Co4haDCYO9N+Xg4Z4ljBIBPxYAoSRjHhQT84Mq0b53pnn91/d0TCZemf
         rRDg==
X-Gm-Message-State: AGi0Pua8dPVd+O8NtwY8FOT/RUIhoXJgoDwsQnK1+6Upa57+CrH4Exiu
        Pchc0g3LfZiYj+uubGr4OcvugA==
X-Google-Smtp-Source: APiQypLrYbew1no5omvbjU9joZ1jBq1iCiNrEMbsucLbFm81Qoxs8pbSKSWaPfTzf50pTHDWBSO+2g==
X-Received: by 2002:a63:7705:: with SMTP id s5mr12563890pgc.449.1586794366534;
        Mon, 13 Apr 2020 09:12:46 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id fa16sm9411079pjb.39.2020.04.13.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 09:12:46 -0700 (PDT)
Date:   Mon, 13 Apr 2020 10:12:45 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/4] commit: write commit-graph with Bloom filters
Message-ID: <20200413161245.GE59601@syl.local>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
 <7e8f1aed1138ab2a52a8957ac95895ac9effd933.1586789126.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e8f1aed1138ab2a52a8957ac95895ac9effd933.1586789126.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 13, 2020 at 02:45:24PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The GIT_TEST_COMMIT_GRAPH environment variable updates the commit-
> graph file whenever "git commit" is run, ensuring that we always
> have an updated commit-graph throughout the test suite. The
> GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variable was
> introduced to write the changed-path Bloom filters whenever "git
> commit-graph write" is run. However, the GIT_TEST_COMMIT_GRAPH
> trick doesn't launch a separate process and instead writes it
> directly.
>
> Update the "git commit" builtin to write changed-path Bloom filters
> when both GIT_TEST_COMMIT_GRAPH and GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS
> are enabled.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 77668629e27..3e8f36ce5c8 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1968,6 +1968,8 @@ int write_commit_graph(struct object_directory *odb,
>  	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
>  	ctx->split_opts = split_opts;
>  	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
> +	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
> +		ctx->changed_paths = 1;

Hmm. I'm not crazy about a library function looking at 'GIT_TEST_*'
environment variables and potentially ignoring its arguments, but given
the discussion we had in v1, I don't feel strongly enough to recommend
that you change this.

For what it's worth, I think that 'write_commit_graph' could behave more
purely if callers checked 'GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS' and set
'flags' appropriately from the outside, but I can understand also why
it's preferred to do it in this style, too.

>  	ctx->total_bloom_filter_data_size = 0;
>
>  	if (ctx->split) {
> --
> gitgitgadget
>

Thanks,
Taylor
