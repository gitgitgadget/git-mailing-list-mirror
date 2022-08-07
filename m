Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC66CC25B08
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiHGCuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHGCtv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:49:51 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DCBE02A
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:49:50 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id g187so5046236oia.2
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JJXaThtHVnFFjjN9KTrqfO6NhjG7AfwwJ9hadS8DhjM=;
        b=UMixBWfVbMNrHXZPkyqxmNPZHIywmpmTdtHiFywQIdm8mbcVfDhDTe1tdOiZpvrVQf
         VN/y10U7qS/JIhBNO0xUBtuH6N0LjHGTFfemiiKMyu1eeKxS/nECVCrhqOLmM/FEVIZc
         vFq5FZreLOSvVk3Af/dGop/5HDtcUG5zGnleK/vIX8S2pTu6+3TiZLTikko55xlPrLT3
         VoJREEpVk0zO59LJ0Lrvet7+48xXBbWJOY44LHw7nLgifKyGV8jP124F5H0gCwQekg6c
         KeJgg5Jg/QWEPVjPWILpSADphU2fuIXKt4mAkY5tkaaGYtglLxWCAepNfeIPPzi9/Ddl
         M+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JJXaThtHVnFFjjN9KTrqfO6NhjG7AfwwJ9hadS8DhjM=;
        b=GO+0GJmHebm6IIRAUcT2RVh/foEDJ7z2GR7pbrwNbjaFNMEDi91bzeNQg6m58LwvEY
         yUppqa0R5jYbgWCg7gduYLJGyQlzAa+kR8f+qgEmB7sZwJ3Yun55FRqUrGpZ4YHlPG6X
         GLc1Yf2DoYZOxbjXHOertXucX8i7aqBem5/jcUSfdbg9UW9pvRUochSBeANU6JSjxR61
         BSFc1sILkq2TEm6EFIg3Kuc5BbMhXDHVnLH9UJTAOus0KiD3B9TrlyJdmgxzcE9FBIDY
         UThyih0nsep5ZXLjFYCmqhsgNwVk8iKt/Sv6fSYv0Vj4xxgtotC6YdlMtZx36PrBM9gL
         GdOw==
X-Gm-Message-State: ACgBeo0IWrJywK3/ZBp8q2/MIA6EvYibJ8d+C/7bfAzUDE2BnfFYXQv1
        6sLZNJPpu2BBs5MKmaUNyr097w2723Y=
X-Google-Smtp-Source: AA6agR6IfWKkg9Biwyfge5rrF3ukP8XZSmgjANPyRN98tgtrd8C3/L7iTpCc/RmWZDWxpohgPOw9cg==
X-Received: by 2002:a05:6808:16ab:b0:331:464c:61b4 with SMTP id bb43-20020a05680816ab00b00331464c61b4mr9070037oib.187.1659840589863;
        Sat, 06 Aug 2022 19:49:49 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i19-20020a056871029300b00101bd4914f9sm1557534oae.43.2022.08.06.19.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:49:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/9] mergetools: vimdiff: silence annoying messages
Date:   Sat,  6 Aug 2022 21:49:37 -0500
Message-Id: <20220807024941.222018-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.378.g3f95da6bac
In-Reply-To: <20220807024941.222018-1-felipe.contreras@gmail.com>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the single window mode we are greeted with the following
warning:

  "./content_LOCAL_8975" 6L, 28B
  "./content_BASE_8975" 6 lines, 29 bytes
  "./content_REMOTE_8975" 6 lines, 29 bytes
  "content" 16 lines, 115 bytes
  Press ENTER or type command to continue

every time.

Silence that.

Suggested-by: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 20c61b040b..fbca6f5c96 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -325,7 +325,7 @@ gen_cmd () {
 	if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
 	then
 		buf=$(get_buf "$LAYOUT")
-		FINAL_CMD="-c \"echo | set hidden | ${buf}b | bufdo diffthis\" -c \"tabfirst\""
+		FINAL_CMD="-c \"echo | set hidden | ${buf}b | silent bufdo diffthis\" -c \"tabfirst\""
 		return
 	fi
 
@@ -560,7 +560,7 @@ run_unit_tests () {
 	EXPECTED_CMD_01="-c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_02="-c \"echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_03="-c \"echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"echo | set hidden | 4b | bufdo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"echo | set hidden | 4b | silent bufdo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_05="-c \"echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_06="-c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_07="-c \"echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-- 
2.37.1.378.g3f95da6bac

