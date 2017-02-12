Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47ED51FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 21:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdBLVye (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 16:54:34 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34675 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdBLVyb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 16:54:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so16203085wmi.1
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 13:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=20ZLy7eeWZHo1dkbBkesjgK655qdB0W96xHL9pZHJhk=;
        b=iGxJpnDodkXb2zUZ0aJEay53l0WQyR9sGP3i+aUjJVQFCS7Di4IIZl1v3dbELRDf+l
         r4oVtnsBF+fXJdDgnlFsWgpQX8cShl0wi4UIrDKTrbryiMU4nv4AYWRJ6OoHF0t+B8P3
         vaK7DbpWtwYzysegB85HdwS3SxOP5Zzf/ZRFd8G1NNQVO9mnH71O5VCeT7DEixeeGCHd
         vraH+ciIbONGjiPR0tHNiGKvJjK6oWNIZ0LQITPp9wFpfvUN4EKqXUsIpbdlgozv+Zyt
         VQ44UHzfIw/L5ohXqHAFMkGGKuWFhBk3DoZxOfsbrRUBluqb44+p3+H6NOr12oSJMcI4
         6qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=20ZLy7eeWZHo1dkbBkesjgK655qdB0W96xHL9pZHJhk=;
        b=qPsJpEyejVwHkNj6bkl5Uq/RLdHnbAP64hkMvQ+qJRxzwQ3IO3mGsEj+46RKMf4y0N
         7Ucr/pvA0XKsW0Az6RMbJ901gKkR8vTo+7lx71xY0ORx6iUC29WMzo/xZkm1ftQFzLR8
         Ue2OhpwsYoiVW6CBEpVp48/fChmDD2FMspZe7TL1sgFnq8JM6GpD7jCXLX/46Hn0fl9m
         I7s3unX0NJA8zHoZOUvXrCtUPKIfOhIvkph0mT2XbYmXr0u4CMWduOo9TI3UgKWxfy3b
         ctQeowb/x2UQBhvruE1WNF1q9XP7qkkQ5J9hJ8jav+ZfgJHWLrnJ1jZMF9enrMAHxaM3
         KZpQ==
X-Gm-Message-State: AMke39n0sjgeqZkgDo8itEGu0ACbvODFIxnWNktatxtUBASfj2dyHJVy8vbaBTn3jb2Cpw==
X-Received: by 10.28.143.204 with SMTP id r195mr15924976wmd.32.1486936464995;
        Sun, 12 Feb 2017 13:54:24 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 17sm11340249wru.16.2017.02.12.13.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Feb 2017 13:54:24 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 4/7] stash: introduce new format create
Date:   Sun, 12 Feb 2017 21:54:17 +0000
Message-Id: <20170212215420.16701-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g86e6ecc671.dirty
In-Reply-To: <20170212215420.16701-1-t.gummerer@gmail.com>
References: <mailto:20170205202642.14216-1-t.gummerer@gmail.com>
 <20170212215420.16701-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git stash create currently supports a positional argument for adding a
message.  This is not quite in line with how git commands usually take
comments (using a -m flag).

Add a new syntax for adding a message to git stash create using a -m
flag.  This is with the goal of deprecating the old style git stash
create with positional arguments.

This also adds a -u argument, for untracked files.  This is already used
internally as another positional argument, but can now be used from the
command line.

This introduces a slight regression, when git stash create -m works is
used.  Before this change, it created a stash with the message
"-m works", but now it creates a stash with the message "-m".

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt |  1 +
 git-stash.sh                | 52 +++++++++++++++++++++++++++++++++++++++++----
 t/t3903-stash.sh            |  9 ++++++++
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2e9e344cd7..a138ed6a24 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
 'git stash' create [<message>]
+'git stash' create [-m <message>] [-u|--include-untracked <untracked|all>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
diff --git a/git-stash.sh b/git-stash.sh
index 8365ebba2a..6d629fc43f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -58,8 +58,52 @@ clear_stash () {
 }
 
 create_stash () {
-	stash_msg="$1"
-	untracked="$2"
+	stash_msg=
+	untracked=
+	new_style=
+	while test $# != 0
+	do
+		case "$1" in
+		-m|--message)
+			shift
+			test -z ${1+x} && usage
+			stash_msg="$1"
+			new_style=t
+			;;
+		-u|--include-untracked)
+			shift
+			test -z ${1+x} && usage
+			untracked="$1"
+			new_style=t
+			;;
+		*)
+			if test -n "$new_style"
+			then
+				echo "invalid argument"
+				option="$1"
+				# TRANSLATORS: $option is an invalid option, like
+				# `--blah-blah'. The 7 spaces at the beginning of the
+				# second line correspond to "error: ". So you should line
+				# up the second line with however many characters the
+				# translation of "error: " takes in your language. E.g. in
+				# English this is:
+				#
+				#    $ git stash save --blah-blah 2>&1 | head -n 2
+				#    error: unknown option for 'stash save': --blah-blah
+				#           To provide a message, use git stash save -- '--blah-blah'
+				eval_gettextln "error: unknown option for 'stash create': \$option"
+				usage
+			fi
+			break
+			;;
+		esac
+		shift
+	done
+
+	if test -z "$new_style"
+	then
+		stash_msg="$*"
+	fi
 
 	git update-index -q --refresh
 	if no_changes
@@ -268,7 +312,7 @@ push_stash () {
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
-	create_stash "$stash_msg" $untracked
+	create_stash -m "$stash_msg" -u "$untracked"
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
@@ -667,7 +711,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash "$*" && echo "$w_commit"
+	create_stash "$@" && echo "$w_commit"
 	;;
 store)
 	shift
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ffe3549ea5..812d0f7a40 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -802,4 +802,13 @@ test_expect_success 'create with multiple arguments for the message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'new style stash create stores correct message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create -m "create test message new style") &&
+	echo "On master: create test message new style" >expect &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.301.g86e6ecc671.dirty

