Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9E1C433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 18:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ2SMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2SMM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 14:12:12 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4993317AAF
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:12:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h206so3516259iof.10
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2WgGO6Zjl86oMY988jlEUkjLAZnqo7w5TRPBZM7hU/w=;
        b=UtbHv7BMZCAhpeVefIyubZOYb6aPepnH7yMpOK26DYgngt6EhCo7dki0GwSDarzwtl
         pUbnJf4Dzh+5y8voi6sA6ELxVlqan1q697XDpoRPFeyJAmXUqMf9tXlrFEge4p8Zsa2G
         GTmekuEfEEryNHKpVPr24yKchBSXIrUk5L4Ccr0J9xuuPjtyWPq5YTfCFWOMiQ1AQfzJ
         NByElNoFLmb6uyUA1Vz6S/vUeVSLZDvVNk94DUF/wv4BbipNMOW8K/4R5q+0nExOmWWn
         wI6hoMt/k2NHDia8yo3NgVzq40xp4K7PO/ioUEBz8j6MBJRmyflCWjxi91fDQ/TBzEne
         ID/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WgGO6Zjl86oMY988jlEUkjLAZnqo7w5TRPBZM7hU/w=;
        b=ksHmxs5K9hR6bCod99kR4A5nyDw/S+bvLtAR3L8z9aENOur32nHv0M+OSe+ab6I5+y
         WlzVK34zux9v/nqseHTymCUohK1/kLCPEraeqTBSevc/pvnO1UXsG8UmNKxiby3X0Kp8
         fAwV3LDQyxitL9jN6oLGJrR1FFYbMWXgU8eFh9mWge6ICnh27eCapL9OeJMNNF0is/tO
         uw7n4pHHy7P0msAI6GStmnnln7VAm1mky/RnFGcmuaSLnzETqU9LRfjQMoxxg2JDV5tL
         zv9wOV6epWLlMSft2fNSE6bDirRZxQkv9PVd5Plz5fNp/OoA2529GNMpNG/M2EdJdqE+
         OBMQ==
X-Gm-Message-State: ACrzQf3eObJEMq9LTBlTHkKUJ7gdUpHM77BSdGXcy4khIG97jjT4zYxu
        1OCrE69TEiAMXbFOT20DkMuEBhblgyg1sLWc
X-Google-Smtp-Source: AMsMyM4eLlnA/XcAwY4Z+fKOLmpMVaEfB++14XyHBiZWk14yamITM8FSsfU63BPQoNc/7+cOMkGerw==
X-Received: by 2002:a6b:d30b:0:b0:6bd:36d0:386b with SMTP id s11-20020a6bd30b000000b006bd36d0386bmr2638775iob.198.1667067131625;
        Sat, 29 Oct 2022 11:12:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m19-20020a92c533000000b002f52f029b4asm784210ili.32.2022.10.29.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:12:10 -0700 (PDT)
Date:   Sat, 29 Oct 2022 14:12:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/8] merge: remove always-the-same "verbose" arguments
Message-ID: <Y11s+XokKbbJ1WTL@nand.local>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <0cae80c0-2576-8be7-48f7-06a0a135961f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cae80c0-2576-8be7-48f7-06a0a135961f@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2022 at 06:35:02PM +0200, René Scharfe wrote:
> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>
> Simplify the code that builds the arguments for the "read-tree"
> invocation in reset_hard() and read_empty() to remove the "verbose"
> parameter.
>
> Before 172b6428d06 (do not overwrite untracked during merge from
> unborn branch, 2010-11-14) there was a "reset_hard()" function that
> would be called in two places, one of those passed a "verbose=1", the
> other a "verbose=0".
>
> After 172b6428d06 when read_empty() was split off from reset_hard()
> both of these functions only had one caller. The "verbose" in
> read_empty() would always be false, and the one in reset_hard() would
> always be true.
>
> There was never a good reason for the code to act this way, it
> happened because the read_empty() function was a copy/pasted and
> adjusted version of reset_hard().
>
> Since we're no longer conditionally adding the "-v" parameter
> here (and we'd only add it for "reset_hard()" we'll be able to move to
> a simpler and safer run-command API in the subsequent commit.

All looks reasonable here. Thanks for the detailed explanation of when
and why these changed and at which point they became redundant.

Thanks,
Taylor
