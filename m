From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Automatically line wrap long commit messages.
Date: Mon, 29 May 2006 04:57:39 -0400
Message-ID: <20060529085738.GB29500@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 10:57:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkdZM-0003Eu-T1
	for gcvg-git@gmane.org; Mon, 29 May 2006 10:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWE2I5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 04:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWE2I5q
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 04:57:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38042 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750780AbWE2I5p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 04:57:45 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FkdZF-0008R0-Tm; Mon, 29 May 2006 04:57:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5557E20E445; Mon, 29 May 2006 04:57:40 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20936>

When using -m on the command line with git-commit it is not uncommon
for a long commit message to be entered without line terminators.
This creates commit objects whose messages are not readable in
'git log' as the line runs off the screen.

So instead reformat log messages if they are supplied on the
command line.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 This one might cause some problems for people.  It requires
 'fmt' in order to use log messages on the command line as well as
 some users may not like having their log messages line wrapped.
 I'm open to suggestions for how to deal with this but personally
 this is one feature which I put into pg's commit tool that I miss
 dearly when working with core GIT.

 git-commit.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index a092b72..e7aa4b1 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -547,7 +547,12 @@ fi
 
 if test "$log_message" != ''
 then
-	echo "$log_message"
+	# The message came from the command line.  It might contain very
+	# long lines so reformat it with a target of 60. Note that we
+	# don't reformat messages created in an editor by the user as
+	# we should assume they carefully formatted it in some way.
+	#
+	echo "$log_message" | fmt -w 60
 elif test "$logfile" != ""
 then
 	if test "$logfile" = -
-- 
1.3.3.g45d8
