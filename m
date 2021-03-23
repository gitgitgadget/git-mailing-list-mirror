Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB28C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A326619CB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhCWUnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbhCWUmz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:42:55 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CFC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:42:54 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so20789057otf.12
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xh/Vw977tXO6r+j0Cd3GueTgXTPXr4LErY0tzngBlBE=;
        b=poYUQi9E3KFDYjrKz9YeQkHINLE4Tnv+mWp1jVfvtFqpRYgoSXtS40iUpbgtkiMzys
         S12nIHpnK9Fp5UFO48bKD15SF3NRitUJCI4fIFozF/JomK9MYuvDd4BZlALj38SP4eM3
         jTKpYTEGxBBTG6IPyBxPxN5dS+cS9Lm8vjRNe6IdXRVOyY+csAwpRXlbfspGQoYA7Sso
         rzoaoRuo+kYTOT6B34iBlvTLSOO/dblTdLxSESY349iGLHUS/AGsfdGE3ii4Bs+JHMAt
         u8OSvdHU0bvGm4ODTW0dX/6/YhVsjqG4qqCAMsUDyazK2pyO4lwHiNggTbLcn6vprLc2
         Op0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xh/Vw977tXO6r+j0Cd3GueTgXTPXr4LErY0tzngBlBE=;
        b=L10SDsQJP4L1LvOy0R4J0BiT3HkhdN9RT3lO+O3XNF33eMzJuywNthcPh7g7XQYv/N
         /uFUmMCdCuo4SZKd3UG0lWqRcaHXAoT8E+7XcjXLZKXsUb0NKlWwIIv9GPyQLIkQr2zJ
         HwbImt7TaNQgFZfpCyBT5r3tw1sYtgC+YybzI9ugzsQe4hluhQ4eTMpRHSNwBkU7CpGS
         RpvMxCEV0LAdLqdzTDREk8QteCeBlkRtGlngMc0WChH3iDuK0fsiuo2FjJ/tKHQkgTZR
         6+cQlc5u24D4xBImMhLUss3SE0+pXHG+ZFx8oZALAFgfc44QdgBcYrSJ6mq6ZW1C3hmi
         Tkkw==
X-Gm-Message-State: AOAM532TrKjRjGeuwIzvS5XH10MZPDy+FXKsvg6U1rY7efd3FvEkNlE3
        1TnQgB3BZHQfp1rBt3blAbM=
X-Google-Smtp-Source: ABdhPJy0XrwaIptri/0BS51VTyO1/4z2igUiPHe85tlqGjk6gwH/dV1GzRDLlONBFN7+JcH1H8+Pog==
X-Received: by 2002:a9d:6c88:: with SMTP id c8mr139867otr.87.1616532174211;
        Tue, 23 Mar 2021 13:42:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:19be:10a5:ec17:ace3? ([2600:1700:e72:80a0:19be:10a5:ec17:ace3])
        by smtp.gmail.com with ESMTPSA id u11sm116454oif.10.2021.03.23.13.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 13:42:53 -0700 (PDT)
Subject: Re: [PATCH v3 01/20] sparse-index: design doc and format update
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <62ac13945bec13270e0898126756c3f947ae264b.1615912983.git.gitgitgadget@gmail.com>
 <xmqqczvulnfn.fsf@gitster.g> <97d57947-dd5f-bb06-cc40-37a23f1db5d9@gmail.com>
 <xmqq8s6d3a39.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7cb99ad8-3853-5670-6b9f-7b4afe3603a2@gmail.com>
Date:   Tue, 23 Mar 2021 16:42:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqq8s6d3a39.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2021 4:10 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>>> +Three important scale dimensions for a Git worktree are:
>>>
>>> s/worktree/working tree/; The former is the thing the "git worktree"
>>> command deals with.  The latter is relevant even when "git worktree"
>>> is not used (the traditional "git clone and you get a working tree
>>> to work in").
>>
>> I guess I'm distracted by using SKIP_WORKTREE a lot, but "working
>> directory" is more specific and hence better.
> 
> Since the user's current working directory can be outside any
> working tree that is governed by any git repository, "working
> directory" is a term I try to avoid when describing the directory
> where a checkout of a revision lives.
> 
> Documentation/glossary-content.txt is where the suggestion for
> "working tree" comes from.

Whoops. Somehow I read that wrong. Thanks for pointing out my error.

>> I meant by "serialized index file" is that the file written to disk has
>> the sparse directory entries, but the in-core copy will not (except for
>> a very brief moment in time, during do_read_index()).
> 
> Nice.  That would probably mean cache-tree extension on-disk can go
> away, because we can populate in-core cache-tree from these entries.
> I've always hated the on-disk encoding of that extension.
> 
> Or we are not doing this "extra tree" everywhere (i.e. limited only
> to the parts that are marked for "sparse checkout")?

The current design is to only have these entries when all paths
within the directory are marked with SKIP_WORKTREE. This pairs
with the cache-tree extension, which has these directories as
nodes, but only consuming one cache entry (for itself).

I haven't considered the idea of inserting trees for other
reasons. Seems like a valuable experiment.

Thanks,
-Stolee
