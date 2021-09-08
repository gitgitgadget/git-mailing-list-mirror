Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3B0C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 17:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706886113D
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 17:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbhIHR4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhIHRzw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 13:55:52 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7C6C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 10:54:42 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d11so2624744qtw.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+bokqA2BcalvA/4l4/wWrt/J8bXKlIk7gBlLRbbhUEg=;
        b=OHWWGEj580XePW9JOP5X01Newx3hlhntJNI8avcOMJ2YI1XqUKWZUVWPky+YGrMhwF
         UnWR5303es1Fm217QzJhmhL8yCcXrhYA+GxSMpmejWv1zr1y/AMtTrcqtxojKBRvjvKw
         XvMijaQ45eZwHsYOeVc5r31PqMn3HCc75H6HLbNxEO9qmrS7X/uy1QWQJHFBjI4nP1dq
         YlBk7Vww6j44vY4QePDuQw+OsgXx8ZmY2+rcM4BeMi7bypzBYC0GXtdT71Cv+Fu4wtai
         NybeNxCvcrx/PtfiUMF00YoYe6wSgPIMS9/+JmnFL+eqDHjNSwvW3wQTDGBXDprlLmyi
         79hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+bokqA2BcalvA/4l4/wWrt/J8bXKlIk7gBlLRbbhUEg=;
        b=ELCcCg2ia7gnbTnBshEUBfMdpNehLO56Ooqu+DmSKnTYqmL5AGY0tGLn3WVL69623h
         RNtUYldj2NP5YKjNdOMIGQmR91SJ9K1WQ04QnUzrvBoZyzL0qZRHiykE+foMLx111KZz
         CLWdcWLxFmuGv0//36hoxhIcDenjIlQ5Rb0T0fwj09apDgCFPcEMP8Z7UiGW9Gezhb1/
         8+rcTlcDbSjZE9d+yJDeygrg8mAgwHMswodlkRH/kxzfxGNSStpH0NRse9u4F2f9hZyI
         15cV5HCoXnwPrSpFJFuTqNQD7WvpDAaa60Vgh2d7J0qsbkw2+ZTOTfoJzsBkW0S9Hcjq
         Wpbg==
X-Gm-Message-State: AOAM531nNXtV6PajdNaXaEMHHbtEeq1AJTg+hcKlKT8CG+Wq/tcgKOn1
        8AlG0YHzN/tGicb5HnRhuQo=
X-Google-Smtp-Source: ABdhPJxZKdOPUCIb5aNETwCgG+FEiQJsf9i2C5JsUKo5SlPfRekvoGP+rMdxy20m+WH+a5jX3HLVwQ==
X-Received: by 2002:ac8:1e93:: with SMTP id c19mr5120079qtm.60.1631123681594;
        Wed, 08 Sep 2021 10:54:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id t24sm2359826qkg.28.2021.09.08.10.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 10:54:41 -0700 (PDT)
Subject: Re: [PATCH 05/13] add: fail when adding an untracked sparse file
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <e80fcfa932cca394c5c8b349cafadb0754a594dd.1629842085.git.gitgitgadget@gmail.com>
 <CAHd-oW7D1jikE5ByS36AjACfSJoZeekLCKzX2MRRfayKwKv=qQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2826d2dd-5beb-e595-a5bc-9ffb1ef653ea@gmail.com>
Date:   Wed, 8 Sep 2021 13:54:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHd-oW7D1jikE5ByS36AjACfSJoZeekLCKzX2MRRfayKwKv=qQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2021 5:06 PM, Matheus Tavares Bernardino wrote:
> On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

Thanks for adding your review. I'm sorry I'm so late getting back to it.

>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The add_files() method in builtin/add.c takes a set of untracked files
>> that are being added by the input pathspec and inserts them into the
>> index. If these files are outside of the sparse-checkout cone, then they
>> gain the SKIP_WORKTREE bit at some point. However, this was not checked
>> before inserting into the index, so these files are added even though we
>> want to avoid modifying the index outside of the sparse-checkout cone.
>>
>> Add a check within add_files() for these files and write the advice
>> about files outside of the sprase-checkout cone.
> 
> s/sprase/sparse/

Thanks.

>> diff --git a/builtin/add.c b/builtin/add.c
>> index 88a6c0c69fb..3a109276b74 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -443,6 +443,7 @@ static void check_embedded_repo(const char *path)
>>  static int add_files(struct dir_struct *dir, int flags)
>>  {
>>         int i, exit_status = 0;
>> +       struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
> 
> I see this reuses the logic from cmd_add() and refresh(). But since we
> are operating on untracked files here, perhaps we could replace
> "skip_worktree" by "sparse_paths" or something similar?

How about "matched_sparse_paths" as a whole name swap? The earlier uses
cared only if every match was sparse, but here we are actually looking
at cases that are untracked, and the pathspec could also match other
non-sparse cases.

>> +
>> +       if (only_match_skip_worktree.nr) {
>> +               advise_on_updating_sparse_paths(&only_match_skip_worktree);
> 
> 
> Hmm, advise_on_updating_sparse_paths() takes a list of pathspecs that
> only matched sparse paths, but here we are passing a list of actual
> pathnames... Well, these are technically pathspecs too, but the advice
> message may be confusing.
> 
> For example, if we ran `git add *.c` on a repo with the untracked
> files `d1/file.c` and `d2/file.c`, we will get:
> 
> The following pathspecs didn't match any eligible path, but they do match index
> entries outside the current sparse checkout:
> d1/file.c
> d2/file.c
> 
> However, `d1/file.c` and `d2/file.c` are neither index entries nor the
> pathspecs that the user has given to `git add`. So perhaps we need to
> change the error/advice message?

I think the advice should be modified to refer to paths and/or pathspecs,
and also it is not completely correct anymore.

Instead of

  The following pathspecs didn't match any eligible path, but they do match index
  entries outside the current sparse checkout:

perhaps

  The following paths and/or pathspecs matched paths that exist outside of your
  sparse-checkout definition, so will not be updated in the index:

I'm going to save this one for a new patch at the end to make sure it handles
all of the cases involved in this series.

Thanks,
-Stolee
