From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 14:34:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151429440.3586@pacific.mpi-cbg.de>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSN3-00014b-TN
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764986AbZAONdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765065AbZAONdL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:33:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:55226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765057AbZAONdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:33:10 -0500
Received: (qmail invoked by alias); 15 Jan 2009 13:33:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp010) with SMTP; 15 Jan 2009 14:33:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PtkpdA53PGtSy23gZlKXfZqyRw7PcEmfnbufKxA
	9MKDZfS9SG2Tsr
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105799>

Hi,

On Thu, 15 Jan 2009, Sitaram Chamarty wrote:

> While trying to understand "rebase -p", I came across some
> very unexpected behaviour that made me throw in the towel
> and ask for help!
>
> [... some script with some aliases ...]

I turned this into a proper test case (to show what would be most helpful 
if you report bugs like this in the future).

If nobody beats me to it, I'll work on it tonight.

-- snipsnap --
 t/t3409-rebase-preserve-merges.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index e6c8327..5e2128c 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -92,4 +92,32 @@ test_expect_success '--continue works after a conflict' '
 	)
 '
 
+test_commit () {
+	: > "$1" &&
+	git add "$1" &&
+	test_tick &&
+	git commit -m "$1" "$1"
+}
+
+test_expect_success 'test case from Sitaram' '
+
+	git checkout master &&
+	test_commit a1 &&
+	git checkout -b work &&
+	test_commit b1 &&
+	git checkout master &&
+	test_commit a3 &&
+	git checkout work &&
+	git merge master &&
+	test_commit b3 &&
+	echo before: &&
+	git log --graph --pretty=oneline --decorate --abbrev-commit &&
+	test -f b3 &&
+	git rebase -p master &&
+	echo after: &&
+	git log --graph --pretty=oneline --decorate --abbrev-commit &&
+	test -f b3
+
+'
+
 test_done
