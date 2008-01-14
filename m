From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Remove usage of git- (dash) commands from email hook
Date: Sun, 13 Jan 2008 22:51:01 -0600
Message-ID: <1200286261-12209-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 05:51:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEHIQ-0001i2-9l
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 05:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbYANEvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 23:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbYANEvI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 23:51:08 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:55331 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbYANEvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 23:51:05 -0500
Received: by py-out-1112.google.com with SMTP id u52so2866261pyb.10
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 20:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=iMepLhZoiqug0hcYy9mveLW2wdguwvjkQ3l4/FpDvwI=;
        b=IvK9t1XwuykBOOCZeTym3hZHGlW7DLrZyKn1QXanmsi9HaLT1gGo7tTyYZmFflpPS3Kv4prk3QJJCgelkRi2x0A+sTmdqPXJw9iB/bWc6Hwt+wW/DAp6MUd7N6rdaVpQy5oHJPN8z5LZahjBPXYuOIzsrXyjQf7jDRNPCN+dOX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Zpw7FS+67eDG+tgEWs2VEJcSttjyJgAPjDhhthRQaJCPdIskMtnDsg8y9gx/9t7J+BRaWVhD5HeNhU1omnNO74AKlTnOqxtZnNNDj2TKtGriXoMIdFDeC4p0mx7pwB6vXFzGTo23UClMNQdmlnc/WOz2MNnHWCc/rH6vzRzC9mE=
Received: by 10.35.96.6 with SMTP id y6mr7247227pyl.46.1200286264410;
        Sun, 13 Jan 2008 20:51:04 -0800 (PST)
Received: from localhost ( [76.197.238.51])
        by mx.google.com with ESMTPS id w67sm19787830pyg.29.2008.01.13.20.51.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 20:51:03 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70438>

Switch all git command calls to use the git (space) command format, and
remove the use of git-repo-config in place of git config.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 contrib/hooks/post-receive-email |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 7511ea0..77c88eb 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -248,24 +248,24 @@ generate_update_branch_email()
 	# In this case we want to issue an email containing only revisions
 	# 3, 4, and N.  Given (almost) by
 	#
-	#  git-rev-list N ^O --not --all
+	#  git rev-list N ^O --not --all
 	#
 	# The reason for the "almost", is that the "--not --all" will take
 	# precedence over the "N", and effectively will translate to
 	#
-	#  git-rev-list N ^O ^X ^N
+	#  git rev-list N ^O ^X ^N
 	#
-	# So, we need to build up the list more carefully.  git-rev-parse
-	# will generate a list of revs that may be fed into git-rev-list.
+	# So, we need to build up the list more carefully.  git rev-parse
+	# will generate a list of revs that may be fed into git rev-list.
 	# We can get it to make the "--not --all" part and then filter out
 	# the "^N" with:
 	#
-	#  git-rev-parse --not --all | grep -v N
+	#  git rev-parse --not --all | grep -v N
 	#
-	# Then, using the --stdin switch to git-rev-list we have effectively
+	# Then, using the --stdin switch to git rev-list we have effectively
 	# manufactured
 	#
-	#  git-rev-list N ^O ^X
+	#  git rev-list N ^O ^X
 	#
 	# This leaves a problem when someone else updates the repository
 	# while this script is running.  Their new value of the ref we're
@@ -274,10 +274,10 @@ generate_update_branch_email()
 	# all of our commits.  What we really want is to exclude the current
 	# value of $refname from the --not list, rather than N itself.  So:
 	#
-	#  git-rev-parse --not --all | grep -v $(git-rev-parse $refname)
+	#  git rev-parse --not --all | grep -v $(git rev-parse $refname)
 	#
 	# Get's us to something pretty safe (apart from the small time
-	# between refname being read, and git-rev-parse running - for that,
+	# between refname being read, and git rev-parse running - for that,
 	# I give up)
 	#
 	#
@@ -295,7 +295,7 @@ generate_update_branch_email()
 	# As above, we need to take into account the presence of X; if
 	# another branch is already in the repository and points at some of
 	# the revisions that we are about to output - we don't want them.
-	# The solution is as before: git-rev-parse output filtered.
+	# The solution is as before: git rev-parse output filtered.
 	#
 	# Finally, tags: 1 --- 2 --- O --- T --- 3 --- 4 --- N
 	#
@@ -305,7 +305,7 @@ generate_update_branch_email()
 	# for a branch update.  Therefore we still want to output revisions
 	# that have been output on a tag email.
 	#
-	# Luckily, git-rev-parse includes just the tool.  Instead of using
+	# Luckily, git rev-parse includes just the tool.  Instead of using
 	# "--all" we use "--branches"; this has the added benefit that
 	# "remotes/" will be ignored as well.
 
@@ -454,7 +454,7 @@ generate_update_atag_email()
 #
 generate_atag_email()
 {
-	# Use git-for-each-ref to pull out the individual fields from the
+	# Use git for-each-ref to pull out the individual fields from the
 	# tag
 	eval $(git for-each-ref --shell --format='
 	tagobject=%(*objectname)
@@ -572,7 +572,7 @@ generate_general_email()
 	else
 		# What can we do here?  The tag marks an object that is not
 		# a commit, so there is no log for us to display.  It's
-		# probably not wise to output git-cat-file as it could be a
+		# probably not wise to output git cat-file as it could be a
 		# binary blob.  We'll just say how big it is
 		echo "$newrev is a $newrev_type, and is $(git cat-file -s $newrev) bytes long."
 	fi
@@ -622,10 +622,10 @@ then
 	projectdesc="UNNAMED PROJECT"
 fi
 
-recipients=$(git repo-config hooks.mailinglist)
-announcerecipients=$(git repo-config hooks.announcelist)
-envelopesender=$(git-repo-config hooks.envelopesender)
-emailprefix=$(git-repo-config hooks.emailprefix || echo '[SCM] ')
+recipients=$(git config hooks.mailinglist)
+announcerecipients=$(git config hooks.announcelist)
+envelopesender=$(git config hooks.envelopesender)
+emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
-- 
1.5.4.rc3
