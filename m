Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B85D1F855
	for <e@80x24.org>; Wed,  3 Aug 2016 08:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756946AbcHCItV (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 04:49:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33658 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972AbcHCItQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 04:49:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id i6so14242560pfe.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 01:47:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=v5AxTCDl6qXMXSbx9U9YsmgypvVcstzJLpLnF7WUzlg=;
        b=mc/Q3BBER2WRH5RwAbzbCuku0gsAN+4F0A8Na0Xsk0lN4WiiX9Kg1eZ8ElmEW6l4Gh
         qD5r9RxY68LJ2jwMYLZ9dgYoDfW/A5ofpNGmeN+n79eJKQC9QKE3iyGTJepfejcKqq08
         Nub9NlCNqZb6loEaWqo2osULoqwLXiCZg9N1DDRt0Yv7HW/b0hnLTraDGKZotHtBjvCN
         G1H16d3cFPEsOMKTieE6XffaW7UmxnguE5yMqmuuXzXg8CtXPLbDELXQVinUWmA8ATmg
         aYLciJ852KixwXrbp6hcuy8HCp5H4yOOF9TTDecx5A/w2BTr/DwKKo4HAZw9JS/ajmtD
         IUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v5AxTCDl6qXMXSbx9U9YsmgypvVcstzJLpLnF7WUzlg=;
        b=VBGmKJKrlRVBo+rM9lYhq5Zwsdgtk2ozlZokmNwDWbKUE36MiTM+FqUWm/B7GYPBHJ
         8mVhWD20snS2gxwuiYznRTbXPk0Ffyt8ywZwWT4Sr9nA5SE5DWK14drS5mR/+as5yDlh
         nVnOYSBH9RH4wo2W1F+4DNhARS2O1AtxYCtPgeNIrnk1EnCsNMxMtwQtnK71h/1wbDs2
         olYmSHpFLfYIEOEXW5ondUZ6NXvhZeiWJflX8GKYiaWQHLAG5o/WHJwHZ/yaX/1dZyYB
         mmGDLN5Qaz0686Oh9ztum+Recrps8FtsqcQXKNAgoXZPq0yrt8R8BP7kmczS/f3d1ixN
         Uyfw==
X-Gm-Message-State: AEkoouvxNtWN8AY/peZiJD3b3jJ2TFG9Jk1czk9tgqN4OIp216EYsUTxsx4KViI1vlSGiA==
X-Received: by 10.98.36.15 with SMTP id r15mr114838584pfj.1.1470214075288;
        Wed, 03 Aug 2016 01:47:55 -0700 (PDT)
Received: from chrisp-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by smtp.gmail.com with ESMTPSA id sk4sm10593275pac.16.2016.08.03.01.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 01:47:54 -0700 (PDT)
From:	Chris Packham <judge.packham@gmail.com>
To:	git@vger.kernel.org
Cc:	Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCH] rebase--interactive: Add "sign" command
Date:	Wed,  3 Aug 2016 20:47:43 +1200
Message-Id: <20160803084743.3299-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.9.2.518.ged577c6.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is similar to the existing "reword" command in that it can be used
to update the commit message the difference is that the editor presented
to the user for the commit. It provides a useful shorthand for "exec git
commit --amend --no-edit -s"

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
Hi,

At $dayjob we have a patch based work-flow where committers sign patches on the
way through. Occasionally when a larger patch series is involved it's easier
pull from the submitter's repo and use git rebase -i to add the required sign
off either by using 'reword' or 'exec git commit --amend -s'.

This is my attempt at making this a little less cumbersome by adding a
'sign' command. I decided not to add a short version of the command,
partly because 's' was taken and partly because it is a bit of a niche
use-case.

Thanks,
Chris

 git-rebase--interactive.sh    | 10 +++++++++-
 t/lib-rebase.sh               |  2 +-
 t/t3404-rebase-interactive.sh |  9 +++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ded4595..1cd8bc6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -148,6 +148,7 @@ append_todo_help () {
 Commands:
  p, pick = use commit
  r, reword = use commit, but edit the commit message
+ sign = use commit, add sign-off to the commit message
  e, edit = use commit, but stop for amending
  s, squash = use commit, but meld into previous commit
  f, fixup = like \"squash\", but discard this commit's log message
@@ -594,6 +595,13 @@ you are able to reword the commit.")"
 		}
 		record_in_rewritten $sha1
 		;;
+	sign)
+		comment_for_reflog sign
+		mark_action_done
+		do_pick $sha1 "$rest"
+		git commit --amend -s --no-post-rewrite --no-edit ${gpg_sign_opt:+"$gpg_sign_opt"}
+		record_in_rewritten $sha1
+		;;
 	edit|e)
 		comment_for_reflog edit
 
@@ -959,7 +967,7 @@ check_bad_cmd_and_sha () {
 			# Work around CR left by "read" (e.g. with Git for
 			# Windows' Bash).
 			;;
-		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
+		pick|p|drop|d|reword|r|sign|edit|e|squash|s|fixup|f)
 			if ! check_commit_sha "${rest%%[ 	]*}" "$lineno" "$1"
 			then
 				retval=1
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 25a77ee..5a54228 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -47,7 +47,7 @@ set_fake_editor () {
 	action=pick
 	for line in $FAKE_LINES; do
 		case $line in
-		squash|fixup|edit|reword|drop)
+		squash|fixup|edit|reword|sign|drop)
 			action="$line";;
 		exec*)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 197914b..e473ffb 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -690,6 +690,15 @@ test_expect_success 'reword' '
 	git show HEAD~2 | grep "C changed"
 '
 
+test_expect_success 'sign-off' '
+	git checkout -b sign-off-branch master &&
+	set_fake_editor &&
+	FAKE_LINES="1 2 3 sign 4" git rebase -i A &&
+	git show HEAD | grep "Signed-off-by:" &&
+	test $(git rev-parse master) != $(git rev-parse HEAD) &&
+	test $(git rev-parse master^) = $(git rev-parse HEAD^)
+'
+
 test_expect_success 'rebase -i can copy notes' '
 	git config notes.rewrite.rebase true &&
 	git config notes.rewriteRef "refs/notes/*" &&
-- 
2.9.2.518.ged577c6.dirty

