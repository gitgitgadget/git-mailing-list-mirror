From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe@aidecoe.name>
Subject: [PATCH] git-p4.py: Make submit working on bare repository
Date: Fri, 19 Feb 2016 21:57:54 +0000
Message-ID: <1455919074-5683-1-git-send-email-aidecoe@aidecoe.name>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, aidecoe@aidecoe.name
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 22:58:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWt43-0003za-EP
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 22:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947811AbcBSV6E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2016 16:58:04 -0500
Received: from jim.zolnowski.name ([188.116.54.122]:46165 "EHLO
	jim.zolnowski.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030385AbcBSV6C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 16:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aidecoe.name; s=jim;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=bMyN5zFuaB7pXuv4Z7PBeEwvj7MeyQ+pSM7BS18hMq4=;
	b=xf+J/mawF1AjGhz+pZc0xqBVAsRTJba78QLYwagG+UloylxYE4pD6FsLPVyB5FezMUVh4lDSgEPv4kxkvjKaHVx6440EVm4l9DAg58yE5GmIY4WuOdYSy6E/BS1fweqRo8qtPuRWexEC0Tyv9cKz4t+lVt+ZlVX8TqTl/KZzGYJiZBaW3yEydRMvf+hDisRZRRZA6YRrA4GEpw/WO9i1vImGb197LZyrY/9w6yIAFHDlsian7tHWsVImgtyVJLjAEYEHYrxJAXy/GgXYDtM3KGRNQci13oUPTcWacaITtI+WHlQr8DzQgiC9+8I1GEp0oYon7BoWdqcsS7JYF+PUWw==;
Received: from cpc92302-cmbg19-2-0-cust189.5-4.cable.virginm.net ([82.1.208.190] helo=localhost)
	by jim.zolnowski.name with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.85)
	(envelope-from <aidecoe@aidecoe.name>)
	id 1aWt3l-00013q-Ng; Fri, 19 Feb 2016 22:57:58 +0100
X-Mailer: git-send-email 2.7.0
In-Reply-To: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286753>

git-p4 can be successfully used from bare repository (which may act as =
a
bridge between Perforce repository and pure Git repositories). After
submitting changelist to Perforce, git-p4 performs unconditional rebase
which obviously fails.

Perform rebase only on non-bare repositories, so submit command can be
successful on bare repository.

Signed-off-by: Amadeusz =C5=BBo=C5=82nowski <aidecoe@aidecoe.name>
---
 git-p4.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c33dece..e00cd02 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2059,8 +2059,9 @@ class P4Submit(Command, P4UserMap):
                 sync.branch =3D self.branch
             sync.run([])
=20
-            rebase =3D P4Rebase()
-            rebase.rebase()
+            if not gitConfigBool("core.bare"):
+                rebase =3D P4Rebase()
+                rebase.rebase()
=20
         else:
             if len(applied) =3D=3D 0:
--=20
2.7.0
