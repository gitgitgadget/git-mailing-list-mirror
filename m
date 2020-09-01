Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80DAC433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4272137B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqPwPIg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIALNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgIALEg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 07:04:36 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC75C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 04:03:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so345987plb.12
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pUQmtuQNXstLTcHlF/lqhyHxv4U4vGvbvyNLzduOf4w=;
        b=hqPwPIg5zBnaiHiR+v6QeSYFxWGxa0By5c5KIm8ejVUfEH47y/sUnYoTiMzpx0NfDk
         ZDled8fWW7OHAQwKaRXMkD36UAFb8QvOto3Zhtx4VwmHmJoJ64DIKtwuwGTp8qbPTmmZ
         tSxkRzX3C8foJ5QQNTDs8EAx9XUbAlfwwrvDJBGvBktOjE30bD4GzbcuvYcpbm7i6hEO
         eUWn3lE8skcuhlVPdV4qC0HjZ6+3FVB3eSLxYSHeHUIQUfvaVL+La1TruJZvP/tZXzYH
         vJ57Tz41iev85jyCCHtLiGsEctasUnxRvWevYl3TLqsGUR/581jLYjqUQUIH/SIuETWy
         DcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=pUQmtuQNXstLTcHlF/lqhyHxv4U4vGvbvyNLzduOf4w=;
        b=tVM3vOLF038oLiITMn0nuY6o+yHULuKOe6JN2uNz55r92Xs/8gS6P66vw3+B+tmxoq
         ftfB0FRp/fTW1HfnKGB/M9uC6yMzORXCUGSleufA/ceuQzrCgCx6GYO0MJs0JNr05bFi
         PbkObQQxmOOsySCh+z3Kecp88gbvAYd/zalZPaNoaaT1XDjyZk9TPHla6BfHGLiqmT9P
         5bfMpwWRinDd5zgRw4lrNjV8XCGUBcJ4EguoiZNexMbZgkOzGdHemFXa8VWku8ap4ZAN
         Hpa1FQviyUOUUwrAC5WTbYy0XYF4oaYcilBkIp8xLKmXwgDe+V95W9czY2hkOrLCu6cB
         JF4A==
X-Gm-Message-State: AOAM5336SfarrB0rDgzFfemPGjvjuCN0VlgtW57U0ncuSJtauoyfw3Xt
        WbXzb9rpYiWNxHGJPyByCgWVAEwOoh7Dqg==
X-Google-Smtp-Source: ABdhPJz0aZEdgUVxdpva+kBKtPLs2pck02F1zHN566arLvIsQr/DXo1PrL/bCUmsOrkTX9KfQVaKEw==
X-Received: by 2002:a17:902:9690:: with SMTP id n16mr907735plp.305.1598958238276;
        Tue, 01 Sep 2020 04:03:58 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:79b:52ed:48f6:b1a4:ca3c:754b])
        by smtp.gmail.com with ESMTPSA id h65sm1531899pfb.210.2020.09.01.04.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 04:03:57 -0700 (PDT)
Date:   Tue, 1 Sep 2020 16:31:41 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v3 07/11] commit-graph: implement corrected commit date
Message-ID: <20200901110141.GC10388@Abhishek-Arch>
Reply-To: 85wo1nca3u.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <4074ace65be3094d35dd0aaedb89eb5a0ec98cee.1597509583.git.gitgitgadget@gmail.com>
 <85wo1rk0iy.fsf@gmail.com>
 <20200825064954.GA645690@Abhishek-Arch>
 <85wo1nca3u.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85wo1nca3u.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 12:07:17PM +0200, Jakub Narębski wrote:
> Hello,
> 
> ...
> 
> I think I was not clear enough (in trying to be brief).  I meant here
> loading available generation numbers for use in graph traversal,
> done in later patches in this series.
> 
> In _next_ commit we store topological levels in `generation` field:
> 
>   @@ -755,7 +763,11 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
>    	date_low = get_be32(commit_data + g->hash_len + 12);
>    	item->date = (timestamp_t)((date_high << 32) | date_low);
> 
>   -	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
>   +	if (g->chunk_generation_data)
>   +		graph_data->generation = item->date +
>   +			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
>   +	else
>   +		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> 
> 
> We use topo_level slab only when writing the commit-graph file.
> 

Right, I thought the agenda outlined points in the process of writing
commit-graph file.

>
> > We could avoid initializing topo_slab if we are not writing generation
> > data chunk (and thus don't need corrected commit dates) but that
> > wouldn't have an impact on run time while writing commit-graph because
> > computing corrected commit dates is cheap as the main cost is in walking
> > the graph and writing the file.
> 
> Right.
> 
> Though you need to add the cost of allocation and managing extra
> commit slab, I think that amortized cost is negligible.
> 
> But what would be better is showing benchmark data: does writing the
> commit graph without GDAT take not insigificant more time than without
> this patch?

Right, we could compare time taken by master and series until (but not
including this patcth) to write a commit-graph file. Will add.

> 
> [...]
> >>> @@ -2372,8 +2384,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
> >>>  	for (i = 0; i < g->num_commits; i++) {
> >>>  		struct commit *graph_commit, *odb_commit;
> >>>  		struct commit_list *graph_parents, *odb_parents;
> >>> -		timestamp_t max_generation = 0;
> >>> -		timestamp_t generation;
> >>> +		timestamp_t max_corrected_commit_date = 0;
> >>> +		timestamp_t corrected_commit_date;
> >>
> >> This is simple, and perhaps unnecessary, rename of variables.
> >> Shouldn't we however verify *both* topological level, and
> >> (if exists) corrected commit date?
> >
> > The problem with verifying both topological level and corrected commit
> > dates is that we would have to re-fill commit_graph_data slab with commit
> > data chunk as we cannot modify data->generation otherwise, essentially
> > repeating the whole verification process.
> >
> > While it's okay for now, I might take this up in a future series [1].
> >
> > [1]: https://lore.kernel.org/git/4043ffbc-84df-0cd6-5c75-af80383a56cf@gmail.com/
> 
> All right, I believe you that verifying both topological level and
> corrected commit date would be more difficult.
> 
> That doesn't change the conclusion that this variable should remain to
> be named `generation`, as when verifying GDAT-less commit-graph files it
> would check topological levels (it uses commit_graph_generation(), which
> in turn uses `generation` field in commit graph info, which as I have
> show above in later patch could be v1 or v2 generation number).
> 

Right, I completely misunderstood you initially. Reverted the variable
name changes.

> Best,
> -- 
> Jakub Narębski
