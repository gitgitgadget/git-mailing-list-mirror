From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 2/3] contrib/subtree: remove use of -a/-o in [ commands
Date: Sun, 24 Mar 2013 19:37:42 +0000
Message-ID: <1364153863-27437-3-git-send-email-pcampbell@kemitix.net>
References: <1364153863-27437-1-git-send-email-pcampbell@kemitix.net>
Cc: greened@obbligato.org, Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Pelle Wessman" <pelle@kodfabrik.se>,
	"Win Treese" <treese@acm.org>, "Wayne Walter" <wayne@tickzoom.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 20:38:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJqkh-00016y-02
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 20:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab3CXTiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 15:38:10 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33424 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab3CXTiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 15:38:05 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so9436743wib.15
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 12:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=rLYGTBjtSBmcHhCKnkFB/ENuwigdGadUl3TO+Y9PvRM=;
        b=LiyeZTIB5yu/t/6wmIMmbz24Poz2kzfIjgM2TRBzpR1Ud4xtax+3Kna+q+H+Vgfima
         Pv8tqUvX1nIZ0ri9tJoEAJTBGfpJKOVmt1FF4g5Vd0w19qbOdQuWLyrk7+WbTVedPh+1
         3H9AtU8na6zKUzhurJQGEJXyAmVhKayOvSx1ANEzXCPiLeY5exFxqpJqLyQo0LAeTPG6
         LtNnJuck0w/JBrqf31lhgBXv3WBOXtmLdbmgpoHS2BWFQrXWRMyqi0SZrQ0/r7rFGY6z
         yOVsYkj2KCNLvuuNC0RkTNbifR4hHXa4rIEtfgDG3UVvWcJvcqsRWm3Tq1kG00SLvQYB
         /Ctw==
X-Received: by 10.180.94.135 with SMTP id dc7mr21646295wib.11.1364153884559;
        Sun, 24 Mar 2013 12:38:04 -0700 (PDT)
Received: from coyote.home (host-2-102-87-178.as13285.net. [2.102.87.178])
        by mx.google.com with ESMTPS id ek4sm23825220wib.11.2013.03.24.12.38.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 12:38:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364153863-27437-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQlcHZfneFb405zIwmIg1CFolQoSpkNuASGcQ2MMIdEfTP6XBWu/6LYeRjMB9pCDzr1iPaAx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218969>

Use of -a and -o in the [ command can have confusing semantics.

Use a separate test invocation for each single test, combining them with
&& and ||, and use ordinary parentheses for grouping.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 5701376..884cbfb 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -119,7 +119,7 @@ esac
 
 dir="$(dirname "$prefix/.")"
 
-if [ "$command" != "pull" -a "$command" != "add" -a "$command" != "push" ]; then
+if ( test "$command" != "pull" ) && ( test "$command" != "add" ) && ( test "$command" != "push" ); then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs="$(git rev-parse --no-revs --no-flags "$@")" || exit $?
 	if [ -n "$dirs" ]; then
@@ -181,9 +181,9 @@ cache_set()
 {
 	oldrev="$1"
 	newrev="$2"
-	if [ "$oldrev" != "latest_old" \
-	     -a "$oldrev" != "latest_new" \
-	     -a -e "$cachedir/$oldrev" ]; then
+	if ( test "$oldrev" != "latest_old" ) \
+	     && ( test "$oldrev" != "latest_new" ) \
+	     && ( test -e "$cachedir/$oldrev" ); then
 		die "cache for $oldrev already exists!"
 	fi
 	echo "$newrev" >"$cachedir/$oldrev"
@@ -273,12 +273,12 @@ find_existing_splits()
 			git-subtree-split:) sub="$b" ;;
 			END)
 				debug "  Main is: '$main'"
-				if [ -z "$main" -a -n "$sub" ]; then
+				if ( test -z "$main" ) && ( test -n "$sub" ); then
 					# squash commits refer to a subtree
 					debug "  Squash: $sq from $sub"
 					cache_set "$sq" "$sub"
 				fi
-				if [ -n "$main" -a -n "$sub" ]; then
+				if ( test -n "$main" ) && (test -n "$sub" ); then
 					debug "  Prior: $main -> $sub"
 					cache_set $main $sub
 					cache_set $sub $sub
@@ -541,7 +541,7 @@ cmd_add_commit()
 	tree=$(git write-tree) || exit $?
 	
 	headrev=$(git rev-parse HEAD) || exit $?
-	if [ -n "$headrev" -a "$headrev" != "$rev" ]; then
+	if ( test -n "$headrev" ) && ( test "$headrev" != "$rev" ); then
 		headp="-p $headrev"
 	else
 		headp=
-- 
1.8.2
