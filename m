Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA42C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F7A6101D
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhGLN7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbhGLN7R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 09:59:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071A1C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:56:29 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w8-20020a0568304108b02904b3da3d49e5so14906670ott.1
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nkBt+KA+sFauV7ust+O08mSlLYtVbRyHy9SuOwHr3Vw=;
        b=T3TS0R4UQb9KmpCaKnpudl2AGS1lSsWuu43z9rsjh3lD72zCwDUmZiXdCuV3y1r0ZO
         EQ7j60CyWlXTv5MjuGbSRFewW/gHT0CH6zhWxHKbkSyynwPwXlvTmCWMFWkpGBvNmOrT
         ABO7nWNWTR3lGmAfEVm6gQI+Wpi7iDW9/6GDDjUmwmN74FonOq2mu8/TmObEPV8vCe/F
         k4aTYmWBwFuo5fZ8ju+MWeK8uxNJ4WAZZRVO0lZoTg+Sxx8iTMQGi8zXsWDdFgTykAN0
         sp0t7FGJOEr8dL/bKYSJqAkKKazeaiDl2Lt6tT6ZI6HOSLW3VnCVg7I76F4AcsBKHmHZ
         VX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nkBt+KA+sFauV7ust+O08mSlLYtVbRyHy9SuOwHr3Vw=;
        b=pszEjBndeuIoOLcGNG75BA3X6+e+sfUOO4qgMet5r69eN85IfmrpaoJ2euxpXqinIH
         C8VB85i/ctH1SWnVEgc4groC+kKli6OR30+yLFfA3JBdJpi0gvH7WyI6UEh52KOmLGk0
         GM6qWg72oscmdqC3Deu07Ie/eeB4CpPCL4PubnuBkGgX/qHAH396UyvbNKp2NGlhC/Mt
         IAD0rkt39b+/wJ+uokUMo9l4kRo9+B/hkM+om8v2qBbBRHCAh2Tx88NjUC1A2zY0eu5W
         CCtIotvmfUkcqNt1jEDNcXaGvpjEx3D+GS5GfzE3tmhjMUWkn3LyXDVLaL9PynPrx/VI
         sm6w==
X-Gm-Message-State: AOAM530tFT4bN1buudv2oo36whPW8LQ3cK40MQQvz2IoDiOcC8W6pHkb
        e0urQGPj8cAdTJr+ODjXkBA=
X-Google-Smtp-Source: ABdhPJx0TInp4KCovbknChcdJajwJaaWndl+qHNGu3AOGptVIVuvBLo+abv/OmVtxrRj5KSdmUkx/w==
X-Received: by 2002:a05:6830:2385:: with SMTP id l5mr581027ots.227.1626098188329;
        Mon, 12 Jul 2021 06:56:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f8:61a:4701:b6c? ([2600:1700:e72:80a0:91f8:61a:4701:b6c])
        by smtp.gmail.com with ESMTPSA id g1sm3157591otq.22.2021.07.12.06.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 06:56:27 -0700 (PDT)
Subject: Re: [PATCH v7 15/16] wt-status: expand added sparse directory entries
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
 <717a3f49f97753149d5c435a83b3f1773dd4b1bb.1624932294.git.gitgitgadget@gmail.com>
 <CABPp-BE=qw9pO89hggUFbu=eovfL=7Os5BY8DZNd5Z=qU==wFg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3cf96b5f-3a8d-c00c-5d9e-c7095c058059@gmail.com>
Date:   Mon, 12 Jul 2021 09:56:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE=qw9pO89hggUFbu=eovfL=7Os5BY8DZNd5Z=qU==wFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2021 9:03 PM, Elijah Newren wrote:
> On Mon, Jun 28, 2021 at 7:05 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
...
>> +test_expect_success 'reset mixed and checkout orphan' '
>> +       init_repos &&
>> +
>> +       test_all_match git checkout rename-out-to-in &&
>> +
>> +       # Sparse checkouts do not agree with full checkouts about
>> +       # how to report a directory/file conflict during a reset.
>> +       # This command would fail with test_all_match because the
>> +       # full checkout reports "T folder1/0/1" while a sparse
>> +       # checkout reports "D folder1/0/1". This matches because
>> +       # the sparse checkouts skip "adding" the other side of
>> +       # the conflict.
> 
> The same issue I highlighted last time is still present.  If you
> insert an "exit 1" right here, then run
>     ./t1092-sparse-checkout-compatibility.sh --ver --imm -x
> until it stops, then
>     cd t/trash directory.t1092-sparse-checkout-compatibility/sparse-checkout
>     git ls-files -t | grep folder  # Note the files that are sparse
>     git reset --mixed HEAD~1
>     git ls-files -t | grep folder  # Note the files that are sparse --
> there are some that aren't that should be
>     git sparse-checkout reapply
>     git ls-files -t | grep folder  # Note the files that are sparse
> 
> Granted, this is a bug with sparse-checkout without sparse-index, so
> not something new to your series.  But since you are using comparisons
> between regular sparse-checkouts and sparse-index to verify
> correctness, this seems problematic to me.

I'll add it to the pile, but I want to continue having this series
focus on making the sparse-index work quickly without a change in
behavior from a normal index. Changing the behavior of the sparse-
checkout feature should be a separate series.

Thanks,
-Stolee
