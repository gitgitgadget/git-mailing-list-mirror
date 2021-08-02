Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BBEC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78F860F4B
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhHBVIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhHBVIN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 17:08:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7532BC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 14:08:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b13so12111885wrs.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZMP9PZsC49mibdEen0Cw6ByiSDzfVhNguJsvz6UsTZY=;
        b=pZ2yFHNQaCoJm/O6ycvO0VUDEkYtqrLBlr+fhnhvthd9G6LNbT/A2xTUizrpOy9Qod
         /xycuJ6rSQhfFNBiTUM6qIpj5ZY/w7e64ZSsPwx7+ACuKYuE/80x6HQA50w/vfYecxkk
         7eq5EWhfDpuPUxgTNiQEj5XkkR6rN/RZegSfG0IJUERuiyUVN1O7B0URE5Tz47oyZuJf
         3svMihzuefN1CRTV41fNtvrP/b0BSMKJI+KeNtxRuB7fVEOciFHRJDCA/mhcD1IIdFBt
         Wg57Nw5pHcR+uJiTtEhfewJ7WScamyCELl0NXg+ucVOuVEvXNoJr5+A2oiXfqrtn464+
         Im4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZMP9PZsC49mibdEen0Cw6ByiSDzfVhNguJsvz6UsTZY=;
        b=mTmSUKeF/Y+5K7Z+0qrPakEDAPRDF/jmbpZhUray/12agkEQecdBolsd4lkT1A+Nmc
         3Kh1AmqMYvgMDmiJUloVWLC7CdzOntLHlW46wqQWvl8CPgUWvoBWgTURHay22p+afIJK
         Qc+p0YTUY3VeSR7+2GlkV52McDNrBJxv22+p+KvbDUI8b7tUz/TzQUwnlY6BzyH6xB3W
         yvij17OcUZ37BonS8C6EPBYAeRcMHQ3OjWj2LGv41Qc1JIkdajlKRWZtMda3Npd2+qy4
         dfUv0hdOk0V0sy63gJW+kndr1Ws8QyH3bvRxWIBCv6zB3JFPJZf7Wu6VvCfnhKmbMbWu
         0Mdw==
X-Gm-Message-State: AOAM531E9Xn0h0zAqg2qIhX7H3Npj61MRT8ycGoFsNKokJO0G4LxV89F
        2e+oz80x8x6n9wz/tCnAuPQ=
X-Google-Smtp-Source: ABdhPJyg3Ldh11UhWX2qPIIs/GFEW6YCbVqBEDfFZIBoSoHGSOnZx8mlxkGwe2z79g7q0P+kjNVnJw==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr18733759wrp.226.1627938482097;
        Mon, 02 Aug 2021 14:08:02 -0700 (PDT)
Received: from szeder.dev (78-131-14-245.pool.digikabel.hu. [78.131.14.245])
        by smtp.gmail.com with ESMTPSA id v5sm12880533wrd.74.2021.08.02.14.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:08:01 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:07:59 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/3] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
Message-ID: <20210802210759.GD23408@szeder.dev>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
 <patch-1.3-832a6c1f78-20210722T121801Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.3-832a6c1f78-20210722T121801Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 02:20:15PM +0200, Ævar Arnfjörð Bjarmason wrote:
> From: SZEDER Gábor <szeder.dev@gmail.com>
> 
> The final value of the counter of the "Scanning merged commits"
> progress line is always one less than its expected total, e.g.:
> 
>   Scanning merged commits:  83% (5/6), done.
> 
> This happens because while iterating over an array the loop variable
> is passed to display_progress() as-is, but while C arrays (and thus
> the loop variable) start at 0 and end at N-1, the progress counter
> must end at N.  This causes the failures of the tests
> 'fetch.writeCommitGraph' and 'fetch.writeCommitGraph with submodules'
> in 't5510-fetch.sh' when run with GIT_TEST_CHECK_PROGRESS=1.

There is no GIT_TEST_CHECK_PROGRESS in this patch series.

> Fix this by passing 'i + 1' to display_progress(), like most other
> callsites do.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  commit-graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 1a2602da61..918061f207 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2096,7 +2096,7 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>  
>  	ctx->num_extra_edges = 0;
>  	for (i = 0; i < ctx->commits.nr; i++) {
> -		display_progress(ctx->progress, i);
> +		display_progress(ctx->progress, i + 1);
>  
>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>  			  &ctx->commits.list[i]->object.oid)) {
> -- 
> 2.32.0.957.gd9e39d72fe6
> 
