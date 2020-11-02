Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1628EC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F532071A
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B61dvNg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgKBUoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgKBUoD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:03 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE75EC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:44:02 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id c80so4536540oib.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EU5eR3cWvBGUmKiDUkbd1kHFSAPGBQBdRmerAY3P0ho=;
        b=B61dvNg5FeIYQEpR+0Ow6zHd09AxgZpEJyw0C+1DhCCSt92Dk/dBt66JGORcY/9RJs
         n9+XAJhM5VjSiXlVF+mpokLKbeOPKNHrNy4hD/CozLgvXldwEZHLmOMZH9tGYUUahGo9
         zU39OLf59FbvgNc1roBhLlTs2GcgHb4QzDaeC2Z4nDyDs58X/gkUveqtRD5y5OBdUnpm
         Q9KbcSy9cnoqFT8MgGf1b6pC3/xzBQ167c6kT4qM5WXTHht2LvZvVwWtr6ZsykIeHiLS
         vgkSu4bXDaS408sobKIE92gpLkXacyxvUZsBAIu1fnh/YbJkUDdcMzfeu9Y/+ncCIiWi
         Hd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EU5eR3cWvBGUmKiDUkbd1kHFSAPGBQBdRmerAY3P0ho=;
        b=DiocX3yy8cFNd16pZgx2yxuHz87qZgEwV8OapkWBAxyqwsWvuEHiWDo26hSI6cfYZ1
         3kt8fvWhtM/egh0jva/4UHPcYSl7c7E3wZfdHdHnD5g4Dx6H9GgKnmm8M/xwFvXakUHs
         DYpiPylRNKKlPizhm/g/TAKr27TUWMkD8pC2jbL5v+J18xa8s6ip62Js89LWTCB4J0AO
         L8VD8LZYsyuQXfUky7u4pr0ElUMj11So6/isPrXW9d1kLZVevHAPJiY3mfQJ4G3py3Je
         mdBGteits8IGZ9r8T7i02aa77ci44yBQAL9ip7p1ylgkjPrdAeBX87jc3KHV1CLpTl8R
         qKpg==
X-Gm-Message-State: AOAM530r14UbCtQeV28y9nj9vXVJRS0Q6g4tIvtEmYlBVDidAhl7TTO1
        eOrMTFJTOppj3bA19iyfjNu0mslUJy8egg==
X-Google-Smtp-Source: ABdhPJy0Q8NfUaRAeOrzr9P0FdHrbPXX2JUI3o3pr3oYNi7HmdSkP6JvFycGi7mG+5URe+B9Hzexpg==
X-Received: by 2002:aca:d502:: with SMTP id m2mr3923148oig.105.1604349841993;
        Mon, 02 Nov 2020 12:44:01 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:44:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 12/20] merge-ort: have process_entries operate in a defined order
Date:   Mon,  2 Nov 2020 12:43:36 -0800
Message-Id: <20201102204344.342633-13-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to handle paths below a directory before needing to handle the
directory itself.  Also, we want to handle the directory immediately
after the paths below it, so we can't use simple lexicographic ordering
from strcmp (which would insert foo.txt between foo and foo/file.c).
Copy string_list_df_name_compare() from merge-recursive.c, and set up a
string list of paths sorted by that function so that we can iterate in
the desired order.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 92bbdc7255..3d46d62ed3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -323,6 +323,33 @@ static int detect_and_process_renames(struct merge_options *opt,
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
@@ -413,23 +440,41 @@ static void process_entries(struct merge_options *opt,
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
 		 * WARNING: If ci->merged.clean is true, then ci does not
 		 * actually point to a conflict_info but a struct merge_info.
 		 */
-		struct conflict_info *ci = e->value;
+		struct conflict_info *ci = entry->util;
 
 		if (!ci->merged.clean)
-			process_entry(opt, e->key, e->value);
+			process_entry(opt, path, ci);
 	}
 
+	string_list_clear(&plist, 0);
 	die("Tree creation not yet implemented");
 }
 
-- 
2.29.0.471.ga4f56089c0

