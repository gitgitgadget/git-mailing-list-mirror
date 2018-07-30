Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E09E1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 21:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbeG3WlA (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:41:00 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36491 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbeG3WlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:41:00 -0400
Received: by mail-qk0-f194.google.com with SMTP id a132-v6so8824259qkg.3
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MSS3N57dzv40SPe4yulD1K5WHOBemwvYktsvtfJ4zgY=;
        b=ckyzNTetrUpFX574awTBUnJw3WXQx3VPMeyB6MucCPG2uMzt+6lKPSvhKjAjNeFXpK
         mYBu+z4QtXmXqCkgZlL+EZyHyjI4Z/qp/wlUFqZ74OsJEtZuDxbnuJyjEJc/ZvzwO+eP
         7vEj7O4XDB9Krumh9b8SIGCjknjJn35gdBVrMUDaSOSMNV2CQpO7dTdmmkz2YzEjQcKj
         dWdhyeIipolaPMrmBy59SfT1HEqCb0wbWLDYs8onNvFlWR8jsp+9TewApbkYX2Mx+re7
         l4uuhZKf2f4N173priRbPPJ5BUOIxsUrfyR1FKqNlXnAHOQfzMCNH/PVjklT22AcIguF
         JimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MSS3N57dzv40SPe4yulD1K5WHOBemwvYktsvtfJ4zgY=;
        b=FAktfVU2eaUzFbhEnMynZhpSL6lR56A9Bw3rO8KpucTpRgNAMxFiADdOYm6LIfTQ25
         kpINjA3ulEcMqSERYeBFS7oQqLvW5VQm/DRZp/tL/SXyoV2UEfPDJ5Wv8sg64QnTO2Vh
         VwZyzgG171GhpCiVz84FJeyUfKsbomga65fccMGSK6kN4zX6TU9X5GRCuRROsHcDaf5i
         4jpRBsdfNfXKH+KsdUrRR/OrU4SqxAu87modbCPAyltjXee8RSCVc98qqV+dYJftSQhx
         aPAtghiEHz0niFBZ8BnqM+BUHdgjU3mPBVyOWsSUG3PpoiP3UiI1DQWKEM+8vuoJkmqL
         MMdQ==
X-Gm-Message-State: AOUpUlEtAgYFQ9v0dqXq/VPdLDKmlfzawvIK5VPs8fe0QvB8aJ/f+oOQ
        w7zQ8JYOdvaeJuG4A2Nj/w8=
X-Google-Smtp-Source: AAOMgpe4s0/1JYG2fM0llAuoG9uplbuMhMFjzFzvdzVOZtI6D7UAJiLb8UHEqSQNLwlZ+Uhhm+fGFA==
X-Received: by 2002:a37:1113:: with SMTP id b19-v6mr17808886qkh.242.1532984651566;
        Mon, 30 Jul 2018 14:04:11 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o18-v6sm6491503qtm.84.2018.07.30.14.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 14:04:10 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Speed up unpack_trees()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
References: <20180727154241.GA21288@duynguyen.home>
 <20180729103306.16403-1-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <dfe67a11-8b0b-682e-ff6c-4341808339bc@gmail.com>
Date:   Mon, 30 Jul 2018 17:04:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729103306.16403-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/29/2018 6:33 AM, Nguyễn Thái Ngọc Duy wrote:
> This series speeds up unpack_trees() a bit by using cache-tree.
> unpack-trees could bit split in three big parts
> 
> - the actual tree unpacking and running n-way merging
> - update worktree, which could be expensive depending on how much I/O
>    is involved
> - repair cache-tree
> 
> This series focuses on the first part alone and could give 700%
> speedup (best case possible scenario, real life ones probably not that
> impressive).
> 
> It also shows that the reparing cache-tree is kinda expensive. I have
> an idea of reusing cache-tree from the original index, but I'll leave
> that to Ben or others to try out and see if it helps at all.
> 
> v2 fixes the comments from Junio, adds more performance tracing and
> reduces the cost of adding index entries.
> 
> Nguyễn Thái Ngọc Duy (4):
>    unpack-trees.c: add performance tracing
>    unpack-trees: optimize walking same trees with cache-tree
>    unpack-trees: reduce malloc in cache-tree walk
>    unpack-trees: cheaper index update when walking by cache-tree
> 
>   cache-tree.c   |   2 +
>   cache.h        |   1 +
>   read-cache.c   |   3 +-
>   unpack-trees.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   unpack-trees.h |   1 +
>   5 files changed, 166 insertions(+), 2 deletions(-)
> 

I have a limited understanding of this code path so I'm not the best 
person to review this but I didn't see any issues that concerned me.  I 
also was able to run our internal functional and performance tests in 
addition to the git tests and the results were positive.

Ben
