From: Junio C Hamano <junkio@cox.net>
Subject: Re: Simplify "git reset --hard"
Date: Sun, 14 May 2006 23:55:24 -0700
Message-ID: <7v1wuvwzdv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605141040210.3866@g5.osdl.org>
	<Pine.LNX.4.64.0605141110150.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 08:55:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfWzP-0004Am-Eb
	for gcvg-git@gmane.org; Mon, 15 May 2006 08:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWEOGz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 02:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWEOGz0
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 02:55:26 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:5513 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932301AbWEOGzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 02:55:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515065525.TBKL24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 02:55:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605141110150.3866@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 14 May 2006 11:20:37 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20030>

Linus Torvalds <torvalds@osdl.org> writes:

> Now that the one-way merge strategy does the right thing wrt files that do 
> not exist in the result, just remove all the random crud we did in "git 
> reset" to do this all by hand.
>
> Instead, just pass in "-u" to git-read-tree when we do a hard reset, and 
> depend on git-read-tree to update the working tree appropriately.

Well, this is wrong.  Local modifications remain after your
version of "git-reset --hard HEAD". which is not what we want
from a hard reset.

-- >8 --

diff --git a/git-reset.sh b/git-reset.sh
index 0ee3e3e..ecc111b 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -52,7 +52,7 @@ git-update-ref HEAD "$rev"
 
 case "$reset_type" in
 --hard )
-	;; # Nothing else to do
+	git-checkout-index -f -q -u -a ;;
 --soft )
 	;; # Nothing else to do
 --mixed )
