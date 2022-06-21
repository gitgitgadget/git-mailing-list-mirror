Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A85C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 10:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349003AbiFUK3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFUK3A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 06:29:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F204228706
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 03:28:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d14so9155607pjs.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkyUIuppH1oFHjFXyxjU+yZFSfExGId8+6/WRLWPCeA=;
        b=ZoZlP/JPnwG0GdQNCzkGS8FMapdHRmAPXPwyf4E89tKUMGphlsp88Gj0Ivaonl9BrK
         Iaq+i8mZw6VWlKtINghGOvcmfTvCI7oNfsHgCb9ouD2eN9qhRMcRapbDuexDQwRhEiqT
         Ukt9yU8vBL+NibnW/tuGYOUUnVrcqTHMn5k7a5zxEhsUwSCd7A7NMgWfXe0ySQRVfdrI
         J9evA053U5XgLrVwDbmJ8KvScxcUkf6jQzeqikcvGU+omUo2oVH4ds63ruTo+h40tyJW
         9CLeG6hS8yE7vH3EZcTEwv1x9KF1J2a9JfjEH3wCjFdtcycxJZvBqEeG9rkk/elSz2cG
         KrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkyUIuppH1oFHjFXyxjU+yZFSfExGId8+6/WRLWPCeA=;
        b=nVTvX8nvhgQFmBWcW/M5vWmDk0K3gZrcww1s3sDbJACtFNsKYWIKmfwrzOiRyJvcRZ
         VVO+NVuWXYcR7vvRnoE55FwOxoiJSfGRU7t1xTiOmAKdKs2b8c9fuzbXZo6W/xFQQTiL
         qo6pbPOo2S3zVZpv+iowpYN7vSotYEwqeqAKuHbZ4E2OO+Geg/riN/M8bE6U9AoILBzk
         s+Plvs63b4uBEnHtfu+/v6vfKX0E/QHYznWTHS+RGxr6WYpTld5aRkkGtlguUi8eKZjn
         AnU5sJx6qUCk5mpgetl2dAC1FacTujCOMilffgS/SAMF8sWsxsmrvSD8x1S9X+RRYxZe
         XpIQ==
X-Gm-Message-State: AJIora+r8vGzTeJe/vgkZjNTFSHsZJ4sbhDA6eJVzdc+JPZMhAXdj2bw
        nGratgMggVuLaSnabXFHQHQ=
X-Google-Smtp-Source: AGRyM1vU8adg3HhNpLI632aD6o9fC1m3Y8IsTFb9L7O+CbQwkEld7WBmrm+tfB0oUVaRMdQ1bBPNAQ==
X-Received: by 2002:a17:90b:4f84:b0:1e8:436b:a9ba with SMTP id qe4-20020a17090b4f8400b001e8436ba9bamr32800225pjb.191.1655807338360;
        Tue, 21 Jun 2022 03:28:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:4060:e8c:d9c4:5de9:32:b7ec:5230])
        by smtp.gmail.com with ESMTPSA id t66-20020a637845000000b004088f213f68sm10892863pgc.56.2022.06.21.03.28.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jun 2022 03:28:57 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/6] pack-bitmap: prepare to read lookup table extension
Date:   Tue, 21 Jun 2022 15:58:32 +0530
Message-Id: <20220621102832.21837-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <92dc6860-ff35-0989-5114-fe1e220ca10c@github.com>
References: <92dc6860-ff35-0989-5114-fe1e220ca10c@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> wrote:

> Here is an attempt to reword this a bit:
>
>   The bitmap lookup table extension was documented by an earlier
>   change, but Git does not yet know how to parse that information.
>   The extension allows parsing a smaller portion of the bitmap
>   file in order to find bitmaps for specific commits.

Got it. Thanks.

> This environment variable does not appear to be used or
> documented anywhere. Do we really want to use it as a way
> to disable reading the lookup table in general? Or would it be
> better to have a GIT_TEST_* variable for disabling the read
> during testing?

GIT_TEST_* is perfect. This was mainly for testing purpose.

> Here, uint32_T is probably fine, but maybe we should just use
 size_t instead? Should we use st_mult() and st_add() everywhere?

Yeah, it would be better to use st_*().

> I see that we have a two-method recursion loop. Please move this
> declaration to immediately before lazy_bitmap_for_commit() so it
> is declared as late as possible.

Ok.

> These two helpers should probably return a size_t and uint32_t
> instead of a pointer. Let these do get_be[32|64]() on the computed
> pointer.

Ok.

> This is using an interesting type of tail-recursion. We might be
> better off using a loop with a stack: push to the stack the commit
> positions of the XOR bitmaps. At the very bottom, we get a bitmap
> without an XOR base. Then, pop off the stack, modifying the bitmap
> with XOR operations as we go. (Perhaps we also store these bitmaps
> in-memory along the way?) Finally, we have the necessary bitmap.

Hmm, got the point. I need to fix the xor-offset related issue first
(That I said earlier) before doing this.

> Perhaps it is time to use hexadecimal representation here to match the
> file format document?

Yeah, of course!

Thanks :)
