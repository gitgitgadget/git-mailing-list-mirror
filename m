Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFBBC25B0D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 00:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244767AbiHIAqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 20:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244457AbiHIAqH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 20:46:07 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D596559D
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 17:46:01 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f3-20020a9d0383000000b00636d99775a2so3928531otf.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 17:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uxfny2JjPZ1nPpdt7ZaXR1QCkbXQh6hyg+Be/e7Ow1c=;
        b=qxW7gW78k38qGxHJXHEjBlCVyJqllx/Ddt1Os6X7o1Vyq7PfvcKO9XpSKGJi/tpJY/
         IHhPseOJPRfK/jr1fof+/e0bqj0TSqDIyGS97crtPFhTeBB3gw5Z5v89dBKZ9DVgseD2
         oSXBxqfl6j7UzOeDLyLJyaRHBmhn6GsgACOPytB1VdmwihZh9O/6olvXo7RBCwF4o9L0
         njr8Kak/YNCV7BuL/OntJnaTHnWENLtY6CNgVp3LSJmGn4gOc1pXUrA0gtp0qaLi+w91
         HJxi3JDCuhb2OHdHZ9dNv+j5KO8F7wsrs5FJes7HY4umwUc2AIIHYg1bxsf51jOyyGEk
         nkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uxfny2JjPZ1nPpdt7ZaXR1QCkbXQh6hyg+Be/e7Ow1c=;
        b=fAvMI0WkPoFKGUgVEtMdSA5tzOxdhkWvpgm7RGnJ1rDdv/YpePoWyvweUyX0F3XaGh
         2wQ9QuDbNp/HJV4NCH9A+zeREjpmj8VUSpngjC/8IIh77C8XNvQVAs3J1YJr4MohqHBl
         Qz0NrU0rS7cvv/Tsav+ze6/sPZp91y0mfNR/uqwlAnTA6+68FgYUzMuEAhNnNJtpeH0X
         OXUYEngzivdQij1nn/7KXWgEuJWEmQ0dCEJ82X4WuLSI2rE6hnljzUMP+b7on4LugDB3
         UYhQyqGRkOA1vrYtH/iqJXgkbYN0oKC9Yb5W1CWtUaWTKP3SpQ41l8P0OFGSxMd17je7
         gp8w==
X-Gm-Message-State: ACgBeo1ztHXA1p7P0IT3/gMAnp4MJGDVudDGbDP/FAK7jG7SfkXHBcul
        xOVFMsrs3BC4GMnsajLLRky3VjXrXt4=
X-Google-Smtp-Source: AA6agR4NqUe6RGsNCkTQxN8pxUP90JAzbQ4ViKd7l/ClHSnsR6eBdmPImH8SS7RcmcA1EqW9yu3ziQ==
X-Received: by 2002:a05:6830:310c:b0:61c:c2c2:f9c7 with SMTP id b12-20020a056830310c00b0061cc2c2f9c7mr7912948ots.61.1660005960584;
        Mon, 08 Aug 2022 17:46:00 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h1-20020a056870c18100b0010e73e252b8sm2681772oad.6.2022.08.08.17.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 17:46:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 7/7] mergetools: vimdiff: restore selective diff mode
Date:   Mon,  8 Aug 2022 19:45:49 -0500
Message-Id: <20220809004549.123020-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809004549.123020-1-felipe.contreras@gmail.com>
References: <20220809004549.123020-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apparently some people want the diff mode to show differences only on
the visible windows, so turn this on only when the tab has more than one
window.

This should probably be configurable.

Cc: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 50 ++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 8029be0975..17921b6ba9 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -68,7 +68,7 @@ gen_cmd_aux () {
 
 	if test -z "$CMD"
 	then
-		CMD="silent execute 'bufdo diffthis'"
+		CMD="echo"
 	fi
 
 	start=0
@@ -323,8 +323,20 @@ gen_cmd () {
 	IFS=+
 	for tab in $LAYOUT
 	do
-		test -n "$CMD" && CMD="$CMD | tabnew | silent execute 'bufdo diffthis'"
-		CMD=$(gen_cmd_aux "$tab" "$CMD")
+		if echo "$tab" | grep ",\|/" >/dev/null
+		then
+			test -n "$CMD" && CMD="$CMD | tabnew"
+			CMD=$(gen_cmd_aux "$tab" "$CMD")
+			CMD="$CMD | execute 'windo diffthis'"
+		else
+			if test -z "$CMD"
+			then
+				CMD="silent execute 'bufdo diffthis'"
+			else
+				CMD="$CMD | tabnew | silent execute 'bufdo diffthis'"
+			fi
+			CMD=$(gen_cmd_aux "$tab" "$CMD")
+		fi
 	done
 	IFS=$oldIFS
 
@@ -537,22 +549,22 @@ run_unit_tests () {
 	TEST_CASE_15="  ((  (LOCAL , BASE , REMOTE) / MERGED))   +(BASE)   , LOCAL+ BASE , REMOTE+ (((LOCAL / BASE / REMOTE)) ,    MERGED   )  "
 	TEST_CASE_16="LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL / BASE / REMOTE),MERGED"
 
-	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | 1b | wincmd l | 3b\" -c \"tabfirst\""
-	EXPECTED_CMD_03="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b\" -c \"tabfirst\""
+	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_03="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
 	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_05="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b\" -c \"tabfirst\""
-	EXPECTED_CMD_06="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_07="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b\" -c \"tabfirst\""
-	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b\" -c \"tabfirst\""
-	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b\" -c \"tabfirst\""
-	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
-	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_05="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_06="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_07="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis' | tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis' | tabnew | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis' | tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis' | tabnew | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis' | tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis' | tabnew | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
@@ -617,7 +629,7 @@ run_unit_tests () {
 	cat >expect <<-\EOF
 	-f
 	-c
-	set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b
+	set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | execute 'windo diffthis'
 	-c
 	tabfirst
 	lo cal
-- 
2.37.1

