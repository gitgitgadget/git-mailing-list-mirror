From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCH] display the subject of the commit just made
Date: Mon, 16 Apr 2007 06:53:25 +0300
Message-ID: <20070416035325.GA20304@mellanox.co.il>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
	<7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
	<20070415223909.GG15208@mellanox.co.il>
	<7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 05:54:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdIIM-0003Xd-CP
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 05:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbXDPDyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 23:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbXDPDyE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 23:54:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:59348 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbXDPDyB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 23:54:01 -0400
Received: by ug-out-1314.google.com with SMTP id m2so952374uge
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 20:54:00 -0700 (PDT)
Received: by 10.67.100.4 with SMTP id c4mr66247ugm.1176695640308;
        Sun, 15 Apr 2007 20:54:00 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id k2sm6037837ugf.2007.04.15.20.53.59;
        Sun, 15 Apr 2007 20:53:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44567>

Useful e.g. to figure out what I did from screen history,
or to make sure subject line is short enough and makes sense
on its own.

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

> WHY?  You just made the commit.

Hopefully answered above.
This also gets rid of the only user of --no-commit-id, so we
should be able to deprecate this in the future in favor of
--pretty=format:

> >> Quoting Junio C Hamano <junkio@cox.net>:
> >> Subject: Re: [PATCH] display shortlog after git-commit
> >> 
> >> Too noisy for a default.
> >
> > So maybe the following isn't too bad?
> > This results in:
> > $ ./git-commit.sh --amend
> > Created commit 5633ddde0e35210f607bde063bcbf709e4d20a8d
> > Display the subject of the commit just made.
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> I think this is still one line too many.  It _might_ be an
> improvement if it were
> 
>     $ ./git-commit.sh --amend
>     Created commit 5633ddde: Display the subject of the commit just made.
>      1 files changed, 1 insertions(+), 1 deletions(-)
> 
> though...

Better?

diff --git a/git-commit.sh b/git-commit.sh
index 9e0959a..32257b0 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -649,8 +649,9 @@ then
 	fi
 	if test -z "$quiet"
 	then
+		commit=`git-diff-tree --shortstat --pretty="format:%h: %s"\
+		       --summary --root HEAD --`
 		echo "Created${initial_commit:+ initial} commit $commit"
-		git-diff-tree --shortstat --summary --root --no-commit-id HEAD --
 	fi
 fi
 
 
-- 
MST
