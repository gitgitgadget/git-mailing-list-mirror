Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2FDC433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970E964E57
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhBWXxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhBWXo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 18:44:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E743CC061793
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:12 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c7so117736wru.8
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JN0wvt58itYZYUkNRwdYTTFw6FJIsIxDn0Jcd0Za3ok=;
        b=Q4vmyRl0EnVzFINToiQSZdzST0m9KlJ05x9KI1sjjhz5ZoaPrw7kljdITz6CdjAYnp
         ALzjDNy1NQJ6U+szgL8+mtu/pyXus4dXDj5xx7PCTdvCKhlLQ1fFNNUqQMeovrnqYO5o
         LXY+xPJOcg+DanB7FFTvkt2mV8Fxh9W9i2YaTnzLXGAEZYT83rIhq8YGhl2WLxoL1JKO
         aHZbE4U+PGsHAvX4ISRCk/kiXHSuAyP9GXtnAq2Q/pM9OPUGCVsXtAaEk3cAERCRq0Wd
         4DrSzTWL+04SZ7lbvzFDHGpGebRwT3pZQH4oasxys7k+u+Yp/GsNd/2kFsIX7CYxUkD9
         JAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JN0wvt58itYZYUkNRwdYTTFw6FJIsIxDn0Jcd0Za3ok=;
        b=X9ggg06R+CmpBVH6tStSLfRHBrUXVbW0g78bIL1fJR4ZYLlb7/nNeu1ex022NXKEb6
         fhrwQCoIQgWH0X+bG80aBFYNj0PWPPOadgv4OZtG2o6A28+zb0nyTRAA0TK4V7P1srNH
         0IbH7XkRkjnBbsi194DTBKtfIns0f90SJtDx6T1E1zmV7bMGUZENmC4mZnd9xWs9gAQY
         nC2qel9dbJK5Nn5g68cFwO3xJGUI0eVVeTj6kx91Su9BXzZq8cBzEXC5fp6JfgOOa1+r
         8rhhg7SxorKs4PM6FYvLSW1uqpLUO/Nsmk023iyK0i2e/OpHniMEGLdTJKovVArlZ5pD
         +8jw==
X-Gm-Message-State: AOAM531DTB9kHWY5ucLMeDiAGBTJqzrLy+OybQaGfl/1DXI7j7OOc0T0
        K7KLCLTV+R/pUX3qHWX0FFGN5GgMMI4=
X-Google-Smtp-Source: ABdhPJzMhaX54nJ+8rqKdk3HvllZJwvxxSVCbb0NTzmOguN9fss+dpn6GyIhQeF0z5wVP2dsCeymdw==
X-Received: by 2002:a5d:4bc1:: with SMTP id l1mr21709495wrt.396.1614123851793;
        Tue, 23 Feb 2021 15:44:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h22sm187092wmb.36.2021.02.23.15.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:44:11 -0800 (PST)
Message-Id: <f7bdad78219de6819d0403f8957e9a0c8b4218bc.1614123848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
        <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 23:44:01 +0000
Subject: [PATCH v2 04/10] diffcore-rename: extend cleanup_dir_rename_info()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When diffcore_rename_extended() is passed a NULL dir_rename_count, we
will still want to create a temporary one for use by
find_basename_matches(), but have it fully deallocated before
diffcore_rename_extended() returns.  However, when
diffcore_rename_extended() is passed a dir_rename_count, we want to fill
that strmap with appropriate values and return it.  However, for our
interim purposes we may also add entries corresponding to directories
that cannot have been renamed due to still existing on both sides.

Extend cleanup_dir_rename_info() to handle these two different cases,
cleaning up the relevant bits of information for each case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 7759c9a3a2ed..aa21d4e7175c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -507,13 +507,45 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
 }
 
 MAYBE_UNUSED
-static void cleanup_dir_rename_info(struct dir_rename_info *info)
+static void cleanup_dir_rename_info(struct dir_rename_info *info,
+				    struct strset *dirs_removed,
+				    int keep_dir_rename_count)
 {
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
 	if (!info->setup)
 		return;
 
-	partial_clear_dir_rename_count(info->dir_rename_count);
-	strmap_clear(info->dir_rename_count, 1);
+	if (!keep_dir_rename_count) {
+		partial_clear_dir_rename_count(info->dir_rename_count);
+		strmap_clear(info->dir_rename_count, 1);
+		FREE_AND_NULL(info->dir_rename_count);
+	} else {
+		/*
+		 * Although dir_rename_count was passed in
+		 * diffcore_rename_extended() and we want to keep it around and
+		 * return it to that caller, we first want to remove any data
+		 * associated with directories that weren't renamed.
+		 */
+		struct string_list to_remove = STRING_LIST_INIT_NODUP;
+		int i;
+
+		strmap_for_each_entry(info->dir_rename_count, &iter, entry) {
+			const char *source_dir = entry->key;
+			struct strintmap *counts = entry->value;
+
+			if (!strset_contains(dirs_removed, source_dir)) {
+				string_list_append(&to_remove, source_dir);
+				strintmap_clear(counts);
+				continue;
+			}
+		}
+		for (i=0; i<to_remove.nr; ++i)
+			strmap_remove(info->dir_rename_count,
+				      to_remove.items[i].string, 1);
+		string_list_clear(&to_remove, 0);
+	}
 }
 
 static const char *get_basename(const char *filename)
-- 
gitgitgadget

