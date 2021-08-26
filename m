Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECFBC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 03:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769AA610CE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 03:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhHZDWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 23:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHZDWX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 23:22:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F24C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 20:21:36 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z1so1902577ioh.7
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 20:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J2musqVlkGUlyRClyA/3KhbRNY3W+J8F7B48XM/cREw=;
        b=ySREebKCWQ7O3tLDM/fmQbICU+/sAIS/BGzdpmoXWSuUq/Ll4G75pdfXmXpHWXSfxX
         gWJg72/3f8uhkNl1SKLywGPVt7+xeECrUTkpPULM98A4YyIJfd6hLZqzJbBCeL0/nPj2
         /6YyeDizQF8spji+NQG1dLxlPU72zuKce3FvVylVY06OWixDcr2C+3Kqq1IFQT9TMHLl
         rRdql27P+WWzx8HVfHLEC1s0IlfEDBfP/oNHpdxOYKIu8MTkF1Q35O5iIAvpKCZABDdy
         ZHdK6BNBhJHPl1w5nTnAn4uQODLh/nZ3Gw9BXqi/BVcgllN4GyFQlQQTuDvw4vm+dp5/
         WsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J2musqVlkGUlyRClyA/3KhbRNY3W+J8F7B48XM/cREw=;
        b=aN41q5d6jBdrBj3o6u4bvWr7xk5p+x44spCUR6emWSGkQavUfOQCGF/U2xbsTKmclN
         gyOKTkOeWfSngwmmsnUIbEyYB0kPlRB6tZQv7G+nvYx2jRdpo0uDFs5fz8uA9D0o2s6r
         PM8u5amg6VnNHsw2vbvnU3kG32CjpKtB/nTItPzJz+5B1nmnEJP4eFlbKMaQ856lbMcW
         D3lG+8M+PIoWQL6hOOfHKUP0pVa6zMyrbJx7OWV1yZqdNA/BNyRqv/Q72fEQtPThtHd6
         W4mcKGy/KHmeKql7FIUsDZsBbY8o4z5u4br+8Mb8rucjNSi37p5tXGOmnWqEcxh152bJ
         RRMw==
X-Gm-Message-State: AOAM5301AhmGReFQ6Q1Z4slYT2ggQcKDFGzDqQf+sKIdq9XLs1g4icgd
        12F+TLP1AF1wsPaVtb5pUJmKHW+mkdrhU7XB
X-Google-Smtp-Source: ABdhPJxPtHziTfInLTI+6ggdWNMWQPOwgXItHef6N9xW9WizX521v58B639bFemuIPM0YXjiSYORHA==
X-Received: by 2002:a05:6602:1581:: with SMTP id e1mr1333643iow.49.1629948095985;
        Wed, 25 Aug 2021 20:21:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g23sm873772ioc.8.2021.08.25.20.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 20:21:35 -0700 (PDT)
Date:   Wed, 25 Aug 2021 23:21:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 4/6] tr2: fix memory leak & logic error in 2f732bf15e6
Message-ID: <YScIvuySaXPcBb/Y@nand.local>
References: <87o8agp29o.fsf@evledraar.gmail.com>
 <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
 <patch-4.6-73e7d4eb6ac-20210825T231400Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.6-73e7d4eb6ac-20210825T231400Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 01:19:22AM +0200, Ævar Arnfjörð Bjarmason wrote:
> In a subsequent commit I'll be replacing most of this code to log N
> parents, but let's first fix bugs introduced in the recent
> 2f732bf15e6 (tr2: log parent process name, 2021-07-21).
>
> It was using the strbuf_read_file() in the wrong way, its return value
> is either a length or a negative value on error. If we didn't have a
> procfs, or otherwise couldn't access it we'd end up pushing an empty
> string to the trace2 ancestry array.

Sure, and I could believe that we didn't ever test the "couldn't open
/proc/pid/comm" case, which explains why this error didn't fail any
tests. I wondered whether it was worth writing this instead as:

    if (strbuf_read_file(...) < 0)
      warning(...);

before trimming and pushing the result onto "names", but we should
probably be swallowing this case and not presenting it as an error
(since it's completely acceptable to not be able to read from comm,
e.g., in versions of procfs on Linux older than 2.6.33).

> It was also using the strvec_push() API the wrong way. That API always
> does an xstrdup(), so by detaching the strbuf here we'd leak
> memory. Let's instead pass in our pointer for strvec_push() to
> xstrdup(), and then free our own strbuf.

Right, you could make strvec_push_nodup() non-static, but I don't think
that kind of churn is worthwhile.

> Furthermore we need to free that "procfs_path" strbuf whether or not
> strbuf_read_file() succeeds, which was another source of memory leaks
> in 2f732bf15e6, i.e. we'd leak that memory as well if we weren't on a
> system where we could read the file from procfs.

Hmm. It's completely correct to only call strbuf_release on names inside
of the body of the if statement, but it's extra work for the reader to
figure that out. Why not put both strbuf_release() calls next to each
other (immediately before the return) to make it more obvious (since
freeing the STRBUF_INIT value is a noop)?

Thanks,
Taylor
