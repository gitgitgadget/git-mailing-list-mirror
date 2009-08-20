From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 03/19] Introduce "skip-worktree" bit in index, teach Git to get/set this bit
Date: Thu, 20 Aug 2009 20:46:57 +0700
Message-ID: <1250776033-12395-4-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81B-0007ZS-RA
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbZHTNri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754613AbZHTNri
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:47:38 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:54197 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbZHTNrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:47:37 -0400
Received: by mail-px0-f196.google.com with SMTP id 34so3268834pxi.4
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PFoBVVrGpcjyzrf79x252f+UeVpZDcMqTtI73MqTLfY=;
        b=mFStex2ar9seTPObzS8eYlQ7YqiITWL4oZNHmfkPbQDdtm7MH6uhmY532gc3tBthjK
         MX9nI1fJm4wgbYvRnI7smF+xg2xr+yFGM3lTX5ZF9g4maHgNqXP42AQcaJbOiNyGgwlc
         maWHgfxI/Wtg5bTTKzzT0ALkRT9SGkQkbkEaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gPbQ6BBeYM4uKPcnlJ598E7U39w8yvffBnHDSY8JsiKRdq8/jjyo7tfopLkbtR2yGc
         JqBmNGg3LV6Y3YBpejMNvIiOVLpjWGKZNIYPVYianEtQIaRM3qZ8UB33WrVOw15diUS4
         Nu6xqXS4yn8HUPJZItIm6jORN2Z3MntL/wrmY=
Received: by 10.115.103.9 with SMTP id f9mr9201839wam.227.1250776058886;
        Thu, 20 Aug 2009 06:47:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 21sm185915pzk.3.2009.08.20.06.47.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:47:38 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:47:31 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126624>

Detail about this bit is in Documentation/git-update-index.txt.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt        |    1 +
 Documentation/git-update-index.txt    |   29 +++++++++++++++++
 builtin-ls-files.c                    |    5 ++-
 builtin-update-index.c                |   16 +++++++++-
 cache.h                               |    4 ++-
 t/t2104-update-index-skip-worktree.sh |   57 +++++++++++++++++++++++++=
++++++++
 6 files changed, 109 insertions(+), 3 deletions(-)
 create mode 100755 t/t2104-update-index-skip-worktree.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index 021066e..6f9d880 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -107,6 +107,7 @@ OPTIONS
 	Identify the file status with the following tags (followed by
 	a space) at the start of each line:
 	H::	cached
+	S::	skip-worktree
 	M::	unmerged
 	R::	removed/deleted
 	C::	modified/changed
diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index 25e0bbe..a10f355 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	     [--cacheinfo <mode> <object> <file>]\*
 	     [--chmod=3D(+|-)x]
 	     [--assume-unchanged | --no-assume-unchanged]
+	     [--skip-worktree | --no-skip-worktree]
 	     [--ignore-submodules]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
@@ -99,6 +100,13 @@ in the index e.g. when merging in a commit;
 thus, in case the assumed-untracked file is changed upstream,
 you will need to handle the situation manually.
=20
+--skip-worktree::
+--no-skip-worktree::
+	When one of these flags is specified, the object name recorded
+	for the paths are not updated. Instead, these options
+	set and unset the "skip-worktree" bit for the paths. See
+	section "Skip-worktree bit" below for more information.
+
 -g::
 --again::
 	Runs 'git-update-index' itself on the paths whose index
@@ -304,6 +312,27 @@ M foo.c
 <9> now it checks with lstat(2) and finds it has been changed.
=20
=20
+Skip-worktree bit
+-----------------
+
+Skip-worktree bit can be defined in one (long) sentence: When reading
+an entry, if it is marked as skip-worktree, then Git pretends its
+working directory version is up to date and read the index version
+instead.
+
+To elaborate, "reading" means checking for file existence, reading
+file attributes or file content. The working directory version may be
+present or absent. If present, its content may match against the index
+version or not. Writing is not affected by this bit, content safety
+is still first priority. Note that Git _can_ update working directory
+file, that is marked skip-worktree, if it is safe to do so (i.e.
+working directory version matches index version)
+
+Although this bit looks similar to assume-unchanged bit, its goal is
+different from assume-unchanged bit's. Skip-worktree also takes
+precedence over assume-unchanged bit when both are set.
+
+
 Configuration
 -------------
=20
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f473220..c1afbad 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -37,6 +37,7 @@ static const char *tag_removed =3D "";
 static const char *tag_other =3D "";
 static const char *tag_killed =3D "";
 static const char *tag_modified =3D "";
+static const char *tag_skip_worktree =3D "";
=20
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
@@ -178,7 +179,8 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
-			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
+			show_ce_entry(ce_stage(ce) ? tag_unmerged :
+				(ce_skip_worktree(ce) ? tag_skip_worktree : tag_cached), ce);
 		}
 	}
 	if (show_deleted | show_modified) {
@@ -490,6 +492,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		tag_modified =3D "C ";
 		tag_other =3D "? ";
 		tag_killed =3D "K ";
+		tag_skip_worktree =3D "S ";
 	}
 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_=
