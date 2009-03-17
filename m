From: Olivier Goffart <ogoffart@kde.org>
Subject: Ability to edit message from git rebase --interactive.
Date: Tue, 17 Mar 2009 19:53:23 +0100
Message-ID: <200903171953.23650.ogoffart@kde.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jG/vJnD5WmG0P2/"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 19:51:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjeNc-0007eY-B8
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 19:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756476AbZCQStn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 14:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756206AbZCQStn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 14:49:43 -0400
Received: from hoat.troll.no ([62.70.27.150]:44333 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbZCQStn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 14:49:43 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 6BDF2213AA
	for <git@vger.kernel.org>; Tue, 17 Mar 2009 19:49:36 +0100 (CET)
Received: from og21.localnet (unknown [172.24.91.237])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 61D80213A8
	for <git@vger.kernel.org>; Tue, 17 Mar 2009 19:49:36 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.28-ARCH; KDE/4.2.66; x86_64; svn-920023; 2009-01-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113517>

--Boundary-00=_jG/vJnD5WmG0P2/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello.

I use git in a workflow in wich we often need to edit the message logs of some 
commits.
The way we do it is using git rebase -i    and choose edit.   
But then you need to do git commit --amend and git rebase --continue,  which 
is error prone and add more useless steps.

The attached patch add a new keyword to git rebase interactive to just edit 
the message log.

I was told on IRC that this has been discussed already not so long ago, and 
looking on the archive[1], all i seen was bikesheeding .  Here is a patch :-)

Do you think it make sens to have that in git?

Please CC me replies.

-- 
Olivier


[1] http://thread.gmane.org/gmane.comp.version-control.git/105738
(my patch is different from this one as it adds a new keyword rather than 
change the behavior of one existing one)


--Boundary-00=_jG/vJnD5WmG0P2/
Content-Type: text/x-patch;
  charset="ISO-8859-1";
  name="editmessage.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="editmessage.diff"

commit 71793acdd9f926ea52d034b17ac3465e3a810799
Author: Olivier Goffart <ogoffart@kde.org>
Date:   Tue Mar 17 19:41:40 2009 +0100

    rebase interactive: add the possibility to easily edit the message log of commits

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3dc659d..6ded58e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -406,6 +406,16 @@ do_next () {
 			die_with_patch $sha1 ""
 		fi
 		;;
+	message|m)
+		comment_for_reflog message
+
+		mark_action_done
+
+		pick_one $sha1 ||
+			die_with_patch $sha1 "Could not apply $sha1... $rest"
+
+		git commit --amend || failed=t
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		die_with_patch $sha1 "Please fix this in the file $TODO."
@@ -730,6 +740,7 @@ first and then run 'git rebase --continue' again."
 #  p, pick = use commit
 #  e, edit = use commit, but stop for amending
 #  s, squash = use commit, but meld into previous commit
+#  m, message = use commit and promt the editor to edit the message log
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.

--Boundary-00=_jG/vJnD5WmG0P2/--
