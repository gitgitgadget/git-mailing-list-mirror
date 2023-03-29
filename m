Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB49C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 20:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjC2UuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 16:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2UuX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 16:50:23 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0FC44B8
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 13:50:22 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id k17so21027026ybm.11
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 13:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680123022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BVujWEna2XxxDZNvGVV2btJhak9BlK0rJVK7q7xhltY=;
        b=T2y7eiX/xh8LXdUM7/dXU9lyx4kxNvMtl3agStuo+B3NNVShXU+AsB9B+bxAslDgOf
         +maw/WiJACxDnlBdZGkEEw34KDgJ+StGFL+u6Szp8l4Cy3ySworyxF6exI7kbGi5VKmi
         2KnyPVXe1LRCw9ZTz5slgcdnPZXclZChFhvjrEYK02myt7CIqxxY35R4qe/gWsyuaQOn
         eVpPzILuxzNb5rCYPHXS7s0RlW573gB7Dyh6hrBApBL9FzIemXfs21i68fruCXuaRT+O
         SfQqCCJ1VTRIYgCrmnNFUCAfZUI9puDYpknXVHFRMgFEtVbHSopFjPa7X8IVrusTQ3Oq
         VQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680123022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVujWEna2XxxDZNvGVV2btJhak9BlK0rJVK7q7xhltY=;
        b=eGErpj+wKELowycZNOGh0+kqg4tziCcIxzG7k2+uWQkGwB9W40cpHSLKqEnaEZDiK+
         XlBQmLqA3xcJ2MUy1p2SJwRjHZb/v0Fel2SFO1Bk6j5WF7XTld8OcNIyvXw2ePvL52pb
         0icFw1GKmKjC4OAtd0aRbfhEFDs6Fs1dfZO9ENcEfuz9w8nIbs4fH5UZWXv+FG76JUEt
         xOMzcqFBPIqHfDaGG2dJ2qsfFaslGwRdLArJFDFu7evwRNlO1Ztn+aoXyBzgWt+J2xd5
         M9K2fd7NPPXFfgRITomMxvJMzRSmVtZcS+jwHw/I2s6X0vbe40iTB9yNHixCFk0MnB5a
         QYUA==
X-Gm-Message-State: AAQBX9eM4xOBSeGBG8Rg/AytaXaNbcsI7o60MJZu7J/fAGr+O5JxbL2z
        LMgX7s1jsZWdDzFxiApbRKggPA==
X-Google-Smtp-Source: AKy350YkpZ8yjvuG1p+CN9o6S85l4DgJIiJFibcJ+rB2p9Pb/vyKptG7RI483/+wSuAEtJEjgi4N+w==
X-Received: by 2002:a25:490:0:b0:b72:c618:e1cb with SMTP id 138-20020a250490000000b00b72c618e1cbmr20855942ybe.15.1680123021712;
        Wed, 29 Mar 2023 13:50:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d205-20020a25e6d6000000b00b7767ca7463sm3708181ybh.0.2023.03.29.13.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 13:50:21 -0700 (PDT)
Date:   Wed, 29 Mar 2023 16:50:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 16/17] post-cocci: adjust comments for recent repo_*
 migration
Message-ID: <ZCSkjFyoK45Yr2Po@nand.local>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
 <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
 <patch-v2-16.17-f947bb69dee-20230328T110947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-16.17-f947bb69dee-20230328T110947Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 03:58:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
> In preceding commits we changed many calls to macros that were
> providing a "the_repository" argument to invoke corresponding repo_*()
> function instead. Let's follow-up and adjust references to those in
> comments, which coccinelle didn't (and inherently can't) catch.

Thanks for being extra meticulous here.

Did you write a script to catch any of these? Asking partly to satisfy
my own curiosity, but I also think that it might be worth including in
this patch if you did do something other than manual inspection.

Thanks,
Taylor
