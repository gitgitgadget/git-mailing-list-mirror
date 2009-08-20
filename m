From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 11/19] Introduce "sparse checkout"
Date: Thu, 20 Aug 2009 20:47:05 +0700
Message-ID: <1250776033-12395-12-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
 <1250776033-12395-7-git-send-email-pclouds@gmail.com>
 <1250776033-12395-8-git-send-email-pclouds@gmail.com>
 <1250776033-12395-9-git-send-email-pclouds@gmail.com>
 <1250776033-12395-10-git-send-email-pclouds@gmail.com>
 <1250776033-12395-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81J-0007ZS-IL
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbZHTNsV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbZHTNsV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:48:21 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:62823 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbZHTNsU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:48:20 -0400
Received: by mail-px0-f196.google.com with SMTP id 34so3269349pxi.4
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4tEb7of8I/Ahlz98YY3yRARBe8XOnMuyn+qrs6azHoo=;
        b=D/Luu/R4O1mfxY6dsMvIN6LW/Se9mAQViT2GFPtr59GVE4gaWdf84IyGCp3ch9Y+NQ
         gcXBwpwcWzLCq30ZuS9fzTEuN2k0FzsQCIxJovljEe47WD+cf2vZnO9l+a/48IT7JoeD
         VCWH2stzHBmrvERgvmWNY4Xlc3Sz4/wNMf4Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=h8nIuZuGnMRtniOZxt0akzwVclWkHZTcw+pXLTh2BgldI+OgoDjCLjF2Q4L3YtVCvH
         XB/917IjFCXvmbUUuqHei3mGo32pIYPeRwiTtRbc4kSyDyfCVFlJLmDR1VknUJhukpud
         J3Yxl1+idR4JKJ53Pkl0nzRgQ/GbbvW6U8T4o=
Received: by 10.115.85.16 with SMTP id n16mr6170958wal.123.1250776100644;
        Thu, 20 Aug 2009 06:48:20 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 20sm186925pzk.1.2009.08.20.06.48.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:48:15 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-11-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126633>

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
1.6.3.GIT
