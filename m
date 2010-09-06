From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] tree-walk: copy tree_entry_interesting() as is from tree-diff.c
Date: Mon,  6 Sep 2010 14:47:07 +1000
Message-ID: <1283748429-31076-3-git-send-email-pclouds@gmail.com>
References: <1283645647-1891-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 06:47:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsTcG-0001Nt-PU
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 06:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052Ab0IFErb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 00:47:31 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46509 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab0IFErb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 00:47:31 -0400
Received: by pvg2 with SMTP id 2so1336301pvg.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 21:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ah9/jp+LYnPDw0iaG/i68zev5QijdseTpgysNqSxXXE=;
        b=lRCGMKI/pGwbRv/lzWnJc42r6ncMjWi0dS80ZjjuKSLeP94qMMiWkOPp0Vo+o/U6YB
         CyLuMpF2e++ftIfw4QuuA6fscnIqMtLdR9g0ns8fud4AuEdmFCYFKW70t4dwS6uNYDUO
         tL+b/DcnGaiTAV4TXcujEZjYRjgwD2Ab5H9Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xN2ldU1FxEJ3TqaFmSAUseafcl+8BU+86qO5NNynzOPxGk7oXgZtp/bgblV8TIdtlx
         fu7UJUuY1PfYj5+Q894gF+tcHqbAcUKDZb+Fj2X5O7whqtH84cbeeNoyhGxnNgXFCNjA
         ZYlG90/YlbH68onMAi4exVYoivzhFId3irHsw=
Received: by 10.142.213.3 with SMTP id l3mr2114695wfg.6.1283748450635;
        Sun, 05 Sep 2010 21:47:30 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id t11sm3647070wfc.22.2010.09.05.21.47.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 21:47:29 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  6 Sep 2010 14:47:23 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283645647-1891-8-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155522>

Just a straight copy. The function is not used anywhere. It is to
separate changes that will be made to this function in the next patch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-walk.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index a9bbf4e..bc83fa3 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "tree.h"
+#include "diff.h"
=20
 static const char *get_mode(const char *str, unsigned int *modep)
 {
@@ -455,3 +456,117 @@ int get_tree_entry(const unsigned char *tree_sha1=
, const char *name, unsigned ch
 	free(tree);
 	return retval;
 }
+
+/*
+ * Is a tree entry interesting given the pathspec we have?
+ *
+ * Return:
+ *  - 2 for "yes, and all subsequent entries will be"
+ *  - 1 for yes
+ *  - zero for no
+ *  - negative for "no, and no subsequent entries will be either"
+ */
+static int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt)
+{
+	const char *path;
+	const unsigned char *sha1;
+	unsigned mode;
+	int i;
+	int pathlen;
+	int never_interesting =3D -1;
+
+	if (!opt->nr_paths)
+		return 1;
+
+	sha1 =3D tree_entry_extract(desc, &path, &mode);
+
+	pathlen =3D tree_entry_len(path, sha1);
+
+	for (i =3D 0; i < opt->nr_paths; i++) {
+		const char *match =3D opt->paths[i];
+		int matchlen =3D opt->pathlens[i];
+		int m =3D -1; /* signals that we haven't called strncmp() */
+
+		if (baselen >=3D matchlen) {
+			/* If it doesn't match, move along... */
+			if (strncmp(base, match, matchlen))
+				continue;
+
+			/*
+			 * If the base is a subdirectory of a path which
+			 * was specified, all of them are interesting.
+			 */
+			if (!matchlen ||
+			    base[matchlen] =3D=3D '/' ||
+			    match[matchlen - 1] =3D=3D '/')
+				return 2;
+
+			/* Just a random prefix match */
+			continue;
+		}
+
+		/* Does the base match? */
+		if (strncmp(base, match, baselen))
+			continue;
+
+		match +=3D baselen;
+		matchlen -=3D baselen;
+
+		if (never_interesting) {
+			/*
+			 * We have not seen any match that sorts later
+			 * than the current path.
+			 */
+
+			/*
+			 * Does match sort strictly earlier than path
+			 * with their common parts?
+			 */
+			m =3D strncmp(match, path,
+				    (matchlen < pathlen) ? matchlen : pathlen);
+			if (m < 0)
+				continue;
+
+			/*
+			 * If we come here even once, that means there is at
+			 * least one pathspec that would sort equal to or
+			 * later than the path we are currently looking at.
+			 * In other words, if we have never reached this point
+			 * after iterating all pathspecs, it means all
+			 * pathspecs are either outside of base, or inside the
+			 * base but sorts strictly earlier than the current
+			 * one.  In either case, they will never match the
+			 * subsequent entries.  In such a case, we initialized
+			 * the variable to -1 and that is what will be
+			 * returned, allowing the caller to terminate early.
+			 */
+			never_interesting =3D 0;
+		}
+
+		if (pathlen > matchlen)
+			continue;
+
+		if (matchlen > pathlen) {
+			if (match[pathlen] !=3D '/')
+				continue;
+			if (!S_ISDIR(mode))
+				continue;
+		}
+
+		if (m =3D=3D -1)
+			/*
+			 * we cheated and did not do strncmp(), so we do
+			 * that here.
+			 */
+			m =3D strncmp(match, path, pathlen);
+
+		/*
+		 * If common part matched earlier then it is a hit,
+		 * because we rejected the case where path is not a
+		 * leading directory and is shorter than match.
+		 */
+		if (!m)
+			return 1;
+	}
+	return never_interesting; /* No matches */
+}
--=20
1.7.1.rc1.69.g24c2f7
