Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9A91F404
	for <e@80x24.org>; Wed, 15 Aug 2018 14:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeHOQ5Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 12:57:25 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42789 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbeHOQ5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 12:57:25 -0400
Received: by mail-qk0-f194.google.com with SMTP id 13-v6so806601qkl.9
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=euI9sGVCf/LEeQxxtRidPyTJ3LwNslGxUE+KC7or3c0=;
        b=jsyJREO0BA2FZ9j+2mTEvCJ7VxK5KCmmdn3WPObSsdNbIJdIV29j5/6xzMx9yssxu+
         gg45CBiKPe6oAM4ObcoXSO6p0Jo4eyduHMR+zXitrUCNy5APR8Xsqz/Oq/ia3k9OFM32
         PYeex177PD4FkinRr6RvBh5Kje+ElqnV8Gm0R52aZIPeUolwHBYPNJwQiUcKujEVkTU2
         91r0ULOa6zy/rIXgDhvtwcqyzSmsaLU4DFXr2r6RimWNlQozV51ZOqnMrvOO6Mz2GmVO
         HjSlzO5wfWCTVGXBrNqbJleKywXcOu0RveG33OQ9juSJF8lWllW0UC477ZSe1ioDtDab
         IvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=euI9sGVCf/LEeQxxtRidPyTJ3LwNslGxUE+KC7or3c0=;
        b=CtvAgt0uzXieyo7N13PqHawa6n8TVhc6ZJj7uOUwFYx9Mza0qV2lwFgjSUi5v35MeJ
         73IPEnaqk4rWdwlNj4zAbwR1JMsEFVL8Rfotk6aNMfe1Jo3lFF3OBxZuX4wat/RUked+
         l4ygBZZoFPrPt41ymoedfozH0s3OGFvhLidOMuvZT6vqCSE9swe19ecTMDCyuqx82PG2
         60iMIjsDmSOfAi+Z6HkzlNXTJvISynrNyz22OFJ+WSd4OwIYYhH7RMHQzRs93iodNO9W
         WDZQYJ4eG2r6BVdpGsU/YJWhPZLNJ9e7xLT0r7qRgA+kaZ7A85f27QwllBAne3FoT2s6
         wD/g==
X-Gm-Message-State: AOUpUlFX28uL8OuO1uQMUUmfCciM1IDlraeLyKnWfRHd1k9B7IHp+4bW
        QFZ+GBTXPdJQ2mnWExu2xxc=
X-Google-Smtp-Source: AA+uWPzioKp502QkDzy4ol6m2/wTqo0i4KHJJcngZWmDXC6L5jDNHI8k4G+hyoGVOyaGkcwyvLMM3A==
X-Received: by 2002:a37:6b84:: with SMTP id g126-v6mr23760171qkc.231.1534341906447;
        Wed, 15 Aug 2018 07:05:06 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:6962:3b9:979a:51c3? ([2001:4898:8010:0:5298:3b9:979a:51c3])
        by smtp.gmail.com with ESMTPSA id a187-v6sm15410924qkd.47.2018.08.15.07.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:05:05 -0700 (PDT)
Subject: Re: [PATCH 0/7] speeding up cat-file by reordering object access
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
References: <20180810230729.GA19090@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fc30f98e-0aa0-89d3-ee32-3d86cc5b342a@gmail.com>
Date:   Wed, 15 Aug 2018 10:05:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180810230729.GA19090@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/10/2018 7:07 PM, Jeff King wrote:
> The general idea is that accessing objects in packfile order is way
> kinder to the delta base cache, and thus way more efficient. See patches
> 4 and 7 in particular for discussion and numbers.
>
> I'm primarily interested in cat-file, so this series is focused there.
> But there may be other callers of for_each_packed_object() who could
> benefit. Most of the existing ones just care about getting the oid, so
> they're better off as-is. It's possible the call in is_promisor_object()
> could benefit, since it calls parse_object() on each entry it visits. I
> didn't experiment with it.

I like this series, and the follow-up. I could not find any problems 
with it.

One thing that I realized while reading it is that the multi-pack-index 
is not integrated into the for_each_packed_object method. I was already 
going to work on some cleanups in that area [1][2].

When using the new flag with the multi-pack-index, I expect that we will 
want to load the pack-files that are covered by the multi-pack-index 
(simply, the 'packs' array) and use the same mechanism to traverse them 
in order. The only "strange" thing about this is that we would see 
duplicate objects when traversing the pack-files directly but not when 
traversing the multi-pack-index (since it de-duplicates when indexing).

I hope to have a series working on top of this series by end-of-week.

Thanks,

-Stolee

[1] 
https://public-inbox.org/git/CAPig+cTU--KrGcv4C_CwBZEuec4dgm_tJqL=CFWKT6vxxR016w@mail.gmail.com/

     Re: [PATCH v4 04/23] multi-pack-index: add 'write' verb

     (Recommends more user-friendly usage reporting in 'git 
multi-pack-index')

[2] 
https://public-inbox.org/git/20180814222846.GG142615@aiede.svl.corp.google.com/

     [PATCH] partial-clone: render design doc using asciidoc

     (The commit-graph and multi-pack-index docs are not in the 
Makefile, either.)

