Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF9BC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449C620771
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDrHwe2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGGN3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGGN3b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 09:29:31 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBDFC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 06:29:30 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x83so27297481oif.10
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mR823h5HBIfQuYeMVx9M+VAtfcRruhy6DGDYPchClVw=;
        b=CDrHwe2ngPuEWeuYuRTxX/FcZRnEVkTQlPni2AJt6YwIqGJngavuh0V5q1XHg9wWrv
         seJbZaZeBFiA7bQcLeIRdgh/lHqUtfWrfyO2V41NwTmqbMtZEGRUC0Ucwf1yDlVbZeOJ
         yDu3u/z0PXx5A3V05H+XhyMNNSMstm9wirfJI4C8r57V2gGfJ9cRE0WTUJrg1efQY2Rr
         kQC5orEfOAQpPrIyoJz1ewJKhCxROuePUmuHgzPWnk/OwGuexY8aWu/FxMfqzrIUqk4G
         5J8e6UowX52sICplLzjqXDj75KZIk8ufmkfsUOzcjMH3c8QjdI54jnsKHjeyDOUsI57q
         h7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mR823h5HBIfQuYeMVx9M+VAtfcRruhy6DGDYPchClVw=;
        b=lzuRhhXOMox7MMpd47CZ5lZZhqbha7bZ8YkCV0HFces/vpi5NTPvwxD+qX88woStaW
         q9i0r7/qjWfmvGcow4+BpHbpHpt3EtxvwM5RZ5QmsOSkdtEF02GKfTf5uvC9v+gufMKL
         rk0EuWuUX3myGl97Neo5O4lM7noFhu9AGoCHXSXzdbSx4PqJ4d3HDxaMiIkJzRGREM12
         9B/jGBpJk2YF338a6qfkq23oJuezznHlbTLE4X2RYXhiZA8z6q0RSL5lbj0Z0Mubk85/
         T4gMjwMHfpj4rZfjAoww9VOi5z6tUnou9/y2Vg5tKAyOlt3E2iVqn9hJYa22+itYBW2W
         alcA==
X-Gm-Message-State: AOAM530CKb/Ht/TOAJYbeiCaaqA6Yy9CrNnozUxX2hfUHIcLe+EMvA3d
        qgaJJa/4b48/Pm1eXJHSNgVZWsa2hik=
X-Google-Smtp-Source: ABdhPJyVsjnLLDmdtn3d+eMWHhAMVHOG3i4roOLcWZ+B7QuD4BslXhURz+IhHJSYXdYXpKDbh9vi2Q==
X-Received: by 2002:aca:ef82:: with SMTP id n124mr2978435oih.99.1594128569938;
        Tue, 07 Jul 2020 06:29:29 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r18sm1602302otd.59.2020.07.07.06.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 06:29:29 -0700 (PDT)
Subject: sg/commit-graph-cleanups (was Re: What's cooking in git.git (Jul
 2020, #01; Mon, 6))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <90cf9ac2-1ab0-1c9b-706b-6c5176ab47dd@gmail.com>
Date:   Tue, 7 Jul 2020 09:29:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/7/2020 1:57 AM, Junio C Hamano wrote:
> * ds/commit-graph-bloom-updates (2020-07-01) 10 commits
>   (merged to 'next' on 2020-07-06 at 177e6b362e)
>  + commit-graph: check all leading directories in changed path Bloom filters
>  + revision: empty pathspecs should not use Bloom filters
>  + revision.c: fix whitespace
>  + commit-graph: check chunk sizes after writing
>  + commit-graph: simplify chunk writes into loop
>  + commit-graph: unify the signatures of all write_graph_chunk_*() functions
>  + commit-graph: persist existence of changed-paths
>  + bloom: fix logic in get_bloom_filter()
>  + commit-graph: change test to die on parse, not load
>  + commit-graph: place bloom_settings in context
>  (this branch uses sg/commit-graph-cleanups.)
> 
>  Updates to the changed-paths bloom filter.
> 
>  Will merge to 'master'.
> 
> * sg/commit-graph-cleanups (2020-06-08) 10 commits
>  + commit-graph: simplify write_commit_graph_file() #2
>  + commit-graph: simplify write_commit_graph_file() #1
>  + commit-graph: simplify parse_commit_graph() #2
>  + commit-graph: simplify parse_commit_graph() #1
>  + commit-graph: clean up #includes
>  + diff.h: drop diff_tree_oid() & friends' return value
>  + commit-slab: add a function to deep free entries on the slab
>  + commit-graph-format.txt: all multi-byte numbers are in network byte order
>  + commit-graph: fix parsing the Chunk Lookup table
>  + tree-walk.c: don't match submodule entries for 'submod/anything'
>  (this branch is used by ds/commit-graph-bloom-updates.)
> 
>  The changed-path Bloom filter is improved using ideas from an
>  independent implementation.
> 
>  Under review.
>  cf. <20200627155610.GN2898@szeder.dev>
>  cf. <20200627163335.GO2898@szeder.dev>
>  cf. <20200627155348.GM2898@szeder.dev>

I see these are both in 'next' (thanks!).

Perhaps the "Under review" status for sg/commit-graph-cleanups
should be modified to match ds/commit-graph-bloom-updates?

Thanks,
-Stolee
