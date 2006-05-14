From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add "--branches", "--tags" and "--remotes" options to git-rev-parse.
Date: Sun, 14 May 2006 16:24:57 -0700
Message-ID: <7v8xp4196e.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP0299DC98A51B55188BDF96AEAD0@CEZ.ICE>
	<7vd5ehu8og.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP043948149786B7EE06DED3AEA20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 01:25:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfPxP-0005ue-Ot
	for gcvg-git@gmane.org; Mon, 15 May 2006 01:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWENXY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 19:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWENXY7
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 19:24:59 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47757 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751403AbWENXY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 19:24:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514232458.JFOS19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 19:24:58 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP043948149786B7EE06DED3AEA20@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sat, 13 May 2006 21:43:00 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19991>

Sean <seanlkml@sympatico.ca> writes:

> On a related note, would it be okay to change "git tag -l" to
> produce a list of tags without the "tags/" prefix in front of
> every tag as it does now?  Wanted to use the new "git
> rev-parse --tags" instead of "find" to produce the list but am
> not sure how important backward compatibility is in that case.

I do not have problem with that, but somebody else's script
might; Cogito seems not to mind.

Something like this perhaps?

-- >8 --
diff --git a/git-tag.sh b/git-tag.sh
index dc6aa95..2286ad5 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -28,11 +28,10 @@ do
         cd "$GIT_DIR/refs" &&
 	case "$#" in
 	1)
-		find tags -type f -print ;;
-	*)
-		shift
-		find tags -type f -print | grep "$@" ;;
+		set x . ;;
 	esac
+	shift
+	find tags -type f -print | sed -e 's|^tags/||' | grep "$@"
 	exit $?
 	;;
     -m)
