Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC21EC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 05:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFAA61059
	for <git@archiver.kernel.org>; Thu, 20 May 2021 05:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhETF2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 01:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETF2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 01:28:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30409C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 22:26:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y32so11027675pga.11
        for <git@vger.kernel.org>; Wed, 19 May 2021 22:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oa7G4qEOQ/xEnyus3B4eKUCxXT6LXdzZFLhi5BYrG9k=;
        b=Qu6gonWJh77TzJ8IP2HdIuHz09TABW1hihszq2hsyOz6C08/p9UHG7bhTROHY99omE
         LHro6JuV9/A80J+T4Vr5LXITufCQdY4xgodWldehWDmnXgZcS/irAN/sA9/2Xu+x/LRO
         bmSedNILS6D64OCRjYGKkXrOYXFI7VdKvNA9vgvqLgsKdmFGsTHN3dXFx5k2QbJwBXys
         6vW4Bv/McOad28n5qUlbPCNd7dzK2WvOgtGHn05d3DsMvpCdrCJg9Mr5a2UwcztfRoQs
         mc4UHkrCoqh+OppU2COpHost5Pue4Q64AlHVOMxxQkPleTxKct8vp2ro4cbIdaWRoEJO
         44ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oa7G4qEOQ/xEnyus3B4eKUCxXT6LXdzZFLhi5BYrG9k=;
        b=nQXt7D40U3xoo18zttp65iTxIyOjTq6p+SoWcIW2zr0lSfrIRlgmmsnYjJSkcJCXwu
         WMUDTL2Scpok0EbQe9SWw5wB36972WgcY0d/6745qaE/AvQWErJ545wwUodrIR65M5uN
         blMSaWEyMcE0+I8YNy0Vboi7QANf0qeCJrN5phFG3iGItoGpQle9qCSOjvm5ewR0O1T5
         ZJLrHzNvg8w4dPd6u5FPw89+iUSmyTb3ZXPtluOALW+Fuve0WPbyOMxHFkr0l2Y9QgCC
         jPqLPAt25+dFkLmUCIPfzqhBXe5KLAR69X4K12mrSWrG2Wfx1Vc5h9Pd9Avh5Hju2T48
         5wRQ==
X-Gm-Message-State: AOAM533lApdTTtO8qs3mXjBwt6gTXs1C1pDFkUN48cv6QRLm0UF1o56a
        2MikUvqf7PyX5v45vbRpKk0=
X-Google-Smtp-Source: ABdhPJxWX1isTIuLtbl6ny0Ohj3ylzrylve4lHDTk8ta0w+0fkuhmXLkwrR3qompsdCGyiZkeVzqPw==
X-Received: by 2002:a65:6183:: with SMTP id c3mr2753560pgv.403.1621488400403;
        Wed, 19 May 2021 22:26:40 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-15.three.co.id. [180.214.232.15])
        by smtp.gmail.com with ESMTPSA id t22sm818682pfg.119.2021.05.19.22.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 22:26:39 -0700 (PDT)
Subject: Re: [PATCH] revisions(7): clarify that most commands take a single
 revision range
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, schacon@gmail.com
References: <xmqqv97g2svd.fsf@gitster.g>
 <ab2d8b16-42db-9675-083a-efa7cfca6e4c@gmail.com> <xmqqh7iyuhlp.fsf@gitster.g>
 <xmqqcztmuhem.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <43f44eca-bf71-effa-29b0-cb2db41d581f@gmail.com>
Date:   Thu, 20 May 2021 12:26:36 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <xmqqcztmuhem.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/05/21 12.02, Junio C Hamano wrote:
>> The confusion we often see goes more like "The set A..B contains B
>> (and nothing else), and C..D contains D (and nothing else), hence
>> 'git log A..B C..D' would show B and D".  But that is not what
>> happens because "git log" (like most other commands) takes just a
>> "range" that is "A..B C..D", which is a set of connected commits
>> each of whose member is reachable from one of the "positive"
>> endpoints (like B and D) and is not reachable from any of the
>> "negative" endpoints (like A and C).
> 
> Well, apparently the proposed text may have failed to educate you
> about what a "revision range" is and how it works, so it is not good
> enough, so I'll postpone merging the change down further and see if
> somebody else can come up with a better description.
> 
> Thanks.
> 

 From Pro Git book [1]:
> The most common range specification is the double-dot syntax. This basically asks Git to resolve a range of commits that are reachable from one commit but aren’t reachable from another.
> Say you want to see what is in your experiment branch that hasn’t yet been merged into your master branch. You can ask Git to show you a log of just those commits with master..experiment — that means “all commits reachable from experiment that aren’t reachable from master.” 
> If, on the other hand, you want to see the opposite — all commits in master that aren’t in experiment — you can reverse the branch names. experiment..master shows you everything in master not reachable from experiment

So in the first case, git log master..experiment shows all commits that
are only on experiment, while git log experiment..master shows all commits
that are only on master.

This above are often confused by most Git users, because they execute the
latter when they want semantics of the former.

I CC'ed Scott Chacon because he wrote the description about revision
range in Pro Git book. Let's see what his opinions are.

[1]: https://git-scm.com/book/en/v2/Git-Tools-Revision-Selection

-- 
An old man doll... just what I always wanted! - Clara
