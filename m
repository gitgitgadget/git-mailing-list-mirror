Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1977C4724C
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1AD9206B9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htVg58DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgEDPts (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgEDPtr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 11:49:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C108C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 08:49:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x2so5668928pfx.7
        for <git@vger.kernel.org>; Mon, 04 May 2020 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ko2+QlUW2I6FF8ZlmQH9phzTArvgWz6BxmT/mrtW5zI=;
        b=htVg58DB4QcNaCxMDxUgnUCVzDiXODi+9Uu7eUQ1b40rXWCNMz8bxlVkyvJGO6sSJR
         /KgmQyJU0O7cGo5+sUkcdvvK2WGLUjXMsk6EKY6C9ZqrtC02zw4GRvSP6g9+68cDDoEU
         //bKMZlgWpNSBcwwncEkV8ycLskhz46eKhiIoiyHLPBG6F+tpOgYF7sZ4F28VL6mWt1s
         CXtEiWUHOfLw9vdx3EHoVE+Z8WlpgJu5Q3mwnIzB7s39ksQ54YtktfLbx10u72iS7WdE
         Coz+kt1Xs/2wcS5yre3lnVVmZZTzDwhMnD27xH3oGZlDRdjtiJ6IU4xO9/MZWZgtHV9u
         yFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ko2+QlUW2I6FF8ZlmQH9phzTArvgWz6BxmT/mrtW5zI=;
        b=R/UX62Ioo71asjdRwquhgSDk39z82DrunpyJTT7zCFHI/k4sUPAA2eGTD5hlX2zIvW
         cBdJ2mGmeBTxiyWhB8grTYBAWeUdsPgcplJMpRyRw8CdWoRWHJYHlSQpTfss86coDzGE
         Dwjln2cHOC175Enx3z3Nc6Rl2GmajjLmgjqHShlDyl2WxUNlvb437spwW+4zqdsNwaFI
         z/KcyyqH7HB5lF+6AS+/Q6kKsnKd6BY7b3uElNTM+j5pPCnaQ/a4JDjtXUqwVejejjsM
         gzaNOHgy8VO3/f0F0jSXKkPfOvNknhPJHOlu72SjKUShIIo2+fYc3qZY/NBrQiiNHrnS
         Cgyw==
X-Gm-Message-State: AGi0Pubsjvcoif91Q+qwluTBEqSz5va9BxhivR9Yh/vMGXm5f9q4STSB
        egWi4zcLfQMx6K4M+Vrz9W8QLoSg
X-Google-Smtp-Source: APiQypK+E1kYSWrEJo7xhmDVEsCGNQ1hv7Fevh7PENrtFhInRW9lOeJQEQ8HknIfJ4KP31XMqV8Ovg==
X-Received: by 2002:a63:c241:: with SMTP id l1mr17529356pgg.42.1588607386603;
        Mon, 04 May 2020 08:49:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id x63sm9319513pfc.56.2020.05.04.08.49.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 08:49:46 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Date:   Mon,  4 May 2020 22:49:31 +0700
Message-Id: <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
In-Reply-To: <cover.1588607262.git.congdanhqx@gmail.com>
References: <20200504150105.GB11373@coredump.intra.peff.net> <cover.1588607262.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's maintainer usually don't have enough time to debug the failure of
invidual feature branch, they usually want to look at intergration
branches.

Contributors now can have GitHub Actions as an opt-in option,
should they want to check their code, they will push into designated
branch.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .github/workflows/main.yml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fd4df939b5..ea43b03092 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -1,6 +1,18 @@
 name: CI/PR
 
-on: [push, pull_request]
+on:
+  pull_request:
+    branches:
+      - '**'
+  push:
+    branches:
+      - maint
+      - master
+      - next
+      - jch
+      - pu
+    tags:
+      - '*'
 
 env:
   DEVELOPER: 1
-- 
2.26.2.672.g232c24e857

