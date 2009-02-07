From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] submodule: warn about non-submodules
Date: Sat, 7 Feb 2009 14:43:15 +0100 (CET)
Message-ID: <4392cb2a9f5f3283d6505e17ddcb36a6b427fbcf.1234013924u.git.johannes.schindelin@gmx.de>
References: <7vfxiqy76k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 07 14:44:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVnTa-0000i5-Cl
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 14:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbZBGNmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 08:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbZBGNmi
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 08:42:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:59268 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753243AbZBGNmh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 08:42:37 -0500
Received: (qmail invoked by alias); 07 Feb 2009 13:42:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 07 Feb 2009 14:42:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Si49RZubSU8BBA1Uhm5kITqJ5VtK6rXIdUWea44
	FLoE2x7gV1+f/7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vfxiqy76k.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108852>

Earlier, when you called

        git submodule some/bogus/path

Git would silently ignore the path, without warning the user about the
likely mistake.  Now it does.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-submodule.sh           |    2 +-
 t/t7400-submodule-basic.sh |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2f47e06..6cc2d33 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -59,7 +59,7 @@ resolve_relative_url ()
 #
 module_list()
 {
-	git ls-files --stage -- "$@" | grep '^160000 '
+	git ls-files --error-unmatch --stage -- "$@" | grep '^160000 '
 }
 
 #
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a74f24c..b8cb2df 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -240,4 +240,11 @@ test_expect_success 'ls-files gracefully handles trailing slash' '
 
 '
 
+test_expect_success 'submodule <invalid-path> warns' '
+
+	git submodule no-such-submodule 2> output.err &&
+	grep "^error: .*no-such-submodule" output.err
+
+'
+
 test_done
-- 
1.6.1.2.630.g01a7e
