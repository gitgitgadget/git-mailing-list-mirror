From: Junio C Hamano <junkio@cox.net>
Subject: Re: "Patch is empty.  Was is split wrong?"
Date: Fri, 16 Mar 2007 21:19:42 -0700
Message-ID: <7vy7lwtsbl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703161925190.3910@woody.linux-foundation.org>
	<7v3b44v825.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 05:20:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSQOf-0003gR-Hc
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 05:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbXCQETp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 00:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbXCQETp
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 00:19:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50633 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbXCQETo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 00:19:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070317041944.LGAW2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 17 Mar 2007 00:19:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bgKj1W00H1kojtg0000000; Sat, 17 Mar 2007 00:19:44 -0400
In-Reply-To: <7v3b44v825.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 16 Mar 2007 20:54:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42421>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> My usage of "git-applymbox -u" these days always results in these bogus 
>> warnings:
>>
>> 	Patch is empty.  Was is split wrong?
>> 	/home/torvalds/bin/git-applymbox: line 82: stop_here: command not found
>>
>> but then it applies the patch anyway.
>>
>> Hmm? I've not looked into it any more yet.
>
> Sounds like two new bugs from the mailinfo series we added last
> week, primarily 87ab7992 and f0658cf2.

Sheesh.  Sorry, for a false patch.  Here is a fix (will do this
on 'master' tonight).

diff --git a/git-applymbox.sh b/git-applymbox.sh
index 2cbdc7e..3efd6a7 100755
--- a/git-applymbox.sh
+++ b/git-applymbox.sh
@@ -77,9 +77,9 @@ do
     *)
 	    git-mailinfo $keep_subject $utf8 \
 		.dotest/msg .dotest/patch <$i >.dotest/info || exit 1
-	    test -s $dotest/patch || {
+	    test -s .dotest/patch || {
 		echo "Patch is empty.  Was is split wrong?"
-		stop_here $this
+		exit 1
 	    }
 	    git-stripspace < .dotest/msg > .dotest/msg-clean
 	    ;;
