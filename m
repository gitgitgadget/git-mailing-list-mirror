Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99229C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5457422208
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="2Rkew7O1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgIKS7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgIKS7m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 14:59:42 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965DEC061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:59:41 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 16so10904743qkf.4
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DPHCG40FC3ISedGHfyekvFCzHnw04JGahVt74rqdauY=;
        b=2Rkew7O1jZxcaGS3chwN49DL3Vwd7R6zKzQjVoON/5clQyrMsG6/sTWJCuNDgOf/L7
         CKzi3OhKgU7i7R4y2utjDqEghydNiPZfwgPfqftQY1kcmkfihNJw9qTZj3xAR5hfAw81
         81Ho9vJFSl7ekJVX3+9aHzMIUqFsfuy4sNT+cpMmVYC6yaCMtkNCKRCFZ6WAzGTklUbt
         EVtrG+bU4vIzSmGALlGL/DQRs+jGEK8c7Md6H/MFGnLAeSRAkNQPzoQjFDMGigULeww/
         GtuPajnyrqSoAG2dQc7LREC1pvk1U7B2XanZRbn9V7LqbTxf/xKCvZc7CjlQk4/kdmxk
         Im9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DPHCG40FC3ISedGHfyekvFCzHnw04JGahVt74rqdauY=;
        b=jC0u69zMS/6AWqyZ/DC/RyfxrBoSX5t/1HQ2hFqGtwoPyM24K8IYPpg0AwUxDyb8Fg
         VY1jAu9l4uG6ddFRkxctEhHDzVXvvpTA0H63Y8FBSJ2TYsqZqafodQzdAvvdWno5JvPi
         rizMXOUR3FNuRCQcqN7DfGj8yUMAN4OzWO6SsaYSSpx6HkC/jqtgUXaj9RjVhU0JvzVa
         30M8NEc4FQU6+2halAjUoDwgsZoBEgisHCJr4p11N3L1hBhiOqe1TwL54HnD3rEi+8QX
         gsjDiqEfvsd9Mq7EuVuaS4fNWUkC5fmYT+QyPoGrk/iXjDDoDjuKfusM0qJl+GJgRo4w
         C1dw==
X-Gm-Message-State: AOAM5307cEi6SUt0z4MZcmRrgEEIm51JqXKHgu1UtHFvPq9+pzKMANwE
        ZfExdJXjM6NIugfDl+PmP1hs7g==
X-Google-Smtp-Source: ABdhPJyyQx613l2mf1vFmw3yCP/TD7IAaSSGHVth4FaUJlLqkt/CBP3cFpdYCplPXp2X0AiZxT/HCg==
X-Received: by 2002:a37:c88:: with SMTP id 130mr2776700qkm.67.1599850780716;
        Fri, 11 Sep 2020 11:59:40 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:30be:852e:e670:3033])
        by smtp.gmail.com with ESMTPSA id g45sm3891404qtb.60.2020.09.11.11.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 11:59:40 -0700 (PDT)
Date:   Fri, 11 Sep 2020 14:59:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200911185934.GA2871@xor.lan>
References: <cover.1599664389.git.me@ttaylorr.com>
 <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
 <20200911175216.GA2693949@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911175216.GA2693949@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 01:52:16PM -0400, Jeff King wrote:
> On Wed, Sep 09, 2020 at 11:24:00AM -0400, Taylor Blau wrote:
> > +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
> > +filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
> > +enforced. Commits whose filters are not calculated are stored as a
> > +length zero Bloom filter, and their bit is marked in the `BFXL` chunk.
> > +Overrides the `commitGraph.maxNewFilters` configuration.
>
> The BFXL chunk doesn't exist anymore in this iteration, right?

Ack; I'll have to drop that.

> I wondered about having a user-facing "-1" here. My gut feeling is that
> we usually use "0" to mean "no limit" in other places, and it probably
> make sense to be consistent. It does look like we use both, though, and
> I'm having trouble formulating a grep pattern to find examples that
> doesn't produce a lot of noise.
>
> These are "0 is no limit":
>
>   pack.windowMemory
>   pack.deltaCacheSize
>   git-daemon --max-connections
>
> These are "-1 is no limit":
>
>   git-grep --max-depth
>   rev-list --max-parents (I think?)
>
> So I dunno. It's a pretty minor thing, but I think it's good to aim for
> consistency, and since this is user-facing we won't be able to change it
> later.

I think that we have to treat "-1" as the no-limit indicator, or
otherwise we'd have to specify some other way to say we don't want to
generate any filters. With this patch, users can write:

  $ git commit-graph write --changed-paths .. --max-new-filters=0

to generate a commit-graph without writing any new filters. This is
important to be able to do since we also have a
'commitGraph.maxNewFilters' configuration, which callers may want to
override.

You may wonder why you wouldn't just write '--no-changed-paths' instead.
Doing so would indeed generate no new filters, but it also wouldn't
write any already existing filters into a new graph which is important
when rolling up graph layers that already have incrementals, for example
with '--split'.

I'm happy to include all or none of this in a re-rolled commit message
if you think it's relevant, too.

> -Peff

Thanks,
Taylor
