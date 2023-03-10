Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1382C61DA4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 01:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCJBrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 20:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCJBrn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 20:47:43 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE150F4DA9
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 17:47:42 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-176b48a9a05so4432252fac.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 17:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678412862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I+eCRYxHBTngui5asc/J6IN1Z3D92rQyOdoJPNTGrbc=;
        b=DCIvEdg/Adk1SPvwJVStXiXvt+jnx4GXC2J0yHvs4HsqCkuDCFYdxMTdJXUx+aOShJ
         6ZMDm19iAnEPfy/Yst3xktOkwhkGz0Ba1JKpaVHlIoEYNtR1qa1wMkT8I748A/6O2+DE
         wvIwOI65CXTt+X2O3RlKbqChio/XxQmXS4QQUqubhiLcoNUID863YE1HYrhdVN5ol4Co
         j2HUGSiVWFyWGgtqBxwP3RaWNUP3GmWWOuIK/yrsr2PLe9CXzbyIpPQuyYYJjzgrxrxm
         94yPNPAlKIWpajQv0EwW3SfdiQbLutcxAeCAT+eB+40u3BcFnX+TbTuM0epLSfCSFUjC
         +GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678412862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+eCRYxHBTngui5asc/J6IN1Z3D92rQyOdoJPNTGrbc=;
        b=T3AMjW8meh0LdjPBnzwQV2IR4+BDtDIPnVj8uBhRTwlDq/CzT6RMRew13dZrmL+hr7
         P1WBS1okLazb3JkJujcPVF1XxOgtH3VhoLhi8EK2HjuLTc16SLBQJlhxbcMQyy2MvAzO
         szUt1kj0A7fbpSMsBYYbZgKM4FiQ7A8tdM/JVdKrVWcUSioETPDL6LsrNLBeAm28Y73U
         kfwQcIM1SkvWLsNRoI2K14yn2VYoQ3ppUc/RDyxH9x+M9/Xc0rvxjGC04rQnRaPf7gAR
         X4cHAH9PBZSgjUi4Iq8Q+RuE3KbKAma4OE1q6tGcmvDsRk5OWAY9RtfSve04W/KJPw4b
         3DZw==
X-Gm-Message-State: AO0yUKXn8e6nWySTqAAmRojYZKbAHWXkybTt59nLdxnTnl7sQ0kGB4WX
        D+MHuTnHwMAsD9CAqiDu/jnqTSuB/+4=
X-Google-Smtp-Source: AK7set/F3g8yZRT5g9iDYJgeC9u4qOjZ4GdDxfgovRodPjRnLFGo1YWgfS96kmTlJUZ8yid70IxIVA==
X-Received: by 2002:a05:6870:5389:b0:172:7218:9c01 with SMTP id h9-20020a056870538900b0017272189c01mr203298oan.2.1678412861728;
        Thu, 09 Mar 2023 17:47:41 -0800 (PST)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id ed48-20020a056870b7b000b001762ce27f9asm400899oab.23.2023.03.09.17.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 17:47:41 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] sequencer: change amend advice to an actual advice
Date:   Thu,  9 Mar 2023 19:47:40 -0600
Message-Id: <20230310014740.1076715-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0.rc2.1.gf652911b76.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Show it like a proper advice, and also allow the possibility to turn
that off for experts who don't need this annoying advice.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/advice.txt | 2 ++
 advice.c                        | 1 +
 advice.h                        | 1 +
 sequencer.c                     | 2 +-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index a00d0100a8..f493af466a 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -80,6 +80,8 @@ advice.*::
 		prevent the operation from being performed.
 	sequencerInUse::
 		Advice shown when a sequencer command is already in progress.
+	sequencerToAmend::
+		Advice shown when a sequencer is ready to ammend a commit.
 	implicitIdentity::
 		Advice on how to set your identity configuration when
 		your information is guessed from the system username and
diff --git a/advice.c b/advice.c
index fd18968943..28e7401c68 100644
--- a/advice.c
+++ b/advice.c
@@ -66,6 +66,7 @@ static struct {
 	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict", 1 },
 	[ADVICE_RM_HINTS]				= { "rmHints", 1 },
 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse", 1 },
+	[ADVICE_SEQUENCER_TO_AMEND]			= { "sequencerToAmend", 1 },
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure", 1 },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1 },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning", 1 },
diff --git a/advice.h b/advice.h
index 07e0f76833..933a6614ca 100644
--- a/advice.h
+++ b/advice.h
@@ -41,6 +41,7 @@ struct string_list;
 	ADVICE_RESOLVE_CONFLICT,
 	ADVICE_RM_HINTS,
 	ADVICE_SEQUENCER_IN_USE,
+	ADVICE_SEQUENCER_TO_AMEND,
 	ADVICE_SET_UPSTREAM_FAILURE,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
 	ADVICE_STATUS_HINTS,
diff --git a/sequencer.c b/sequencer.c
index 1c96a75b1e..e5831907f6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3559,7 +3559,7 @@ static int error_with_patch(struct repository *r,
 		if (intend_to_amend())
 			return -1;
 
-		fprintf(stderr,
+		advise_if_enabled(ADVICE_SEQUENCER_TO_AMEND,
 			_("You can amend the commit now, with\n"
 			  "\n"
 			  "  git commit --amend %s\n"
-- 
2.40.0.rc2.1.gf652911b76.dirty

