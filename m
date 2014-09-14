From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 2/2] headers: include dependent headers
Date: Sat, 13 Sep 2014 18:00:50 -0700
Message-ID: <1410656450-96087-2-git-send-email-davvid@gmail.com>
References: <1410656450-96087-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 03:01:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSyBi-0007R4-HE
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 03:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbaINBBF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Sep 2014 21:01:05 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:41590 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbaINBBC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 21:01:02 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so3881337pdb.14
        for <git@vger.kernel.org>; Sat, 13 Sep 2014 18:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eQsqA9nMYP98Xn8kbA3pxt8+ZU8oq5S0w9y8VYqTZaA=;
        b=Ci0bgx66s26wCdtPf59y7R0T+dbN1BadkRSa+RM1yaJa+pnm7lUR7Ig2zVch1q3WtG
         rzWtM0UyNrlM9lX+edy++OwFFtBSdMh2kGIOBUEgD+BLPaEZZd0qUSDTi9pT2eZyTBYW
         Xb6yZK+/F0KnK9l0PBKEIbe2XdcP3U48jz0zS5PRrn0/g8oYYeLhqin3AO3gz1I13Mu7
         O7gDKCSadIkyFOXCaAnmpSYJRwhn0rSeYb0I9hz7k154k7IRGTfdTi4In0lG/EkOB712
         r+HopH5hSUnpipz/qnHrpwzTwc6i4bM9bFtvEwCq117lC4v6gkLQfywfKJD8AyYCzg/4
         PSSA==
X-Received: by 10.66.227.71 with SMTP id ry7mr26483211pac.32.1410656460957;
        Sat, 13 Sep 2014 18:01:00 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id dg5sm7898741pac.12.2014.09.13.18.00.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Sep 2014 18:01:00 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.240.gb601169
In-Reply-To: <1410656450-96087-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256988>

Add dependent headers so that including a header does not
require including additional headers.

Move the unicode interval types to unicode_width.h so that we
can include them from utf8.h.

This makes it so that "gcc -c $header" succeeds for each header.

Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since last time:

This patch was redone to no longer add git-compat-util.h
additions, as it was run using the new check-headers.

The unicode interval types were moved into unicode_width.h
to minimize dependencies.

 archive.h         |  1 +
 attr.h            |  2 ++
 blob.h            |  1 +
 branch.h          |  2 ++
 column.h          |  2 ++
 commit.h          |  1 +
 convert.h         |  2 ++
 csum-file.h       |  2 ++
 diff.h            |  2 +-
 diffcore.h        |  2 ++
 dir.h             |  2 ++
 ewah/ewok_rlw.h   |  2 ++
 fsck.h            |  2 ++
 gpg-interface.h   |  2 ++
 graph.h           |  2 ++
 khash.h           |  2 ++
 line-log.h        |  1 +
 list-objects.h    |  2 ++
 ll-merge.h        |  2 ++
 mailmap.h         |  2 ++
 merge-recursive.h |  2 ++
 notes-merge.h     |  4 ++++
 notes-utils.h     |  1 +
 notes.h           |  1 +
 object.h          |  2 ++
 pack-bitmap.h     |  2 ++
 pack-objects.h    |  2 ++
 patch-ids.h       |  3 +++
 reachable.h       |  2 ++
 reflog-walk.h     |  1 +
 refs.h            |  3 +++
 remote.h          |  1 +
 resolve-undo.h    |  4 ++++
 send-pack.h       |  3 +++
 sequencer.h       |  2 ++
 shortlog.h        |  1 +
 submodule.h       |  5 +++--
 tree-walk.h       |  2 ++
 tree.h            |  1 +
 unicode_width.h   | 12 ++++++++++++
 unpack-trees.h    |  2 ++
 url.h             |  2 ++
 utf8.c            |  5 -----
 utf8.h            |  3 ++-
 walker.h          |  1 +
 wt-status.h       |  1 +
 xdiff/xdiffi.h    |  2 ++
 xdiff/xemit.h     |  3 +++
 xdiff/xprepare.h  |  3 ++-
 xdiff/xutils.h    |  3 ++-
 50 files changed, 104 insertions(+), 11 deletions(-)

diff --git a/archive.h b/archive.h
index 4a791e1..b2ca5bf 100644
--- a/archive.h
+++ b/archive.h
@@ -1,6 +1,7 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
=20
+#include "cache.h"
 #include "pathspec.h"
