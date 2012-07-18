From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 3/7] git-rebase--interactive: group all $preserve_merges code
Date: Wed, 18 Jul 2012 00:27:31 -0700
Message-ID: <1342596455-17046-4-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 09:27:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOft-0008JJ-15
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab2GRH1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:27:51 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:45914 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab2GRH1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:27:50 -0400
Received: by qcqs25 with SMTP id s25so131374qcq.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=psYJai71C/3IKuxqMJV/jX8RVGMWQvVt4N6O1PoHmDQ=;
        b=TiGdhXpQtQRMUpkckQxa0/kHpt4H4g+wZ4ROROiu8ZbEixE46OYJivWAryHS3uPnlU
         4CK679RjoAAF7ygTnmmP/ZeZw/AEFPkdfoLGbX3zTb7nWMspFSSYVVV3a6sfvG2IGglX
         MXm0t/JpmXycV8IslB2PGcJCShkIDr3Bkn91Dq20YJBTSTAucms9Okg2ILXkBN/qxI8z
         wNfdxoXrQuq6KqptictVbd9yoPj6lILBQU0Jc+xF0pu9vsuee5tOyrCSqlFLc0r/iErN
         j0huD4x2woyKUysTB3tWTbA0kGp8vsSUrYHRq0xBVNlQr7cNOsxanT//o2hVYnZMtjO0
         HnVA==
Received: by 10.236.133.242 with SMTP id q78mr925304yhi.11.1342596469593;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by 10.236.133.242 with SMTP id q78mr925301yhi.11.1342596469553;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id t29si5979705yha.0.2012.07.18.00.27.49
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 52CF31E0048;
	Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id F309FC1658; Wed, 18 Jul 2012 00:27:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQkHMhssYfCCsD0jyf6P5J/r0jsop+52fv16e4jEOfr+dtNiGZIjy6W+OeYcKVCoSOXUYE1w2tPrNNapiMW7aIYU9NFbuzSVCoM+KQwsuBXbd1HGI7M1qKi8DccunhQeQ8kA6T9TJVzoUhVhdROwV89KAR4vkvj7BF0efsXIgvuDeRI5aRY7W1CVuH1n33asMteYVlSG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201658>

The code in git-rebase--interactive that creates the todo file
contains if-blocks that depend on whether $preserve_merges is
active. There is only a very small amount of code in between that is
shared with non-merge-preserving code path, so remove the repeated
conditions and duplicate the small amount of shared code instead.
---
 git-rebase--interactive.sh | 69 ++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index fa722b6..4bb8e3f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -793,28 +793,6 @@ mkdir "$state_dir" || die "Could not create temporary $state_dir"
 
 : > "$state_dir"/interactive || die "Could not mark as interactive"
 write_basic_state
-if test t = "$preserve_merges"
-then
-	if test -z "$rebase_root"
-	then
-		mkdir "$rewritten" &&
-		for c in $(git merge-base --all $orig_head $upstream)
-		do
-			echo $onto > "$rewritten"/$c ||
-				die "Could not init rewritten commits"
-		done
-	else
-		mkdir "$rewritten" &&
-		echo $onto > "$rewritten"/root ||
-			die "Could not init rewritten commits"
-	fi
-	# No cherry-pick because our first pass is to determine
-	# parents to rewrite and skipping dropped commits would
-	# prematurely end our probe
-	merges_option=
-else
-	merges_option="--no-merges --cherry-pick"
-fi
 
 shorthead=$(git rev-parse --short $orig_head)
 shortonto=$(git rev-parse --short $onto)
@@ -839,16 +817,30 @@ add_pick_line () {
 	printf '%s\n' "${comment_out}pick $1 $2" >>"$todo"
 }
 
-git rev-list $merges_option --pretty=oneline --abbrev-commit \
-	--abbrev=7 --reverse --left-right --topo-order \
-	$revisions | \
-	sed -n "s/^>//p" |
-while read -r shortsha1 rest
-do
-	if test t != "$preserve_merges"
+if test t = "$preserve_merges"
+then
+	if test -z "$rebase_root"
 	then
-		add_pick_line $shortsha1 "$rest"
+		mkdir "$rewritten" &&
+		for c in $(git merge-base --all $orig_head $upstream)
+		do
+			echo $onto > "$rewritten"/$c ||
+				die "Could not init rewritten commits"
+		done
 	else
+		mkdir "$rewritten" &&
+		echo $onto > "$rewritten"/root ||
+			die "Could not init rewritten commits"
+	fi
+	# No cherry-pick because our first pass is to determine
+	# parents to rewrite and skipping dropped commits would
+	# prematurely end our probe
+	git rev-list --pretty=oneline --abbrev-commit \
+		--abbrev=7 --reverse --left-right --topo-order \
+		$revisions |
+	sed -n "s/^>//p" |
+	while read -r shortsha1 rest
+	do
 		sha1=$(git rev-parse $shortsha1)
 		if test -z "$rebase_root"
 		then
@@ -868,12 +860,8 @@ do
 			touch "$rewritten"/$sha1
 			add_pick_line $shortsha1 "$rest"
 		fi
-	fi
-done
-
-# Watch for commits that been dropped by --cherry-pick
-if test t = "$preserve_merges"
-then
+	done
+	# Watch for commits that been dropped by --cherry-pick
 	mkdir "$dropped"
 	# Save all non-cherry-picked changes
 	git rev-list $revisions --left-right --cherry-pick | \
@@ -895,6 +883,15 @@ then
 			rm "$rewritten"/$rev
 		fi
 	done
+else
+	git rev-list --no-merges --cherry-pick --pretty=oneline --abbrev-commit \
+		--abbrev=7 --reverse --left-right --topo-order \
+		$revisions |
+	sed -n "s/^>//p" |
+	while read -r shortsha1 rest
+	do
+		add_pick_line $shortsha1 "$rest"
+	done
 fi
 
 test -s "$todo" || echo noop >> "$todo"
-- 
1.7.11.1.104.ge7b44f1
