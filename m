Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B449DC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAC964E4A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhBQTp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbhBQTol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:44:41 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD78EC061797
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id i23so18087847ejg.10
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0d1ZxTeFD9C5da4FH4CjB+U6np2r6VvDvX58IOSB6Y=;
        b=FtwJXa1EG3CBMgXkz/0qoTWY2+oa7b6XRhjfdCnz21hK8g41Naox1++pez1VET8qWG
         NQpc1UScqrHNllKzxYI4iqX3jXdK3L6UJXZXKYbr6khPa4/INXQocGXpeNXSJHfMJ+NJ
         F6vaDo8FGzaQCpEmyzSm5RjUHWZkX8yK/px8zyUbCvNz9JR90QZSwuu6+t2tj11Bc0g3
         v5Xc9Um9zhglRt88AgeGIAhqV45QIdv1dsYRpbEKTx1JQZMZjwfoVsRt8ToYNYFVx01M
         0EY5ff5eABgVWmoCcLOT5aSzMRwwj4u1M4O9bqQ7g9sgMg1V2g9C1WSkcJ0WFcDJIuil
         m3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0d1ZxTeFD9C5da4FH4CjB+U6np2r6VvDvX58IOSB6Y=;
        b=gFFP9w/5TfmsoCdMnMpK9IRoog5gqFYvU/EOpEfyrpQszvJy7ezdQUScHuZzA5ey4m
         ENghfOZdDchupE8fZK7H8XVfuucIarth7YGtyCjNmV49nAwcTgSbNRKWs+nHNqyS5y0a
         82b9XAQv031etfbXVwEsr+6653oDdBJubQfbQNNMG3hz9+9/cWTurdpt1sbMlXYe+T0o
         SdtDjtKx0V5GuyrxK2M9mwejEldTot0hdQSf2umJQCnjn492JR5LKrYUhL0InmS95Hh3
         e5XiKJl6DI3XTBe4u4fvWFZH9UXmSZOTEueacUxv58TFJNuInfOWFiCyQUosh99gz6Sy
         ecdQ==
X-Gm-Message-State: AOAM531Z/scAbgsfNdeFJFdMRnF6LbH9IH+afUXGO2yfdHtiFPxUd8wU
        fGEdkcFMIVw0XsUbsrJWbb33YyI1RqYpGA==
X-Google-Smtp-Source: ABdhPJyERsWNtRaKjfy7RsLiYyX+N1vD0q63CSs9MQEbzL8QSwD+nz/oRt2q7SrVIgjm/zKt9qIhnw==
X-Received: by 2002:a17:906:e0ca:: with SMTP id gl10mr504496ejb.233.1613590990393;
        Wed, 17 Feb 2021 11:43:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/14] fsck.c: give "FOREACH_MSG_ID" a more specific name
Date:   Wed, 17 Feb 2021 20:42:41 +0100
Message-Id: <20210217194246.25342-10-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the FOREACH_MSG_ID macro to FOREACH_FSCK_MSG_ID in preparation
for moving it over to fsck.h. It's good convention to name macros
in *.h files in such a way as to clearly not clash with any other
names in other files.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fsck.c b/fsck.c
index 88884e91c89..1730acd698d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -22,7 +22,7 @@
 static struct oidset gitmodules_found = OIDSET_INIT;
 static struct oidset gitmodules_done = OIDSET_INIT;
 
-#define FOREACH_MSG_ID(FUNC) \
+#define FOREACH_FSCK_MSG_ID(FUNC) \
 	/* fatal errors */ \
 	FUNC(NUL_IN_HEADER, FATAL) \
 	FUNC(UNTERMINATED_HEADER, FATAL) \
@@ -83,7 +83,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,
 enum fsck_msg_id {
-	FOREACH_MSG_ID(MSG_ID)
+	FOREACH_FSCK_MSG_ID(MSG_ID)
 	FSCK_MSG_MAX
 };
 #undef MSG_ID
@@ -96,7 +96,7 @@ static struct {
 	const char *camelcased;
 	enum fsck_msg_type msg_type;
 } msg_id_info[FSCK_MSG_MAX + 1] = {
-	FOREACH_MSG_ID(MSG_ID)
+	FOREACH_FSCK_MSG_ID(MSG_ID)
 	{ NULL, NULL, NULL, -1 }
 };
 #undef MSG_ID
-- 
2.30.0.284.gd98b1dd5eaa7

