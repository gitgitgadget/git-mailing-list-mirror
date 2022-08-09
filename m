Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3E9C25B0C
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 00:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244746AbiHIAqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 20:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244737AbiHIAqB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 20:46:01 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117B825F7
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 17:46:00 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso7595256otv.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 17:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VGtHhq+z7FPSKro8R/9tuWWnCWkQrqgfsiPZGkMbnNw=;
        b=FQJnICEAWaVZAa7d+LlHnHrp/5MaqoXgvXrGJL/HKNacwplIBqgXL60rsE+m7Xia4c
         4rURdZfr/63vr9FN09YUjY3XU/kJ0vsp6nQN/m/nRPNZI92v3EqF9+jPUwSb72lIChX5
         6R0vM8sjrAVF8wBT6nLJvIVMJyvHf/eq8uurPscJr0TmvklrmwRDXD/XCLx2sIGlVivK
         nJefROvFTJQi542IbKQ4pIY+h7jWqKuyIowRcq01iYb2GXN2EUVDcqguTC73fdD0sRkj
         FMIV877XUG4YNhP9PB7RN/15T3oES3quiyNEbC6GREqA75k9P1jiKfKoEqCljzr7sj4i
         smAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VGtHhq+z7FPSKro8R/9tuWWnCWkQrqgfsiPZGkMbnNw=;
        b=J1vUhW8m59eAkGUa7GButyrjuLkWNuXlygWTNVlD4BtagjntvF5zgCxvObI1BUWQ47
         Ci2sS0EGBwIDQBTOKOLFaIe4rrDXbS50w0X2BS55p1FjTw4f/XD280Rp49ADofYQd5fN
         v+B0DgIoR8hzwk78FZUfWvojrwTwah2RAp0dUSimAPFbNuU9o9qQLBlOKuj8p4oI5+I5
         mx/QqMzDiCdLUeVtuYj2r2CV0zMli4EuZm2vGHgxbO4bP3gdKkT/jQkAc9g57qpe/+5r
         cqEUokA7CwXYSw/Sig9Do3cIt4qVKPzMf4ETSZfyPFBAHdsQufSZHtykA3mvR0sj84Pi
         nY+g==
X-Gm-Message-State: ACgBeo3Vq/JudglYytQlQC4tBYJYX3Lw6DOOivWAbLXlQaMz7Lr1Ja83
        2+2m0lVUrwsVS2KGZ8in6DVYbSqmp0U=
X-Google-Smtp-Source: AA6agR74VRHG5DDss2jdZ0SxKWxsOx6csTu0oxdygbk2clv4tfHiG0m7n8MamciUtJEaiyEMVN5DgQ==
X-Received: by 2002:a05:6830:1291:b0:61c:9204:ddb9 with SMTP id z17-20020a056830129100b0061c9204ddb9mr8226915otp.179.1660005959103;
        Mon, 08 Aug 2022 17:45:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id el40-20020a056870f6a800b0010c727a3c79sm2730733oab.26.2022.08.08.17.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 17:45:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 6/7] mergetools: vimdiff: rework tab logic
Date:   Mon,  8 Aug 2022 19:45:48 -0500
Message-Id: <20220809004549.123020-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809004549.123020-1-felipe.contreras@gmail.com>
References: <20220809004549.123020-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we treat tabs especially, the logic becomes much simpler.

Cc: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 64a8fe170d..8029be0975 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -144,11 +144,10 @@ gen_cmd_aux () {
 
 	# Step 2:
 	#
-	# Search for all valid separators ("+", "/" or ",") which are *not*
+	# Search for all valid separators ("/" or ",") which are *not*
 	# inside parenthesis. Save the index at which each of them makes the
 	# first appearance.
 
-	index_new_tab=""
 	index_horizontal_split=""
 	index_vertical_split=""
 
@@ -182,14 +181,7 @@ gen_cmd_aux () {
 		then
 			current=$c
 
-			if test "$current" = "+"
-			then
-				if test -z "$index_new_tab"
-				then
-					index_new_tab=$i
-				fi
-
-			elif test "$current" = "/"
+			if test "$current" = "/"
 			then
 				if test -z "$index_horizontal_split"
 				then
@@ -219,14 +211,7 @@ gen_cmd_aux () {
 
 	terminate="false"
 
-	if ! test -z "$index_new_tab"
-	then
-		before="-tabnew | silent execute 'bufdo diffthis'"
-		after="tabnext"
-		index=$index_new_tab
-		terminate="true"
-
-	elif ! test -z "$index_horizontal_split"
+	if ! test -z "$index_horizontal_split"
 	then
 		before="leftabove split"
 		after="wincmd j"
@@ -333,7 +318,15 @@ gen_cmd () {
 
 	# Obtain the first part of vim "-c" option to obtain the desired layout
 
-	CMD=$(gen_cmd_aux "$LAYOUT")
+	CMD=
+	oldIFS=$IFS
+	IFS=+
+	for tab in $LAYOUT
+	do
+		test -n "$CMD" && CMD="$CMD | tabnew | silent execute 'bufdo diffthis'"
+		CMD=$(gen_cmd_aux "$tab" "$CMD")
+	done
+	IFS=$oldIFS
 
 
 	# Add an extra "-c" option to move to the first tab (notice that we
@@ -554,12 +547,12 @@ run_unit_tests () {
 	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b\" -c \"tabfirst\""
 	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b\" -c \"tabfirst\""
 	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
 	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b\" -c \"tabfirst\""
 	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | 2b | wincmd l | 1b\" -c \"tabfirst\""
-	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b\" -c \"tabfirst\""
+	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
-- 
2.37.1

