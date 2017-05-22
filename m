Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6FA2023D
	for <e@80x24.org>; Mon, 22 May 2017 14:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934694AbdEVOTV (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:19:21 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64457 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934731AbdEVOTO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:19:14 -0400
X-AuditID: 1207440d-dcfff70000000e33-29-5922f35c22af
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id EE.B8.03635.C53F2295; Mon, 22 May 2017 10:19:08 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24Y023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:19:06 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 25/25] cache_ref_iterator_begin(): avoid priming unneeded directories
Date:   Mon, 22 May 2017 16:17:55 +0200
Message-Id: <0d6a608a62026352c1496239bab02122f123f2e1.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqBvzWSnS4NA3GYu1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxsruWywFz2wq
        zh1bxd7AeMKgi5GTQ0LARGL94ovsXYxcHEICO5gkNrxdwQLhnGKSuNJ7gh2kik1AV2JRTzMT
        iC0ioCYxse0QWBGzwAZmiTfTVwMlODiEBSIkpjcngdSwCKhKXNs2ixXE5hWIkljcMocVYpu8
        xK62i2A2p4CFxO9ZB8BmCgmYS/T+W80ygZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJd
        I73czBK91JTSTYyQQOTdwfh/ncwhRgEORiUeXo3HSpFCrIllxZW5hxglOZiURHmPvgEK8SXl
        p1RmJBZnxBeV5qQWH2KU4GBWEuHVvguU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0t
        SC2CycpwcChJ8E7+BNQoWJSanlqRlplTgpBm4uAEGc4DNHzNB5DhxQWJucWZ6RD5U4yKUuK8
        BiDNAiCJjNI8uF5YonjFKA70ijBvIUgVDzDJwHW/AhrMBDTY+pk8yOCSRISUVAOjQM9jlejS
        hglBd60WlkQKvj+e41tl9+3J1LWKWsnam7tm+J3/sSc4xfG81tFVH7m3Z4ZsfzxL4lW9s8ab
        0rAbZ79JV02M/7Na4nfvjTg9f6FZIeejbBnVJ/5YemlppvzEN9H7nI2T3X7FbT+96mGgaWLK
        /ssGf3z74gR1X8141bP4RXTpfomtSizFGYmGWsxFxYkAjwlLWu8CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When iterating over references, reference priming is used to make sure
that loose references are read into the ref-cache before packed
references, to avoid races. It used to be that the prefix passed to
reference iterators almost always ended in `/`, for example
`refs/heads/`. In that case, the priming code would read all loose
references under `find_containing_dir("refs/heads/")`, which is
"refs/heads/". That's just what we want.

But now that `ref-filter` knows how to pass refname prefixes to
`for_each_fullref_in()`, the prefix might come from user input; for
example,

    git for-each-ref refs/heads

Since the argument doesn't include a trailing slash, the reference
iteration code would prime all of the loose references under
`find_containing_dir("refs/heads")`, which is "refs/". Thus we would
unnecessarily read tags, remote-tracking references, etc., when the
user is only interested in branches.

It is a bit awkward to get around this problem. We can't just append a
slash to the argument, because we don't know ab initio whether an
argument like `refs/tags/release` corresponds to a single tag or to a
directory containing tags.

Moreover, until now a `prefix_ref_iterator` was used to make the final
decision about which references fall within the prefix (the
`cache_ref_iterator` only did a rough cut). This is also inefficient,
because the `prefix_ref_iterator` can't know, for example, that while
you are in a subdirectory that is completely within the prefix, you
don't have to do the prefix check.

So:

* Move the responsibility for doing the prefix check directly to
  `cache_ref_iterator`. This means that `cache_ref_iterator_begin()`
  never has to wrap its return value in a `prefix_ref_iterator`.

* Teach `cache_ref_iterator_begin()` (and `prime_ref_dir()`) to be
  stricter about what they iterate over and what directories they
  prime.

* Teach `cache_ref_iterator` to keep track of whether the current
  `cache_ref_iterator_level` is fully within the prefix. If so, skip
  the prefix checks entirely.

The main benefit of these optimizations is for loose references, since
packed references are always read all at once.

Note that after this change, `prefix_ref_iterator` is only ever used
for its trimming feature and not for its "prefix" feature. But I'm not
ripping out the latter yet, because it might be useful for another
patch series that I'm working on.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/ref-cache.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 84 insertions(+), 10 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index ec97f3a38a..fda3942dbe 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -312,11 +312,42 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
+enum prefix_state {
+	/* All refs within the directory would match prefix: */
+	PREFIX_CONTAINS_DIR,
+
+	/* Some, but not all, refs within the directory might match prefix: */
+	PREFIX_WITHIN_DIR,
+
+	/* No refs within the directory could possibly match prefix: */
+	PREFIX_EXCLUDES_DIR
+};
+
 /*
- * Load all of the refs from `dir` (recursively) into our in-memory
- * cache.
+ * Return a `prefix_state` constant describing the relationship
+ * between the directory with the specified `dirname` and `prefix`.
  */
