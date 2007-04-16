From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] display the subject of the commit just made
Date: Mon, 16 Apr 2007 08:51:11 +0300
Message-ID: <20070416055111.GC23255@mellanox.co.il>
References: <7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 07:51:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdK7P-0006zE-Ez
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 07:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbXDPFvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 01:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbXDPFvK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 01:51:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:30481 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbXDPFvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 01:51:09 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1028810uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 22:51:07 -0700 (PDT)
Received: by 10.67.116.13 with SMTP id t13mr1731961ugm.1176702528558;
        Sun, 15 Apr 2007 22:48:48 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id y1sm6080404uge.2007.04.15.22.51.06;
        Sun, 15 Apr 2007 22:51:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44583>

Display the subject of the commit just made.

Useful e.g. to figure out what I did from screen history,
or to make sure subject line is short enough and makes sense
on its own.

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

> Quoting Junio C Hamano <junkio@cox.net>:
> Close but no cigar.  You broke it for a merge commit, I think.
> 
> Perhaps
> 
> 	pretty="format:Created${initial_commit:+ initial} commit %h: %s%n"
> 	git-diff-tree --always --shortstart --summary --root --pretty="$pretty" HEAD

OK, thanks fo rpointing this out.
But why the extra %n at the end? The following seems to work well for me:

diff --git a/git-commit.sh b/git-commit.sh
index 9e0959a..f28fc24 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -649,8 +649,9 @@ then
 	fi
 	if test -z "$quiet"
 	then
+		commit=`git-diff-tree --always --shortstat --pretty="format:%h: %s"\
+		       --summary --root HEAD --`
 		echo "Created${initial_commit:+ initial} commit $commit"
-		git-diff-tree --shortstat --summary --root --no-commit-id HEAD --
 	fi
 fi
 

-- 
MST
