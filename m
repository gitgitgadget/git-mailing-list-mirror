From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 3/3] clone: Free a few paths
Date: Mon, 14 Mar 2011 20:18:38 +0100
Message-ID: <1300130318-11279-4-git-send-email-cmn@elego.de>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 20:28:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDRm-0004Lj-J9
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab1CNT2r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 15:28:47 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:51619 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570Ab1CNT2p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 15:28:45 -0400
Received: from bee.lab.cmartin.tk (brln-4dbc728c.pool.mediaWays.net [77.188.114.140])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 798E3460FF;
	Mon, 14 Mar 2011 20:18:54 +0100 (CET)
Received: (nullmailer pid 11316 invoked by uid 1000);
	Mon, 14 Mar 2011 19:18:39 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1300130318-11279-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169011>

=46ree the path, repo, dir buffers

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/clone.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 60d9a64..d90770a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -365,8 +365,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 {
 	int is_bundle =3D 0, is_local;
 	struct stat buf;
-	const char *repo_name, *repo, *work_tree, *git_dir;
-	char *path, *dir;
+	const char *repo_name, *work_tree, *git_dir;
+	char *path, *dir, *repo;
 	int dest_exists;
 	const struct ref *refs, *remote_head;
 	const struct ref *remote_head_points_at;
@@ -415,7 +415,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	else if (!strchr(repo_name, ':'))
 		repo =3D xstrdup(make_absolute_path(repo_name));
 	else
-		repo =3D repo_name;
+		repo =3D xstrdup(repo_name);
 	is_local =3D path && !is_bundle;
 	if (is_local && option_depth)
 		warning("--depth is ignored in local clones; use file:// instead.");
@@ -665,6 +665,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			err =3D run_command_v_opt(argv_submodule, RUN_GIT_CMD);
 	}
=20
+	free(dir);
+	free(repo);
+	free(path);
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
--=20
1.7.4.1