-static void prime_ref_dir(struct ref_dir *dir)
+static enum prefix_state overlaps_prefix(const char *dirname,
+					 const char *prefix)
+{
+	while (*prefix && *dirname == *prefix) {
+		dirname++;
+		prefix++;
+	}
+	if (!*prefix)
+		return PREFIX_CONTAINS_DIR;
+	else if (!*dirname)
+		return PREFIX_WITHIN_DIR;
+	else
+		return PREFIX_EXCLUDES_DIR;
+}
+
+/*
+ * Load all of the refs from `dir` (recursively) that could possibly
+ * contain references matching `prefix` into our in-memory cache. If
+ * `prefix` is NULL, prime unconditionally.
+ */
+static void prime_ref_dir(struct ref_dir *dir, const char *prefix)
 {
 	/*
 	 * The hard work of loading loose refs is done by get_ref_dir(), so we
@@ -327,8 +358,29 @@ static void prime_ref_dir(struct ref_dir *dir)
 	int i;
 	for (i = 0; i < dir->nr; i++) {
 		struct ref_entry *entry = dir->entries[i];
-		if (entry->flag & REF_DIR)
-			prime_ref_dir(get_ref_dir(entry));
+		if (!(entry->flag & REF_DIR)) {
+			/* Not a directory; no need to recurse. */
+		} else if (!prefix) {
+			/* Recurse in any case: */
+			prime_ref_dir(get_ref_dir(entry), NULL);
+		} else {
+			switch (overlaps_prefix(entry->name, prefix)) {
+			case PREFIX_CONTAINS_DIR:
+				/*
+				 * Recurse, and from here down we
+				 * don't have to check the prefix
+				 * anymore:
+				 */
+				prime_ref_dir(get_ref_dir(entry), NULL);
+				break;
+			case PREFIX_WITHIN_DIR:
+				prime_ref_dir(get_ref_dir(entry), prefix);
+				break;
+			case PREFIX_EXCLUDES_DIR:
+				/* No need to prime this directory. */
+				break;
+			}
+		}
 	}
 }
 
@@ -343,6 +395,8 @@ struct cache_ref_iterator_level {
 	 */
 	struct ref_dir *dir;
 
+	enum prefix_state prefix_state;
+
 	/*
 	 * The index of the current entry within dir (which might
 	 * itself be a directory). If index == -1, then the iteration
@@ -369,6 +423,13 @@ struct cache_ref_iterator {
 	/* The number of levels that have been allocated on the stack */
 	size_t levels_alloc;
 
+	/*
+	 * Only include references with this prefix in the iteration.
+	 * The prefix is matched textually, without regard for path
+	 * component boundaries.
+	 */
+	const char *prefix;
+
 	/*
 	 * A stack of levels. levels[0] is the uppermost level that is
 	 * being iterated over in this iteration. (This is not
@@ -390,6 +451,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			&iter->levels[iter->levels_nr - 1];
 		struct ref_dir *dir = level->dir;
 		struct ref_entry *entry;
+		enum prefix_state entry_prefix_state;
 
 		if (level->index == -1)
 			sort_ref_dir(dir);
@@ -404,6 +466,14 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		entry = dir->entries[level->index];
 
+		if (level->prefix_state == PREFIX_WITHIN_DIR) {
+			entry_prefix_state = overlaps_prefix(entry->name, iter->prefix);
+			if (entry_prefix_state == PREFIX_EXCLUDES_DIR)
+				continue;
+		} else {
+			entry_prefix_state = level->prefix_state;
+		}
+
 		if (entry->flag & REF_DIR) {
 			/* push down a level */
 			ALLOC_GROW(iter->levels, iter->levels_nr + 1,
@@ -411,6 +481,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 			level = &iter->levels[iter->levels_nr++];
 			level->dir = get_ref_dir(entry);
+			level->prefix_state = entry_prefix_state;
 			level->index = -1;
 		} else {
 			iter->base.refname = entry->name;
@@ -496,10 +567,10 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 		dir = find_containing_dir(dir, prefix, 0);
 	if (!dir)
 		/* There's nothing to iterate over. */
-		return  empty_ref_iterator_begin();
+		return empty_ref_iterator_begin();
 
 	if (prime_dir)
-		prime_ref_dir(dir);
+		prime_ref_dir(dir, prefix);
 
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
@@ -511,9 +582,12 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 	level->index = -1;
 	level->dir = dir;
 
-	if (prefix && *prefix)
-		ref_iterator = prefix_ref_iterator_begin(ref_iterator,
-							 prefix, 0);
+	if (prefix && *prefix) {
+		iter->prefix = xstrdup(prefix);
+		level->prefix_state = PREFIX_WITHIN_DIR;
+	} else {
+		level->prefix_state = PREFIX_CONTAINS_DIR;
+	}
 
 	return ref_iterator;
 }
-- 
2.11.0

