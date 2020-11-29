Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F0C64E90
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F0F20809
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA/5Ulnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgK2Hov (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgK2Hou (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF593C061A4F
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:36 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g185so7315873wmf.3
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bxHGKizmJ6jjFkFgdOxDxkLQ0GowaVPZABJAzSl9eMk=;
        b=iA/5UlnqFfR6bjGW0CQ/tX/r0aLOiKvt8NHRIOcVlwNJpTNPf0rMuW9ZzyfbXh4Uqd
         qtFjeTmfNWe98ENeKNsfpSz0o2826wLTCYAqFWk+Qp81IxNt8Lj5zdAcsu3ZSd3hYVek
         Zzc4nmTh9Ll9COBFygy5prMoR0KzgsMXmaZ0jRfd7IQhc+SmbldfkPHpsksDj60MDxJe
         YwwnJdlB9HpkA+NDaX6MYjM0geKFsUJf/snIZpZflFnogvGUleq5+BGSC/aI7qZeAaAU
         MkdCmyNJsV/GbQ3HOO7NKXmhO1xdO6vA1garYe2DsQwyn2HqhOwVCW88XgAdQ6vosVvO
         6ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bxHGKizmJ6jjFkFgdOxDxkLQ0GowaVPZABJAzSl9eMk=;
        b=hrm1R4iXl1okUEUDEbbEX8uCZw9xr/KryOZb3HGl3+D2+AAR3lzvhOAMLa6WG3RK51
         PXPNZrz3kDDtte58XPhsLxj7A0dh3tr4qtJcWuQWrP1OX94xRHQBmfSnlkXlU2hVXysq
         5SddrnDQ60zV2vorAeNXhE9jREOx9QvPA1YeNHiCduD0uc02lSK7oYJhny+8O83fuKiO
         oqFnZUkYG6DVuoEUnkE+73yk60V1mxveuxhUeJ1BR82mjPiJear4yjeWgLY0EJVES0xW
         HIjk4n1q6OQIvpqrBQXv/5LuXBHM7XjQvS9yrzxVTI7GJ6lJYSqL9QZ06LiOGqFY/4mF
         c1Ig==
X-Gm-Message-State: AOAM533x0onLMzPv1uRKs9Pc16q4HrNT3zMqaa3n+gAG6bKQ8JE4bePx
        zsCTri7YkrHJoTdNcAXB7EiWiME7E9s=
X-Google-Smtp-Source: ABdhPJwgMRJCbVbUt/2r6HzADTJ2MNo0MxcWTJYKEaNKe8jajI6qkrE1HnM+B0du6+04MXkHw1JHaQ==
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr4539095wmd.91.1606635815290;
        Sat, 28 Nov 2020 23:43:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm20512564wmf.8.2020.11.28.23.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:34 -0800 (PST)
Message-Id: <605cbc19d2553ab15ac8b1541c5b3442b0c381a1.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:15 +0000
Subject: [PATCH 12/20] merge-ort: have process_entries operate in a defined
 order
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

We want to handle paths below a directory before needing to handle the
directory itself.  Also, we want to handle the directory immediately
after the paths below it, so we can't use simple lexicographic ordering
from strcmp (which would insert foo.txt between foo and foo/file.c).
Copy string_list_df_name_compare() from merge-recursive.c, and set up a
string list of paths sorted by that function so that we can iterate in
the desired order.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 04127a32f8..eec3b41e7e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -465,6 +465,33 @@ static int detect_and_process_renames(struct merge_options *opt,
 	return clean;
 }
 
+static int string_list_df_name_compare(const char *one, const char *two)
+{
+	int onelen = strlen(one);
+	int twolen = strlen(two);
+	/*
+	 * Here we only care that entries for D/F conflicts are
+	 * adjacent, in particular with the file of the D/F conflict
+	 * appearing before files below the corresponding directory.
+	 * The order of the rest of the list is irrelevant for us.
+	 *
+	 * To achieve this, we sort with df_name_compare and provide
+	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
+	 * We use the mode S_IFDIR for everything else for simplicity,
+	 * since in other cases any changes in their order due to
+	 * sorting cause no problems for us.
+	 */
+	int cmp = df_name_compare(one, onelen, S_IFDIR,
+				  two, twolen, S_IFDIR);
+	/*
+	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
+	 * that 'foo' comes before 'foo/bar'.
+	 */
+	if (cmp)
+		return cmp;
+	return onelen - twolen;
+}
+
 /* Per entry merge function */
 static void process_entry(struct merge_options *opt,
 			  const char *path,
@@ -551,24 +578,44 @@ static void process_entries(struct merge_options *opt,
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
+	struct string_list plist = STRING_LIST_INIT_NODUP;
+	struct string_list_item *entry;
 
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
 		return;
 	}
 
+	/* Hack to pre-allocate plist to the desired size */
+	ALLOC_GROW(plist.items, strmap_get_size(&opt->priv->paths), plist.alloc);
+
+	/* Put every entry from paths into plist, then sort */
 	strmap_for_each_entry(&opt->priv->paths, &iter, e) {
+		string_list_append(&plist, e->key)->util = e->value;
+	}
+	plist.cmp = string_list_df_name_compare;
+	string_list_sort(&plist);
+
+	/*
+	 * Iterate over the items in reverse order, so we can handle paths
+	 * below a directory before needing to handle the directory itself.
+	 */
+	for (entry = &plist.items[plist.nr-1]; entry >= plist.items; --entry) {
+		char *path = entry->string;
 		/*
 		 * NOTE: mi may actually be a pointer to a conflict_info, but
 		 * we have to check mi->clean first to see if it's safe to
 		 * reassign to such a pointer type.
 		 */
-		struct merged_info *mi = e->value;
+		struct merged_info *mi = entry->util;
 
-		if (!mi->clean)
-			process_entry(opt, e->key, e->value);
+		if (!mi->clean) {
+			struct conflict_info *ci = (struct conflict_info *)mi;
+			process_entry(opt, path, ci);
+		}
 	}
 
+	string_list_clear(&plist, 0);
 	die("Tree creation not yet implemented");
 }
 
-- 
gitgitgadget

