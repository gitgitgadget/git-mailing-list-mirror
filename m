Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8B7C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiHGCuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiHGCtz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:49:55 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7891EE0B5
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:49:53 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id q184so6925885oif.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VA+bUk13kvQZ233UAZvAu60paObb5ICC3sVSSWmCUxs=;
        b=h8EXIZ1zXyWO2AtiVPcTB9qijsEoVBIYU6mAPb/nDwd8nEIfLmapfpeyIsif/SPR5g
         r6oZFJRywj8GJUDQ7TGDi6vEx9gVPHf+uFFLfQ6EEljpUd8YVw0hvOxRG66HeDrBiADJ
         hH/gagyv6zHCMuaWXMrt2EJqY4/qXYM8+OfCSQjbmwSrHAUTpH4+0EzNT5c9FHwcU/mn
         Iw3m/WclVpU/qUkENq2MN3BDH9gkOLF1wvdz+GzNDi4XIC1DkEojNKJkL77z9/p2Hmai
         KOjt2lBM4Au6pAUI+nJx0P2nuDt5Qnn0HFNTAc4XC1qaA3HeoYYKhV5XJpNh1BpwLr9w
         P3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VA+bUk13kvQZ233UAZvAu60paObb5ICC3sVSSWmCUxs=;
        b=3cttG7Hl+pk7Gf0CGb6+cM5yIrhw0utOYUDCFOHRalVDr2Sof5boTg8snyCXbF9OmR
         VZcVMtuAlOy9FR25kUPZdHEOKXWH8nDs3PPBwclisDGkWQnxixrTkhz28fOuEl+IoDa8
         PsidaM54De7WKD8lIwhHyskjbNyXVVW9ErR7TFwoltwAddzoU4HsWpTO2apIfqrioujW
         YAKShBoLuQIG8xxqcoQcPJlgeDjsjJrl3ACqZcDAFMt94H+cNNH0ruMPfQy5TlmwgIbt
         RTBPKSaW2mgR7g9y+pgstA4s9EGmr4bwmpDCTsVhiXOv1GYWLUNPRFe6wvQv2gQl7LN4
         6c9g==
X-Gm-Message-State: ACgBeo348wYzayOoicVLiHp0zVmugqk3FcPdKOmXZIJzB42L/Uc9qzuL
        ULpx8BCueoKwnrvii1kcuyt1g0vHYms=
X-Google-Smtp-Source: AA6agR4UktStzJsCZgHwTQ026QtpMgpeco4a2dgGYO7W0Q5Jw9herGdMeIFGxDwFenVQhQ14X1vRRQ==
X-Received: by 2002:a05:6808:2211:b0:33a:ba7b:3da4 with SMTP id bd17-20020a056808221100b0033aba7b3da4mr8463689oib.137.1659840592643;
        Sat, 06 Aug 2022 19:49:52 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k102-20020a9d19ef000000b00636deb2bfe6sm49871otk.68.2022.08.06.19.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:49:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 7/9] mergetools: vimdiff: cleanup cruft
Date:   Sat,  6 Aug 2022 21:49:39 -0500
Message-Id: <20220807024941.222018-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.378.g3f95da6bac
In-Reply-To: <20220807024941.222018-1-felipe.contreras@gmail.com>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These unnecessary commands come from when the single window mode was
calling gen_cmd_aux().

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 68e399768c..cdef1dcae3 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -325,7 +325,7 @@ gen_cmd () {
 	if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
 	then
 		buf=$(get_buf "$LAYOUT")
-		FINAL_CMD="-c \"echo | set hidden diffopt-=hiddenoff | ${buf}b | silent bufdo diffthis\" -c \"tabfirst\""
+		FINAL_CMD="-c \"set hidden diffopt-=hiddenoff | ${buf}b | silent bufdo diffthis\""
 		return
 	fi
 
@@ -560,7 +560,7 @@ run_unit_tests () {
 	EXPECTED_CMD_01="-c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_02="-c \"echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_03="-c \"echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"echo | set hidden diffopt-=hiddenoff | 4b | silent bufdo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | 4b | silent bufdo diffthis\""
 	EXPECTED_CMD_05="-c \"echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_06="-c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_07="-c \"echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-- 
2.37.1.378.g3f95da6bac

