Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8813AC00140
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 00:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbiHIAqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 20:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242257AbiHIAqB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 20:46:01 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8992719
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 17:45:59 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id m22-20020a0568301e7600b006369227f745so7572621otr.7
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 17:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DUbVheBx93ba2pkuSb1IWXwCzzBsdySkloHOONSgQ0k=;
        b=Ah/6sk3Me9qP1rLgsCFFU8UoXUzBzff6zMdnBvQPjeNrXDHpguARseuaQdvblRtY54
         IKns5T9Rrvz05pcKPu7VNlMg9yhNpBkvU6cG2Xfn4nc26sPPJgM7nYjyADNhDj6awe+M
         uvCrD4QU7kGrrUPN7nMp9YccN+rvUT1EZa0SjhY+R7/RGaG4xfixIDfBesSjEhg51WWj
         0Io1rozbNEfkfuPsEiRIFtDP+5Gzj/LTa/hUaxNAuTM+x5HvvvZTHX/WceB/GiJWXthQ
         vW7j7SqcC/Id7nU0z5ggr1iepM7Ic3AXzNaQXXNXjbBZ5OCme/DBFUiPgRKwNRTYZQy1
         jfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DUbVheBx93ba2pkuSb1IWXwCzzBsdySkloHOONSgQ0k=;
        b=ihF1/HA6lTe64EQADZXByFEu56XkqtIkC91hTl1OL+EJMqJbSIblHdzGoFgDCpp3C9
         2a24DUUc/PP3Xfm9Ts3/90VHa0KyWKHvcQIZNVDFHhhIZOUFG43zs6e7mnzuFE4LWS0y
         pW5wTRFgJN197+BXN/v3N4x/Qukv9tErYpZ7rVokZbiAfTwQOKpNMqUmWH4UhkqGVs8c
         6/GAA8iBpg9ZY2GxBFwzaUl9IUnV53Ali3E8X0WLnopOrD6BlHA2PGB4Csv/50BPBFiO
         9dwiwrdu1W3SbQf53xtCmDpGLXEQMJTUqybIU4ut/jviSdWxh40jUnIb796NEHyelC7E
         kl0Q==
X-Gm-Message-State: ACgBeo2rlBLPKenJHmNtE/MSUoYdlXHpEWgZUnhlS4VxrSRNpX2IIF9N
        QDb3Wj+sk1oLPL0caWlWBmlrPC47g0M=
X-Google-Smtp-Source: AA6agR5y+GzLXYz2lPDJFhwsgCc3rG3/hMYgByAeZ/zWeMP9RmSlVBoq80qWQM8lka5XPe3td+xiUg==
X-Received: by 2002:a9d:6484:0:b0:60b:eb0b:4054 with SMTP id g4-20020a9d6484000000b0060beb0b4054mr8162695otl.159.1660005957621;
        Mon, 08 Aug 2022 17:45:57 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id w204-20020acaadd5000000b00342fc99c5cbsm730836oie.54.2022.08.08.17.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 17:45:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/7] mergetools: vimdiff: fix single window layouts
Date:   Mon,  8 Aug 2022 19:45:47 -0500
Message-Id: <20220809004549.123020-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809004549.123020-1-felipe.contreras@gmail.com>
References: <20220809004549.123020-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Layouts with a single window other than "MERGED" do not work (e.g.
"LOCAL" or "MERGED+LOCAL").

This is because as the documentation of bufdo says:

    The last buffer (or where an error occurred) becomes the current
    buffer.

And we do always do bufdo the end.

Additionally, we do it only once, when it should be per tab.

There's no need to enable the diff mode differently depending on the
layout: we can enable it the same way for all cases by doing
`bufdo diffthis` before doing anything else.

If we do this on every tab, then all the windows in the tab will have
diff mode enabled against all buffers, which is what we want, and in
single window tabs, the desired buffer will remain.

This way a multi-window layout like "MERGED,REMOTE" behaves the same way
as "MERGED" after closing the "REMOTE" window. A consistent behavior is
clearly what most users would want.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 49 ++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 2ecac41231..64a8fe170d 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -68,7 +68,7 @@ gen_cmd_aux () {
 
 	if test -z "$CMD"
 	then
-		CMD="echo" # vim "nop" operator
+		CMD="silent execute 'bufdo diffthis'"
 	fi
 
 	start=0
@@ -221,7 +221,7 @@ gen_cmd_aux () {
 
 	if ! test -z "$index_new_tab"
 	then
-		before="-tabnew"
+		before="-tabnew | silent execute 'bufdo diffthis'"
 		after="tabnext"
 		index=$index_new_tab
 		terminate="true"
@@ -336,17 +336,6 @@ gen_cmd () {
 	CMD=$(gen_cmd_aux "$LAYOUT")
 
 
-	# Adjust the just obtained script depending on whether more than one
-	# windows are visible or not
-
-	if echo "$LAYOUT" | grep ",\|/" >/dev/null
-	then
-		CMD="$CMD | tabdo windo diffthis"
-	else
-		CMD="$CMD | silent bufdo diffthis"
-	fi
-
-
 	# Add an extra "-c" option to move to the first tab (notice that we
 	# can't simply append the command to the previous "-c" string as
 	# explained here: https://github.com/vim/vim/issues/9076
@@ -555,22 +544,22 @@ run_unit_tests () {
 	TEST_CASE_15="  ((  (LOCAL , BASE , REMOTE) / MERGED))   +(BASE)   , LOCAL+ BASE , REMOTE+ (((LOCAL / BASE / REMOTE)) ,    MERGED   )  "
 	TEST_CASE_16="LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL / BASE / REMOTE),MERGED"
 
-	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_03="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | echo | 4b | silent bufdo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_05="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_06="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_07="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | 1b | wincmd l | 3b\" -c \"tabfirst\""
+	EXPECTED_CMD_03="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_05="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b\" -c \"tabfirst\""
+	EXPECTED_CMD_06="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_07="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b\" -c \"tabfirst\""
+	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b\" -c \"tabfirst\""
+	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | 2b | wincmd l | 1b\" -c \"tabfirst\""
+	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
+	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | -tabnew | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | silent execute 'bufdo diffthis' | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b\" -c \"tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
@@ -635,7 +624,7 @@ run_unit_tests () {
 	cat >expect <<-\EOF
 	-f
 	-c
-	set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
+	set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b
 	-c
 	tabfirst
 	lo cal
-- 
2.37.1

