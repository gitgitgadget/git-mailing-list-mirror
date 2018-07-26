Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620D81F597
	for <e@80x24.org>; Thu, 26 Jul 2018 19:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeGZU0y (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 16:26:54 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35255 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbeGZU0y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 16:26:54 -0400
Received: by mail-yb0-f193.google.com with SMTP id x15-v6so1073402ybm.2
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 12:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26a40Xx0v8UAxr2VWUWpJo7cYGF0ZbJPUnbNtuwaCAM=;
        b=KD2kQRUOh9smnes/WLXQLI3kvcF0pPsl4g+f0GygmHl/0V1dDGrnMBsqCjnxMo3NwZ
         BiqGW/3QoQDra8PO80R/bHYfP2Bb0UTyi9sZK5kZkCkBBGliDzgFxrs8ANaIviUJ9s2g
         tEonVt96eqeWkKDHOVw+Jo6uCuDQm7Q7ts++d1BJ8QDXVWALxsXSAWkAQy0o2QJd6+fW
         oR7M4Wu2xKhCffrJdq71oATFUUnlBVGPDRTyeLHAHI+MxUJgX6jkflIJ0+X6olUgUq9E
         BhaN+LC7NE1CD8NCMiDni9deZbFXwJFouGpTU20YvPCgSrGEujrVh4VuWyaZgMs/zQBq
         Ao/g==
X-Gm-Message-State: AOUpUlEvPpI0nETzolef6k0hMbTBcmYo1zhkdvcfogWtTMMZXhbAJbq4
        dori0pODYk8uwUfagzhzu/vh37CIJ8BLt4KoieQ=
X-Google-Smtp-Source: AAOMgpelHTPGVU3ponj37l3+J57o6OYre82Obv4HTHvYK9AdM3H8pLqNBOzwhGls6+OqOK3ePVO1yoiJUTtCHtWvxNQ=
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr1801913ybp.76.1532632122844;
 Thu, 26 Jul 2018 12:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <CAPig+cQZ4g-6uT3zB0n2XWb-68DUUBZdaimTb6_Y4DNZrLUdyQ@mail.gmail.com>
 <960c32c0-5b10-6854-73c9-392814dddbb3@gmail.com> <xmqqeffqrqb3.fsf@gitster-ct.c.googlers.com>
 <CAPig+cRtUeSCUnUFw0xgXEV7nyBiORZSLfLYfhKWjXxcgHvQmg@mail.gmail.com>
In-Reply-To: <CAPig+cRtUeSCUnUFw0xgXEV7nyBiORZSLfLYfhKWjXxcgHvQmg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 26 Jul 2018 15:08:32 -0400
Message-ID: <CAPig+cRgJh2+1wdQS3a8Vd+D0VDPwLO8HXGYZ6MhkCK3ww47sA@mail.gmail.com>
Subject: Re: [PATCH v1] checkout: optionally speed up "git checkout -b foo"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 2:59 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jul 26, 2018 at 11:04 AM Junio C Hamano <gitster@pobox.com> wrote:
> > If there were a simple and futureproof way to tell the option
> > parsing loop to notice any feature other than "-b newbranch" was
> > used, then such a whitelisting may be a viable way [...]
>
> I'm wondering if a two-stage parse-options invocations could make this
> potential maintenance problem more manageable by altogether
> eliminating needs_working_tree_merge().

A downside of this approach is that it too becomes a nightmare if
git-checkout grows additional special cases like the proposed "-b", in
which case multi-stage or disjoint or intersecting parse-options
invocations might arise. Another downside is that this parse-options
idea is somewhat invasive, whereas, needs_working_tree_merge(),
despite its ugliness, is at least is self-contained and not at all
invasive.
