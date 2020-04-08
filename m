Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E080C2BA1B
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50F720730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeBQVWX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDHEGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46447 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgDHEGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id s23so2031945plq.13
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gT7c91AbNzt9s4NLVVCFVAOJXpLUduxjSqCE+yLOFFQ=;
        b=LeBQVWX1UNdqwzIOxrRgVe/r39ioe5E1H9pyLk41XYQ9XMk424926apMPfmrb8Ca/J
         rfWh8g7siFi7th5LJyf65ZQcILVszo56zpHBjA5+fTd2ndh9EYe9v+kSQyyXdw5xD4U7
         lE9a/a9JLSRjwI7WvesHQsO4+pt/uQfkYS35hJlDxv4VfSiV5tmDwc1/luvry4HKYwDM
         OdACs7x+h+3AoHJUBNS/XTvrCw4XMddwiFK9L7jmFbLwCPfeG+W1OR5v0onsFsX0ov1d
         ViLRmApwG5p6rz1L6J/ioCZrfNdw28WTS6dDjKabUi6nR0BR+sg6hOLrYO8RynmYxtMh
         Yd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gT7c91AbNzt9s4NLVVCFVAOJXpLUduxjSqCE+yLOFFQ=;
        b=Mx54Ufozc1OH6NzpJEal6Mah58HUcOOE8P3cNr12sv6bw47uj1k7PyWSe3m/OJye1i
         3V6w0Jmz0wDxsUgR797/dBFJbN0i2P1QHfmaw9Y6tzRw9lYWyXZeLGzN09IWPfKdyqlt
         k14lGWn7v4sI9dszBORzn4rJdxpkA6wu2vtgPoiASOX2+lGnFtLjRJDER9z+PwJF9CsM
         DU1PCE0Q7wrslKCl+AAFAUYe7Nq8tGWHzPLGX4orUv5xpNXyTM5RS8Vc+XknPel1hBby
         8xaes9krPAsmdrpwJJkFLm1MoOTP4jKrk03FF+1nTItDS7TFg6mhYegluyMok46c2RnB
         UdYg==
X-Gm-Message-State: AGi0PuZWJ/7IVn14BnwcIuztUqmhslsXyRBQ9KD+XYzojEBGpaT2U9dP
        wmXuaJpMsrw3aFCiBqX0dkUV7BZdJ5E=
X-Google-Smtp-Source: APiQypKDJNmnsF2/LR9WUsmBvEda40YG17HgPyIH5c1+9hzCOIfQrhIdBBspmuweOGKay9QgZGEnkw==
X-Received: by 2002:a17:90a:e02:: with SMTP id v2mr3027848pje.131.1586318771259;
        Tue, 07 Apr 2020 21:06:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:06:10 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 08/12] README: add a build badge for the GitHub Actions runs
Date:   Wed,  8 Apr 2020 11:05:39 +0700
Message-Id: <46f2b6bce6ec55853a8708a090ad7e8e751b0075.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README.md b/README.md
index 9d4564c8aa..e2e00ae249 100644
--- a/README.md
+++ b/README.md
@@ -1,3 +1,4 @@
+[![Build status](https://github.com/git/git/workflows/CI/PR/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
 [![Build Status](https://dev.azure.com/git/git/_apis/build/status/git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=11)
 
 Git - fast, scalable, distributed revision control system
-- 
2.26.0.334.g6536db25bb

