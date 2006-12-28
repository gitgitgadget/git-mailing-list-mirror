From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/11] Honor pull.{twohead,octopus} in git-merge.
Date: Thu, 28 Dec 2006 02:35:05 -0500
Message-ID: <20061228073505.GE17867@spearce.org>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:35:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzpnH-0000v9-Mb
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWL1HfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWL1HfN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:35:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45818 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964991AbWL1HfL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:35:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gzpmi-0007we-1H; Thu, 28 Dec 2006 02:34:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5DCA220FB65; Thu, 28 Dec 2006 02:35:05 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35527>

If git-merge is invoked without a strategy argument it is probably
being run as a porcelain-ish command directly and is not being run
from within git-pull.  However we still should honor whatever merge
strategy the user may have selected in their configuration, just as
`git-pull .` would have.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-merge.sh |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index c7e033c..a8f673e 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -272,9 +272,21 @@ case "$use_strategies" in
 '')
 	case "$#" in
 	1)
-		use_strategies="$default_twohead_strategies" ;;
+		var="`git-repo-config --get pull.twohead`"
+		if test -n "$var"
+		then
+			use_strategies="$var"
+		else
+			use_strategies="$default_twohead_strategies"
+		fi ;;
 	*)
-		use_strategies="$default_octopus_strategies" ;;
+		var="`git-repo-config --get pull.octopus`"
+		if test -n "$var"
+		then
+			use_strategies="$var"
+		else
+			use_strategies="$default_octopus_strategies"
+		fi ;;
 	esac
 	;;
 esac
-- 
1.4.4.3.gd2e4
