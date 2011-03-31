From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 2/2] cmd_clone: make sure repo is allocated on the stack and free it
Date: Thu, 31 Mar 2011 16:18:42 +0200
Message-ID: <1301581122-19947-2-git-send-email-cmn@elego.de>
References: <1301581122-19947-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 16:18:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Ii4-00027l-KT
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 16:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757891Ab1CaOSp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 10:18:45 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:45851 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757881Ab1CaOSo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 10:18:44 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 4FDE54611E;
	Thu, 31 Mar 2011 16:18:33 +0200 (CEST)
Received: (nullmailer pid 19996 invoked by uid 1000);
	Thu, 31 Mar 2011 14:18:42 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301581122-19947-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170492>

Make sure that the buffer repo points to is in the stack and free it
afterwards.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/clone.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index fe0408c..697b1bf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -415,7 +415,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	else if (!strchr(repo_name, ':'))
 		die("repository '%s' does not exist", repo_name);
 	else
-		repo =3D repo_name;
+		repo =3D xstrdup(repo_name);
 	is_local =3D path && !is_bundle;
 	if (is_local && option_depth)
 		warning("--depth is ignored in local clones; use file:// instead.");
@@ -667,6 +667,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	free(dir);
 	free(path);
+	free(repo);
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
--=20
1.7.4.1
