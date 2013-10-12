From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 7/7] pull: add documentation about non-ff merges
Date: Sat, 12 Oct 2013 02:02:02 -0500
Message-ID: <1381561322-20059-8-git-send-email-felipe.contreras@gmail.com>
References: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:08:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtJR-0002MJ-Jz
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905Ab3JLHIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:08:25 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:57231 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab3JLHIX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:08:23 -0400
Received: by mail-ob0-f171.google.com with SMTP id uy5so3456379obc.2
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GPx8tQe+IbS60oCu24oCBEXKxfEK97mkLrXW2INEtIY=;
        b=qLx6Q6sRPzS4aiPz90D8mmdoe3gf1U26PdLDtXiDjbUADSVALMIZk0fvrk09RNbMCh
         yAWdFyeWZetinC2arnfxgfQTgIOg89SeJFTHphb1GSwTTWNsBJq4CnrApg2g7Pe/Lf8G
         5Mxxib0dUTthT5zblFRJaiv/NWpxyroUCrY/PUpEoGjDMBhR8cNJ38aJGuHgGiTdmj5A
         IaybCUeE0QSlxpc4+vOcF8iPuErXCRZJ/nRM66JJaLPvnE2Gf3FwndEpPhVFO+WL3KbU
         BwcSh7Rgz+58KfY/zYr4VraVglCNWp4p1Wi3wI89x91fLPPl/M21TjkzBmMCN78oXUBt
         wS4Q==
X-Received: by 10.60.40.67 with SMTP id v3mr18191794oek.16.1381561702971;
        Sat, 12 Oct 2013 00:08:22 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm101370387oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:08:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235955>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 6d55737..b4053a8 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -23,6 +23,7 @@ More precisely, 'git pull' runs 'git fetch' with the given
 parameters and calls 'git merge' to merge the retrieved branch
 heads into the current branch.
 With `--rebase`, it runs 'git rebase' instead of 'git merge'.
+With `--merge`, it forces the merge, even if it's non-fast forward.
 
 <repository> should be the name of a remote repository as
 passed to linkgit:git-fetch[1].  <refspec> can name an
@@ -41,9 +42,26 @@ Assume the following history exists and the current branch is
 ------------
 	  A---B---C origin/master
 	 /
+    D---E master
+------------
+
+Then `git pull` will merge in a fast-foward way up to the new master.
+
+------------
+    D---E---A---B---C master, origin/master
+------------
+
+However, a non-fast-foward case looks very different.
+
+------------
+	  A---B---C origin/master
+	 /
     D---E---F---G master
 ------------
 
+In the future, `git pull` will fail on these situations, however, most likely
+you would want to force a merge, which you can do with `git pull --merge`.
+
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
 until its current commit (`C`) on top of `master` and record the
-- 
1.8.4-fc
