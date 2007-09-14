From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 07/13] Clean up Series.refresh_patch
Date: Sat, 15 Sep 2007 00:31:44 +0200
Message-ID: <20070914223144.7001.49604.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJho-0001VC-9C
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155AbXINWbu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758141AbXINWbu
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:31:50 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56512 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758072AbXINWbt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:31:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id DFABB200A1D7;
	Sat, 15 Sep 2007 00:31:45 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05544-01-40; Sat, 15 Sep 2007 00:31:45 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 0C295200A1CE;
	Sat, 15 Sep 2007 00:31:45 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id BD1EDBFA59;
	Sat, 15 Sep 2007 00:31:44 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58199>

This patch does some minor simplifications of the code and updates the
documentation string of Series.refresh_patch.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/stack.py |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)


diff --git a/stgit/stack.py b/stgit/stack.py
index 9b8ed6e..03ce218 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -749,14 +749,12 @@ class Series(PatchSet):
                       committer_name =3D None, committer_email =3D Non=
e,
                       backup =3D False, sign_str =3D None, log =3D 're=
fresh',
                       notes =3D None):
-        """Generates a new commit for the given patch
+        """Generates a new commit for the topmost patch
         """
-        name =3D self.get_current()
-        if not name:
+        patch =3D self.get_current_patch()
+        if not patch:
             raise StackException, 'No patches applied'
=20
-        patch =3D self.get_patch(name)
-
         descr =3D patch.get_description()
         if not (message or descr):
             edit =3D True
@@ -767,7 +765,7 @@ class Series(PatchSet):
         if not message and edit:
             descr =3D edit_file(self, descr.rstrip(), \
                               'Please edit the description for patch "=
%s" ' \
-                              'above.' % name, show_patch)
+                              'above.' % patch.get_name(), show_patch)
=20
         if not author_name:
             author_name =3D patch.get_authname()
