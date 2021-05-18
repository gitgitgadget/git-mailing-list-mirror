Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F4DC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 19:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DF66100C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 19:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbhERTGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 15:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhERTGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 15:06:20 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D2C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 12:05:02 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso9626150ote.1
        for <git@vger.kernel.org>; Tue, 18 May 2021 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MKyEWj6AmRGJI21CYCQTIfMmRnG3uuhMiFBr42vBMqI=;
        b=OugomSypItFCINiflyIigAAUWBbeee7/3Zvkl+M7jMyF0QOJMzOOZXL2pipcFPtrl6
         RjK5sz83WWgZ7h5w8N9pecIZzXQprVIBLC2HU4nnQfki3UTwXcVlSyBZWZNO2zoXiBE0
         RfZue2xpaXJsxZWaLvhku3r/XZo37yE4DV3VCq+E9/2y3mVUQAhmN0Llmx7A8KFofAG4
         uB75VGvC7TOl7Ye6lLIpWbwiPxSzunQ3KqW2QOUjsHujDOriwlkm3fLFOE7coa3+WLUb
         YRMn72wJYupmRXbH4h2DpFQw87ZIiwPArRkDv0acWwafvCUWnPYEHykHkB8zqPhbXeZ8
         HhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MKyEWj6AmRGJI21CYCQTIfMmRnG3uuhMiFBr42vBMqI=;
        b=QMIe85UcrVtmn3bvgloU41Q27a6vjfDkFxCnMMykqD6gAXGoeDPfTXIR28QVMccMWS
         fctsizmTBBxnPhSyIqiJwIHuAd5WworLtsSOyUmRMY3PKxpdQ8QbBJoEmjC7dg7M8MSD
         o3slxP1nc7QuHp6vFApw4FiybkBotcpQvFarBBCT5M6cybHeT/5UuXsDVsX6PdoyRnbq
         tl6yrpNIiwdzO8Dh3lNOLFQimk3wYeFsJ37GFiVV/zMUszvWFOvoQUG5IdANe5nO94MI
         fQ4nV01hPOI0X1KbFXA4CdkTHL/+sySQbLZKDckmaiRURlBlDaINLa2AHyEJa0WF1c6S
         9ERg==
X-Gm-Message-State: AOAM5337A3U1kf0SJleJwYnqYWUJSyp8elLDmsGUFSUethHN42ud6/ww
        8DOp4Va6obt4LA5PRk+EWdQ=
X-Google-Smtp-Source: ABdhPJxlAudef46fT4V/YGDpbMmWoLcn7dzzEMcSv0WRjZ/yVzhVg8wbbqqffjrGsaA7cSeq9jAexw==
X-Received: by 2002:a05:6830:1690:: with SMTP id k16mr5430002otr.54.1621364701552;
        Tue, 18 May 2021 12:05:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bcf4:c194:74a1:9906? ([2600:1700:e72:80a0:bcf4:c194:74a1:9906])
        by smtp.gmail.com with ESMTPSA id a7sm3982494ooo.9.2021.05.18.12.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 12:05:01 -0700 (PDT)
Subject: Re: [PATCH v3 11/12] wt-status: expand added sparse directory entries
From:   Derrick Stolee <stolee@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
 <3b42783d4a86473420480b2789d61d8103e6e7d4.1621017072.git.gitgitgadget@gmail.com>
 <CABPp-BGww6VPMmp9dDyRJ2vgNCOdj16-LjU3aM3MM1NQ+T-pmg@mail.gmail.com>
 <a96b5081-e913-22a8-45eb-8d5de432dccb@gmail.com>
Message-ID: <f592fa8e-b607-1665-5f2e-3a3ad834b30b@gmail.com>
Date:   Tue, 18 May 2021 15:04:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <a96b5081-e913-22a8-45eb-8d5de432dccb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/18/2021 2:26 PM, Derrick Stolee wrote:
> On 5/17/2021 10:27 PM, Elijah Newren wrote:
>> On Fri, May 14, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>>
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> It is difficult, but possible, to get into a state where we intend to
>>> add a directory that is outside of the sparse-checkout definition. Add a
>>
>> Then we need to fix that; allowing things to be added outside the
>> sparse-checkout definition is a bug[1][2].  That's an invariant I
>> believe we should maintain everywhere; things get really confusing to
>> users somewhere later down the road if we don't.  Matheus worked to
>> fix that with 'git add'; if there are other commands that need fixing
>> too, then we should also fix them.
>>
>> [1] https://lore.kernel.org/git/CABPp-BFhyFiKSXdLM5q5t=ZKzr6V0pY7dbheierRaOHFbMEdkg@mail.gmail.com/
>> [2] https://lore.kernel.org/git/CABPp-BF0ZhbSs42R3Bw_r-hbhQ71qtbXSBqXdq0djyaan=8p=A@mail.gmail.com/
>>
>>> test to t1092-sparse-checkout-compatibility.sh that demonstrates this
>>> using a combination of 'git reset --mixed' and 'git checkout --orphan'.
>>
>> I think `git checkout --orphan` should just throw an error if
>> sparse-checkout is in use.  Allowing adding paths outside the
>> sparse-checkout set causes too much collateral and deferred confusion
>> for users.
> 
> I've been trying to strike an interesting balance of creating
> performance improvements without changing behavior, trying to
> defer those behavior changes to an isolated instance. I think
> that approach is unavoidable with the 'git add' work that I
> pulled out of this series and will return to soon.
> 
> However, here I think it would be too much to start throwing
> an error in this case. I think that change is a bit too much.
> 
> The thing I can try to do, instead of the current approach, is
> to not allow sparse directory entries to differ between the
> index and HEAD. That will satisfy this case, but also a lot of
> other painful cases.
> 
> I have no idea how to actually accomplish that, but I'll start
> digging.

It didn't take much digging to discover that this is likely
impossible, or rather it would be a drastic change to make this
happen.

The immediate issue is trying to prevent sparse directory entries
from existing when the contained paths don't match what exists at
HEAD. However, in the 'git checkout --orphan' case, we are using
a full index for the unpack_trees() that updates the in-memory
index according to the paths at HEAD, then updates HEAD to point
to a non-existing ref. The sparse directories are only created as
part of convert_to_sparse() within do_write_index(). At that
point, there is no HEAD provided. Trying to load it from scratch
violates the fact that HEAD is being staged to change _after_ the
index updates in a command like 'git checkout'.

So, the drastic change to make this work would be to update the
index API to require a root tree to be provided whenever writing
the index. However, that doesn't make sense, either! What do we
do when in a conflicted state?

What if a user modifies HEAD manually to point to a new ref?

Such a change would couple the index to the concept of HEAD in
an unproductive way, I think. The index data structure exists
as a separate entity that is frequently _compared_ to HEAD, and
the solution presented in this patch presents a way to keep the
comparison of a sparse-index and HEAD to be the same as if we
had a full index.

So, after looking into it, I'm back in favor of this change and
forever allowing sparse cache entries to differ from HEAD,
because there is no way to avoid it.

Thanks,
-Stolee
