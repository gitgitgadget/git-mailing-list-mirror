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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2D0C43603
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB2A64F73
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhCQSVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhCQSVV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2ACC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo1872027wmq.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Yn7ZE5LnR/l8/KqJi2HPu78wVassmxwUo2jdgWO2sc=;
        b=OEuPQWo5BKSlfypX/IrTAtobo3erkSyUQqS8uORLASbF/s3h70ev6uailGO1SDI6dT
         SfgoLlOJASZm00qdso9bb70FmaMiSMVMJgQEKhnJdj548C8+pv6gNaA7p+YcRQkc9XFN
         z0znsnRR6CdGnZh98x/v12+NKQDv7K7EjrxOPB2Wr9+dgg1mRIIlDMDj4WnyC9zPg+7G
         iSvxbP2Z5GN9/YNGYgC/aur4SA5atCwToxeNYjczEAzV+TGWWUQu4PtYdVwOqzX49d6L
         o00YlIIdm9mZMRnNJiAbpSWFZN8Pi3VtszsdyuSevnA/kjhnAluy2ca05E0oHP7q258p
         zGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Yn7ZE5LnR/l8/KqJi2HPu78wVassmxwUo2jdgWO2sc=;
        b=FZ4Et9l/T7CnpR/Z49LURm0NqMO9xy665qyTdf7iKDKLIhIxfUaVeaWzX9ZkT6Vfsx
         w0IqTvG3qnOl8B5+A5peq57AYORPvu56skJzzmxDDEt7PXfjKY2v2bUZxT/ce1UOanpu
         3yLO2zvvJJhsP5GCqowX7PB+KL2EXdp1weXSLc86J0NqVHOM/DDvpvG6gvZuA0EWAdUA
         qSsBeWj5LDjsH5HaeK6WqVB8dc9Le4VDEVS9bhdTiBXwo3Wg2BYbu3IB/BMyPQw1xMqL
         sIqiKxqCNA4m59kJWPZmDMpFICNqaEcm5x0KYlxC6U97sscZjl3dr5/tcrgr7Iwn11MB
         dErQ==
X-Gm-Message-State: AOAM533MHttfP00yTijpTGHBSJx1w8a6FXNsJw/7bbUdnjoN+juSbn8d
        vmnJdDMh+DGL36/olftG553nrqPiCbFb1A==
X-Google-Smtp-Source: ABdhPJyojEnxlzuWeFllvawNEL+QWtgCIXhKPATMKWnAJnylwmFjuCMlJ5/orJ3D9zkVEoRsnn5sGA==
X-Received: by 2002:a05:600c:4151:: with SMTP id h17mr142584wmm.68.1616005280139;
        Wed, 17 Mar 2021 11:21:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 12/19] fsck.c: give "FOREACH_MSG_ID" a more specific name
Date:   Wed, 17 Mar 2021 19:20:47 +0100
Message-Id: <20210317182054.5986-13-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
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
index e657636a6f..b64526ea35 100644
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
2.31.0.260.g719c683c1d

