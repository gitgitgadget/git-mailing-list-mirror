From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] When nothing to git-commit, honor the git-status color
	setting.
Date: Mon, 27 Aug 2007 06:15:09 -0400
Message-ID: <20070827101509.GB23248@coredump.intra.peff.net>
References: <20070826183526.GA16359@ruiner> <20070827082550.GC17373@coredump.intra.peff.net> <20070827094543.GA8014@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 12:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbd8-0001jt-FT
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 12:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbXH0KPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 06:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbXH0KP3
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 06:15:29 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2019 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbXH0KPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 06:15:11 -0400
Received: (qmail 30379 invoked by uid 111); 27 Aug 2007 10:15:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 27 Aug 2007 06:15:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2007 06:15:09 -0400
Content-Disposition: inline
In-Reply-To: <20070827094543.GA8014@ruiner>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56806>

On Mon, Aug 27, 2007 at 05:45:43AM -0400, Brian Hetro wrote:

> I was thinking more along the lines of "use color as if you had run
> git-status" when I decided on $use_status_color.  Perhaps there is a
> better name.

I wonder if the implementation below is slightly more readable.

BTW, I suspect Junio will not apply this until post-1.5.3; I am starting
a queue of such patches that I care about and will re-send after the
release.

-Peff

---
diff --git a/git-commit.sh b/git-commit.sh
index d7e7028..96cec04 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -13,6 +13,7 @@ git rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=t
 case "$0" in
 *status)
 	status_only=t
+	no_override_color=t
 	;;
 *commit)
 	status_only=
@@ -49,7 +50,7 @@ run_status () {
 		export GIT_INDEX_FILE
 	fi
 
-	case "$status_only" in
+	case "$no_override_color" in
 	t) color= ;;
 	*) color=--nocolor ;;
 	esac
@@ -556,7 +557,7 @@ fi
 if [ "$?" != "0" -a ! -f "$GIT_DIR/MERGE_HEAD" -a -z "$amend" ]
 then
 	rm -f "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
-	run_status
+	no_override_color=t run_status
 	exit 1
 fi
 

> 
> Brian
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
