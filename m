Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E49C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 14:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61952067C
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 14:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc5ep8+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgAaOkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:40:21 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35022 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgAaOkV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 09:40:21 -0500
Received: by mail-qt1-f196.google.com with SMTP id n17so4388385qtv.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 06:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XuT7/G+HSQzVDkQyq8ruoJ+vjh3vcD+DQNEIc9a3m3M=;
        b=Nc5ep8+81aZCXhRF/mWKqQDmjzXtcZfOg9+PIg/vWuZejdXDRGUvUivrr1GtsjN+6u
         elnn7Y7EH9D0hrVGSdGz5tY3HcS2Blv5+ru2V0G+4/TOqpwjk/BmYDp2fvyljXV1uq36
         t7sZ69WUj9pcUkFtWP7s+CX+LdTDIbLCb4Mqllgj6hjyYtPUYQWBw+GbQPqdXUEQv82k
         LD329EUo9DWSiZW9WZXpJpwWYCIVpzKFFyLpvt61sYUopuhrItuAjC7vR2YtVUGYtYZt
         rjqukEEdhrPlZnVSorM2LGt4o5mP3eobBKAaTXUR4uM04yqkXW8XikI131gHbwCyNSZZ
         6vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XuT7/G+HSQzVDkQyq8ruoJ+vjh3vcD+DQNEIc9a3m3M=;
        b=h7byCVCGCDUTMTVivurLya7vmwLXgzINlWaFGc8FYAs8dZrvoQZBPjG+T9xeOEc0Yk
         nZle79APr9uULrJh9XaSavKlWrf3UWkLLlYBRkmNUtODqezDdXIWIQbJGVckLA4cQ4GW
         akExMbIwT0vvXg9q82lVUB2R/GhR/T1tlVBbZRnIyiwfdXcEyuRPhRN8+yVIzrgzbzGY
         NiCuAnyqMkmTsG6znDOhrTBDAr1R7mRXb4QttcizYR8aSpMIQ9VkfRB8Ff9X6Z/kqyC3
         HSLoklOcGaxgol4dxlLNKJksuVLzToN4YYc4bB/16CP1oMk3/bf5YNylJph9Tfvv11lq
         XNoA==
X-Gm-Message-State: APjAAAUfC9Kr/NFPOSFq7tTa4sPEH26STlkTTNy4NvjNgD0ZddUuaSBN
        1ZuKYQ15QJJXv/ONwy2aXjw=
X-Google-Smtp-Source: APXvYqwNjY/xoQKTl3U/ESarGDbUKGsuKlSGS6zCYCkJVT8do57AD6qyh6EvM05L5V9Xxp7h4L1slA==
X-Received: by 2002:aed:2f01:: with SMTP id l1mr10773498qtd.391.1580481620342;
        Fri, 31 Jan 2020 06:40:20 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:e1f4:827:3448:54f3? ([2001:4898:a800:1010:932a:827:3448:54f3])
        by smtp.gmail.com with ESMTPSA id x11sm4568038qkf.50.2020.01.31.06.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 06:40:19 -0800 (PST)
Subject: Re: [PATCH 3/3] builtin/commit-graph.c: support '--input=none'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
References: <cover.1580430057.git.me@ttaylorr.com>
 <c329a8ddc087c9b74f673005f8b1e8769816ab9a.1580430057.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5fac4f9c-b9e3-5e78-591b-abc62e73ac0e@gmail.com>
Date:   Fri, 31 Jan 2020 09:40:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <c329a8ddc087c9b74f673005f8b1e8769816ab9a.1580430057.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 7:28 PM, Taylor Blau wrote:
> In the previous commit, we introduced '--[no-]merge', and alluded to the
> fact that '--merge' would be useful for callers who wish to always
> trigger a merge of an incremental chain.
> 
> There is a problem with the above approach, which is that there is no
> way to specify to the commit-graph builtin that a caller only wants to
> include commits already in the graph. One can specify '--input=append'
> to include all commits in the existing graphs, but the absence of
> '--input=stdin-{commits,packs}' causes the builtin to call
> 'fill_oids_from_all_packs()'.
> 
> Passing '--input=reachable' (as in 'git commit-graph write
> --split=merge-all --input=reachable --input=append') works around this
> issue by making '--input=reachable' effectively a no-op, but this can be
> prohibitively expensive in large repositories, making it an undesirable
> choice for some users.
> 
> Teach '--input=none' as an option to behave as if '--input=append' were
> given, but to consider no other sources in addition.

The code change looks good.

> +test_expect_success '--split=no-merge, --input=none writes nothing' '
> +	test_when_finished rm -rf a graphs.before graphs.after &&
> +	rm -rf $graphdir &&
> +	git reset --hard commits/2 &&
> +	git rev-list -1 HEAD~1 >a &&
> +	git commit-graph write --split=no-merge --input=stdin-commits <a &&
> +	ls $graphdir/graph-*.graph >graphs.before &&
> +	test_line_count = 1 $graphdir/commit-graph-chain &&
> +	git commit-graph write --split --input=none &&
> +	ls $graphdir/graph-*.graph >graphs.after &&
> +	test_cmp graphs.before graphs.after
> +'
> +
> +test_expect_success '--split=merge-all, --input=none merges the chain' '
> +	test_when_finished rm -rf a b &&
> +	rm -rf $graphdir &&
> +	git reset --hard commits/2 &&
> +	git rev-list -1 HEAD~1 >a &&
> +	git rev-list -1 HEAD >b &&
> +	git commit-graph write --split=no-merge --input=stdin-commits <a &&
> +	git commit-graph write --split=no-merge --input=stdin-commits <b &&
> +	test_line_count = 2 $graphdir/commit-graph-chain &&
> +	git commit-graph write --split=merge-all --input=none &&
> +	test_line_count = 1 $graphdir/commit-graph-chain
> +'

And these tests demonstrate the value quite clearly. Thanks!

-Stolee
