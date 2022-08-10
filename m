Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97C2C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiHJPqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiHJPqc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:46:32 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E989D6B166
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:30 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so10892033otk.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lH/btJU9O5mJV54EpzR0UAG1AVpxRHSJPNS2CqMEN9k=;
        b=PYQrl+3iAMiNgkjjMklo71PirN/mZmu9r30s83XzeS7vOsoV/7bqn/Y8SR7MbaDIfB
         JDijxO6gyMWSgb5WjCiyNc6bQyTQo7hxkpKjovMAu5NF6e/b7UgnRdpcTjOAEpAW0WjH
         03r0BxA9QZXq/O8tdF0Wt5dR6cMqcnTWcq0C3TdjQcYtenLZdJs97I9YnHrMEpJkC/Ym
         6KDVyJrSSmqOr/uIwdfn8Pz4m/GXLlMTXmwqqAqOPYg1kLLyy3ENNo1d7cM7leOPDeA1
         iUuu0HDp7JL310XT2WTblayw2Ivogjb0F/7W65tl6uV2mIQZdVmHfcR/x72+xv7IPXub
         eRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lH/btJU9O5mJV54EpzR0UAG1AVpxRHSJPNS2CqMEN9k=;
        b=Ewn+HH4AbTNCQ4nlhXfdlum+i2y/yZ3wPQqot/aUgbzxVfoqUFd+5TbCThpKUnwSWN
         sGWw3XFZ22X/y3TLO4uxtHq86+a+CB7CDCx1DcMHz1l7R9jqO/slVvc387RQybuNsZ50
         VHxamgRrDhNnjN57vwzr6aDMlmL/tDFZ43ftLwjcPRESfrvDYegFyjhu7MwUivdSAZb1
         6KIQhd5gmlhjTFl6S3rVTcEwMrTZi7aDS32yRpaOCfOQx2ZC4YuRPLLit6FZayQtTKsZ
         JSuLTbTb3ZDGWdGkzGMZ8l6Z4ql2zbWUwe0YR7CovSNBPluDPDpBg1WOQhx7JuL7HfN+
         6+Cg==
X-Gm-Message-State: ACgBeo3nA0psJrKJlZSHAYvE4i29R3m0EK7Hl7cf+1eBBWuitDgFN0Aa
        GfGNQaMaeS5DZrAuW9rHu/PbMGn882Y=
X-Google-Smtp-Source: AA6agR77be9Zms0287O5Any6Cz9u9Nzm/8LREcEo/HGHX1PtSggdo9DWZNPWsH7NOO+aQ/arSPCu1Q==
X-Received: by 2002:a05:6830:8d:b0:637:1e6c:8975 with SMTP id a13-20020a056830008d00b006371e6c8975mr846633oto.135.1660146389708;
        Wed, 10 Aug 2022 08:46:29 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id a10-20020aca1a0a000000b003430d6696e8sm688839oia.8.2022.08.10.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:46:29 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 6/7] mergetools: vimdiff: fix single window layouts
Date:   Wed, 10 Aug 2022 10:46:17 -0500
Message-Id: <20220810154618.307275-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810154618.307275-1-felipe.contreras@gmail.com>
References: <20220810154618.307275-1-felipe.contreras@gmail.com>
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

Fix this by doing it once per tab right after it's created and before
any buffer is switched.

Cc: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 8334871417..e27734b6e7 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -325,21 +325,17 @@ gen_cmd () {
 			CMD="$CMD | tabnew"
 		fi
 
+		# If this is a single window diff with all the buffers
+		if ! echo "$tab" | grep ",\|/" >/dev/null
+		then
+			CMD="$CMD | silent execute 'bufdo diffthis'"
+		fi
+
 		CMD=$(gen_cmd_aux "$tab" "$CMD")
 	done
 	IFS=$oldIFS
 
-
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
+	CMD="$CMD | tabdo windo diffthis"
 
 	# Add an extra "-c" option to move to the first tab (notice that we
 	# can't simply append the command to the previous "-c" string as
@@ -552,7 +548,7 @@ run_unit_tests () {
 	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_03="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | echo | 4b | silent bufdo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | echo | silent execute 'bufdo diffthis' | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_05="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_06="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_07="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-- 
2.37.1

