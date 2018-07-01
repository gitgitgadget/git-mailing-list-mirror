Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143781F516
	for <e@80x24.org>; Sun,  1 Jul 2018 01:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeGABZS (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 21:25:18 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41339 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeGABZN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 21:25:13 -0400
Received: by mail-ot0-f196.google.com with SMTP id o17-v6so576614otk.8
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 18:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VJ3Z6sm8DVoXjzgapGVArZ6zlUeWyNMhcqC5wgH5WBM=;
        b=QHUH5MWIMi1nbhGAPKx1b2h7rvttR9HkyO6aiwp4DgH29B4EVgotJp8ikUlNODYhUT
         XRDh/PrIG7GmDIn/a7vIS5alE4XX+raLmhcIwXp8AntsS/wxkr7G9kiyUVnxHm87mL2I
         EZxSSs68IlGcScf8FbD1a5QETRL6v6lvhFa8NJhI6Zmz/0GoKhZQBR+If4diDw24L7bF
         GN319HHrOXaZrRK+bJ8CQ3v6dI+XR8QKftyB94z5JmDKnxJFOarLgFG7WiI1MXYgJIY5
         39RD14UiVqK2AwhyZ37Jg6Od/XoFOQnY+TaSJcGTcLsaBWBde2RE3fJaMa1i+qiqiUoU
         epRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VJ3Z6sm8DVoXjzgapGVArZ6zlUeWyNMhcqC5wgH5WBM=;
        b=IlzU5hTrnmTJOJGUMrz30UFY8LCM31DYHSKV736+9+ecSQy92G/f15ESjOW/j+kWeY
         AgHLg/828FFDr4RkPhsiq+D9gGjCdGEsaoQMQVFsf/7QRrxV1sas8iakzH2Myw5jRDcl
         cwjeIs4O0h2+PKMM1otc2AFIf6tRgJf/ROQwKD7sMJaLQB2A6zBFk0b8L698vabzcUhX
         VhKiunjd9IwjAaPdJhIEgq8Mz5CnVt+DLg6XuAYSA7/r/noBbcfxa4HwbwfgFwpkpe3b
         FUdNIRF03q+fFtnU29ohjcwu9y1mVWcJdh3m0N/GAJdYtl/CiRpULkTNnOZN3t+ix93n
         jl/A==
X-Gm-Message-State: APt69E2ttuNsqjO5iQ2szs/BNi9tULXuTXaKfDdKjm0G7EzKHH2/IGwg
        HKbm3qBGPl6Ukt+hjlODnC8V4g==
X-Google-Smtp-Source: AAOMgpd/1mjHvRI3LC3/g32Jd+FqBWhTtuYNPa0zd5ExznPTB6V2eWnmJVAIxKqL04//CXWNaWEO9Q==
X-Received: by 2002:a9d:1b67:: with SMTP id l94-v6mr11374107otl.334.1530408312759;
        Sat, 30 Jun 2018 18:25:12 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id g20-v6sm3509394ote.38.2018.06.30.18.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 18:25:12 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/9] index_has_changes(): avoid assuming operating on the_index
Date:   Sat, 30 Jun 2018 18:24:56 -0700
Message-Id: <20180701012503.14382-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.137.g2a11d05a6.dirty
In-Reply-To: <20180701012503.14382-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
 <20180701012503.14382-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modify index_has_changes() to take a struct istate* instead of just
operating on the_index.  This is only a partial conversion, though,
because we call do_diff_cache() which implicitly assumes work is to be
done on the_index.  Ongoing work is being done elsewhere to do the
remainder of the conversion, and thus is not duplicated here.  Instead,
a simple check is put in place until that work is complete.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c      |  6 +++---
 cache.h           | 11 ++++++-----
 merge-recursive.c |  2 +-
 read-cache.c      | 11 +++++++----
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 6273ea519..24ad3e435 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1763,7 +1763,7 @@ static void am_run(struct am_state *state, int resume)
 
 	refresh_and_write_cache();
 
-	if (index_has_changes(&sb)) {
+	if (index_has_changes(&the_index, &sb)) {
 		write_state_bool(state, "dirtyindex", 1);
 		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
 	}
@@ -1820,7 +1820,7 @@ static void am_run(struct am_state *state, int resume)
 			 * Applying the patch to an earlier tree and merging
 			 * the result may have produced the same tree as ours.
 			 */
-			if (!apply_status && !index_has_changes(NULL)) {
+			if (!apply_status && !index_has_changes(&the_index, NULL)) {
 				say(state, stdout, _("No changes -- Patch already applied."));
 				goto next;
 			}
@@ -1874,7 +1874,7 @@ static void am_resolve(struct am_state *state)
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
-	if (!index_has_changes(NULL)) {
+	if (!index_has_changes(&the_index, NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
 			"If there is nothing left to stage, chances are that something else\n"
 			"already introduced the same changes; you might want to skip this patch."));
diff --git a/cache.h b/cache.h
index d49092d94..125f2767a 100644
--- a/cache.h
+++ b/cache.h
@@ -635,12 +635,13 @@ extern void move_index_extensions(struct index_state *dst, struct index_state *s
 extern int unmerged_index(const struct index_state *);
 
 /**
- * Returns 1 if the index differs from HEAD, 0 otherwise. When on an unborn
- * branch, returns 1 if there are entries in the index, 0 otherwise. If an
- * strbuf is provided, the space-separated list of files that differ will be
- * appended to it.
+ * Returns 1 if istate differs from HEAD, 0 otherwise.  When on an unborn
+ * branch, returns 1 if there are entries in istate, 0 otherwise.  If an
+ * strbuf is provided, the space-separated list of files that differ will
+ * be appended to it.
  */
-extern int index_has_changes(struct strbuf *sb);
+extern int index_has_changes(const struct index_state *istate,
+			     struct strbuf *sb);
 
 extern int verify_path(const char *path, unsigned mode);
 extern int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
diff --git a/merge-recursive.c b/merge-recursive.c
index bed4a5be0..f9384fabf 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3266,7 +3266,7 @@ int merge_trees(struct merge_options *o,
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
 		struct strbuf sb = STRBUF_INIT;
 
-		if (!o->call_depth && index_has_changes(&sb)) {
+		if (!o->call_depth && index_has_changes(&the_index, &sb)) {
 			err(o, _("Dirty index: cannot merge (dirty: %s)"),
 			    sb.buf);
 			return 0;
diff --git a/read-cache.c b/read-cache.c
index 5a9a93da3..ad3102083 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1986,11 +1986,14 @@ int unmerged_index(const struct index_state *istate)
 	return 0;
 }
 
-int index_has_changes(struct strbuf *sb)
+int index_has_changes(const struct index_state *istate, struct strbuf *sb)
 {
 	struct object_id head;
 	int i;
 
+	if (istate != &the_index) {
+		BUG("index_has_changes cannot yet accept istate != &the_index; do_diff_cache needs updating first.");
+	}
 	if (!get_oid_tree("HEAD", &head)) {
 		struct diff_options opt;
 
@@ -2008,12 +2011,12 @@ int index_has_changes(struct strbuf *sb)
 		diff_flush(&opt);
 		return opt.flags.has_changes != 0;
 	} else {
-		for (i = 0; sb && i < the_index.cache_nr; i++) {
+		for (i = 0; sb && i < istate->cache_nr; i++) {
 			if (i)
 				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, the_index.cache[i]->name);
+			strbuf_addstr(sb, istate->cache[i]->name);
 		}
-		return !!the_index.cache_nr;
+		return !!istate->cache_nr;
 	}
 }
 
-- 
2.18.0.137.g2a11d05a6.dirty

