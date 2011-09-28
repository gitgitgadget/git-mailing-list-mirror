From: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
Subject: [GUILT 3/6] Handle paths that contain spaces
Date: Wed, 28 Sep 2011 15:15:21 +0100
Message-ID: <1317219324-10319-3-git-send-email-alan.christopher.jenkins@googlemail.com>
References: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Cc: git@vger.kernel.org,
	Alan Jenkins <alan.christopher.jenkins@googlemail.com>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Wed Sep 28 16:16:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uwS-0007Ie-UP
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642Ab1I1OQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:16:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61456 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab1I1OQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:16:53 -0400
Received: by wwf22 with SMTP id 22so8982121wwf.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OXu8+zkTyL+W6zNYzrcpYaQ+Ge2rS1SKq138zdtqSrA=;
        b=Q/PUb+Snkbm1zQTmg/VyUR0V15mSeTgzBmaq94pupzKzyHPIeEFUDYDU/IfeycL6ov
         YTf1s4WnoDey5Z8Kf3n4RiXZKswmlzVdsIs3puQukjesFVBNXM2Rc0Oczv7l+/6g5PUI
         LhaWrKEwXbrRT7ivrPVk19qgxqZvqtXXzHPBk=
Received: by 10.216.185.74 with SMTP id t52mr1169002wem.25.1317219411706;
        Wed, 28 Sep 2011 07:16:51 -0700 (PDT)
Received: from localhost.localdomain ([86.53.68.233])
        by mx.google.com with ESMTPS id n21sm40795936wbp.2.2011.09.28.07.16.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 07:16:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182321>


Signed-off-by: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
---
 guilt           |    6 +++---
 guilt-applied   |    4 ++--
 guilt-files     |    4 ++--
 guilt-fold      |    2 +-
 guilt-new       |    2 +-
 guilt-next      |    2 +-
 guilt-pop       |   12 ++++++------
 guilt-push      |    6 +++---
 guilt-series    |    4 ++--
 guilt-unapplied |    2 +-
 10 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/guilt b/guilt
index 5d79e0f..9f06b41 100755
--- a/guilt
+++ b/guilt
@@ -196,7 +196,7 @@ get_full_series()
 
 		p
 		}
-		" $series
+		" "$series"
 }
 
 get_series()
@@ -632,7 +632,7 @@ push_patch()
 
 		commit "$pname" HEAD
 
-		echo "$pname" >> $applied
+		echo "$pname" >> "$applied"
 
 		rm -f "$TMP_LOG"
 	)
@@ -739,7 +739,7 @@ __refresh_patch()
 
 		# move the new patch in
 		mv "$p" "$p~"
-		mv "$TMP_DIFF" $p
+		mv "$TMP_DIFF" "$p"
 
 		# commit
 		commit "$pname" "HEAD~$3"
diff --git a/guilt-applied b/guilt-applied
index ead787b..a1f684a 100755
--- a/guilt-applied
+++ b/guilt-applied
@@ -14,7 +14,7 @@ _main() {
 case $# in
 	0)
 		# just output the regular series-style applied list
-		cat $applied
+		cat "$applied"
 	;;
 
 	1)
@@ -22,7 +22,7 @@ case $# in
 			usage
 		fi
 
-		cat $applied | while read pname; do
+		cat "$applied" | while read pname; do
 			git show-ref refs/patches/$branch/$pname | sed -e "s,refs/patches/$branch/,,"
 		done
 	;;
diff --git a/guilt-files b/guilt-files
index 9188070..f31a94c 100755
--- a/guilt-files
+++ b/guilt-files
@@ -34,9 +34,9 @@ top_patch=`get_top`
 
 IFS=:
 if [ -n "$opt_all" ]; then
-	cat $applied
+	cat "$applied"
 else
-	tail -n 1 $applied
+	tail -n 1 "$applied"
 fi | while read patch; do
 	obj=`git rev-parse refs/patches/$branch/$patch`
 
diff --git a/guilt-fold b/guilt-fold
index 9bf0d6e..06fbb7f 100755
--- a/guilt-fold
+++ b/guilt-fold
@@ -36,7 +36,7 @@ if ! must_commit_first; then
 fi
 
 # make sure it is not applied
-pline=`cat $applied | grep -e "^$patch$"`
+pline=`cat "$applied" | grep -e "^$patch$"`
 if [ ! -z "$pline" ]; then
 	die "Patch is applied. Pop the patch first."
 fi
diff --git a/guilt-new b/guilt-new
index c660dfc..402104e 100755
--- a/guilt-new
+++ b/guilt-new
@@ -95,7 +95,7 @@ fi
 series_insert_patch "$patch"
 
 # apply the patch
-echo "$patch" >> $applied
+echo "$patch" >> "$applied"
 commit "$patch" HEAD
 
 }
