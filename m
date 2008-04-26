From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] Improve git bisect error message
Date: Sat, 26 Apr 2008 15:39:38 +0200
Message-ID: <20080426133937.GA27677@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 15:40:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpkdj-0006vv-2m
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 15:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbYDZNjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 09:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbYDZNjo
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 09:39:44 -0400
Received: from smtp-out03.alice-dsl.net ([88.44.63.5]:11584 "EHLO
	smtp-out03.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbYDZNjo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 09:39:44 -0400
Received: from out.alice-dsl.de ([192.168.125.62]) by smtp-out03.alice-dsl.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 26 Apr 2008 15:32:47 +0200
Received: from basil.firstfloor.org ([92.224.153.175]) by out.alice-dsl.de with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 26 Apr 2008 15:32:47 +0200
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 3D80D1B454E; Sat, 26 Apr 2008 15:39:38 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 26 Apr 2008 13:32:47.0347 (UTC) FILETIME=[03FC5C30:01C8A7A2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80375>


It took me some time to figure out what this error message meant and
how to fix the problem.  So let's improve it a little.

-Andi

--- git-1.5.4/git-bisect~	2008-02-09 13:37:16.000000000 +0100
+++ git-1.5.4/git-bisect	2008-04-26 01:26:19.000000000 +0200
@@ -71,7 +71,10 @@
 		git checkout $branch || exit
 		;;
 	refs/heads/*)
-		[ -s "$GIT_DIR/head-name" ] && die "won't bisect on seeked tree"
+		if [ -s "$GIT_DIR/head-name" ] ; then
+			echo >&2 "Please run git bisect reset"
+			die "won't bisect on seeked tree"
+		fi
 		echo "${head#refs/heads/}" >"$GIT_DIR/head-name"
 		;;
 	*)
