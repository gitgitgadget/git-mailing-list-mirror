Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4096F1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 13:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733296AbeLTNsr (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 08:48:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39282 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732995AbeLTNso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 08:48:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so1833129wra.6
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 05:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lgf7x4h58mmKQYNTwDzznIylKDlvOabAczbkCJgniDo=;
        b=K6Ps5hu2+V/oz2xTowI4ybcEpaznTe0o767r+vz/Jxe67sfr4FpGCJvY4mGG1M8o24
         /oOxMBc1OHwEpYyARCju/ZLP7cm3EOBHx9hY1LdLFKLvGphq48b+/0ljr4ZiY95/etu8
         MpdE2pf+siTiZZ3kZLgZi4us+bQZFWzwAMB/mevqTDJ5ZY2OsHL5prMxRvZ66PUEEe5n
         jcR9nidwnjytKDsdL81QmuO1CVUkdq9zbXxmIxQPqgLRSJr3shpD0hw3BwnrXWa8wRgO
         88pZT0YFqZTvlkZRAfZLSk7fEHYhqYz7mGx2Z4RfCAbm9bPTBRmpl/dTlOqi0z/8bd/G
         qAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lgf7x4h58mmKQYNTwDzznIylKDlvOabAczbkCJgniDo=;
        b=Oxb9wPLBPQQGLg1VaYzZf84H0YmA3pqppAP6AjdY78rDb+uPgfeGjXZuHjCGKsPE2B
         MPcg0G6Ly1ssxg5SUMqEDAXSskAZfxKoEzkUlblL5xHopJ0eIUjONihnCOU5JaDJob9O
         WqemCjv8+HpdYK+FZzwWNqztsgU16vbjTuwU5tsbzeawyQm2luAFw6JQbo5arKDEbEuR
         X26BqackQmHcF9CJ2eSj/xQ+/DyyejekkILbZuJKfS9UjFdxYDNazBkrXpqjLhG8/XXd
         moyIIlazJYj84CW4+lPyBuh5Go3vyGG/wxSABqPshBXuwEApMft8n/bZ3gmrMuYxozwM
         eZRw==
X-Gm-Message-State: AA+aEWYSFvDcyV8VriqEdtkIiZRpUeE0UEf/w/ubkqZqkYRwvto/LP41
        lAWBtOUH14QmuBW40L6YT60bBF9RhHg=
X-Google-Smtp-Source: AFSGD/VA1y7TQA3tOQla7PVX2PfZhiThyAV6pfByJQt88SWGZSPL30FQBNCzmkvlC0/zWcbKLN6zrg==
X-Received: by 2002:adf:d146:: with SMTP id b6mr22952418wri.156.1545313722183;
        Thu, 20 Dec 2018 05:48:42 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id c12sm6460673wrs.82.2018.12.20.05.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 05:48:41 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 4/8] read-cache: add invalidate parameter to remove_marked_cache_entries
Date:   Thu, 20 Dec 2018 13:48:16 +0000
Message-Id: <20181220134820.21810-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <20181220134820.21810-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181220134820.21810-1-t.gummerer@gmail.com>
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
2.20.1.415.g653613c723

