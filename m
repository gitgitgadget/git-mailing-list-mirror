From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/47] Add t1510 and basic rules that run repo setup
Date: Fri, 26 Nov 2010 22:31:58 +0700
Message-ID: <1290785563-15339-3-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:34:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0K0-0000mL-FN
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab0KZPen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:34:43 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53916 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0KZPem (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:34:42 -0500
Received: by pzk6 with SMTP id 6so348637pzk.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=54bX5VNJgUP/lgYtviNf235xxppLBcvfxe8XWai8e98=;
        b=ABSneRXXZ1ud0tkmSb0/1qU+Lr09uPaFsVrrr3Fb7HUyTHBvN7nC9oTKjnxn2g++xK
         iDsMVTQZCoDvHN6bOGif4mNg/4DvHOJsnPPax+2k4aSFvwXBs1ijQSrkmHeSXQlhLUAr
         aqYzBfh2Bdys5kKd7M86EPOvpauuHq/mS7k1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Hf4cZztcH4HMeh03GwpvnXNeyc1cjWVGhFMjpeuYz6MJBhMgqJItot99726Zc7cuHC
         qmyjpg+iLcBX/TeSIENFCIdHxEtLvtkq82/oReVUzzTXv6/y6VCNOJuA4yfpVKjP5QNn
         dHMy6tzVU54a327DVxlLlj6VqGCOZ3drBZOAQ=
Received: by 10.142.165.8 with SMTP id n8mr2199436wfe.319.1290785682077;
        Fri, 26 Nov 2010 07:34:42 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id b11sm2674948wff.9.2010.11.26.07.34.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:34:40 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:33:29 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162218>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1510-repo-setup.sh |   59 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100755 t/t1510-repo-setup.sh

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
new file mode 100755
index 0000000..623807d
--- /dev/null
+++ b/t/t1510-repo-setup.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description=3D'Tests of cwd/prefix/worktree/gitdir setup in all c=
ases'
+
+. ./test-lib.sh
+
+#
+# A few rules for repo setup:
+#
+# 1. GIT_DIR is relative to user's cwd. --git-dir is equivalent to
+#    GIT_DIR.
+#
+# 2. .git file is relative to parent directory. .git file is basically
+#    symlink in disguise. The directory where .git file points to will
+#    become new git_dir.
+#
+# 3. core.worktree is relative to git_dir.
+#
+# 4. GIT_WORK_TREE is relative to user's cwd. --work-tree is
+#    equivalent to GIT_WORK_TREE.
+#
+# 5. GIT_WORK_TREE/core.worktree is only effective if GIT_DIR is set
+#    Uneffective worktree settings should be warned.
+#
+# 6. Effective GIT_WORK_TREE overrides core.worktree and core.bare
+#
+# 7. Effective core.worktree conflicts with core.bare
+#
+# 8. If GIT_DIR is set but neither worktree nor bare setting is given,
+#    original cwd becomes worktree.
+#
+# 9. If .git discovery is done inside a repo, the repo becomes a bare
+#    repo. .git discovery is performed if GIT_DIR is not set.
+#
+# 10. If no worktree is available, cwd remains unchanged, prefix is
+#     NULL.
+#
+# 11. When user's cwd is outside worktree, cwd remains unchanged,
+#     prefix is NULL.
+#
+
+test_repo() {
+	(
+	if [ -n "$1" ]; then cd "$1"; fi &&
+	if [ -f trace ]; then rm trace; fi &&
+	GIT_TRACE=3D"`pwd`/trace" git symbolic-ref HEAD >/dev/null &&
+	grep '^setup: ' trace >result &&
+	test_cmp expected result
+	)
+}
+
+# Bit 0 =3D GIT_WORK_TREE
+# Bit 1 =3D GIT_DIR
+# Bit 2 =3D core.worktree
+# Bit 3 =3D .git is a file
+# Bit 4 =3D bare repo
+# Case# =3D encoding of the above 5 bits
+
+test_done
--=20
1.7.3.2.316.gda8b3
