Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9B2C25B0C
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiHGCt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiHGCts (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:49:48 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21B4BF59
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:49:47 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id f3-20020a9d0383000000b00636d99775a2so742604otf.2
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=h6HbwcPKlPSeszIOkKVtGtkEZlCM4y93HzKT2xgCV/8=;
        b=EDxn+vLeQy3qtwwACeMGsryYglhow9yG8YW1r2TcuO+rmjzrAYMfj7vu3lqaO8SFsO
         kjw5xCHaFxV4TXzf+q+dP/O/0GsEL65TnDEfVdV95GiN2Kme/IAbpls9FonM3COgfEb3
         uOB23wir7FriqBhxwi9IAJH3ly2K1bRT0nPZRHfO7Oj9pMRWgyMFHDXvoZqaIO31kEOJ
         aUyXZIlPlmdUOITCGl8HfaiC2g7DuVS9kwxoFgF4iQrZo+yDf1r0LuojulpWtoDCHNil
         8F/4n+y3ronDwc3CEw8LqgwadCR2JctEZapSJBWiOEzp0p5MBcPiQWI/KkIF9telv61B
         MTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=h6HbwcPKlPSeszIOkKVtGtkEZlCM4y93HzKT2xgCV/8=;
        b=MQkeBMcMv8R1LbMUCuzjLJUyIqq7uauOkwfzQHC629zD06nqrqeVUAyRxPmT2/3/mD
         cBKALffi1iHZEqqHMG+mjXTYRdNLMl/2eg9rO6p5+uxzqnqB82M/GxnBofUHD/zsitCh
         bJo6Q/ag55f++iU8BPwMyV/ymyLoRgNUUk1VCH4Y6rjVPRIJrTASEjtmHHQjLORgcoS3
         Oa4qZDrkjWwREKbgJ/sZ9NGzbIbp50i4hhml6mGevHSuUxsF1aisjj89zsyts2JD1KHS
         7XdBVLcvuy4K5xiCu3j2id4gu9HooyRBDuGWN/JT2InvPZ4M1dw7v/z/InbRxwbIP+m5
         varw==
X-Gm-Message-State: ACgBeo0VohJwMycbS4c2JgEckk8n6JiXPwKXLUczwKPzQGlIBapf8z6v
        JNdsF4725aDhv8fQPtWyLe2ZWUHaor4=
X-Google-Smtp-Source: AA6agR5VNMJTy47jdEc97OdOyhkAMlpXQiCgk5FzmGpgmHyf9udsaP7M3NxM/KAueNpd5JKXz46k3Q==
X-Received: by 2002:a05:6830:12ca:b0:636:c552:46f2 with SMTP id a10-20020a05683012ca00b00636c55246f2mr1973805otq.362.1659840587069;
        Sat, 06 Aug 2022 19:49:47 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h12-20020a9d554c000000b006339b36127dsm1512768oti.3.2022.08.06.19.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:49:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/9] mergetools: vimdiff: add get_buf() helper
Date:   Sat,  6 Aug 2022 21:49:35 -0500
Message-Id: <20220807024941.222018-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.378.g3f95da6bac
In-Reply-To: <20220807024941.222018-1-felipe.contreras@gmail.com>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now the single window mode can avoid gen_cmd_aux() altogether.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 51 +++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 9805d139bc..103729b6a6 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -55,6 +55,30 @@ substring () {
 	echo "$STRING" | cut -c$(( START + 1 ))-$(( START + $LEN ))
 }
 
+get_buf () {
+	target=$(echo "$1" | sed 's:[ @();|-]::g')
+	buf="1"
+
+	if test "$target" = "LOCAL"
+	then
+		buf="1"
+
+	elif test "$target" = "BASE"
+	then
+		buf="2"
+
+	elif test "$target" = "REMOTE"
+	then
+		buf="3"
+
+	elif test "$target" = "MERGED"
+	then
+		buf="4"
+	fi
+
+	echo "$buf"
+}
+
 gen_cmd_aux () {
 	# Auxiliary function used from "gen_cmd()".
 	# Read that other function documentation for more details.
@@ -257,27 +281,8 @@ gen_cmd_aux () {
 	# If we reach this point, it means there are no separators and we just
 	# need to print the command to display the specified buffer
 
-	target=$(substring "$LAYOUT" "$start" "$(( end - start ))" | sed 's:[ @();|-]::g')
-
-	if test "$target" = "LOCAL"
-	then
-		CMD="$CMD | 1b"
-
-	elif test "$target" = "BASE"
-	then
-		CMD="$CMD | 2b"
-
-	elif test "$target" = "REMOTE"
-	then
-		CMD="$CMD | 3b"
-
-	elif test "$target" = "MERGED"
-	then
-		CMD="$CMD | 4b"
-
-	else
-		CMD="$CMD | ERROR: >$target<"
-	fi
+	buf=$(get_buf $(substring "$LAYOUT" "$start" "$(( end - start ))"))
+	CMD="$CMD | ${buf}b"
 
 	echo "$CMD"
 	return
@@ -319,8 +324,8 @@ gen_cmd () {
 
 	if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
 	then
-		CMD=$(gen_cmd_aux "$LAYOUT")
-		FINAL_CMD="-c \"$CMD | bufdo diffthis\" -c \"tabfirst\""
+		buf=$(get_buf "$LAYOUT")
+		FINAL_CMD="-c \"echo | ${buf}b | bufdo diffthis\" -c \"tabfirst\""
 		return
 	fi
 
-- 
2.37.1.378.g3f95da6bac

