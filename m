Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCFC1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfAHVwl (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:52:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41531 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbfAHVwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:52:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so5587853wrs.8
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 13:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUd4dzpb0Oe6KhMsVzCmSBoKMzWu2sGoSFxLBGHkldA=;
        b=p7/fhw4Oy1yuIprFa2OF0BaEinsUdT7ycjfeSxN+mMvngJd/3ayuuctzMw1IPTbeMU
         r/rwpsRhFAGjLclb44l7sxubf+U6C9X2RqzY44TH72NuZAgP+8ClEotay2zQSuxXUAGx
         41dXnRqH70hh/s9Sya4pdfysTi0i73FdPsOKlJlK7wOeJ4NWbd6oWsiJL2Z/9j7woMHd
         lVOuZXjFfT1aLlwilY31ziuzErV/saAt4Edh4Y0NtjGgw6RmIaSWq18vOpHSqqXqHcob
         e+BU15x0V/Nh+87c9yEJa9r/7DiaaPBJxrAuPpcN83XyW4KAWRADjQ8bQ2boXSXAGkC1
         gBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUd4dzpb0Oe6KhMsVzCmSBoKMzWu2sGoSFxLBGHkldA=;
        b=uDnK2wHBMpPuXql2Zkg8XfEtjwwdwGfcKJ/iVlaUxqObSBfiP6y7lx3nYWPKQ31XHb
         VZPAFPALM43tsB97tm1+YyeP55KcILOzQEIqwsslnBHBpo6MssN6FpRw/lrGxFNEMncb
         NZzOm1ME344CAEAn1b3bXnl6Fd/UYoWWBuCN78mhcwgCjaaHuHAgAkMkQl6aacHc2PCh
         FJFTGW6QdNGhwdpoJ4KQZmw7bhKuGBt8WGiuTmaTWT8qtwE/T/kOAmEs2izBqF+tDkOA
         Gc8qlwJaBk+FShl2xx1E3z/o5CfGHeJ248u0VUIPLeInX3Y6x3B6QQZNn0T2re8EY6oC
         Ud1Q==
X-Gm-Message-State: AJcUukfmRih1BYJ79bLh90uSI06WNc68guAdBtUbstVv6hpD5l/cJmo7
        m2eyfj1FgtsmqSTSQ64fR5DI2f4d
X-Google-Smtp-Source: ALg8bN5ndNDHQA2owzepPCOwWIQ3Yzeters3eOyx3FfWCiV0biwEinnKDsLlgx+6lkQ2TvTTUMD+7A==
X-Received: by 2002:adf:9521:: with SMTP id 30mr2565558wrs.192.1546984358522;
        Tue, 08 Jan 2019 13:52:38 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id h17sm54295082wrt.59.2019.01.08.13.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:52:37 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 4/8] read-cache: add invalidate parameter to remove_marked_cache_entries
Date:   Tue,  8 Jan 2019 21:52:21 +0000
Message-Id: <20190108215225.3077-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190108215225.3077-1-t.gummerer@gmail.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When marking cache entries for removal, and later removing them all at
once using 'remove_marked_cache_entries()', cache entries currently
have to be invalidated manually in the cache tree and in the untracked
cache.

Add an invalidate flag to the function.  With the flag set, the
function will take care of invalidating the path in the cache tree and
in the untracked cache.

Note that the current callsites already do the invalidation properly
in other places, so we're just passing 0 from there to keep the status
quo.

This will be useful in a subsequent commit.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h        | 2 +-
 read-cache.c   | 8 +++++++-
 split-index.c  | 2 +-
 unpack-trees.c | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index c1c953e810..1deee48f5b 100644
--- a/cache.h
+++ b/cache.h
@@ -751,7 +751,7 @@ extern void rename_index_entry_at(struct index_state *, int pos, const char *new
 /* Remove entry, return true if there are more entries to go. */
 extern int remove_index_entry_at(struct index_state *, int pos);
 
-extern void remove_marked_cache_entries(struct index_state *istate);
+extern void remove_marked_cache_entries(struct index_state *istate, int invalidate);
 extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
diff --git a/read-cache.c b/read-cache.c
index bd45dc3e24..978d43f676 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -590,13 +590,19 @@ int remove_index_entry_at(struct index_state *istate, int pos)
  * CE_REMOVE is set in ce_flags.  This is much more effective than
  * calling remove_index_entry_at() for each entry to be removed.
  */
-void remove_marked_cache_entries(struct index_state *istate)
+void remove_marked_cache_entries(struct index_state *istate, int invalidate)
 {
 	struct cache_entry **ce_array = istate->cache;
 	unsigned int i, j;
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE) {
+			if (invalidate) {
+				cache_tree_invalidate_path(istate,
+							   ce_array[i]->name);
+				untracked_cache_remove_from_index(istate,
+								  ce_array[i]->name);
+			}
 			remove_name_hash(istate, ce_array[i]);
 			save_or_free_index_entry(istate, ce_array[i]);
 		}
diff --git a/split-index.c b/split-index.c
index 5820412dc5..8aebc3661b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -162,7 +162,7 @@ void merge_base_index(struct index_state *istate)
 	ewah_each_bit(si->replace_bitmap, replace_entry, istate);
 	ewah_each_bit(si->delete_bitmap, mark_entry_for_delete, istate);
 	if (si->nr_deletions)
-		remove_marked_cache_entries(istate);
+		remove_marked_cache_entries(istate, 0);
 
 	for (i = si->nr_replacements; i < si->saved_cache_nr; i++) {
 		if (!ce_namelen(si->saved_cache[i]))
diff --git a/unpack-trees.c b/unpack-trees.c
index e8d1a6ac50..8e6afa924d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -392,7 +392,7 @@ static int check_updates(struct unpack_trees_options *o)
 				unlink_entry(ce);
 		}
 	}
-	remove_marked_cache_entries(index);
+	remove_marked_cache_entries(index, 0);
 	remove_scheduled_dirs();
 
 	if (should_update_submodules() && o->update && !o->dry_run)
-- 
2.20.1.153.gd81d796ee0

