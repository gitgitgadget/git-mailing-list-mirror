Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086FFC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFFA20671
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP7MR4jZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgEOP22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 11:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726945AbgEOP20 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 11:28:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ED7C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:28:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z15so4213176pjb.0
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WI62PQ3tcJMhh4Aq4N9NWbWtbMu2Xl7mE0uizmSGxjA=;
        b=OP7MR4jZsapPQf60sZPd7I5F7SVPg5mPTBqjrB4nLCqrjvo66ZQK7NkShQocPy3UPI
         LGWqhUMWCg9TihqtK6gLf83MRVR5+/Yb62zVLWe2rZgQK3FlbpU8jgzyrd400UEB/f/V
         +4EK1U/QSKcWPLJFlVznLiVirtyk/46w3RGuxpAtE80eyRAmaLUOsnB2QlTD3m4UWlej
         vELAus5PMTdwAUy6QOw2Pe1cQXHN8nKhnUSghUx2LMrpsF0EnEaeceG7P1EpbAuGsv7+
         MXAeoOc9URM7XXtjdy2DxJCXFz0w/TRgulSludLxvk+Ta/o2ECD/yR1QTCR8JLILU2Yg
         9C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WI62PQ3tcJMhh4Aq4N9NWbWtbMu2Xl7mE0uizmSGxjA=;
        b=r/AigHv44Rr0/v8xctSPsGArx8k3pmHbcbusCeU52rCWgSrZ1PuKLKt02AQGDWywYZ
         Y8UZglpcNWi9aerEa2QJ8uvGrozdLEHCaF2ciz55av/YML4aXxNIoJMdUxohIpSsD2jm
         SRH5jV6dz0k4BC7UyQ7kzbIYnrskbJOWOh8jrn94uszf8KOJhcbwSjNr5uPHO8rU6dni
         FNMDaKw2IKkRTjHN0l9IbizUYBOdT2yBcDPNJLYajL7BQ4lHjzLxAHU4LFTpX+V8BB+z
         jQZ8JgKXQP+N0Zs6wVvMk7cJ510EjPNdfSCuoBS3nan2sbsOiWJMCLdw4bVAzJ3v9ORU
         Cpmg==
X-Gm-Message-State: AOAM533vfgBJZ4Fcr3WDxzv1/NzsHmz4TK181kAR+4wni+gHt2vNJ8Kq
        ZqSgs/ZibgfxNf2/JYBoGNY=
X-Google-Smtp-Source: ABdhPJzGFYD9LumjP6YhFcfmfiThd6dWpxOsUo+reymQpY/R5mZcp1I618nort6KqGKNpkgZ2A5dJg==
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr3797105pja.80.1589556505426;
        Fri, 15 May 2020 08:28:25 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id d13sm2018331pga.64.2020.05.15.08.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 08:28:24 -0700 (PDT)
Date:   Fri, 15 May 2020 08:28:23 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures
 with file name/line number
Message-ID: <20200515152823.GA61200@Carlos-MBP>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586538752.git.congdanhqx@gmail.com>
 <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
 <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 03:16:38PM +0200, Alban Gruin wrote:
> 
> This happens on my machine, as well as on github.

could you point me to a failed github report?, also would the patch I posted
earlier (better with the following on top) help?

Carlo
-- >8 --
diff --git a/ci/git-problem-matcher.json b/ci/git-problem-matcher.json
index e10e88bba1..6d7424441b 100644
--- a/ci/git-problem-matcher.json
+++ b/ci/git-problem-matcher.json
@@ -4,7 +4,7 @@
             "owner": "git-test-suite",
             "pattern": [
                 {
-                    "regexp": "^(.*)(error|warning|info):\\([^ :]+\\.sh):(\\d+)\\)$",
+                    "regexp": "^(.*)\\((error|warning|info):([^ :]+\\.sh):(\\d+)\\)$",
                     "file": 3,
                     "line": 4,
                     "severity": 2,
