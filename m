Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ED5C2D0DC
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C0E2075E
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQDVU1Pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfLZOVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 09:21:39 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34391 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLZOVj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 09:21:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id 5so22417322qtz.1
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 06:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8QhiLnETmo4uS+goxqEdNT/+l3uaMZ9AQK1QqYuJjC0=;
        b=uQDVU1PiCmiWFZOUa0q6AvaNQmDxlTYs+3pF8q9qenDD3tVEe4etsWEtUj//XHnw5b
         QOVGUS3L/+RaqKzXygk2GVrQAAWymrD5VswQzRGoPQ7ALn9c3uG0koWVX5RCi98KTOv9
         k/qmSdjMHgvLgLC5tYgYx0jpZ3LooBtLrkuO+UrToNjHML4qsE0DVuANog9ziXythNz+
         vHFBkiP8MM/wXpVUCATgQG9oI6aouC6s+0QQE8VserzQWmTYMZNdgJiUdOoGGG7Q2ML4
         Lv6mwH7jyHsm/wCY+64VuLtYdavXXT/LA7S3aa1QvsbDvzPWdhsNVxXoaLIshh0X+vq3
         WAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8QhiLnETmo4uS+goxqEdNT/+l3uaMZ9AQK1QqYuJjC0=;
        b=syCeXbkWOO/yC+NwSqmxJcgcJezxw++IwnoMJyytJoO9vuh6pC0YKLcf0XlF9aVE2p
         L0CEi+EcxmxBOgD2APhz3Sy+aL7o0dMMatR4VqtxPLv4O3BG12xP2X2eOX6Yu8WZabpr
         MrTTDrq5fG94iMPe1TPQ0TasPLYaCtHsn25k2HKjxHt5z55YfDZf5LWg39TctUElSfUN
         fvEKejwD83ZrBk/Q+CUOa0JEJeRnjXSHfk2ldtwnaYbmIQiSGpgawcfR1UaZxSGrYVHw
         tE3xA9n0VL/YgNuIBBBzEZ19gD5bQvwPzvZdgby6rU0cyRkc4PJsItU3dOcs++BD6c5Y
         aTEg==
X-Gm-Message-State: APjAAAW7aj5gAGQGmi2qqdsxa58E7MWrqMxGbPtAzkvxRsmMfXdwCguI
        DGrwHtR1WQnHtfUTVDqlV08=
X-Google-Smtp-Source: APXvYqxSJsYmI1PYilJjnxeiuuYM2TixwjD5Wi4ZhEDFBab3S/0u5L7Hm3Vj7KikFOxpz1WDkUZK0g==
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr34678659qte.327.1577370097928;
        Thu, 26 Dec 2019 06:21:37 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:d596:b1c5:69e0:b2e5? ([2001:4898:a800:1010:86cc:b1c5:69e0:b2e5])
        by smtp.gmail.com with ESMTPSA id c24sm7140729qtk.40.2019.12.26.06.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 06:21:37 -0800 (PST)
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
To:     Jeff King <peff@peff.net>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <20191222093036.GA3449072@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fc30441a-1bb7-73e5-43f6-6e26824e04f6@gmail.com>
Date:   Thu, 26 Dec 2019 09:21:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191222093036.GA3449072@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/22/2019 4:30 AM, Jeff King wrote:
> On Fri, Dec 20, 2019 at 10:05:11PM +0000, Garima Singh via GitGitGadget wrote:
> 
>> Adopting changed path bloom filters has been discussed on the list before,
>> and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
>> Derrick Stolee [1]. This series is based on Dr. Stolee's approach [2] and
>> presents an updated and more polished RFC version of the feature.
> 
> Great to see progress here. I probably won't have time to review this
> carefully before the new year, but I did notice some low-hanging fruit
> on the generation side.
> 
> So here are a few patches to reduce the CPU and memory usage. They could
> be squashed in at the appropriate spots, or perhaps taken as inspiration
> if there are better solutions (especially for the first one).
> 
> I think we could go further still, by actually doing a non-recursive
> diff_tree_oid(), and then recursing into sub-trees ourselves. That would
> save us having to split apart each path to add the leading paths to the
> hashmap (most of which will be duplicates if the commit touched "a/b/c"
> and "a/b/d", etc). I doubt it would be that huge a speedup though. We
> have to keep a list of the touched paths anyway (since the bloom key
> parameters depend on the number of entries), and most of the time is
> almost certainly spent inflating the trees in the first place. However
> it might be easier to follow the code, and it would make it simpler to
> stop traversing at the 512-entry limit, rather than generating a huge
> diff only to throw it away.

Thanks for these improvements. This diff machinery is new to us (Garima
and myself).

Here are some recommendations (to Garima) for how to proceed with these
patches. Please let me know if anyone disagrees.

>   [1/3]: commit-graph: examine changed-path objects in pack order

This one is best kept as its own patch, as it shows a clear reason why
we want to do the sort-by-position. It would also be a complicated
patch to include this logic along with the first use of
compute_bloom_filters().

>   [2/3]: commit-graph: free large diffs, too
This one seems best to squash into "commit-graph: write changed paths
bloom filters" with a Helped-by for Peff.

>   [3/3]: commit-graph: stop using full rev_info for diffs

While I appreciate the clear benefit in the commit-message here, it
may be best to also squash this one similarly.

Of course, if we create our own diff logic with the short-circuit
capability, then perhaps these patches become obsolete. I'll spend
a little time playing with options here.

Thanks!
-Stolee
