From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] wt-status.c: make wt_status_get_state() support worktree
Date: Sun, 17 Apr 2016 19:59:23 +0700
Message-ID: <1460897965-486-6-git-send-email-pclouds@gmail.com>
References: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
 <1460897965-486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 15:00:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1armJR-0007OU-Fv
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 15:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbcDQNAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2016 09:00:21 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33527 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbcDQNAT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 09:00:19 -0400
Received: by mail-pa0-f67.google.com with SMTP id vv3so13728916pab.0
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJ8FWu485qieYLTtqn30HejhKnVcEmYcknUkbYo1Qr8=;
        b=hjcfwtZKfG9qeLWCDoRulGruXMu+gBJKUGSG4CPMkau0TeOPJ3aUiSre1+/siVdvrg
         qHsviElKTb0lVDiaCjR9xfypB9/jvurfasKi3vsIFc9fHHI1FEXrMP1k8v4j2zcoHsTW
         wLfUycvk8GWQXT0eh0oje9ucrm2J1u1SnfPz/it2SHlTuo1fSn2bs9YoigwCpMFRfK4L
         wn5emJ11SW/Hq7ZAPCdj0gMHm5BRfBTxNobFHwZql/ezY4okE01Yc8UXR/QQ1k+WPdFK
         Z31hNCT9OlDqyICZMjpY4slZM8MQJ9p4X+/Rl673c+n8jz/igbyjc6OWDSh6K/v6OezC
         flGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJ8FWu485qieYLTtqn30HejhKnVcEmYcknUkbYo1Qr8=;
        b=JgFFduUDw4ZMD0Q9GrbtZ9bOeSis8WqqgLrhEldPAPGWBaDoDLK7XwA0qDDHL7bg0w
         MYeVsAGxGTUV8BW72rCZ+blNYva9wU164yB425zBA2qcBwNAEiw/+qH74FIqvuUb78xJ
         o0GeFNH5AlZSJoE9BcMlqs6O4gD+fRc0blMso2RYOdyICAHt+2jfRdAAJulEMwdNHtRL
         +4TL0GBAAOK/O1XIAuSAk4qY1eDnV2kwpjJguD1mbnAsrs34LDQuTXVXs8+nzYhLYcj6
         h5XDjMS7zpttj3grXVexnCc+NxPx/hSvMQ/cTTHoWAlUZKX1XH59Fz1WnVlZkD0zJAkE
         H9Jw==
X-Gm-Message-State: AOPr4FXcqVjG4NtMIRh7z9bjcQnA1kILjI/cEybnM6wAk/FFNj+TCigoNYvx7cZ9vTyXTQ==
X-Received: by 10.66.177.75 with SMTP id co11mr10901193pac.85.1460898018835;
        Sun, 17 Apr 2016 06:00:18 -0700 (PDT)
Received: from lanh ([171.232.186.84])
        by smtp.gmail.com with ESMTPSA id xa4sm77042151pab.26.2016.04.17.06.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 06:00:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 17 Apr 2016 20:00:27 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460897965-486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291756>

The function is to be used to detect if a ref is checked out in another
worktree. In some cases, parsing "HEAD" alone is not enough because the
worktree may be under rebase or bisect.

Note that because get_sha1() cannot take a worktree (and of course will
not, we need something like worktree_get_sha1), cherry-pick and revert
detection will not work when the examined worktree is not the current
one. The same for get_detached_from.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 42 +++++++++++++++++++++++++-----------------
 wt-status.h |  3 +++
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 1ea2ebe..6cca3a6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -15,6 +15,7 @@
 #include "column.h"
 #include "strbuf.h"
 #include "utf8.h"
+#include "worktree.h"
=20
 static const char cut_line[] =3D
 "------------------------ >8 ------------------------\n";
