Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF5C433EA
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4146196C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhC1NQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhC1NQG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC14CC061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so10184050wrd.1
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NePBdE+cKIwFwv/LanoIn7GgCdwtfSZN3QjEIwCRy/w=;
        b=QPa68YVDnLfYqt/2Oh3ceGlUYVBTU8ehzBe0cf5Cq552R3A53WuAePGlY2XIlc4BED
         GK4wY0zSQsUFuxAPwdBkIE8xbUtOircSlpF0COwV+9TeCAVOhSRxhVIdNqN8ZIbFiUuS
         J840E1joz1DpS1Fj+xNtm9j1AB2kQBURChbIYj0p5q4zOYGJ4uObD1X+Vkw6qj+wdv3z
         bRwKb7M5cRijRqOpCok7NxokKcV38sHMf1kK+2CB9V50/7vpLmebJ8irf3bO2qdUBpeZ
         OG/cAjX8ArHBdag01EuA4cekCJFjqNinBUlVdoE2/5HU7NZ43deji3fXATdHyEpw906z
         Yb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NePBdE+cKIwFwv/LanoIn7GgCdwtfSZN3QjEIwCRy/w=;
        b=A0wGjVxlqUk6Q4qVRF6LOHmUzoNzqt5KYT/mp9LTU8RS8YmUhURWNP6El0UElIl0SW
         9jc8WTJNb74he0Yg0q/CRiKgtqCsJjrETHxkpflmf24Hyk0pLnyEAF3T6H9VUpkh7bWj
         s7BaBIZrDFsWEDE1KiD991dHUi3yjDwdnWZVf9ZvDKoFkduM5zWglGKSMzBDEYrgJatb
         bWe/h3Ie6Xf1m3p1F9Q36K27gK3ADYJP3yjVEOiLgceboENBXrORAEjDkj3EBaE9jZXT
         ZyAZ68ocgvIyoKMQNcEkVSoi4a0aeF2Z8xGSO9xrIFYBSw2H/DGdQLpDpk3LHWbMnGSH
         gjKg==
X-Gm-Message-State: AOAM531EeGHWEQmiq5iRrspoGYN+s9nfTPdmUzW2Nm3m8boV51ewbDtZ
        OQppR57YPhVT+jZ3MhZvSGa9Oi6DyZ5E6A==
X-Google-Smtp-Source: ABdhPJzxmk878jVg7Tad7DQOeVFgtpRRlZjRZhXXxKd0DWsJwZbAbfAmZRnpe4/zsDb3gNgwp1Usng==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18mr23865698wru.366.1616937364246;
        Sun, 28 Mar 2021 06:16:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 12/19] fsck.c: give "FOREACH_MSG_ID" a more specific name
Date:   Sun, 28 Mar 2021 15:15:44 +0200
Message-Id: <patch-12.20-96995244806-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
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
index 1b12e824ef6..31c9088e3f7 100644
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
2.31.1.445.g087790d4945

