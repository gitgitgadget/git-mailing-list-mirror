From: Junio C Hamano <junkio@cox.net>
Subject: Shipping gitk as part of core git.
Date: Sat, 30 Jul 2005 14:36:47 -0700
Message-ID: <7vk6j8yo0g.fsf_-_@assigned-by-dhcp.cox.net>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
	<7vy87o6htm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 23:39:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyz3H-0002uq-RF
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 23:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVG3Vi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 17:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbVG3Vi6
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 17:38:58 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:38345 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262934AbVG3Vgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 17:36:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730213647.DJPM16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Jul 2005 17:36:47 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <7vy87o6htm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri, 29 Jul 2005 21:25:41 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It appears that gitk gets wider test coverage only after it is
pulled into git.git repository.  I think it would be a good idea
for me to pull from you often.

Recently there was a discussion with binary packaging folks.
While I do not mind, and actually I would prefer, shipping gitk
as part of the core GIT, I have never heard about your
preference.  As long as gitk is just a single file (or even a
handful files in the future) project that does not have a
filename that overlaps with core GIT, I can continue pulling
from you and I think the binary packaging folks can produce
separate git-core and gitk package out of git.git tree without
problems.  However, once you start wanting to have your own
Makefile and maybe debian/rules file for packaging, for example,
I suspect the way currently things are set up would break
miserably.  It's all Linus' fault to have merged with your tree
in the first place ;-).

Anyhow, I have one bug to report.  I selected one rev, and then
said "diff this -> selected" from right-click menu on an
adjacent one, and I got this:

    wrong # args: should be "startdiff ids"
    wrong # args: should be "startdiff ids"
        while executing
    "startdiff $newid [list $oldid]"
        (procedure "diffvssel" line 28)
        invoked from within
    "diffvssel 0"
        invoked from within
    ".rowctxmenu invoke active"
        ("uplevel" body line 1)
        invoked from within
    "uplevel #0 [list $w invoke active]"
        (procedure "tk::MenuInvoke" line 47)
        invoked from within
    "tk::MenuInvoke .rowctxmenu 1"
        (command bound to event)

The following seems to fix it.
------------
Fix diff invoked from the right-click menu.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
# - master: [PATCH] Making it easier to find which change introduced a bug
# + (working tree)
diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -2700,7 +2700,7 @@ proc diffvssel {dirn} {
     $ctext conf -state disabled
     $ctext tag delete Comments
     $ctext tag remove found 1.0 end
-    startdiff $newid [list $oldid]
+    startdiff [list $newid $oldid]
 }
 
 proc mkpatch {} {
