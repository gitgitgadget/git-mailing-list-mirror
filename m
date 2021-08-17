Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F8CC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC4260FA0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhHQS07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhHQS06 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 14:26:58 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC46C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 11:26:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id p22so22976496qki.10
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EVIbB2qh0oTgHloZp5sshhZqnFSrep28GcCAjhU6OUs=;
        b=s5DhMLaMtFDpyv7lbplkJjIJuFx6KgURubCyUICSebX9jVzFlC6cCYn4zba4HrU+f1
         n53bB2vuUejYppJABe00fciN4dcTj7o30p27NWs/5IG1b98PB/iQ0DDzwGUsv3LLGo/d
         usfdTRyYrD2bT6UqRDvp8IzDlpalMZy7C+aHrRAGgaleqnC+CJyBQdiwPROnaQImIg98
         Vp6IORo68sKFsct21YoXIhk7Xee4Z6P1OaXCeU7HfvYIpozXR5pMMA7KDC6e2xU1U20Q
         5Kianh15JuTUm74PXStCcFwf1KRNCLX2vTMGk76PnlnHE01KRiQpjk5ddJbmt1V7ZQjJ
         Ig0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EVIbB2qh0oTgHloZp5sshhZqnFSrep28GcCAjhU6OUs=;
        b=VCYEfaQZ3z7G6PoYuvnGl0t3PMfZUXNzqbYQqDnxQ/MkHI9fbTw7uZtdgf4hVuJYqs
         pjDfaRrl+WmQnzoPoh9bR8QeSHNZnBJwTvQQVAzpiFgkoH0hmvKUGjUQoCHP8N9MI1gu
         qU5noK2ns3f/82aN8batwkwnZwRpYClolvrntr6xfUiqkGtoc643kF5mCbBipNG/Dnna
         LQmeJMSmMMi/4WHa4s9noTJLqWcb7zeost+ULqX+JCA+Lqx4Yw2RPO0WTaPjsTUgYGKu
         4G+kBVrwwplhfFlQLOpg5B24b6qDqs1U+opI/QoCZlAvblv52veG3u+wgiHg55FvHZwL
         EY9g==
X-Gm-Message-State: AOAM530e9zfwf+7ceowXdSE5FPczTS60Rj5x1tftPvUFzjVLN26KrsVG
        OHxVcpTX8WGmjRzQxxc5YOE=
X-Google-Smtp-Source: ABdhPJxuQfibGTWmJaxrXrjmfCLyIyXeJtbyYzO/H581nTFtd9t9kKdTMVZcARQLpzWScD0pR5G2cA==
X-Received: by 2002:a05:620a:16d4:: with SMTP id a20mr5243219qkn.34.1629224784132;
        Tue, 17 Aug 2021 11:26:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dc75:b61d:e533:9004? ([2600:1700:e72:80a0:dc75:b61d:e533:9004])
        by smtp.gmail.com with ESMTPSA id o10sm1445894qtv.31.2021.08.17.11.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 11:26:23 -0700 (PDT)
Subject: Re: [PATCH 5/6] tests: disable GIT_TEST_SPLIT_INDEX for sparse index
 tests
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210817174938.3009923-6-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6f900a58-19b4-753c-18f5-852eaebc1527@gmail.com>
Date:   Tue, 17 Aug 2021 14:26:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817174938.3009923-6-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2021 1:49 PM, SZEDER Gábor wrote:
> The sparse index and split index features are said to be currently
> incompatible [1], and consequently GIT_TEST_SPLIT_INDEX=1 might
> interfere with the test cases exercising the sparse index feature.
> Therefore GIT_TEST_SPLIT_INDEX is already explicitly disabled for the
> whole of 't1092-sparse-checkout-compatibility.sh'.  There are,
> however, two other test cases exercising sparse index, namely
> 'sparse-index enabled and disabled' in
> 't1091-sparse-checkout-builtin.sh' and 'status succeeds with sparse
> index' in 't7519-status-fsmonitor.sh', and these two could fail with
> GIT_TEST_SPLIT_INDEX=1 as well [2].
> 
> Unset GIT_TEST_SPLIT_INDEX and disable the split index in these two
> test cases to avoid such interference.
> 
> Note that this is the minimal change to merely avoid failures when
> these test cases are run with GIT_TEST_SPLIT_INDEX=1.  Interestingly,
> though, without these changes the 'git sparse-checkout init --cone
> --sparse-index' commands still succeed even with split index, and set
> all the necessary configuration variables and create the initial
> '$GIT_DIR/info/sparse-checkout' file, but the test failures are caused
> by later sanity checks finding that the index is not in fact a sparse
> index.  This indicates that 'git sparse-checkout init --sparse-index'
> lacks some error checking and its tests lack coverage related to split
> index, but fixing those issues (let alone making sparse index
> comparible with split index) is beyond the scope of this patch series.

s/comparible/compatible.

I agree that making these two things compatible is not something to
solve today. I'm not sure they should _ever_ be solved because of
the complexity involved (what if the base index is not sparse but
the tip wants to be, or vice-versa?, or if a directory must be
expanded because of a conflict?). They use very different approaches
to solve a similar problem: how to deal with large index files.

* The split index reduces index _write_ time by only editing a diff
  of the base index.

* The sparse index reduces index _read and write_ time by writing a
  smaller index, but only if the user is using cone mode sparse-
  checkout.

>  test_expect_success 'sparse-index enabled and disabled' '
> -	git -C repo sparse-checkout init --cone --sparse-index &&
> -	test_cmp_config -C repo true index.sparse &&
> -	test-tool -C repo read-cache --table >cache &&
> -	grep " tree " cache &&
> -
> -	git -C repo sparse-checkout disable &&
> -	test-tool -C repo read-cache --table >cache &&
> -	! grep " tree " cache &&
> -	git -C repo config --list >config &&
> -	! grep index.sparse config
> +	(
> +		sane_unset GIT_TEST_SPLIT_INDEX &&
> +		git -C repo update-index --no-split-index &&
> +
> +		git -C repo sparse-checkout init --cone --sparse-index &&
> +		test_cmp_config -C repo true index.sparse &&
> +		test-tool -C repo read-cache --table >cache &&
> +		grep " tree " cache &&
> +
> +		git -C repo sparse-checkout disable &&
> +		test-tool -C repo read-cache --table >cache &&
> +		! grep " tree " cache &&
> +		git -C repo config --list >config &&
> +		! grep index.sparse config
> +	)
>  '

This test is safe for now.

>  test_expect_success 'status succeeds with sparse index' '

This test is being edited in ds/sparse-index-ignored-files. v3
of the relevant patch was just sent today [1].

[1] https://lore.kernel.org/git/e66106f7a99d94145eec983ea5e72b7cf8a8a479.1629206603.git.gitgitgadget@gmail.com/

You might want to rebase on top of that topic. The edits to
the test are likely stable now.

Thanks,
-Stolee
