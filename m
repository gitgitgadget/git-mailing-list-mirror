From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/42] Add t1510 and basic rules that run repo setup
Date: Fri, 29 Oct 2010 13:48:14 +0700
Message-ID: <1288334934-17216-3-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:49:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBima-0005pv-SV
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140Ab0J2Gtn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:49:43 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500Ab0J2Gtl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:49:41 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BTWhdBwiNWiO0JatTvuJOy22sOT9y9dlf225R9/JV4Q=;
        b=irNeT/3BBNMtJufoOhlhJv2ll0qNKWEkDX8roGQ+BmI8sxfnHDl0vca8DxC9bv6PDx
         YaP4kKqvbHZcZrLewzgpvNEb0YQQYVUAsaeMseTRCfrySnKR1fEUVg2W9Z0tc1K7WBwv
         lp7SA1Zb3BCTDo3OAprmUv28SEKYC3uxCEyhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PG5+QCtGBO6JMrb3DSs2AUYVfpLhpxvVy/4ONnD6oTdqf4pyYLYiwL3yITk1V0MEcY
         F0kJesxmDM41y9cKEMxIaUSuWsr0K1sGwUKpw4SXa7F+dBLgk/Gq7WVZ60Sa9L7vTjlK
         FCxmjU3A7qK7jsFyQ1bBkyoupnRy6bFdROYus=
Received: by 10.143.31.8 with SMTP id i8mr1067413wfj.130.1288334981661;
        Thu, 28 Oct 2010 23:49:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x18sm1021289wfa.11.2010.10.28.23.49.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:49:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:49:41 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160270>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.7.0.2.445.gcbdb3
