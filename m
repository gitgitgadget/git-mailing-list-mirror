Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE1C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDD52076A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="yk+OHbbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgI1Ooq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 10:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1Oop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 10:44:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8080DC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 07:44:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k25so912737qtu.4
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0DQiRGl8EewXxlXHTYmTuQzOLzTyA8dH/ffXkI+jlDI=;
        b=yk+OHbbzUU6leGWHDPA6T3Kt6VD36wO1//+1iuwUJmrzPBzcu4K8qB4ZoZ7TJQgAhW
         VmPo2H8EELjMZF9fuO22PknfzdKEarBuUon/0wCzFDLrkuDEpX6fGxv/QA7wQ9MGDJ2+
         20hH3cccSlcO4g+2nJ8OkzjOtq24EWPwcoArbZDCLmO0Nu4WPxhJ7au8BTiLMe6npkHB
         0jjtPUe6lwVldQ0YFHjrsheA9iz+Sk42ozKfcfY03gEohTTsZa95gUVp8IwcTGvTBjep
         S/XJbDa/9jeZJYwLKMjlT0L6JEjIT8AFuZ5LofqsKPa1odz2iTMGmRir0iyj96NwmR0w
         RkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0DQiRGl8EewXxlXHTYmTuQzOLzTyA8dH/ffXkI+jlDI=;
        b=eFESoOTJVSLR0r/xiBlWq5dwZZ9XUjcgWB2be1WT7WeerDagY+s/mFau7QTqUzpiSR
         gQCEWVwp2J4MSFtHZSWV4pLX81ti6EHVIyaf94g1IGxt7/eP1h6FEPpZlf69A1jDSANz
         d5YuechpxztsvgATV/eRg7SGqGhFtYMws6ipW//yy3VUofQR4xQ6bHKfvI7XjVqlZA5H
         DAEMFOx600/CJ5mWZFn5h2JCwhktFJwHgwkKc1ZGwiAprDfoI5EoO5CkfdTFKDR58h9+
         73K5ydkqDJZPZSRZrQ6P+U4GXZVDnW/4pNGIUv8UW4donQm3f1utTS6UVl5DdHTzdWIi
         VEwg==
X-Gm-Message-State: AOAM530ue9fPhIr9O1ud1/YzOKtdijki46TBPVSX6EIcxQPMA/mHyAU8
        DqlWAdC2RnMIgfOGjCtBLaWH0FDAcPpdHKgh
X-Google-Smtp-Source: ABdhPJwN3nLNrls3XZUHwjTRvLk0YNvALdu6pHC8BSt0WdglQkwcbGn7gpBFGZD81mDpqobATZLaQQ==
X-Received: by 2002:ac8:74c8:: with SMTP id j8mr1855955qtr.77.1601304284697;
        Mon, 28 Sep 2020 07:44:44 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7c0e:340:55b4:224c])
        by smtp.gmail.com with ESMTPSA id l26sm1160492qki.62.2020.09.28.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 07:44:43 -0700 (PDT)
Date:   Mon, 28 Sep 2020 10:44:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] config/uploadpack.txt: fix typo in `--filter=tree:<n>`
Message-ID: <20200928144440.GA3846176@nand.local>
References: <20200927141156.9878-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200927141156.9878-1-martin.agren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Sun, Sep 27, 2020 at 04:11:55PM +0200, Martin Ågren wrote:
> That should be a ":", not a second "=". While at it, refer to the
> placeholder "<n>" as "<n>", not "n" (see, e.g., the entry just before
> this one).

Thanks for catching this. The patch below looks great to me.

> Signed-off-by: Martin Ågren <martin.agren@gmail.com>

  Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
