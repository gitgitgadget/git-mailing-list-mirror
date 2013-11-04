From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Rename suffixcmp() to has_suffix()
Date: Mon, 04 Nov 2013 22:45:11 +0100
Message-ID: <20131104214512.19757.74215.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 04 22:50:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdS2P-0003YU-0P
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 22:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab3KDVuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 16:50:15 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:45059 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750957Ab3KDVuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 16:50:14 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 831A051;
	Mon,  4 Nov 2013 22:49:51 +0100 (CET)
X-git-sha1: 3d3730679ff5640a97c1f13fb5a8a63d75156f26 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237306>

As suffixcmp() should not be used as an ordering comparison function,
and anything-cmp() ought to be usable as an ordering comparison function,
suffixcmp() should be renamed to something that doesn't end with "cmp".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
Hi Junio,

This is a patch, following your last suggestion, that should be added or
squashed into the 2 patch series I sent one hour ago.

Thanks,
Christian.

 builtin/clone.c           | 2 +-
 builtin/fetch.c           | 2 +-
 builtin/merge-recursive.c | 2 +-
 builtin/remote.c          | 6 +++---
 builtin/repack.c          | 2 +-
 connected.c               | 2 +-
 git-compat-util.h         | 2 +-
 strbuf.c                  | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 874e0fd..4b8308e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -510,7 +510,7 @@ static void write_followtags(const struct ref *refs, const char *msg)
 	for (ref = refs; ref; ref = ref->next) {
 		if (prefixcmp(ref->name, "refs/tags/"))
 			continue;
-		if (!suffixcmp(ref->name, "^{}"))
+		if (!has_suffix(ref->name, "^{}"))
 			continue;
 		if (!has_sha1_file(ref->old_sha1))
 			continue;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index bd7a101..a26b0e5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -653,7 +653,7 @@ static void find_non_local_tags(struct transport *transport,
 		 * to fetch then we can mark the ref entry in the list
 		 * as one to ignore by setting util to NULL.
 		 */
-		if (!suffixcmp(ref->name, "^{}")) {
+		if (!has_suffix(ref->name, "^{}")) {
 			if (item && !has_sha1_file(ref->old_sha1) &&
 			    !will_fetch(head, ref->old_sha1) &&
 			    !has_sha1_file(item->util) &&
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 3a64f5d..6ba30aa 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -29,7 +29,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	struct commit *result;
 
 	init_merge_options(&o);
-	if (argv[0] && !suffixcmp(argv[0], "-subtree"))
+	if (argv[0] && !has_suffix(argv[0], "-subtree"))
 		o.subtree_shift = "";
 
 	if (argc < 4)
diff --git a/builtin/remote.c b/builtin/remote.c
index 9b3a98e..c04fd7d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -269,13 +269,13 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		enum { REMOTE, MERGE, REBASE } type;
 
 		key += 7;
-		if (!suffixcmp(key, ".remote")) {
+		if (!has_suffix(key, ".remote")) {
 			name = xstrndup(key, strlen(key) - 7);
 			type = REMOTE;
-		} else if (!suffixcmp(key, ".merge")) {
+		} else if (!has_suffix(key, ".merge")) {
 			name = xstrndup(key, strlen(key) - 6);
 			type = MERGE;
-		} else if (!suffixcmp(key, ".rebase")) {
+		} else if (!has_suffix(key, ".rebase")) {
 			name = xstrndup(key, strlen(key) - 7);
 			type = REBASE;
 		} else
diff --git a/builtin/repack.c b/builtin/repack.c
index a0ff5c7..79b14bf 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -78,7 +78,7 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 		return;
 
 	while ((e = readdir(dir)) != NULL) {
-		if (suffixcmp(e->d_name, ".pack"))
+		if (has_suffix(e->d_name, ".pack"))
 			continue;
 
 		len = strlen(e->d_name) - strlen(".pack");
diff --git a/connected.c b/connected.c
index fae8d64..6a1629c 100644
--- a/connected.c
+++ b/connected.c
@@ -38,7 +38,7 @@ int check_everything_connected_with_transport(sha1_iterate_fn fn,
 	if (transport && transport->smart_options &&
 	    transport->smart_options->self_contained_and_connected &&
 	    transport->pack_lockfile &&
-	    !suffixcmp(transport->pack_lockfile, ".keep")) {
+	    !has_suffix(transport->pack_lockfile, ".keep")) {
 		struct strbuf idx_file = STRBUF_INIT;
 		strbuf_addstr(&idx_file, transport->pack_lockfile);
 		strbuf_setlen(&idx_file, idx_file.len - 5); /* ".keep" */
diff --git a/git-compat-util.h b/git-compat-util.h
index 7776f12..0f6a31e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -351,7 +351,7 @@ extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int prefixcmp(const char *str, const char *prefix);
-extern int suffixcmp(const char *str, const char *suffix);
+extern int has_suffix(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
diff --git a/strbuf.c b/strbuf.c
index 9ba50de..5a82735 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -10,7 +10,7 @@ int prefixcmp(const char *str, const char *prefix)
 			return (unsigned char)*prefix - (unsigned char)*str;
 }
 
-int suffixcmp(const char *str, const char *suffix)
+int has_suffix(const char *str, const char *suffix)
 {
 	int len = strlen(str), suflen = strlen(suffix);
 	if (len < suflen)
-- 
1.8.4.1.561.g186b3da.dirty
