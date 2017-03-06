Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA8E1FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbdCFJvz (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:51:55 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34961 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753742AbdCFJvh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:37 -0500
Received: by mail-wr0-f195.google.com with SMTP id u108so17017792wrb.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M2Z6DDSBKadr7IfY0bcNdUw4nb0QGPRrWb5/qvwSRv4=;
        b=N7jlEAba9hNCyS/XSOFxRO/V+mDHrztFzwBQpQKE4qUptpbHk9JET+oSfiy2uIW22L
         mn/w9q70SlpT46rsRIKZkJvbdwMFQeyi4LbvyvgQDtWVrGLLAdvXOxpWF47COE5UVHV3
         fLVaBGrUmm2Wi1vgG5diTniGbPINYkHd65iZWSuTV29NYYSuhcN6sOVHqgftR0CZhGXP
         R7YA0bzFiDLzuOwrjsdYsOuynBZXHtObDq+3a0EYpCttvvoEnHTYCk0FLJjzEK4pKV87
         mvjp8gJz7UjoHOAa4X+L3mmdIGRYJmMmAvaxUMp4UIT/d4WIlBzrZeG62I70Ky+hNOSl
         8jhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M2Z6DDSBKadr7IfY0bcNdUw4nb0QGPRrWb5/qvwSRv4=;
        b=WDs+T61UUIioOR7+u0Po7dxJOxOJpVkKDf6jIHLuMac+QTYMmP3ltJNb86TNu+zAom
         WhS9uQNrIibD70Ybw4PonS3uIBi8bgHcg74n+yQ+HF3OmbFVRy8bbpG+hJ9fB8okIyFE
         a84NLEfvFCwAryZ9kpTE6mIqC5ND8cLM7vY9thNvwbgvJ69/TiwcZlCo2VU9VvQqOkbQ
         j1/FjwKClb92uQ+wuzwRFZrFq23I8IJekZjRwyWfk1cdSdC4YDfY18tnOobGkrkUPvR6
         VfiPLJe7zHh0lBiWb7XPtp6Tempg1n9fIrc8C4vGAydqc0+/hrCoqs7dO4YcrhMaZJcI
         eWKA==
X-Gm-Message-State: AMke39nc2CQLMuwsrMCuyER8dPnw9OmxmV2rUw40Ploednn0kRurmJ9RRLoykoh04tnHZw==
X-Received: by 10.223.154.50 with SMTP id z47mr13283889wrb.76.1488793358474;
        Mon, 06 Mar 2017 01:42:38 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:37 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 15/22] read-cache: touch shared index files when used
Date:   Mon,  6 Mar 2017 10:41:56 +0100
Message-Id: <20170306094203.28250-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a split-index file is created, let's update the mtime of the
shared index file that the split-index file is referencing.

In a following commit we will make shared index file expire
depending on their mtime, so updating the mtime makes sure that
the shared index file will not be deleted soon.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index aeb413a508..13375fa0ff 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1674,6 +1674,19 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	die("index file corrupt");
 }
 
+/*
+ * Signal that the shared index is used by updating its mtime.
+ *
+ * This way, shared index can be removed if they have not been used
+ * for some time.
+ */
+static void freshen_shared_index(char *base_sha1_hex, int warn)
+{
+	const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
+	if (!check_and_freshen_file(shared_index, 1) && warn)
+		warning("could not freshen shared index '%s'", shared_index);
+}
+
 int read_index_from(struct index_state *istate, const char *path)
 {
 	struct split_index *split_index;
@@ -2245,6 +2258,7 @@ static int too_many_not_shared_entries(struct index_state *istate)
 int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		       unsigned flags)
 {
+	int new_shared_index, ret;
 	struct split_index *si = istate->split_index;
 
 	if (!si || alternate_index_output ||
@@ -2261,13 +2275,22 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	}
 	if (too_many_not_shared_entries(istate))
 		istate->cache_changed |= SPLIT_INDEX_ORDERED;
-	if (istate->cache_changed & SPLIT_INDEX_ORDERED) {
-		int ret = write_shared_index(istate, lock, flags);
+
+	new_shared_index = istate->cache_changed & SPLIT_INDEX_ORDERED;
+
+	if (new_shared_index) {
+		ret = write_shared_index(istate, lock, flags);
 		if (ret)
 			return ret;
 	}
 
-	return write_split_index(istate, lock, flags);
+	ret = write_split_index(istate, lock, flags);
+
+	/* Freshen the shared index only if the split-index was written */
+	if (!ret && !new_shared_index)
+		freshen_shared_index(sha1_to_hex(si->base_sha1), 1);
+
+	return ret;
 }
 
 /*
-- 
2.12.0.206.g74921e51d6.dirty

