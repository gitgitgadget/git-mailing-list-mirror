Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C5CC433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC2C20825
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="sMSYa8hL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgERKEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 06:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgERKEM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 06:04:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C44C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:11 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t11so4591771pgg.2
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lYYyBshx07KEO/WLv1t4JupuYBVvauhB8mdz6AGsw6w=;
        b=sMSYa8hLqjQmfrvzSk3R8hlzQ5ikZcgBwgEhGEuwqiXJd3lgOLLTIM2zL59fjlnuNs
         T0xuAk7naa20fn9lXKawaJF2++LgkmbgeUkrdzdSFbd0c6Dhya8c1k+qbHeA/taCiRS0
         1ZCZQWAjlRlLsHRH+XViVoobPQeP397xX3WM7eJqHEhwRWRVQHAkLd9CD2FjwsrJhliq
         kouXe1vQ9/LMbg7On3H9Zf1T8nrz/3yMOOF4PMG63xX2lHCNjJHqi3J+K7R7soFnBVQV
         iyejy+J5yW61AY3cS3Ky1vuQ47+JQrdd3FzbbaRUpxgConVsx4CRfA/DB0g+iGn9+mTf
         mIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lYYyBshx07KEO/WLv1t4JupuYBVvauhB8mdz6AGsw6w=;
        b=R9lbGkpn3mf7D2rIR1Mq2Gkz8HizJ6NPXie6bJt9AZpaT1tGLuV+zK3X5h4xohwJKQ
         LFpwKNdsZTugrg4yDk/mCrqR6xJ6UY0h835EKQx3BcBskrZpse8cXnkdQ+9BNmgo1xis
         I+unYa+R1eGtiu+1PXVzFYM9mmXRviAMmOk+sfVG/EIUNyUuBquvFo+go7Oe/uyoDfcZ
         L6zxzk9IKiqNrNeQlDBgw8AXjsE3n5jS7WrHeygEOEBCrWqHTxN9BVLp9Nc9QkSnP5WS
         4NJUn+xd6/OpBEFamig6lprCc7K7NJhukAW1aqqOFFDPQfazMXYaHhFWmN5biJCXNhjJ
         kDUQ==
X-Gm-Message-State: AOAM533DNqgk28Cir9uetzsgsos2LLUGuvKcEAKWyRiZv7O9NQUqHv2d
        YgDhby0mgoKVLA70Kr72p1Jw8lEs/61POdq3qTiYK9ZEljWIQT1xUPIOrpwA2wbPVW52/ys4Rob
        zojn4oC9o7+DrZROBiaKJQEXTfjHp9DyQXWWWo3FUvfTXWi+i8T/lNLqw6VpTFzk=
X-Google-Smtp-Source: ABdhPJz/RF/Ko80LYJjyNXdO+sN8DEsqfvxXL5IsA6Qt3DdhW1UEoDK8k7RHFh7GtNKDwGCwu+ZvRQ==
X-Received: by 2002:a62:e117:: with SMTP id q23mr17161362pfh.188.1589796251072;
        Mon, 18 May 2020 03:04:11 -0700 (PDT)
Received: from fw.dtucker.net (ppp59-167-129-32.static.internode.on.net. [59.167.129.32])
        by smtp.gmail.com with ESMTPSA id cc8sm8094167pjb.11.2020.05.18.03.04.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 03:04:10 -0700 (PDT)
Received: from gate.dtucker.net (2001-44b8-3110-fb01-0000-0000-0000-0001.static.ipv6.internode.on.net [2001:44b8:3110:fb01::1])
        by fw.dtucker.net (OpenSMTPD) with ESMTP id 56b53342
        for <git@vger.kernel.org>;
        Mon, 18 May 2020 20:04:02 +1000 (AEST)
Received: from gate.dtucker.net (localhost.localdomain [127.0.0.1])
        by gate.dtucker.net (8.15.2/8.15.2) with ESMTP id 04IA41YN029454;
        Mon, 18 May 2020 20:04:01 +1000
Received: (from dtucker@localhost)
        by gate.dtucker.net (8.15.2/8.15.2/Submit) id 04IA41t5029447;
        Mon, 18 May 2020 20:04:01 +1000
From:   Darren Tucker <dtucker@dtucker.net>
To:     git@vger.kernel.org
Cc:     Darren Tucker <dtucker@dtucker.net>
Subject: [PATCH 2/7] Define NO_PREAD for HPUX 11.11 and 11.00.
Date:   Mon, 18 May 2020 20:03:51 +1000
Message-Id: <20200518100356.29292-2-dtucker@dtucker.net>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518100356.29292-1-dtucker@dtucker.net>
References: <20200518100356.29292-1-dtucker@dtucker.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tested on 11.11 but probably needed for 11.00 too.

Signed-off-by: Darren Tucker <dtucker@dtucker.net>
---
 config.mak.uname | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 5ad43c80b1..e864e04346 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -368,9 +368,14 @@ ifeq ($(uname_S),HP-UX)
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_NSEC = YesPlease
+	ifeq ($(uname_R),B.11.11)
+		NO_PREAD = YesPlease
+		CFLAGS = -D_REENTRANT
+	endif
 	ifeq ($(uname_R),B.11.00)
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
+		NO_PREAD = YesPlease
 	endif
 	ifeq ($(uname_R),B.10.20)
 		# Override HP-UX 11.x setting:
-- 
2.21.3

