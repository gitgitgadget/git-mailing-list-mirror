From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t3702: fix reliance on SHELL_PATH being '/bin/sh'
Date: Mon, 27 Apr 2009 19:51:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904271940100.7741@intel-tinevez-2-302>
References: <e2b179460904270812t3fa159f1ja3b06905d9effebe@mail.gmail.com>  <alpine.DEB.1.00.0904271812180.7741@intel-tinevez-2-302> <e2b179460904270930m3c292bd8l5067447fff330fef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1980394742-1240854703=:7741"
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 19:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyUzl-00022V-Ka
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 19:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756357AbZD0Rvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 13:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbZD0Rvu
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 13:51:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:57191 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750835AbZD0Rvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 13:51:49 -0400
Received: (qmail invoked by alias); 27 Apr 2009 17:51:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp066) with SMTP; 27 Apr 2009 19:51:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YlN9ST5SYFOrzo0WjiTurYYyVfXGfi/WmL2Cfhm
	joZDt4O6nia2OA
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <e2b179460904270930m3c292bd8l5067447fff330fef@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117696>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1980394742-1240854703=:7741
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


Trying to be lazy and comparing files with fake-editor.sh to avoid
having to provide another example text does not work well: the blob
name changes when SHELL_PATH changes, and so does the 'index' line
in the diff.

Therefore provide a second example text.

Noticed by Mike Ralphson.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 27 Apr 2009, Mike Ralphson wrote:

	> 2009/4/27 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
	> > On Mon, 27 Apr 2009, Mike Ralphson wrote:
	> >> I'm seeing a reproducible failure in t3702 on AIX 5.3, shell set to
	> >> bash (v2.05b)
	> >>
	> >> The 'test_cmp orig-patch expected-patch' is seeing this diff:
	> >>
	> >> 2c2
	> >> < index b9834b5..52aff4c 100644
	> >> ---
	> >> > index b9834b5..0b8f197 100644
	> >
	> > Could you send me the output of
	> >
	> >        cd t/trash\ directory.t3702* &&
	> >        git show 0b8f197 > file.txt

	Aargh.

	I know what it is.  Sorry, _very_ stupid thinko on this side of 
	the ocean.

	Time for a day off.

 t/t3702-add-edit.sh |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
index 7262786..4ee47cc 100755
--- a/t/t3702-add-edit.sh
+++ b/t/t3702-add-edit.sh
@@ -21,6 +21,15 @@ who house by the whale-path, heard his mandate,
 gave him gifts:  a good king he!
 EOF
 
+cat > second-part << EOF
+To him an heir was afterward born,
+a son in his halls, whom heaven sent
+to favor the folk, feeling their woe
+that erst they had lacked an earl for leader
+so long a while; the Lord endowed him,
+the Wielder of Wonder, with world's renown.
+EOF
+
 test_expect_success 'setup' '
 
 	git add file &&
@@ -31,10 +40,10 @@ test_expect_success 'setup' '
 
 cat > expected-patch << EOF
 diff --git a/file b/file
-index b9834b5..0b8f197 100644
+index b9834b5..9020acb 100644
 --- a/file
 +++ b/file
-@@ -1,11 +1,3 @@
+@@ -1,11 +1,6 @@
 -LO, praise of the prowess of people-kings
 -of spear-armed Danes, in days long sped,
 -we have heard, and what honor the athelings won!
@@ -46,9 +55,12 @@ index b9834b5..0b8f197 100644
 -till before him the folk, both far and near,
 -who house by the whale-path, heard his mandate,
 -gave him gifts:  a good king he!
-+#!$SHELL_PATH
-+mv -f "\$1" orig-patch &&
-+mv -f patch "\$1"
++To him an heir was afterward born,
++a son in his halls, whom heaven sent
++to favor the folk, feeling their woe
++that erst they had lacked an earl for leader
++so long a while; the Lord endowed him,
++the Wielder of Wonder, with world's renown.
 EOF
 
 cat > patch << EOF
@@ -97,9 +109,9 @@ chmod a+x fake-editor.sh
 
 test_expect_success 'add -e' '
 
-	cp fake-editor.sh file &&
+	cp second-part file &&
 	git add -e &&
-	test_cmp fake-editor.sh file &&
+	test_cmp second-part file &&
 	test_cmp orig-patch expected-patch &&
 	git diff --cached > out &&
 	test_cmp out expected
-- 
1.6.2.1.493.g67cf3

--8323329-1980394742-1240854703=:7741--
