From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 28/32] gc: support prune --worktrees
Date: Sun, 21 Sep 2014 17:43:30 +0700
Message-ID: <20140921104330.GA10475@lanh>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-29-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 12:43:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVecP-00074w-76
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 12:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbaIUKng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2014 06:43:36 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:51329 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaIUKnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 06:43:35 -0400
Received: by mail-pa0-f41.google.com with SMTP id ey11so3132661pad.28
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3yT6mTKHT+TFM6+8Ql0b6D8agGTZI+jBfV7TFCvi+Ik=;
        b=uBcZApCIC0yYJhH0wDE1KtMyI7ZzNTaov6JYanPtRks+bhXNXTlE5o70FiExSRekN6
         cQdW6nRqWyrN3+8o2bxFDEaEjcGwFazU5qr8fgcKfyLnzQS47KjJnAl5jfMDrm4tHcUl
         5zlUNb2DLlGqT9AYWd0jLeX6fx9HO5p4Cd1tjSQAceqpFEAXbXvEgSXB/9HQHKhAut2J
         m1nfT394kP/M55YxT8NqRXmcffQsQj/wK8Q84niFmQ/4ZZmsJAZ34nYWQfl4I094gMEx
         4rkYkrK6YmC16kDDarX03GaMOAVqVvwwRcHCMq9SIFyE/IiAI7Rpx8U6v9KlpvgsCAsF
         0E1A==
X-Received: by 10.67.14.165 with SMTP id fh5mr17066524pad.2.1411296213739;
        Sun, 21 Sep 2014 03:43:33 -0700 (PDT)
Received: from lanh ([115.73.239.77])
        by mx.google.com with ESMTPSA id q1sm6484027pdq.67.2014.09.21.03.43.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Sep 2014 03:43:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 21 Sep 2014 17:43:30 +0700
Content-Disposition: inline
In-Reply-To: <1410388928-32265-29-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257351>

And this is the update as suggested in 23/32 [1]

[1] http://thread.gmane.org/gmane.comp.version-control.git/256210/focus=
=3D256849

-- 8< --
Subject: [PATCH] gc: support prune --worktrees

Helped-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt       |  7 +++++++
 Documentation/git-checkout.txt | 11 +++++++----
 builtin/gc.c                   | 10 ++++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 98b8ef0..8351c8a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1212,6 +1212,13 @@ gc.pruneexpire::
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
index 0fd3bab..6c14710 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -435,8 +435,11 @@ $GIT_DIR or $GIT_COMMON_DIR when you need to direc=
tly access something
 inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
=20
 When you are done with a linked working tree you can simply delete it.
-You can clean up any stale $GIT_DIR/worktrees entries via `git prune
---worktrees` in the main worktree or any linked worktree.
+The working tree's entry in the repository's $GIT_DIR/worktrees
+directory will eventually be removed automatically (see
+`gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
+`git prune --worktrees` in the main worktree or any linked worktree to
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
index 849a87c..35542f3 100644
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



-- 8< --
