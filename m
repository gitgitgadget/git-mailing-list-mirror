Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3CC433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B426103B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhI0AzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhI0AzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:55:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CABBC061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v17so3832606wrv.9
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQ8mVJpemGK74uSrk9WPGPUUo7HiFI8SCIOhxKAnrwY=;
        b=AKDHKVc+KcdLd4H9gL3v4jpt1NDZvMaf19sBwxEYqFvznvhiJuZruxoBgGPQ88g1C0
         JZHSMWnP3S2omRT/in5d+ukTPbpNfHwPsyNzknZo8s1V3yDCPAscyWIr4jftjDCHr/MW
         STJFdf2qAwNsDdaUDHpBdBNOzH4dkSzpOgEIXlW9FDmJqF3Ep82L42kQXHW0x9MwcXWf
         nnwUDrnkKzznw/0EdVo4GH0+2+9yCBGqKBIn4CY1c4gbCEAM+dOyHLN4iZZ2wu8rttLr
         HYDFP4up3QNdX3Z3lLEdctvz8O2l6UAyLG3wn16Q/6KpeUy2MIZSp/2AXYTy3Qb1ZZVm
         9cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQ8mVJpemGK74uSrk9WPGPUUo7HiFI8SCIOhxKAnrwY=;
        b=cZLeGFEJif0JFiPcbisAof5mD5WT5nVk6/F/7WBZwMyRrtIyjOTV9Zn0AW8kLjj+oP
         EhfodkXrDcuBY2aoLsFfzhV0Fz/rqfS0+ViOgvbdzEOXw0wnYdM6hXJJqcLx4ZYT9ZHp
         peP2omUkeWPq6KgW8CdCGHXNwMeEFe3seLQYmO3V1084TJz6Y0cq0/bRTcfsVX/LLBBj
         DIxUFlW5NuSG5+zmnMoE6hJ5RBsbasykZX4fXQYnMRWTP9xWBh5sGP3aJgw4/hwHLDH3
         GFPxah/rOEhi930dHT9dBo1QP/SMzHSHnuTcU92aPhquC4rzZRuLzOLUfWUcqYQRxLs5
         qRtg==
X-Gm-Message-State: AOAM5321i7uF0wC0zEBnaCxaWQKc/SolwqHlFHHzVtt/Z3jwGCD9DH5e
        1upi78szhLpVxRULds7bj8/8iv6CSkBFSg==
X-Google-Smtp-Source: ABdhPJwU+0LW8638VKjGATGka7givmear+MSJcfnHQvY4dPj+HZaFDhaWKbHVm8UuZJkNvpoH9ytsg==
X-Received: by 2002:a5d:6d8e:: with SMTP id l14mr24593087wrs.196.1632704004498;
        Sun, 26 Sep 2021 17:53:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm14749745wrq.78.2021.09.26.17.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:53:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] shortlog: use designated initializer for "struct shortlog"
Date:   Mon, 27 Sep 2021 02:53:17 +0200
Message-Id: <patch-3.6-c9db107fcb1-20210927T004920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 64093fc06a (blame,shortlog: don't make local
option variables static, 2016-06-13) to use a designated initializer
via a typical *_INIT macro pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/shortlog.c | 2 +-
 shortlog.h         | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3e7ab1ca821..fa1f76cc51e 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -342,7 +342,7 @@ void shortlog_init(struct shortlog *log)
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
-	struct shortlog log = { STRING_LIST_INIT_NODUP };
+	struct shortlog log = SHORTLOG_INIT;
 	struct rev_info rev;
 	int nongit = !startup_info->have_repository;
 
diff --git a/shortlog.h b/shortlog.h
index 3f7e9aabcae..47892d6d604 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -28,6 +28,10 @@ struct shortlog {
 	FILE *file;
 };
 
+#define SHORTLOG_INIT { \
+	.list = STRING_LIST_INIT_NODUP, \
+}
+
 void shortlog_init(struct shortlog *log);
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit);
-- 
2.33.0.1316.gb2e9b3ba3ae

