From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-fetch: Shell syntax fix for NetBSD
Date: Sun, 28 May 2006 14:04:01 -0700
Message-ID: <7vbqthdfpa.fsf@assigned-by-dhcp.cox.net>
References: <20060528204510.G51ab1cf8@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 28 23:04:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkSR1-00062g-JS
	for gcvg-git@gmane.org; Sun, 28 May 2006 23:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWE1VEE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 17:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWE1VEE
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 17:04:04 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:50404 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750930AbWE1VEC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 17:04:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060528210402.GCIP24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 May 2006 17:04:02 -0400
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060528204510.G51ab1cf8@leonov.stosberg.net> (Dennis Stosberg's
	message of "Sun, 28 May 2006 22:45:10 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20894>

Dennis Stosberg <dennis@stosberg.net> writes:

> NetBSD's default shell does not accept an opening parenthesis in
> a case switch.
>
> $ ./git-fetch
> ./git-fetch: 219: Syntax error: word unexpected (expecting ")")
>
> ---
> With this change applied to the next branch, all tests complete
> successfully on NetBSD 3.0 without having bash installed.

Funny.  Without the posixy open parenthesis, bash barfs ;-).

        git-fetch: line 219: syntax error near unexpected token `;;'
        git-fetch: line 219: `                 *^*) continue ;;'

So how about doing this instead?  Does NetBSD default shell
still work with it?

diff --git a/git-fetch.sh b/git-fetch.sh
index 280f62e..69bd810 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -211,12 +211,12 @@ # Otherwise we do what we always did.
 reflist=$(get_remote_refs_for_fetch "$@")
 if test "$tags"
 then
-	taglist=$(IFS="	" &&
+	taglist=`IFS="	" &&
 		  git-ls-remote $upload_pack --tags "$remote" |
 	          while read sha1 name
 		  do
 			case "$name" in
-			(*^*) continue ;;
+			*^*) continue ;;
 			esac
 		  	if git-check-ref-format "$name"
 			then
@@ -224,7 +224,7 @@ then
 			else
 			    echo >&2 "warning: tag ${name} ignored"
 			fi
-		  done)
+		  done`
 	if test "$#" -gt 1
 	then
 		# remote URL plus explicit refspecs; we need to merge them.