diff --git a/guilt-next b/guilt-next
index 5ac026b..a0941fc 100755
--- a/guilt-next
+++ b/guilt-next
@@ -21,7 +21,7 @@ while [ $# -ne 0 ]; do
 	shift
 done
 
-n=`wc -l < $applied`
+n=`wc -l < "$applied"`
 n=$(($n + 1))
 
 p=`get_series | awk "{ if (NR == $n) print \\$0}"`
diff --git a/guilt-pop b/guilt-pop
index 77d2c88..df466c7 100755
--- a/guilt-pop
+++ b/guilt-pop
@@ -55,14 +55,14 @@ if [ ! -s "$applied" ]; then
 elif [ "$patch" = "-a" ]; then
 	# we are supposed to pop all patches
 
-	sidx=`wc -l < $applied`
+	sidx=`wc -l < "$applied"`
 	eidx=0
 elif [ ! -z "$num" ]; then
 	# we are supposed to pop a set number of patches
 
 	[ "$patch" -lt 0 ] && die "Invalid number of patches to pop."
 
-	sidx=`wc -l < $applied`
+	sidx=`wc -l < "$applied"`
 	eidx=`expr $sidx - $patch`
 
 	# catch underflow
@@ -71,19 +71,19 @@ elif [ ! -z "$num" ]; then
 elif [ -z "$patch" ]; then
 	# we are supposed to pop only the current patch on the stack
 
-	sidx=`wc -l < $applied`
+	sidx=`wc -l < "$applied"`
 	eidx=`expr $sidx - 1`
 else
 	# we're supposed to pop only up to a patch, make sure the patch is
 	# in the series
 
-	eidx=`cat $applied | grep -ne "^$patch$" | cut -d: -f 1`
+	eidx=`cat "$applied" | grep -ne "^$patch$" | cut -d: -f 1`
 	if [ -z "$eidx" ]; then
 		die "Patch $patch is not in the series/is not applied"
 	fi
 
 	eidx=`expr $eidx - 1`
-	sidx=`wc -l < $applied`
+	sidx=`wc -l < "$applied"`
 fi
 
 # make sure that there are no unapplied changes
@@ -94,7 +94,7 @@ elif ! must_commit_first; then
 	die "Uncommited changes detected. Refresh first."
 fi
 
-l=`awk "BEGIN{n=0}(n==$eidx){print \\$0; exit}{n=n+1}END{}" < $applied`
+l=`awk "BEGIN{n=0}(n==$eidx){print \\$0; exit}{n=n+1}END{}" < "$applied"`
 
 pop_many_patches `git rev-parse refs/patches/$branch/$l^` `expr $sidx - $eidx`
 
diff --git a/guilt-push b/guilt-push
index 05bcef5..d9a8590 100755
--- a/guilt-push
+++ b/guilt-push
@@ -72,7 +72,7 @@ elif [ ! -z "$num" ]; then
 	eidx=`get_series | wc -l`
 
 	# calculate end index from current
-	tidx=`wc -l < $applied`
+	tidx=`wc -l < "$applied"`
 	tidx=`expr $tidx + $patch`
 
 	# clamp to minimum
@@ -81,7 +81,7 @@ elif [ ! -z "$num" ]; then
 elif [ -z "$patch" ]; then
 	# we are supposed to push only the next patch onto the stack
 
-	eidx=`wc -l < $applied`
+	eidx=`wc -l < "$applied"`
 	eidx=`expr $eidx + 1`
 else
 	# we're supposed to push only up to a patch, make sure the patch is
@@ -99,7 +99,7 @@ if ! must_commit_first; then
 fi
 
 # now, find the starting patch
-sidx=`wc -l < $applied`
+sidx=`wc -l < "$applied"`
 sidx=`expr $sidx + 1`
 
 # do we actually have to push anything?
diff --git a/guilt-series b/guilt-series
index d9b1cc2..c87b31e 100755
--- a/guilt-series
+++ b/guilt-series
@@ -30,8 +30,8 @@ if [ ! -z "$edit" ]; then
 	git_editor "$series"
 elif [ ! -z "$gui" ]; then
 	[ -z "`get_top`" ] && die "No patches applied."
-	bottom=`git rev-parse refs/patches/$branch/$(head_n 1 $applied)`
-	top=`git rev-parse refs/patches/$branch/$(tail -n 1 $applied)`
+	bottom=`git rev-parse refs/patches/$branch/$(head_n 1 "$applied")`
+	top=`git rev-parse refs/patches/$branch/$(tail -n 1 "$applied")`
 	range="$bottom..$top"
 
 	# FIXME, this doesn't quite work - it's perfectly fine with
diff --git a/guilt-unapplied b/guilt-unapplied
index 67ee1aa..e703408 100755
--- a/guilt-unapplied
+++ b/guilt-unapplied
@@ -15,7 +15,7 @@ if [ $# -ne 0 ]; then
 	usage
 fi
 
-n=`wc -l < $applied`
+n=`wc -l < "$applied"`
 n=`expr $n + 1`
 
 get_series | sed -n -e "$n,\$p"
-- 
1.7.4.1
