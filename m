Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC183C4332E
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883FB65022
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhCFLFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhCFLFB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F27C061760
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:01 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j2so5220989wrx.9
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJHtvRo9KM/GJVGhENwXB5Vax2+bOQk0xZ5WwaywLn8=;
        b=ABTo0UYkWTWTShR6/IuqcvQvkUwcVQX288nCbNd31Cz1cl7kS8BvomjtgcsBX9hPyn
         eqUupdBOtFYLPtA8tsFgvXJP15kasHd8WJ4P4Y1stD3EKi//fFPBGM2buC6vEDfzoJlN
         C4SQ7BTzPjCrEVxOAqMD7aR2Z7JMy45IAC+fhfSnFPpGzbr28gT79RlTNxbo810tx3W4
         MqHKjqzKPBBGMDeCiI1u/gLqfU5P1abDQs8cRTjQ3obxJPErTOCWyESnZHR1bwwuPAfN
         bEN+xjmSlBUPmVoSowOxKPup5nwAmEF2u3OaxcrXSUpySYrxt2S+ZltawtadGNG7kg/l
         MisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJHtvRo9KM/GJVGhENwXB5Vax2+bOQk0xZ5WwaywLn8=;
        b=Fi9tP8lKzaRLvOQ9G3G+SUxem+RKg7TU5syMdIhTwxDEB4KxMH7bhcTx6frVhNnbPz
         6T0anu0owM+7x9ucgq6g6FQCScJXSo3gHg0k6Hscr8b4s+CWESrzwql2NWQhSZRnlZo7
         rn/4aqCaBbX72Wr0RpZPq6/AOuIfqBzt6NcySR6poKljcFTSEGwyRarFBJCqma1g8uFP
         KzOKweYV0f/qFY+3a4MpGsFJUZEjJIwSclLGGHzfW/xrhk8dTZ1MXrxi9aqIz5L8IVdC
         5YfGxuBeaqvjLxxr22ELXAl7//rykHuq10hrs04yuL+/+HTj5veBVANjfKmBMluPBehn
         AuEA==
X-Gm-Message-State: AOAM530pgfdM498K6K/OYNahSxGxzKy9pHHlN0N21w8kquGJ0obVQ79m
        c6phhEm2eazKaIZvb513bUzf/ojoEEI5QA==
X-Google-Smtp-Source: ABdhPJw+5QM1sSz0NnAnoEUIp3M3igQmyXXJhX3VUwV7BNgOXE1Jsq8xVasfr8Sbm9CeXi+S7+PuQw==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr13498232wrx.403.1615028699932;
        Sat, 06 Mar 2021 03:04:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:04:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/22] fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
Date:   Sat,  6 Mar 2021 12:04:27 +0100
Message-Id: <20210306110439.27694-11-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor "if options->msg_type" and other code added in
0282f4dced0 (fsck: offer a function to demote fsck errors to warnings,
2015-06-22) to reduce the scope of the "int msg_type" variable.

This is in preparation for changing its type in a subsequent commit,
only using it in the "!options->msg_type" scope makes that change

This also brings the code in line with the fsck_set_msg_type()
function (also added in 0282f4dced0), which does a similar check for
"!options->msg_type". Another minor benefit is getting rid of the
style violation of not having braces for the body of the "if".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fsck.c b/fsck.c
index 6b72ddaa51d..0988ab65792 100644
--- a/fsck.c
+++ b/fsck.c
@@ -167,19 +167,17 @@ void list_config_fsck_msg_ids(struct string_list *list, const char *prefix)
 static int fsck_msg_type(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
-	int msg_type;
-
 	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
 
-	if (options->msg_type)
-		msg_type = options->msg_type[msg_id];
-	else {
-		msg_type = msg_id_info[msg_id].msg_type;
+	if (!options->msg_type) {
+		int msg_type = msg_id_info[msg_id].msg_type;
+
 		if (options->strict && msg_type == FSCK_WARN)
 			msg_type = FSCK_ERROR;
+		return msg_type;
 	}
 
-	return msg_type;
+	return options->msg_type[msg_id];
 }
 
 static int parse_msg_type(const char *str)
-- 
2.31.0.rc0.126.g04f22c5b82

