From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2 v2] Documentation: describe how to "bisect skip" a range
 of commits
Date: Tue, 2 Dec 2008 14:53:51 +0100
Message-ID: <20081202145351.24d1a1fb.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 14:54:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Vh9-0006hr-P1
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 14:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbYLBNwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 08:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbYLBNwY
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 08:52:24 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:57491 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468AbYLBNwX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 08:52:23 -0500
Received: from smtp5-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 2B90A3EA1B4;
	Tue,  2 Dec 2008 14:52:20 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g19.free.fr (Postfix) with SMTP id CDD7D3EA21D;
	Tue,  2 Dec 2008 14:52:19 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102135>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   21 ++++++++++++++++++++-
 git-bisect.sh                |    2 +-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 39034ec..147ea38 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -19,7 +19,7 @@ on the subcommand:
  git bisect start [<bad> [<good>...]] [--] [<paths>...]
  git bisect bad [<rev>]
  git bisect good [<rev>...]
- git bisect skip [<rev>...]
+ git bisect skip [(<rev>|<range>)...]
  git bisect reset [<branch>]
  git bisect visualize
  git bisect replay <logfile>
@@ -164,6 +164,25 @@ But computing the commit to test may be slower afterwards and git may
 eventually not be able to tell the first bad among a bad and one or
 more "skip"ped commits.
 
+You can even skip a range of commits, instead of just one commit,
+using the "'<commit1>'..'<commit2>'" notation. For example:
+
+------------
+$ git bisect skip v2.5..v2.6
+------------
+
+would mean that no commit between `v2.5` excluded and `v2.6` included
+can be tested.
+
+Note that if you want to also skip the first commit of a range you can
+use something like:
+
+------------
+$ git bisect skip v2.5 v2.5..v2.6
+------------
+
+and the commit pointed to by `v2.5` will be skipped too.
+
 Cutting down bisection by giving more parameters to bisect start
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/git-bisect.sh b/git-bisect.sh
index ddbdba8..17a35f6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -9,7 +9,7 @@ git bisect bad [<rev>]
         mark <rev> a known-bad revision.
 git bisect good [<rev>...]
         mark <rev>... known-good revisions.
-git bisect skip [<rev>...]
+git bisect skip [(<rev>|<range>)...]
         mark <rev>... untestable revisions.
 git bisect next
         find next bisection to test and check it out.
-- 
1.6.0.4.838.g4ea49