SHOW_IGNORED) || show_killed)
 		require_work_tree =3D 1;
diff --git a/builtin-update-index.c b/builtin-update-index.c
index f1b6c8e..5e97d09 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -24,6 +24,7 @@ static int info_only;
 static int force_remove;
 static int verbose;
 static int mark_valid_only;
+static int mark_skip_worktree_only;
 #define MARK_FLAG 1
 #define UNMARK_FLAG 2
=20
@@ -276,6 +277,11 @@ static void update_one(const char *path, const cha=
r *prefix, int prefix_length)
 			die("Unable to mark file %s", path);
 		goto free_return;
 	}
+	if (mark_skip_worktree_only) {
+		if (mark_ce_flags(p, CE_SKIP_WORKTREE, mark_skip_worktree_only =3D=3D=
 MARK_FLAG))
+			die("Unable to mark file %s", path);
+		goto free_return;
+	}
=20
 	if (force_remove) {
 		if (remove_file_from_cache(p))
@@ -384,7 +390,7 @@ static void read_index_info(int line_termination)
 }
=20
 static const char update_index_usage[] =3D
-"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--=
refresh] [--really-refresh] [--cacheinfo] [--chmod=3D(+|-)x] [--assume-=
unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--u=
nresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file=
>...";
+"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--=
refresh] [--really-refresh] [--cacheinfo] [--chmod=3D(+|-)x] [--assume-=
unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-=
remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore=
-missing] [-z] [--verbose] [--] <file>...";
=20
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
@@ -650,6 +656,14 @@ int cmd_update_index(int argc, const char **argv, =
const char *prefix)
 				mark_valid_only =3D UNMARK_FLAG;
 				continue;
 			}
+			if (!strcmp(path, "--no-skip-worktree")) {
+				mark_skip_worktree_only =3D UNMARK_FLAG;
+				continue;
+			}
+			if (!strcmp(path, "--skip-worktree")) {
+				mark_skip_worktree_only =3D MARK_FLAG;
+				continue;
+			}
 			if (!strcmp(path, "--info-only")) {
 				info_only =3D 1;
 				continue;
diff --git a/cache.h b/cache.h
index f793789..3b0e5fc 100644
--- a/cache.h
+++ b/cache.h
@@ -181,10 +181,11 @@ struct cache_entry {
  * Extended on-disk flags
  */
 #define CE_INTENT_TO_ADD 0x20000000
+#define CE_SKIP_WORKTREE 0x40000000
 /* CE_EXTENDED2 is for future extension */
 #define CE_EXTENDED2 0x80000000
=20
-#define CE_EXTENDED_FLAGS (CE_INTENT_TO_ADD)
+#define CE_EXTENDED_FLAGS (CE_INTENT_TO_ADD | CE_SKIP_WORKTREE)
=20
 /*
  * Safeguard to avoid saving wrong flags:
@@ -233,6 +234,7 @@ static inline size_t ce_namelen(const struct cache_=
entry *ce)
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 #define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT=
)
 #define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
+#define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |=3D CE_UPTODATE)
=20
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-ind=
ex-skip-worktree.sh
new file mode 100755
index 0000000..1d0879b
--- /dev/null
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
+#
+
+test_description=3D'skip-worktree bit test'
+
+. ./test-lib.sh
+
+cat >expect.full <<EOF
+H 1
+H 2
+H sub/1
+H sub/2
+EOF
+
+cat >expect.skip <<EOF
+S 1
+H 2
+S sub/1
+H sub/2
+EOF
+
+test_expect_success 'setup' '
+	mkdir sub &&
+	touch ./1 ./2 sub/1 sub/2 &&
+	git add 1 2 sub/1 sub/2 &&
+	git ls-files -t | test_cmp expect.full -
+'
+
+test_expect_success 'index is at version 2' '
+	test "$(test-index-version < .git/index)" =3D 2
+'
+
+test_expect_success 'update-index --skip-worktree' '
+	git update-index --skip-worktree 1 sub/1 &&
+	git ls-files -t | test_cmp expect.skip -
+'
+
+test_expect_success 'index is at version 3 after having some skip-work=
tree entries' '
+	test "$(test-index-version < .git/index)" =3D 3
+'
+
+test_expect_success 'ls-files -t' '
+	git ls-files -t | test_cmp expect.skip -
+'
+
+test_expect_success 'update-index --no-skip-worktree' '
+	git update-index --no-skip-worktree 1 sub/1 &&
+	git ls-files -t | test_cmp expect.full -
+'
+
+test_expect_success 'index version is back to 2 when there is no skip-=
worktree entry' '
+	test "$(test-index-version < .git/index)" =3D 2
+'
+
+test_done
--=20
1.6.3.GIT
