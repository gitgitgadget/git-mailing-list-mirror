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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB9CC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB627610E9
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhFMDKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 23:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFMDKg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 23:10:36 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF8DC061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 20:08:20 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so1872581oti.2
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 20:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bPI2XuQp7fepBb2Ulb7ViBCgItTR5HAbZLFGqwghd8=;
        b=WFxn25TKt4KefIpYsO2+s3EBl3EAIcDBvEEf12BpcZlf4IWlbvS2ngIU3Je8AOBlBz
         CH5BjOvqJK/zF357ArsyiUMtJaTPafwUI6hHybDt9mHCbfJkG/FAiMjt7Z8NMR0kLiCh
         ecrQnX9OvwSwsKoikb/8yd+tsdSW7ERMYdNKI9Ra8OlEQRys7tf4ciNOzej+fjmZNIxy
         kW5sQf/yjtYuW9o6M1a3aXMit8ejEy97MWZNNPIppahZJ5uAG2C2+CiPFvpLVVKxN94i
         a1dhXyFX84UoYaEBZLpoKj/Awb8/+zw2zoN9HLlEm3ww2fBI4dYbHAkltonykuhM2kSU
         XNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bPI2XuQp7fepBb2Ulb7ViBCgItTR5HAbZLFGqwghd8=;
        b=J5YaJK1tRrOwodQiU8ZIUmtaFrEpgtqIsVPeKxWnuSWhAEkYs/vrqyQmi+ITeqDsZs
         2haDYHjQEdqIBesjLZBZCupa5dMfgBl4SuJZqwJ16IBN3HtTUMDsX+7FBPxCx3ny20S4
         kdoL5T7ioD+pbA6aZNBeZaiQiNVFF0ubmsBPyZNe4gFQdItOTo+8egrDVLUyzNiT/DHN
         UUZyu1dSUwEzY1AE6hqzlYldZ5Jbdx3DtsSYnCalnq3K0oRl3evMAJcitI2kfLA1fUHS
         tivxBuFr9em0KdnzZ0G32kiTANrK5fGFnNE5YxIRX68Igx728abrDQIDmmXK8zTYecXz
         QSow==
X-Gm-Message-State: AOAM532+KUYdqWSlxCTqetLj0Kxc3jHEfYakBAIn5YQCPg2984sKjOua
        7x3H5ZHXbzSNQcWs0dF6Htt6E7BMYRd9rg==
X-Google-Smtp-Source: ABdhPJy8NcNK0Q+WR5ORH8jtjuZlgXLBI6WisKVvXPHpvl8FYklurkS6xZpTaI+gg7Xm3Dc2RAm6Qg==
X-Received: by 2002:a05:6830:118c:: with SMTP id u12mr8554406otq.82.1623553699843;
        Sat, 12 Jun 2021 20:08:19 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id g38sm2385138otg.28.2021.06.12.20.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 20:08:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] test: bisect-porcelain: whitespace cleanups
Date:   Sat, 12 Jun 2021 22:08:16 -0500
Message-Id: <20210613030816.246225-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 48 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a1baf4e451..eef4963e76 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -13,20 +13,20 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 add_line_into_file()
 {
-    _line=$1
-    _file=$2
-
-    if [ -f "$_file" ]; then
-        echo "$_line" >> $_file || return $?
-        MSG="Add <$_line> into <$_file>."
-    else
-        echo "$_line" > $_file || return $?
-        git add $_file || return $?
-        MSG="Create file <$_file> with <$_line> inside."
-    fi
-
-    test_tick
-    git commit --quiet -m "$MSG" $_file
+	_line=$1
+	_file=$2
+
+	if [ -f "$_file" ]; then
+		echo "$_line" >> $_file || return $?
+		MSG="Add <$_line> into <$_file>."
+	else
+		echo "$_line" > $_file || return $?
+		git add $_file || return $?
+		MSG="Create file <$_file> with <$_line> inside."
+	fi
+
+	test_tick
+	git commit --quiet -m "$MSG" $_file
 }
 
 HASH1=
@@ -35,14 +35,14 @@ HASH3=
 HASH4=
 
 test_expect_success 'set up basic repo with 1 file (hello) and 4 commits' '
-     add_line_into_file "1: Hello World" hello &&
-     HASH1=$(git rev-parse --verify HEAD) &&
-     add_line_into_file "2: A new day for git" hello &&
-     HASH2=$(git rev-parse --verify HEAD) &&
-     add_line_into_file "3: Another new day for git" hello &&
-     HASH3=$(git rev-parse --verify HEAD) &&
-     add_line_into_file "4: Ciao for now" hello &&
-     HASH4=$(git rev-parse --verify HEAD)
+	add_line_into_file "1: Hello World" hello &&
+	HASH1=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "2: A new day for git" hello &&
+	HASH2=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "3: Another new day for git" hello &&
+	HASH3=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "4: Ciao for now" hello &&
+	HASH4=$(git rev-parse --verify HEAD)
 '
 
 test_expect_success 'bisect starts with only one bad' '
@@ -570,10 +570,10 @@ test_expect_success 'skipping away from skipped commit' '
 	git bisect start $PARA_HASH7 $HASH1 &&
 	para4=$(git rev-parse --verify HEAD) &&
 	test "$para4" = "$PARA_HASH4" &&
-        git bisect skip &&
+	git bisect skip &&
 	hash7=$(git rev-parse --verify HEAD) &&
 	test "$hash7" = "$HASH7" &&
-        git bisect skip &&
+	git bisect skip &&
 	para3=$(git rev-parse --verify HEAD) &&
 	test "$para3" = "$PARA_HASH3"
 '
-- 
2.32.0

