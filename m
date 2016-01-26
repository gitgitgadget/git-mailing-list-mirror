From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/6] path.c: new (identical) list for worktree v1
Date: Tue, 26 Jan 2016 18:44:41 +0700
Message-ID: <1453808685-21235-3-git-send-email-pclouds@gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, max@max630.net,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 12:45:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO23u-0005Ni-3G
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 12:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbcAZLp1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 06:45:27 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36368 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934260AbcAZLpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 06:45:25 -0500
Received: by mail-pa0-f65.google.com with SMTP id a20so7830241pag.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 03:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iU6n0xiE7mVZWCNOdpqDCbd6OOZmX1LEe4M/iFZxm+U=;
        b=gDMglrs74J33KI28GCm/kblsVk5C51+RYdgTo3U0ichXAzXpxPN+esqWoozs2cTv6i
         XJDpdrQEmx/5C4VUBcQWeCyjYC34wQ+GCHZJquueXE0QD2jGmGBtEpFHwzCCFILb5cBl
         ooy20Xsmo3RerV0nz8P5yxGXU8P5z0ehp6pYY1WBbtmyMxUPgUvBo9OwXiI1SnwGZm/n
         ACNfq8NQ1ExKkULMUFcnfpMMAtkMMG55dphFiiHprNhYdwe2+rLs7LY3FUCfTjSaB7F1
         zfD7VHMyjkPxcvRWptr5ALCnjHcGLIIHHupHeY8k7buIGh7Wm1cZw/PpvZr/cGDRFDz/
         I3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=iU6n0xiE7mVZWCNOdpqDCbd6OOZmX1LEe4M/iFZxm+U=;
        b=dOZRg/34lPefGD+By6ezQ57sX4PFRC8qafjVHu+jR3g5hwDDHrzuAM/D1arq5CkpAG
         kMtYk/ZEPLyY9KCMxg6tkFl9zSgI0xQdR27l8PRqYxuSThXbltey/f9zdDZEg5rONjb7
         yUbxP+B3JzB9kHiPLaPG72L/CYzVyhQL7iw+PyqNZrQbk1/Bg3VwJzEz0ktazDdEq17x
         Z/EYTXpvQJ/hLw8nZFQyum1Wa99g+/OK2lyiON1VChAk2Nvk5bxgubSFW1V55Y4ZGMY7
         SZcAlNvz7ovgqje2IDGP3NVK7xAqWSquhmW9YI9/4IZU1jYJpTbSCksnx8La1dDQK4IL
         uqzw==
X-Gm-Message-State: AG10YOQcdGQkwXMBdnpvU3yTwKW/DXPAlvbYguuKeaVpQXv/+Ge6jkoQLVbhD5VwC0aOQA==
X-Received: by 10.66.234.200 with SMTP id ug8mr33422665pac.129.1453808724744;
        Tue, 26 Jan 2016 03:45:24 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id n84sm1478592pfa.45.2016.01.26.03.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 03:45:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 26 Jan 2016 18:45:27 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453808685-21235-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284806>

Worktree v1 may have different .git file split than v0. Add support
code to change common file list based on extensions.worktree. The list
for now is identical to v0.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/path.c b/path.c
index 3cd155e..14adf5d 100644
--- a/path.c
+++ b/path.c
@@ -100,7 +100,7 @@ struct common_dir {
 	const char *dirname;
 };
=20
-static struct common_dir common_list[] =3D {
+static struct common_dir common_list_v0[] =3D {
 	{ 0, 1, 0, "branches" },
 	{ 0, 1, 0, "hooks" },
 	{ 0, 1, 0, "info" },
@@ -123,6 +123,40 @@ static struct common_dir common_list[] =3D {
 	{ 0, 0, 0, NULL }
 };
=20
+static struct common_dir common_list_v1[] =3D {
+	{ 0, 1, 0, "branches" },
+	{ 0, 1, 0, "hooks" },
+	{ 0, 1, 0, "info" },
+	{ 0, 0, 1, "info/sparse-checkout" },
+	{ 1, 1, 0, "logs" },
+	{ 1, 1, 1, "logs/HEAD" },
+	{ 0, 1, 1, "logs/refs/bisect" },
+	{ 0, 1, 0, "lost-found" },
+	{ 0, 1, 0, "objects" },
+	{ 0, 1, 0, "refs" },
+	{ 0, 1, 1, "refs/bisect" },
+	{ 0, 1, 0, "remotes" },
+	{ 0, 1, 0, "worktrees" },
+	{ 0, 1, 0, "rr-cache" },
+	{ 0, 1, 0, "svn" },
+	{ 0, 0, 0, "config" },
+	{ 1, 0, 0, "gc.pid" },
+	{ 0, 0, 0, "packed-refs" },
+	{ 0, 0, 0, "shallow" },
+	{ 0, 0, 0, NULL }
+};
+
+static struct common_dir *get_common_list(void)
+{
+	switch (repository_format_worktree_version) {
+	case 0: return common_list_v0;
+	case 1: return common_list_v1;
+	default:
+		die(_("unsupported worktree format version %d"),
+		    repository_format_worktree_version);
+	}
+}
+
 /*
  * A compressed trie.  A trie node consists of zero or more characters=
 that
  * are common to all elements with this prefix, optionally followed by=
 some
@@ -309,7 +343,7 @@ static void init_common_trie(void)
 	if (common_trie_done_setup)
 		return;
=20
-	for (p =3D common_list; p->dirname; p++)
+	for (p =3D get_common_list(); p->dirname; p++)
 		add_to_trie(&common_trie, p->dirname, p);
=20
 	common_trie_done_setup =3D 1;
@@ -356,7 +390,7 @@ void report_linked_checkout_garbage(void)
 		return;
 	strbuf_addf(&sb, "%s/", get_git_dir());
 	len =3D sb.len;
-	for (p =3D common_list; p->dirname; p++) {
+	for (p =3D get_common_list(); p->dirname; p++) {
 		const char *path =3D p->dirname;
 		if (p->ignore_garbage)
 			continue;
--=20
2.7.0.288.g1d8ad15