@@ -1262,13 +1263,13 @@ static void show_bisect_in_progress(struct wt_s=
tatus *s,
 /*
  * Extract branch information from rebase/bisect
  */
-static char *read_and_strip_branch(const char *path)
+static char *read_and_strip_branch(const struct worktree *wt, const ch=
ar *path)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	unsigned char sha1[20];
 	const char *branch_name;
=20
-	if (strbuf_read_file(&sb, git_path("%s", path), 0) <=3D 0)
+	if (strbuf_read_file(&sb, worktree_git_path(wt, "%s", path), 0) <=3D =
0)
 		goto got_nothing;
=20
 	while (sb.len && sb.buf[sb.len - 1] =3D=3D '\n')
@@ -1363,45 +1364,52 @@ static void wt_status_get_detached_from(struct =
wt_status_state *state)
 void wt_status_get_state(struct wt_status_state *state,
 			 int get_detached_from)
 {
+	const struct worktree *wt =3D state->wt;
 	struct stat st;
 	unsigned char sha1[20];
=20
-	if (!stat(git_path_merge_head(), &st)) {
+	if (!stat(worktree_git_path_merge_head(wt), &st)) {
 		state->merge_in_progress =3D 1;
-	} else if (!stat(git_path("rebase-apply"), &st)) {
-		if (!stat(git_path("rebase-apply/applying"), &st)) {
+	} else if (!stat(worktree_git_path(wt, "rebase-apply"), &st)) {
+		if (!stat(worktree_git_path(wt, "rebase-apply/applying"), &st)) {
 			state->am_in_progress =3D 1;
-			if (!stat(git_path("rebase-apply/patch"), &st) && !st.st_size)
+			if (!stat(worktree_git_path(wt, "rebase-apply/patch"), &st) && !st.=
st_size)
 				state->am_empty_patch =3D 1;
 		} else {
 			state->rebase_in_progress =3D 1;
-			state->branch =3D read_and_strip_branch("rebase-apply/head-name");
-			state->onto =3D read_and_strip_branch("rebase-apply/onto");
+			state->branch =3D read_and_strip_branch(wt, "rebase-apply/head-name=
");
+			state->onto =3D read_and_strip_branch(wt, "rebase-apply/onto");
 		}
-	} else if (!stat(git_path("rebase-merge"), &st)) {
-		if (!stat(git_path("rebase-merge/interactive"), &st))
+	} else if (!stat(worktree_git_path(wt, "rebase-merge"), &st)) {
+		if (!stat(worktree_git_path(wt, "rebase-merge/interactive"), &st))
 			state->rebase_interactive_in_progress =3D 1;
 		else
 			state->rebase_in_progress =3D 1;
-		state->branch =3D read_and_strip_branch("rebase-merge/head-name");
-		state->onto =3D read_and_strip_branch("rebase-merge/onto");
-	} else if (!stat(git_path_cherry_pick_head(), &st) &&
+		state->branch =3D read_and_strip_branch(wt, "rebase-merge/head-name"=
);
+		state->onto =3D read_and_strip_branch(wt, "rebase-merge/onto");
+	} else if (!wt && /* TODO: get_sha1() cannot select worktree yet */
+		   !stat(worktree_git_path_cherry_pick_head(wt), &st) &&
 			!get_sha1("CHERRY_PICK_HEAD", sha1)) {
 		state->cherry_pick_in_progress =3D 1;
 		hashcpy(state->cherry_pick_head_sha1, sha1);
 	}
-	if (!stat(git_path("BISECT_LOG"), &st)) {
+	if (!stat(worktree_git_path(wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress =3D 1;
-		state->branch =3D read_and_strip_branch("BISECT_START");
+		state->branch =3D read_and_strip_branch(wt, "BISECT_START");
 	}
-	if (!stat(git_path_revert_head(), &st) &&
+	if (!wt &&  /* TODO: get_sha1() cannot select worktree yet */
+	    !stat(worktree_git_path_revert_head(wt), &st) &&
 	    !get_sha1("REVERT_HEAD", sha1)) {
 		state->revert_in_progress =3D 1;
 		hashcpy(state->revert_head_sha1, sha1);
 	}
=20
-	if (get_detached_from)
+	if (get_detached_from) {
+		if (wt)
+			die("BUG: %s:%d: non-zero get_detached_from is not supported",
+			    __FILE__, __LINE__);
 		wt_status_get_detached_from(state);
+	}
 }
=20
 static void wt_status_print_state(struct wt_status *s,
diff --git a/wt-status.h b/wt-status.h
index c9b3b74..d31db38 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -6,6 +6,8 @@
 #include "color.h"
 #include "pathspec.h"
=20
+struct worktree;
+
 enum color_wt_status {
 	WT_STATUS_HEADER =3D 0,
 	WT_STATUS_UPDATED,
@@ -77,6 +79,7 @@ struct wt_status {
 };
=20
 struct wt_status_state {
+	struct worktree *wt;
 	int merge_in_progress;
 	int am_in_progress;
 	int am_empty_patch;
--=20
2.8.0.rc0.210.gd302cd2
