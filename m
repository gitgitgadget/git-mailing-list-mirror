From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/13] wt-status.c: make wt_status_check_rebase() work on any worktree
Date: Fri, 22 Apr 2016 20:01:31 +0700
Message-ID: <1461330096-21783-9-git-send-email-pclouds@gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:02:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atajC-0007RW-9x
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbcDVNCa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:02:30 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35006 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbcDVNC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:02:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so10136883pfr.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGJWybuwHG4JMYyjVTDKalFY3TyvIRoqi8gKQ3I7ECU=;
        b=ENsPfzdG4LBBa4pnw/ctLHVHxamUGQ9SBaxFw3u6fJFqKDMbNFIuZ38aLXWIbZOSON
         z2J0WpCtBbjyBo+ZzdA4hWLIgbI3mIBIGLLxPPtwEX4HjkDtFLfYLCC/5ku586++6z7W
         W7Xv/nbaI5g3fmtJ6moG7VJi+hAc6IhTtmycd2Pc1Lbbs19GlZhhPnWRNGuxMcgAJyG4
         vHuqD+O8AW0mRZf4wVMUzBAAmSihzpbcqAoTGKV4D+ctSQOIdW6BFJWrzp/QMHjWcXN6
         kmy4ELyZv/6yCojYrj3Vt2zgsslur7hfxyevZYgkSiWVg2BdBVfwpE3kfgRgyP3pQZTz
         SyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGJWybuwHG4JMYyjVTDKalFY3TyvIRoqi8gKQ3I7ECU=;
        b=So9dvHUjBov08IkJsy9jyEJjPwCIKyVTqCc9Tv4bupnoKFENqTFhOQeh4xW5mDcfTe
         wvyE3q5t9yiNPQdZ2pwjH3LRBA+bAo4wrOt6/p9X/LE1Zg/TiO45WkrIKlY8WM8Rp7mk
         kOO7sPgnQ6icN7gHC51xLADsf6/697O4VB4+OPtDx0d9FAt81pi+NvfivxyK0YRTEiZz
         VYJmXy4s7DGSCwNBTOTayV3b1U6QtLO6EXDlgrDmhZLi+fkUSJqbyjMYAqVlRigtAqZx
         ii40sWdswkjkTOe50xVuv7933v9sQc0r9lMAg0v3mI+oezGKpMQuXwtkLxoscNJQcZog
         RTPA==
X-Gm-Message-State: AOPr4FX65kK2jCoVWTEbSFaEnea+7trfRS5jBYOBWuc77izZLBtqW4BrtDEY0sjcbpaEGA==
X-Received: by 10.98.52.5 with SMTP id b5mr28335155pfa.9.1461330148501;
        Fri, 22 Apr 2016 06:02:28 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id r65sm8471151pfa.27.2016.04.22.06.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:02:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:02:41 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292197>

This is a preparation step for find_shared_symref() to detect if any
worktree is being rebased.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 33 ++++++++++++++++++++-------------
 wt-status.h |  5 ++++-
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ec9240d..ce5080c 100644
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
+static char *get_branch(const struct worktree *wt, const char *path)
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
@@ -1295,6 +1296,11 @@ got_nothing:
 	return NULL;
 }
=20
+static char *read_and_strip_branch(const char *path)
+{
+	return get_branch(NULL, path);
+}
+
 struct grab_1st_switch_cbdata {
 	struct strbuf buf;
 	unsigned char nsha1[20];
@@ -1360,27 +1366,28 @@ static void wt_status_get_detached_from(struct =
wt_status_state *state)
 	strbuf_release(&cb.buf);
 }
=20
-int wt_status_check_rebase(struct wt_status_state *state)
+int wt_status_check_rebase(const struct worktree *wt,
+			   struct wt_status_state *state)
 {
 	struct stat st;
=20
-	if (!stat(git_path("rebase-apply"), &st)) {
-		if (!stat(git_path("rebase-apply/applying"), &st)) {
+	if (!stat(worktree_git_path(wt, "rebase-apply"), &st)) {
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
+			state->branch =3D get_branch(wt, "rebase-apply/head-name");
+			state->onto =3D get_branch(wt, "rebase-apply/onto");
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
+		state->branch =3D get_branch(wt, "rebase-merge/head-name");
+		state->onto =3D get_branch(wt, "rebase-merge/onto");
 	} else
 		return 0;
 	return 1;
@@ -1394,7 +1401,7 @@ void wt_status_get_state(struct wt_status_state *=
state,
=20
 	if (!stat(git_path_merge_head(), &st)) {
 		state->merge_in_progress =3D 1;
-	} else if (wt_status_check_rebase(state)) {
+	} else if (wt_status_check_rebase(NULL, state)) {
 		;		/* all set */
 	} else if (!stat(git_path_cherry_pick_head(), &st) &&
 			!get_sha1("CHERRY_PICK_HEAD", sha1)) {
diff --git a/wt-status.h b/wt-status.h
index b398353..c4ddcad 100644
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
@@ -100,7 +102,8 @@ void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 void wt_status_get_state(struct wt_status_state *state, int get_detach=
ed_from);
-int wt_status_check_rebase(struct wt_status_state *state);
+int wt_status_check_rebase(const struct worktree *wt,
+			   struct wt_status_state *state);
=20
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
--=20
2.8.0.rc0.210.gd302cd2
