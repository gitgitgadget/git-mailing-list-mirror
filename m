Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D853C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF57660F9D
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhIKJfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 05:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbhIKJfk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 05:35:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78BC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y132so2871030wmc.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STnTcNCjNcJibo8vTW5Xdv72QktRyPLwrCQ4pjmGfec=;
        b=mKUq/hpN33wHo4rvtWOynakr8fWx9ZXXKZbMAdLW+WJlIho2qrbG2eW38K3fd397ZB
         FQJLSU2Ybhc0wp6sILtC7rgG54V76Xl5gsHZQnaEiB2tWxP1k/YBILcv8SbgZWFCrmJL
         hjsQw3APWoRqpzTfFGElj2PYvUw54s3cdk4wudYA23jn0ze0pGrb8x3Mm1kF94LK4ayy
         7nrgt/hiPXWT+mLNbkaB3GHhqjhTyzpd7wnrUMKnwXPT+FTiygkQ3CAn6GMrLfYaEP4O
         /5KR6WTUqbc50BFgT1+v8zhzeZuHW/s/GRbATVUa8c85Qa8N0LnDNhcgRbpftIp34CX3
         pzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STnTcNCjNcJibo8vTW5Xdv72QktRyPLwrCQ4pjmGfec=;
        b=HZkZUju65+cU9e/iqs/aoBLJ01XF5Nqd9s2fCstbqc0xBw0K2pEs4oYC8enixY9XoT
         Jesl+R9LP+l2xL876Ssm+cT/ZnQPypkiGRPSmGS6Q5ZULuqupzK5n3aY43E1LoLGNs6G
         sjE6ZffZUn7TH8zw2NWVtivc7fKyf9+b4lhfl6YGYaYH2xugnz1LGURVmn/ZDEjqgSaj
         9hxm2vVOtA5r95Qty9uHFglKo3wn/SlxIOT9pTB3kKU07v75sOKI35pD0zbDjFybkw/P
         QDibJQ6JVgvw80Riwx+tTVF1aBj398mUOuIHjj2CZrN48bMEAUDDs5tz9yz5x/dd5RTE
         EDpA==
X-Gm-Message-State: AOAM533YG9mmaOqblFSkPkVkDOUQaQy/dXfod+hpuZJ74RnwSKk6Muxs
        Ew8iEj0sWYoCXm3780/1Y2Dk2YnDl/zwDw==
X-Google-Smtp-Source: ABdhPJxItloC0/4a/zQXHddqrttSgAKR0Gqhrr15pmQDO+xb7sc35sMGYKiFHZcWRAg+HDTw2a8LkA==
X-Received: by 2002:a1c:9d8a:: with SMTP id g132mr1938008wme.17.1631352866198;
        Sat, 11 Sep 2021 02:34:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm1161753wrg.42.2021.09.11.02.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 02:34:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/9] INSTALL: don't mention the "curl" executable at all
Date:   Sat, 11 Sep 2021 11:34:15 +0200
Message-Id: <patch-v3-1.9-7b771aa70ef-20210911T092751Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1d53f90ed97 (The "curl" executable is no longer required,
2008-06-15) the wording for requiring curl(1) was changed to the
current "you might also want...".

Mentioning the "curl" executable at all is just confusing, someone
building git might want to use it to debug things, but they might also
just use wget(1) or some other http client. The "curl" executable has
the advantage that you might be able to e.g. reproduce a bug in git's
usage of libcurl with it, but anyone going to those extents is
unlikely to be aided by this note in INSTALL.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 66389ce0591..5b8bd5ccce1 100644
--- a/INSTALL
+++ b/INSTALL
@@ -139,8 +139,7 @@ Issues of note:
 	  (PPC_SHA1).
 
 	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
-	  the curl version >= 7.34.0, for git-imap-send.  You might also
-	  want the "curl" executable for debugging purposes. If you do not
+	  the curl version >= 7.34.0, for git-imap-send. If you do not
 	  use http:// or https:// repositories, and do not want to put
 	  patches into an IMAP mailbox, you do not have to have them
 	  (use NO_CURL).
-- 
2.33.0.984.gea2c3555113

