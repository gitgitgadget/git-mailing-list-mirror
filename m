Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B501F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdB0S7S (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:59:18 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35353 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdB0S7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:59:16 -0500
Received: by mail-wr0-f194.google.com with SMTP id q39so11517718wrb.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f41uPh8ou86m12p/8eZBJon39Hg+dae5uIvZ2eCt+l4=;
        b=Dgdo5O9yR+5UVe3FSYFBLXmXhiFOz6QoN9FhLMNe4iVNp18zrATDrZ7S7vbzee1LBG
         YVGSvBpNAa5nxX0bhPY33r+l52+hnAv6Wle8pbf2jIaYsaw5YmJ3VH3xv72h+/AjcxE6
         oYmu44nUTDR7stOYfp8Ag3g8gI35nrLcEO0IM9hBaJLmBrwwtU7hG4M6JFcEfP/yCF2l
         IbCJpEDlWSE2hi0UHJHWX1Hhb/IycpKSH9EKn7CeNIy6jDCBsHMP1S2MrNmDnSFbfGAV
         5bgjEUbnHHWChi0ecQd6LC4bnylvE69wuK1TZyKpWkW0UGq0lAwLxLXFUGhx84HfdU95
         JODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f41uPh8ou86m12p/8eZBJon39Hg+dae5uIvZ2eCt+l4=;
        b=eGFFLSpxBCmnG5/WvK/5pVG0AApGo1n04jzD6P7klCoH31R5M4lBd5vG77Dxyhj9Fx
         SoKZEa9SDkh95v5JpLl0aVUNOzGWmLYntetl9p97kuYoQure0o1mYs1xXw+879rm2X5w
         NJGzc4jzl8IvR3o75sxP+UMv98rKemPv7RAJkXJPEKa/URIsvXbPxJLJg5MgbuQd51Yr
         vuT5uBN0qUP5kC4LJqqHkOyKyj2tDR/+FZ2ThwfcNhX1jqRHGyiRujv/kaxDfXNjG06o
         Gsin42elPnqGKu3mk8/G8loxzen9x43d7YxfcIWCqBVRTzmTyM2c+BziOxqAJS0e3wyE
         mwyQ==
X-Gm-Message-State: AMke39lRueVI9wBWtC0JuVXDfSwJGmGGnfSnNJGmZBnFpmZuCygv3xPEGTYbmmRLUBrb2Q==
X-Received: by 10.223.129.183 with SMTP id 52mr16541444wra.43.1488218457581;
        Mon, 27 Feb 2017 10:00:57 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:56 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 15/22] read-cache: touch shared index files when used
Date:   Mon, 27 Feb 2017 19:00:12 +0100
Message-Id: <20170227180019.18666-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
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
index aeb413a508..5f295af4c6 100644
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
+		warning("Could not freshen shared index '%s'", shared_index);
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
2.12.0.22.g0672473d40

