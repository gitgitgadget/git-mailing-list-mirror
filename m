From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/23] Introduce "sparse checkout"
Date: Mon, 14 Dec 2009 17:30:58 +0700
Message-ID: <1260786666-8405-16-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FL-0007wL-7i
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbZLNKdY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbZLNKdP
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:33:15 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:62201 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145AbZLNKdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:33:09 -0500
Received: by mail-px0-f174.google.com with SMTP id 4so1691169pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=y1NP/KpsRlwe1ap5xtXkGsCbXefUQROFn8mNKaN/ruY=;
        b=O+kNufdVB8Zu/SgMCf+JBIVYsWSuLlmZtVYMEFaeWtDzZdZmz1DmzuXDJFtUn0UdSq
         2ZiN12Pu6YS9jd2lCJ3Z1783cKfKcAIU5a3l3XEwa9ICUwDXDk5TGGJ3S9MDYeG7ejoG
         tuJ5APsFe/n8DKTLC1NVhAwL0GGHhx1NQjPn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iy/VBHQJuVx6qdWcjtlgskRYg35Gl+oGC12/io5YGdB+FCKch+DlZPQHpCpE68B0k7
         258euLNdYTjsf7+Qqsj4+U5bLUiufrQ4XbTPKbwOFKZ+nbK1ks47ORyf0z0udHNx37GX
         3RZF48D14aNgwXa/zjYJc7Du30HlLUj665HEU=
Received: by 10.141.106.18 with SMTP id i18mr3191857rvm.191.1260786787769;
        Mon, 14 Dec 2009 02:33:07 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 23sm4910690pzk.12.2009.12.14.02.33.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:33:07 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:26 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135179>

With skip-worktree bit, you can manually set it to unwanted files,
then remove them: you would have the so-called sparse checkout. The
disadvantages are:

 - Porcelain tools are not aware of this. Everytime you do an
   operation that may update working directory, skip-worktree may be
   cleared out. You have to set them again.

 - You still have to remove skip-worktree'd files manually, which is
   boring and ineffective.

These will be addressed in the following patches. This patch gives an
idea what is "sparse checkout" in Documentation/git-read-tree.txt.
This file is chosen instead of git-checkout.txt because it is quite
technical and user-unfriendly. I'd expect git-checkout.txt to have
something when Porcelain support is done.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-read-tree.txt |   44 +++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index 4a932b0..8b39716 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -360,6 +360,50 @@ middle of doing, and when your working tree is rea=
dy (i.e. you
 have finished your work-in-progress), attempt the merge again.
=20
=20
+Sparse checkout
+---------------
+
+"Sparse checkout" allows to sparsely populate working directory.
+It uses skip-worktree bit (see linkgit:git-update-index[1]) to tell
+Git whether a file on working directory is worth looking at.
+
+"git read-tree" and other merge-based commands ("git merge", "git
+checkout"...) can help maintaining skip-worktree bitmap and working
+directory update. `$GIT_DIR/info/sparse-checkout` is used to
+define the skip-worktree reference bitmap. When "git read-tree" needs
+to update working directory, it will reset skip-worktree bit in index
+based on this file, which uses the same syntax as .gitignore files.
+If an entry matches a pattern in this file, skip-worktree will be
+set on that entry. Otherwise, skip-worktree will be unset.
+
+Then it compares the new skip-worktree value with the previous one. If
+skip-worktree turns from unset to set, it will add the corresponding
+file back. If it turns from set to unset, that file will be removed.
+
+While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
+files are in. You can also specify what files are _not_ in, using
+negate patterns. For example, to remove file "unwanted":
+
+----------------
+*
+!unwanted
+----------------
+
+Another tricky thing is fully repopulating working directory when you
+no longer want sparse checkout. You cannot just disable "sparse
+checkout" because skip-worktree are still in the index and you working
+directory is still sparsely populated. You should re-populate working
+directory with the `$GIT_DIR/info/sparse-checkout` file content as
+follows:
+
+----------------
+*
+----------------
+
+Then you can disable sparse checkout. Sparse checkout support in "git
+read-tree" and similar commands is disabled by default.
+
+
 SEE ALSO
 --------
 linkgit:git-write-tree[1]; linkgit:git-ls-files[1];
--=20
1.6.5.2.216.g9c1ec
