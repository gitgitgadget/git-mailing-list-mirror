Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B4C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDD5207A0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbhA0Nc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 08:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhA0Nav (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 08:30:51 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116FDC061573
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 05:30:10 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id h14so1637872otr.4
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 05:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gH2QRwcuotiApS7ndacc7D4bUKszVBwH1EOoAnOgYlc=;
        b=E0nzE+hosAv+NibiB+H2DZ45qabOkkuZo4xL9xis2zeyVsWzk5/bFVPMvLQ01nRWJx
         lIIoynSvlQeVcpx4gGyNWI+VSO8mXhmOePtkrbC7fCJ37FP3avyBkOH2xuI8RTCkIYKt
         O4W/aNakVI8/I4rifaMwkS6OJp/sRgsLwZ3bUooOPcHvVXGPeCb/4qiAyR0QmpKM+wUj
         7oPF+PlEcqeMsahcyl3Ow0AOw1njHitot/nzMuxzDsufyhbCSbFsinVFL7DakUM2XN8R
         PNeHTYb4vViBMaUVv9D6TfY8PVkePwfLoU4bUImqjK7YCYeHFdXirXkHar1mMV2fyZql
         P09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gH2QRwcuotiApS7ndacc7D4bUKszVBwH1EOoAnOgYlc=;
        b=rCjePojML7wgYAasspm/MvHVvDTUKM2iUc0aEJAsVAjycsJHnJZgOiU1cHR7hI2YJq
         Guu9tJsQF1sRemixHcA92CqcMQFtJrlQxQjhjs57BdxS+BqbD4Z9U6VL2vwhoayBIk5o
         RayxBoiSGEdhKkTgFQwdFWQD24DaBFZ16Tu/d4YgreNLidTnGYTqr6eF+0nvsPtcUHvG
         cgoTGcpCZ+qv6V5i74NE+D+5QZTNpyKjqWuUsVPQL8IomPAvRG14eHSy7eb1sEg2/77t
         2m0aoW0W2JIk64JbLdE7JRDx5LHDSekUGWoWa4l1aXx9faGIKjdMEvVASuBc0Neh9XnV
         2NQQ==
X-Gm-Message-State: AOAM533fBffKoAf4EmyBoIXZLD7TdgOKZWh/FzqSglvW4xxI56Jw97O6
        UY0cqG4vPE755Fh+fLATp9c=
X-Google-Smtp-Source: ABdhPJyR+dlyTE6gXE+oATy1A1hTJKwyKa9RLlLSYcnOcd9TBiRPmr4Zpwd45l6KdMwbAwP2JV7+mg==
X-Received: by 2002:a9d:1710:: with SMTP id i16mr7551647ota.260.1611754209418;
        Wed, 27 Jan 2021 05:30:09 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:2d7b:5e80:11e5:d0fa? ([2600:1700:e72:80a0:2d7b:5e80:11e5:d0fa])
        by smtp.gmail.com with UTF8SMTPSA id j1sm417547oiw.50.2021.01.27.05.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 05:30:08 -0800 (PST)
Subject: Re: [PATCH 03/27] t1092: compare sparse-checkout to sparse-index
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <b3696c823a24547be391c4ee35b99ba76cce42af.1611596534.git.gitgitgadget@gmail.com>
 <CABPp-BHKva46dZ7zqhy9Ey=cKfMpBNie-2h=yq6URa40WhGDjw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d652eb83-808a-946e-37ef-9112a1790199@gmail.com>
Date:   Wed, 27 Jan 2021 08:30:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHKva46dZ7zqhy9Ey=cKfMpBNie-2h=yq6URa40WhGDjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2021 10:08 PM, Elijah Newren wrote:
> On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Add a new 'sparse-index' repo alongside the 'full-checkout' and
>> 'sparse-checkout' repos in t1092-sparse-checkout-compatibility.sh. Also
>> add run_on_sparse and test_sparse_match helpers. These helpers will be
>> used when the sparse index is implemented.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  t/t1092-sparse-checkout-compatibility.sh | 29 ++++++++++++++++++++----
>>  1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 8cd3e5a8d22..8876eae0fe3 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -7,6 +7,7 @@ test_description='compare full workdir to sparse workdir'
>>  test_expect_success 'setup' '
>>         git init initial-repo &&
>>         (
>> +               (GIT_TEST_SPARSE_INDEX=0 && export GIT_TEST_SPARSE_INDEX) &&
> 
> I thought parentheses started a subshell; once the subshell ends,
> wouldn't the setting of GIT_TEST_SPARSE_INDEX be thrown away?

I think the "export" specifically pushes the setting out of the
first level of subshell. This is the recommendation that comes up
if one runs 

	export GIT_TEST_SPARSE_INDEX=1 &&

inside a test on macOS, since this isn't completely portable.

Thanks,
-Stolee

