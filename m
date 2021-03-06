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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD81C4321A
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21116501A
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCFLFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhCFLFG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F2C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:05 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i9so3172612wml.0
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1HVcPYZkN5BFw8pDVq3UbnTiYElK3xhIOBHucQOWmE=;
        b=JtEELOIr9gRLI/apT6uQn/2z4YjJze9yAhtmLNnIarvRVjettAUV4awCg/B3R5pzHc
         urTQbBHwoc1ifpvKGB4oYj97U2expjLDkm5xinFGOdLf820F0NKNaIcC20N8OE7HtX8v
         NN4kbj1yri8DlCZn4bShtculnA5//giqJ0Tx0K/uqVidVug5tD2yO0Cpo2UmpKKKcPOn
         COX1vhOZMTVUhqpdjdnvd/KkqpgLrOApA3N6S7SKqr6vB0z/GCPczCI0rbpj3UBJTe7j
         PkYQoLEH+6olcKQgtWMqn+W88TsT0Da/P3EEdpsXp6cZcvXTkV6Q5EtIDNV9GsgZhTGs
         6ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1HVcPYZkN5BFw8pDVq3UbnTiYElK3xhIOBHucQOWmE=;
        b=FBvLOeLBRt6M0pwUwmvA9n3Zh9S0gKRwBjfZv0p/0n8Uc8II0gZAxeOcgUWgd6inK+
         xkO22q2SWpgVEordGXB3dPuul5U5AuX7j9KjqoOegmWGu0StJ/WmbOTpxFzLIdmQKmwj
         CeviG2Xyfepz5759GnzE6BYkkKiZKSkzNiSttMkkU5fEqr1YZsovDqXhuC7ddlm2EwWp
         X33ylLqAQ8LyHW3fiPbI4XW8e5KToQAlyHniwY+aDA/5YQiwaBq2ROcRaZpEIPGc/Tfq
         768USNVg2iOKd8/0bcqjzLkip91ZVSlra0vhlYo4ICHqlAoRjWRVU5jnuPQg2+h0fyph
         I4TQ==
X-Gm-Message-State: AOAM531UtiODDp04jVJaX/BTovFSeIn3gtCLTAUqnd7BxB5KYCvZDC3s
        DxcHGJwGoSEpWttoW/s+P4d9EjU5DJ8DXg==
X-Google-Smtp-Source: ABdhPJxmp9tiJCrNHzz+ULoDZUFfe3aPttbS/taE7bQw4XAnd8Ne5yOZJ35XW8X9/VWwRXvr5ZJzrA==
X-Received: by 2002:a1c:4986:: with SMTP id w128mr13042236wma.37.1615028704350;
        Sat, 06 Mar 2021 03:05:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:05:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 15/22] fsck.c: give "FOREACH_MSG_ID" a more specific name
Date:   Sat,  6 Mar 2021 12:04:32 +0100
Message-Id: <20210306110439.27694-16-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
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
index f4c924ed044..6fbc56e9faa 100644
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
2.31.0.rc0.126.g04f22c5b82

