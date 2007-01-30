From: Junio C Hamano <junkio@cox.net>
Subject: Re: MinGW port usable
Date: Mon, 29 Jan 2007 21:53:28 -0800
Message-ID: <7vveip5acn.fsf@assigned-by-dhcp.cox.net>
References: <200701292320.43888.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jan 30 06:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBlw3-0003hQ-QU
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 06:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbXA3Fxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 00:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932954AbXA3Fxa
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 00:53:30 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:34802 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932948AbXA3Fx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 00:53:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070130055328.FCER3989.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jan 2007 00:53:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HHtn1W0111kojtg0000000; Tue, 30 Jan 2007 00:53:48 -0500
In-Reply-To: <200701292320.43888.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Mon, 29 Jan 2007 23:20:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38123>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Junio, you may like to cherry-pick these two non-critical commits from my 
> repository:
>
> 8c8bb94f94f1d972c7ffadda4744cf343fac6f34 gitk: Use peek-remote instead of 
> ls-remote.
> 46580d2192d79a469f8b40fc1081db9116ad5517 Add a missing fork() error check.

Thanks; cherry-picked the fork() one.

Regarding gitk, I think the following patch would be better
regardless of the platform.

-- >8 --
[PATCH] gitk: Use show-ref instead of ls-remote

It used to be ls-remote on self was the only easy way to grab
the ref information.  Now we have show-ref which does not
involve fork and IPC, so use it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/gitk b/gitk
index 31d0aad..67e6a64 100755
--- a/gitk
+++ b/gitk
@@ -309,9 +309,9 @@ proc readrefs {} {
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
 	catch {unset $v}
     }
-    set refd [open [list | git ls-remote [gitdir]] r]
+    set refd [open [list | git show-ref] r]
     while {0 <= [set n [gets $refd line]]} {
-	if {![regexp {^([0-9a-f]{40})	refs/([^^]*)$} $line \
+	if {![regexp {^([0-9a-f]{40}) refs/([^^]*)$} $line \
 	    match id path]} {
 	    continue
 	}
