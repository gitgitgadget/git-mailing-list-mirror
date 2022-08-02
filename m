Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10DAC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 21:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiHBVll (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiHBVlj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 17:41:39 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3913F8B
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 14:41:38 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id p132so17973584oif.9
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 14:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yLh5wycFW2229a754eWiyLX+FUa/e4cpDSnEqRG3XKM=;
        b=COAmRcbAlcgaNuCDVONoiDZiYcSe6+80EFeuWh4uQm7IGh5v6AIROVSYnt2wIr7lA2
         /rjLsLEHstcBh70kLOavh0wgxvLC9b0AgL/d+8X63l1M1x6OAPaZfxmCA8Z/TPw0j2zt
         W2PzeEwzPr2vs3vPj4N5aSxqYIYNcXqqDlXepFbDVJ5GHVl2IlznUuOQ6o4HmwRWYevY
         JoRjBl0thqek+st5AkKdv4l3e/gzAvASe0Xcw4cY40ux6Ygjs0Sk5TWVzVnedzn/7gV1
         lYBwFIYSAyIg56jp+hQU5IoJlfe/+abDrpbFZsPCFss7yG60yApR9iuRcj8lxNlOgkSf
         cAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yLh5wycFW2229a754eWiyLX+FUa/e4cpDSnEqRG3XKM=;
        b=p3dmCbAhRTKR9Lpoule9hreiTtWXH7yl41nw+ysd180R5qPRjJX9uLpLYNber5jwBc
         hBvz0vbGpZm6T10kocLRHnuFg3YktoYEG7EGxqsO9p1bBPbagXBpbFq6GdaMSOIIPb+U
         +M5kKqjgDK88KwtgmsGMSRoNPX7FW4Vi40LwQ3n1nuhONZ8xrvYvnIfuKCbQpHVq1UzM
         Lhl/RYHwuzEc24L1atfDkVBQFhKp/Y4pqlYkVgD67LOv3saDjQCTmEvVRDuTBlchqwCi
         +QRLKV4qF/CpTRPdz18rDA9y4Gag2VG34gH2hjj1trOIsH+WK1dN4g94yaVrg2Exfqp/
         jxKw==
X-Gm-Message-State: ACgBeo08fGE6W+7HkYOfEOYmxh0Kp7jF4iDToh7ReWEb0/l4VW1A61YF
        LlH9UHHnqrm/Gk5Z6u5w0vy7isNCAsU=
X-Google-Smtp-Source: AA6agR6O0XHkRAhd+fNHwgEQnSHNc6g4JR9pk5dHLkAS2PpXxa39Z1WQc5Rvaf1BUYZAaCzOnzB6MQ==
X-Received: by 2002:a05:6808:2194:b0:33a:bab5:ddbe with SMTP id be20-20020a056808219400b0033abab5ddbemr577491oib.3.1659476497188;
        Tue, 02 Aug 2022 14:41:37 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:5c95:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id a40-20020a056870d62800b0010e00d6a1c0sm4032052oaq.51.2022.08.02.14.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 14:41:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] mergetools: vimdiff3: make it work as intended
Date:   Tue,  2 Aug 2022 16:41:33 -0500
Message-Id: <20220802214134.681300-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.313.ge269dbcbc5
In-Reply-To: <20220802214134.681300-1-felipe.contreras@gmail.com>
References: <20220802214134.681300-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When vimdiff3 was added in 7c147b77d3 (mergetools: add vimdiff3 mode,
2014-04-20), the description made clear the intention:

It's similar to the default, except that the other windows are hidden.
This ensures that removed/added colors are still visible on the main
merge window, but the other windows not visible.

However, in 0041797449 (vimdiff: new implementation with layout support,
2022-03-30) this was broken by generating a command that never creates
windows, and therefore vim never shows the diff.

In order to show the diff, the windows need to be created first, and
then when they are hidden the diff remains (if hidenoff isn't set).

The layout support implementation broke the whole purpose of vimdiff3,
and simply shows MERGED, which is no different from simply opening the
file with vim.

We could restore the correct behavior by modifying gen_cmd to open all
the windows, and then hide them, but there's no need to do that when the
-d option of vim (vimdiff) does precisely that.

So let's skip the whole gen_cmd function for vimdiff3, and hide the
windows, therefore restoring the previous intended behavior.

Cc: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index f770b8fe24..f4c3bf6d11 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -388,26 +388,36 @@ merge_cmd () {
 	layout=$(git config mergetool.vimdiff.layout)
 
 	case "$1" in
-	*vimdiff)
-		if test -z "$layout"
+	*vimdiff3)
+		if $base_present
 		then
-			# Default layout when none is specified
-			layout="(LOCAL,BASE,REMOTE)/MERGED"
+			CMD='hid | hid | hid'
+		else
+			CMD='hid | hid'
 		fi
+		FINAL_CMD="-d -c '$CMD'"
 		;;
-	*vimdiff1)
-		layout="@LOCAL,REMOTE"
-		;;
-	*vimdiff2)
-		layout="LOCAL,MERGED,REMOTE"
-		;;
-	*vimdiff3)
-		layout="MERGED"
+	*)
+		case "$1" in
+		*vimdiff)
+			if test -z "$layout"
+			then
+				# Default layout when none is specified
+				layout="(LOCAL,BASE,REMOTE)/MERGED"
+			fi
+			;;
+		*vimdiff1)
+			layout="@LOCAL,REMOTE"
+			;;
+		*vimdiff2)
+			layout="LOCAL,MERGED,REMOTE"
+			;;
+		esac
+
+		gen_cmd "$layout"
 		;;
 	esac
 
-	gen_cmd "$layout"
-
 	debug_print ""
 	debug_print "FINAL CMD : $FINAL_CMD"
 	debug_print "FINAL TAR : $FINAL_TARGET"
-- 
2.37.1.313.ge269dbcbc5