=20
 struct archiver_args {
diff --git a/attr.h b/attr.h
index 8b08d33..34e63f8 100644
--- a/attr.h
+++ b/attr.h
@@ -1,6 +1,8 @@
 #ifndef ATTR_H
 #define ATTR_H
=20
+#include "cache.h"
+
 /* An attribute is a pointer to this opaque structure */
 struct git_attr;
=20
diff --git a/blob.h b/blob.h
index 59b394e..25d8618 100644
--- a/blob.h
+++ b/blob.h
@@ -1,6 +1,7 @@
 #ifndef BLOB_H
 #define BLOB_H
=20
+#include "cache.h"
 #include "object.h"
=20
 extern const char *blob_type;
diff --git a/branch.h b/branch.h
index 64173ab..d5fdcc6 100644
--- a/branch.h
+++ b/branch.h
@@ -3,6 +3,8 @@
=20
 /* Functions for acting on the information about branches. */
=20
+#include "cache.h"
+
 /*
  * Creates a new branch, where head is the branch currently checked
  * out, name is the new branch name, start_name is the name of the
diff --git a/column.h b/column.h
index 0a61917..5d094b4 100644
--- a/column.h
+++ b/column.h
@@ -1,6 +1,8 @@
 #ifndef COLUMN_H
 #define COLUMN_H
=20
+#include "string-list.h"
+
 #define COL_LAYOUT_MASK   0x000F
 #define COL_ENABLE_MASK   0x0030   /* always, never or auto */
 #define COL_PARSEOPT      0x0040   /* --column is given from cmdline *=
/
diff --git a/commit.h b/commit.h
index a401ddf..a0f6d20 100644
--- a/commit.h
+++ b/commit.h
@@ -1,6 +1,7 @@
 #ifndef COMMIT_H
 #define COMMIT_H
=20
+#include "cache.h"
 #include "object.h"
 #include "tree.h"
 #include "strbuf.h"
diff --git a/convert.h b/convert.h
index 0c2143c..82f81fa 100644
--- a/convert.h
+++ b/convert.h
@@ -4,6 +4,8 @@
 #ifndef CONVERT_H
 #define CONVERT_H
=20
+#include "strbuf.h"
+
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
 	SAFE_CRLF_FAIL =3D 1,
diff --git a/csum-file.h b/csum-file.h
index bb543d5..9e29e35 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -1,6 +1,8 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
=20
+#include "cache.h"
+
 struct progress;
=20
 /* A SHA1-protected file */
diff --git a/diff.h b/diff.h
index b4a624d..27f7696 100644
--- a/diff.h
+++ b/diff.h
@@ -6,11 +6,11 @@
=20
 #include "tree-walk.h"
 #include "pathspec.h"
+#include "strbuf.h"
=20
 struct rev_info;
 struct diff_options;
 struct diff_queue_struct;
-struct strbuf;
 struct diff_filespec;
 struct userdiff_driver;
 struct sha1_array;
diff --git a/diffcore.h b/diffcore.h
index 33ea2de..7ae0293 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -9,6 +9,8 @@
  * in anything else.
  */
=20
+#include "diff.h"
+
 /* We internally use unsigned short as the score value,
  * and rely on an int capable to hold 32-bits.  -B can take
  * -Bmerge_score/break_score format and the two scores are
diff --git a/dir.h b/dir.h
index 6c45e9d..3330771 100644
--- a/dir.h
+++ b/dir.h
@@ -3,7 +3,9 @@
=20
 /* See Documentation/technical/api-directory-listing.txt */
=20
+#include "cache.h"
 #include "strbuf.h"
+#include "pathspec.h"
=20
 struct dir_entry {
 	unsigned int len;
diff --git a/ewah/ewok_rlw.h b/ewah/ewok_rlw.h
index 63efdf9..e84aa54 100644
--- a/ewah/ewok_rlw.h
+++ b/ewah/ewok_rlw.h
@@ -20,6 +20,8 @@
 #ifndef __EWOK_RLW_H__
 #define __EWOK_RLW_H__
=20
+#include "ewok.h"
+
 #define RLW_RUNNING_BITS (sizeof(eword_t) * 4)
 #define RLW_LITERAL_BITS (sizeof(eword_t) * 8 - 1 - RLW_RUNNING_BITS)
=20
diff --git a/fsck.h b/fsck.h
index 1e4f527..7712cd1 100644
--- a/fsck.h
+++ b/fsck.h
@@ -1,6 +1,8 @@
 #ifndef GIT_FSCK_H
 #define GIT_FSCK_H
=20
+#include "cache.h"
+
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
=20
diff --git a/gpg-interface.h b/gpg-interface.h
index 37c23da..f42b706 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -1,6 +1,8 @@
 #ifndef GPG_INTERFACE_H
 #define GPG_INTERFACE_H
=20
+#include "strbuf.h"
+
 struct signature_check {
 	char *payload;
 	char *gpg_output;
diff --git a/graph.h b/graph.h
index 0be62bd..17e6a11 100644
--- a/graph.h
+++ b/graph.h
@@ -1,6 +1,8 @@
 #ifndef GRAPH_H
 #define GRAPH_H
=20
+#include "revision.h"
+
 /* A graph is a pointer to this opaque structure */
 struct git_graph;
=20
diff --git a/khash.h b/khash.h
index 06c7906..fc8b1bf 100644
--- a/khash.h
+++ b/khash.h
@@ -26,6 +26,8 @@
 #ifndef __AC_KHASH_H
 #define __AC_KHASH_H
=20
+#include "cache.h"
+
 #define AC_VERSION_KHASH_H "0.2.8"
=20
 typedef uint32_t khint32_t;
diff --git a/line-log.h b/line-log.h
index a9212d8..e1d47e0 100644
--- a/line-log.h
+++ b/line-log.h
@@ -2,6 +2,7 @@
 #define LINE_LOG_H
=20
 #include "diffcore.h"
+#include "string-list.h"
=20
 struct rev_info;
 struct commit;
diff --git a/list-objects.h b/list-objects.h
index 136a1da..8810db6 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -1,6 +1,8 @@
 #ifndef LIST_OBJECTS_H
 #define LIST_OBJECTS_H
=20
+#include "revision.h"
+
 typedef void (*show_commit_fn)(struct commit *, void *);
 typedef void (*show_object_fn)(struct object *, const struct name_path=
 *, const char *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_obje=
ct_fn, void *);
diff --git a/ll-merge.h b/ll-merge.h
index 244a31f..b72b199 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -5,6 +5,8 @@
 #ifndef LL_MERGE_H
 #define LL_MERGE_H
=20
+#include "xdiff/xdiff.h"
+
 struct ll_merge_options {
 	unsigned virtual_ancestor : 1;
 	unsigned variant : 2;	/* favor ours, favor theirs, or union merge */
diff --git a/mailmap.h b/mailmap.h
index ed7c93b..ff90e1f 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -1,6 +1,8 @@
 #ifndef MAILMAP_H
 #define MAILMAP_H
=20
+#include "string-list.h"
+
 int read_mailmap(struct string_list *map, char **repo_abbrev);
 void clear_mailmap(struct string_list *map);
=20
diff --git a/merge-recursive.h b/merge-recursive.h
index 9e090a3..9d11653 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -1,6 +1,8 @@
 #ifndef MERGE_RECURSIVE_H
 #define MERGE_RECURSIVE_H
=20
+#include "commit.h"
+#include "strbuf.h"
 #include "string-list.h"
=20
 struct merge_options {
diff --git a/notes-merge.h b/notes-merge.h
index 1d01f6a..3f33089 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -1,6 +1,10 @@
 #ifndef NOTES_MERGE_H
 #define NOTES_MERGE_H
=20
+#include "commit.h"
+#include "strbuf.h"
+#include "notes.h"
+
 #define NOTES_MERGE_WORKTREE "NOTES_MERGE_WORKTREE"
=20
 enum notes_merge_verbosity {
diff --git a/notes-utils.h b/notes-utils.h
index 890ddb3..3a8beac 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -1,6 +1,7 @@
 #ifndef NOTES_UTILS_H
 #define NOTES_UTILS_H
=20
+#include "commit.h"
 #include "notes.h"
=20
 /*
diff --git a/notes.h b/notes.h
index 2a3f923..12318a4 100644
--- a/notes.h
+++ b/notes.h
@@ -1,6 +1,7 @@
 #ifndef NOTES_H
 #define NOTES_H
=20
+#include "strbuf.h"
 #include "string-list.h"
=20
 /*
diff --git a/object.h b/object.h
index 5e8d8ee..e61b290 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,8 @@
 #ifndef OBJECT_H
 #define OBJECT_H
=20
+#include "cache.h"
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 8b7f4e9..86f39f4 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -3,7 +3,9 @@
=20
 #include "ewah/ewok.h"
 #include "khash.h"
+#include "pack.h"
 #include "pack-objects.h"
+#include "revision.h"
=20
 struct bitmap_disk_entry {
 	uint32_t object_pos;
diff --git a/pack-objects.h b/pack-objects.h
index d1b98b3..2c28bea 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,8 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
=20
+#include "pack.h"
+
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
diff --git a/patch-ids.h b/patch-ids.h
index c8c7ca1..016eb2d 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -1,6 +1,9 @@
 #ifndef PATCH_IDS_H
 #define PATCH_IDS_H
=20
+#include "commit.h"
+#include "diff.h"
+
 struct patch_id {
 	unsigned char patch_id[20];
 	char seen;
diff --git a/reachable.h b/reachable.h
index 5d082ad..5536382 100644
--- a/reachable.h
+++ b/reachable.h
@@ -1,6 +1,8 @@
 #ifndef REACHEABLE_H
 #define REACHEABLE_H
=20
+#include "revision.h"
+
 struct progress;
 extern void mark_reachable_objects(struct rev_info *revs, int mark_ref=
log, struct progress *);
=20
diff --git a/reflog-walk.h b/reflog-walk.h
index 50265f5..d5378b9 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -2,6 +2,7 @@
 #define REFLOG_WALK_H
=20
 #include "cache.h"
+#include "commit.h"
=20
 struct reflog_walk_info;
=20
diff --git a/refs.h b/refs.h
index 68c5770..58dd9f5 100644
--- a/refs.h
+++ b/refs.h
@@ -1,6 +1,9 @@
 #ifndef REFS_H
 #define REFS_H
=20
+#include "strbuf.h"
+#include "string-list.h"
+
 struct ref_lock {
 	char *ref_name;
 	char *orig_ref_name;
diff --git a/remote.h b/remote.h
index 8b62efd..dcecdf9 100644
--- a/remote.h
+++ b/remote.h
@@ -2,6 +2,7 @@
 #define REMOTE_H
=20
 #include "parse-options.h"
+#include "strbuf.h"
 #include "hashmap.h"
=20
 enum {
diff --git a/resolve-undo.h b/resolve-undo.h
index 4630645..05c47f7 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -1,6 +1,10 @@
 #ifndef RESOLVE_UNDO_H
 #define RESOLVE_UNDO_H
=20
+#include "cache.h"
+#include "pathspec.h"
+#include "string-list.h"
+
 struct resolve_undo_info {
 	unsigned int mode[3];
 	unsigned char sha1[3][20];
diff --git a/send-pack.h b/send-pack.h
index 8e84392..63cdc74 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -1,6 +1,9 @@
 #ifndef SEND_PACK_H
 #define SEND_PACK_H
=20
+#include "remote.h"
+#include "run-command.h"
+
 struct send_pack_args {
 	unsigned verbose:1,
 		quiet:1,
diff --git a/sequencer.h b/sequencer.h
index db43e9c..7f036cd 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -1,6 +1,8 @@
 #ifndef SEQUENCER_H
 #define SEQUENCER_H
=20
+#include "strbuf.h"
+
 #define SEQ_DIR		"sequencer"
 #define SEQ_HEAD_FILE	"sequencer/head"
 #define SEQ_TODO_FILE	"sequencer/todo"
diff --git a/shortlog.h b/shortlog.h
index de4f86f..d882a6d 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -1,6 +1,7 @@
 #ifndef SHORTLOG_H
 #define SHORTLOG_H
=20
+#include "commit.h"
 #include "string-list.h"
=20
 struct shortlog {
diff --git a/submodule.h b/submodule.h
index 7beec48..6985f6c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -1,8 +1,9 @@
 #ifndef SUBMODULE_H
 #define SUBMODULE_H
=20
-struct diff_options;
-struct argv_array;
+#include "argv-array.h"
+#include "diff.h"
+#include "string-list.h"
=20
 enum {
 	RECURSE_SUBMODULES_ON_DEMAND =3D -1,
diff --git a/tree-walk.h b/tree-walk.h
index ae7fb3a..0818126 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,6 +1,8 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
=20
+#include "strbuf.h"
+
 struct name_entry {
 	const unsigned char *sha1;
 	const char *path;
diff --git a/tree.h b/tree.h
index d84ac63..aab2213 100644
--- a/tree.h
+++ b/tree.h
@@ -1,6 +1,7 @@
 #ifndef TREE_H
 #define TREE_H
=20
+#include "cache.h"
 #include "object.h"
=20
 extern const char *tree_type;
diff --git a/unicode_width.h b/unicode_width.h
index 47cdd23..ccdd2a0 100644
--- a/unicode_width.h
+++ b/unicode_width.h
@@ -1,3 +1,13 @@
+#ifndef UNICODE_WIDTH_H
+#define UNICODE_WIDTH_H
+
+typedef unsigned int ucs_char_t;  /* assuming 32bit int */
+
+struct interval {
+	ucs_char_t first;
+	ucs_char_t last;
+};
+
 static const struct interval zero_width[] =3D {
 { 0x0300, 0x036F },
 { 0x0483, 0x0489 },
@@ -321,3 +331,5 @@ static const struct interval double_width[] =3D {
 { 0x20000, 0x2FFFD },
 { 0x30000, 0x3FFFD }
 };
+
+#endif
diff --git a/unpack-trees.h b/unpack-trees.h
index 36a73a6..e4792ec 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -1,7 +1,9 @@
 #ifndef UNPACK_TREES_H
 #define UNPACK_TREES_H
=20
+#include "cache.h"
 #include "string-list.h"
+#include "tree-walk.h"
=20
 #define MAX_UNPACK_TREES 8
=20
diff --git a/url.h b/url.h
index abdaf6f..f4a23c3 100644
--- a/url.h
+++ b/url.h
@@ -1,6 +1,8 @@
 #ifndef URL_H
 #define URL_H
=20
+#include "strbuf.h"
+
 extern int is_url(const char *url);
 extern int is_urlschemechar(int first_flag, int ch);
 extern char *url_decode(const char *url);
diff --git a/utf8.c b/utf8.c
index 401a6a5..4073857 100644
--- a/utf8.c
+++ b/utf8.c
@@ -4,11 +4,6 @@
=20
 /* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */
=20
-struct interval {
-	ucs_char_t first;
-	ucs_char_t last;
-};
-
 size_t display_mode_esc_sequence_len(const char *s)
 {
 	const char *p =3D s;
diff --git a/utf8.h b/utf8.h
index 65d0e42..e3ae27e 100644
--- a/utf8.h
+++ b/utf8.h
@@ -1,7 +1,8 @@
 #ifndef GIT_UTF8_H
 #define GIT_UTF8_H
=20
-typedef unsigned int ucs_char_t;  /* assuming 32bit int */
+#include "strbuf.h"
+#include "unicode_width.h"
=20
 size_t display_mode_esc_sequence_len(const char *s);
 int utf8_width(const char **start, size_t *remainder_p);
diff --git a/walker.h b/walker.h
index 95e5765..65166bd 100644
--- a/walker.h
+++ b/walker.h
@@ -2,6 +2,7 @@
 #define WALKER_H
=20
 #include "remote.h"
+#include "pathspec.h"
=20
 struct walker {
 	void *data;
diff --git a/wt-status.h b/wt-status.h
index 283a9fe..38f930a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include "string-list.h"
 #include "color.h"
+#include "pathspec.h"
=20
 enum color_wt_status {
 	WT_STATUS_HEADER =3D 0,
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 8b81206..d1f0e1d 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -23,6 +23,8 @@
 #if !defined(XDIFFI_H)
 #define XDIFFI_H
=20
+#include "xdiff.h"
+#include "xtypes.h"
=20
 typedef struct s_diffdata {
 	long nrec;
diff --git a/xdiff/xemit.h b/xdiff/xemit.h
index d297107..d2aed4a 100644
--- a/xdiff/xemit.h
+++ b/xdiff/xemit.h
@@ -23,6 +23,9 @@
 #if !defined(XEMIT_H)
 #define XEMIT_H
=20
+#include "xdiff.h"
+#include "xdiffi.h"
+#include "xtypes.h"
=20
 typedef int (*emit_func_t)(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t =
*ecb,
 			   xdemitconf_t const *xecfg);
diff --git a/xdiff/xprepare.h b/xdiff/xprepare.h
index 8fb06a5..2007f1b 100644
--- a/xdiff/xprepare.h
+++ b/xdiff/xprepare.h
@@ -23,7 +23,8 @@
 #if !defined(XPREPARE_H)
 #define XPREPARE_H
=20
-
+#include "xdiff.h"
+#include "xtypes.h"
=20
 int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp=
,
 		    xdfenv_t *xe);
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 4646ce5..f5eda78 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -23,7 +23,8 @@
 #if !defined(XUTILS_H)
 #define XUTILS_H
=20
-
+#include "xdiff.h"
+#include "xtypes.h"
=20
 long xdl_bogosqrt(long n);
 int xdl_emit_diffrec(char const *rec, long size, char const *pre, long=
 psize,
--=20
2.0.4.1.g929bde9
