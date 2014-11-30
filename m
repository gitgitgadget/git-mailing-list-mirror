From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/34] gc: support prune --worktrees
Date: Sun, 30 Nov 2014 15:24:53 +0700
Message-ID: <1417335899-27307-29-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:30:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuztK-0000Vo-16
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbaK3I36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:29:58 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:57693 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbaK3I35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:29:57 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so9055221pad.24
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UpCE6m6pCLPXu2xLDFwMpHMM6Dry6B3LdVR0Wda4lSc=;
        b=0xmHEXbkT7ngdmuJSqR1q8UWVKRiw4b0nT7XvfV+9u4NfxMVmtJ8tQbyx60vJrE4gU
         dKsbze4lUSOHtgPXs1oVuUSpD+zBJ6uySnbyWSNHTF4/00ZPUKZaFrYKAYj5qa41dk86
         xByF34R/TAN9tBwJXdZqNRY2lA+lQUzvRV4pZ9fFIr7+CsV2eji+q8Hdy16KVEK73bQl
         dyRGpkjHezqWcyWnZZABIhWBsNlv8tfMviarlj3nY9MmENPeg9MEfeXIdnQh5tOPwW/m
         maZ/c6c/TZaisv++Fi/N8Uf8l1RSwmHAKfVpmuN3x2SMRvcCm7k0BGptIHURjXI7yFJK
         TwVA==
X-Received: by 10.68.109.3 with SMTP id ho3mr89263031pbb.74.1417336197297;
        Sun, 30 Nov 2014 00:29:57 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id a13sm11638363pdm.44.2014.11.30.00.29.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:29:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:29:55 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260415>

Helped-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt       |  7 +++++++
 Documentation/git-checkout.txt | 11 +++++++----
 builtin/gc.c                   | 10 ++++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e1623ec..2700a1b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1229,6 +1229,13 @@ gc.pruneexpire::
 	"now" may be used to disable this  grace period and always prune
 	unreachable objects immediately.
=20
+gc.pruneworktreesexpire::
+	When 'git gc' is run, it will call
+	'prune --worktrees --expire 3.months.ago'.
+	Override the grace period with this config variable. The value
+	"now" may be used to disable the grace period and prune
+	$GIT_DIR/worktrees immediately.
+
 gc.reflogexpire::
 gc.<pattern>.reflogexpire::
 	'git reflog expire' removes reflog entries older than
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 35675da..0c13825 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -435,8 +435,11 @@ $GIT_DIR or $GIT_COMMON_DIR when you need to direc=
tly access something
 inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
=20
 When you are done with a linked working tree you can simply delete it.
-You can clean up any stale $GIT_DIR/worktrees entries via `git prune
---worktrees` in the main or any linked working tree.
+The working tree's entry in the repository's $GIT_DIR/worktrees
+directory will eventually be removed automatically (see
+`gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
+`git prune --worktrees` in the main or any linked working tree to
+clean up any stale entries in $GIT_DIR/worktrees.
=20
 If you move a linked working directory to another file system, or
 within a file system that does not support hard links, you need to run
@@ -444,8 +447,8 @@ at least one git command inside the linked working =
directory
 (e.g. `git status`) in order to update its entry in $GIT_DIR/worktrees
 so that it does not get automatically removed.
=20
-To prevent `git prune --worktrees` from deleting a $GIT_DIR/worktrees
-entry (which can be useful in some situations, such as when the
+To prevent a $GIT_DIR/worktrees entry from from being pruned (which
+can be useful in some situations, such as when the
 entry's working tree is stored on a portable device), add a file named
 'locked' to the entry's directory. The file contains the reason in
 plain text. For example, if a linked working tree's `.git` file points
diff --git a/builtin/gc.c b/builtin/gc.c
index 0728650..fa87ad3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -33,11 +33,13 @@ static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
 static int detach_auto =3D 1;
 static const char *prune_expire =3D "2.weeks.ago";
+static const char *prune_worktrees_expire =3D "3.months.ago";
=20
 static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
 static struct argv_array reflog =3D ARGV_ARRAY_INIT;
 static struct argv_array repack =3D ARGV_ARRAY_INIT;
 static struct argv_array prune =3D ARGV_ARRAY_INIT;
+static struct argv_array prune_worktrees =3D ARGV_ARRAY_INIT;
 static struct argv_array rerere =3D ARGV_ARRAY_INIT;
=20
 static char *pidfile;
@@ -83,6 +85,7 @@ static void gc_config(void)
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_date_string("gc.pruneexpire", &prune_expire);
+	git_config_date_string("gc.pruneworktreesexpire", &prune_worktrees_ex=
pire);
 	git_config(git_default_config, NULL);
 }
=20
@@ -290,6 +293,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
 	argv_array_pushl(&prune, "prune", "--expire", NULL);
+	argv_array_pushl(&prune_worktrees, "prune", "--worktrees", "--expire"=
, NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
=20
 	gc_config();
@@ -359,6 +363,12 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 			return error(FAILED_RUN, prune.argv[0]);
 	}
=20
+	if (prune_worktrees_expire) {
+		argv_array_push(&prune_worktrees, prune_worktrees_expire);
+		if (run_command_v_opt(prune_worktrees.argv, RUN_GIT_CMD))
+			return error(FAILED_RUN, prune_worktrees.argv[0]);
+	}
+
 	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, rerere.argv[0]);
=20
--=20
2.1.0.rc0.78.gc0d8480
