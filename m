From: Junio C Hamano <junkio@cox.net>
Subject: Re: More verbose "git fetch"?
Date: Sat, 03 Jun 2006 23:25:05 -0700
Message-ID: <7v3bele8u6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606031809550.5498@g5.osdl.org>
	<7v7j3xebg6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 08:25:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmm35-00024V-Mi
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 08:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWFDGZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 02:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWFDGZI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 02:25:08 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:30614 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932101AbWFDGZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 02:25:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604062506.LBJB15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 02:25:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v7j3xebg6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 03 Jun 2006 22:28:41 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21246>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> Has it always spit out those annoying
>>
>> 	xyz: same as branch 'xyz' of so-and-so-repo
>>
>> even without "-v"? I thought I killed them at some point, but 
>> either they're back, or I'm just confused.
>
> "same" is protected with [ "$verboase" ] only on the tag side
> but not on the head side, which I think is a bug.  Will fix.

...like this.

---
diff --git a/git-fetch.sh b/git-fetch.sh
index 69bd810..6ee755c 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -166,7 +166,7 @@ fast_forward_local () {
 	    mb=$(git-merge-base "$local" "$2") &&
 	    case "$2,$mb" in
 	    $local,*)
-		echo >&2 "* $1: same as $3"
+	        [ "$verbose" ] && echo >&2 "* $1: same as $3"
 		;;
 	    *,$local)
 		echo >&2 "* $1: fast forward to $3"
