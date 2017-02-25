Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3615D201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbdBYU3d (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:29:33 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34778 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbdBYU2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:28:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id m70so7817587wma.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 12:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e+Pv6QsIQel9cSkjt6tCIqPR+Ig9F9z21lVwE4OyTDs=;
        b=U/p05K6mXLWY2y06Pvn47a9nuHx4oO9BiHhPIfg3ZISRWQQu7as0z91xn9aj2518dn
         p+YJSs74Yrlj+7xTKp3yy74Y2S5q66uZFbHoFt0IGHaX52I4nppoGG1jIrSrtsK77fc6
         a4AfVQ44lYwge9c2tn/Nq/tPQ2Kb7ZoTiRMBNFCyq972FEd1rWAEUEKL0pXI0pb2q0Ta
         vWb7ysstURtVg94i/z9mz7LXkr7OtCC6+BdNxGzUf42C0ba8FhTIKZA+9SIYXll29FHA
         emaJ/RiJ5hk7hlGkK/vji+jbf+LksI3HAbgZOhdFp3JYm4Tm7x8fzFSQqTThs4wIeuFF
         v7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e+Pv6QsIQel9cSkjt6tCIqPR+Ig9F9z21lVwE4OyTDs=;
        b=ACtru0qvtuHFFpR/IaNpv+IZ76FshExA7qQ11Y1RJNyelC35htWpqm1QKt/bcSC/Z5
         P52pgY7A0Meaq/c0vs91uZ/I8/WS8Z8XMPHFMT1ZE3Z5I8JGQv5vmmYxU2iyX2LoNdzn
         lpdrZGoKSKH6yjv3f42HtYawwmQcSF6PDEedVmu7CDwu2BTz4pLDV3jITAPC5oa7TTsx
         Ne7sQ3L1xdCJ+x07qsRH4v1xUzkmm5XJN9SOIh74Azj2QY10l3nm2qVtRJL9Fq7e5SIw
         kbMqcVOwvx65NQ4Pkp/Q2ZIHhSGtiEz4wMlN8WCg3XSUIwPlr4xqH6u345MtpD6e7P2A
         +mbw==
X-Gm-Message-State: AMke39kv4EpDo/W2tR57wg8O3RW/zo/RA4SHYBOVBtLbqjRHwQip4VXyOu1dEEH7sXUwbQ==
X-Received: by 10.28.10.70 with SMTP id 67mr7854378wmk.76.1488054448938;
        Sat, 25 Feb 2017 12:27:28 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id r195sm7605551wme.25.2017.02.25.12.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Feb 2017 12:27:28 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 1/6] stash: introduce push verb
Date:   Sat, 25 Feb 2017 21:33:01 +0000
Message-Id: <20170225213306.2410-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g275aeb250c.dirty
In-Reply-To: <20170225213306.2410-1-t.gummerer@gmail.com>
References: <20170219110313.24070-1-t.gummerer@gmail.com>
 <20170225213306.2410-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new git stash push verb in addition to git stash save.  The
push verb is used to transition from the current command line arguments
to a more conventional way, in which the message is given as an argument
to the -m option.

This allows us to have pathspecs at the end of the command line
arguments like other Git commands do, so that the user can say which
subset of paths to stash (and leave others behind).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt |  3 +++
 git-stash.sh                | 46 ++++++++++++++++++++++++++++++++++++++++++---
 t/t3903-stash.sh            |  9 +++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2e9e344cd7..d240df4af7 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -15,6 +15,8 @@ SYNOPSIS
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
+'git stash' push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
@@ -46,6 +48,7 @@ OPTIONS
 -------
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>]::
 
 	Save your local modifications to a new 'stash' and roll them
 	back to HEAD (in the working tree and in the index).
diff --git a/git-stash.sh b/git-stash.sh
index 10c284d1aa..8365ebba2a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -9,6 +9,8 @@ USAGE="list [<options>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
+   or: $dashless push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+		      [-u|--include-untracked] [-a|--all] [-m <message>]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -189,10 +191,11 @@ store_stash () {
 	return $ret
 }
 
-save_stash () {
+push_stash () {
 	keep_index=
 	patch_mode=
 	untracked=
+	stash_msg=
 	while test $# != 0
 	do
 		case "$1" in
@@ -216,6 +219,11 @@ save_stash () {
 		-a|--all)
 			untracked=all
 			;;
+		-m|--message)
+			shift
+			test -z ${1+x} && usage
+			stash_msg=$1
+			;;
 		--help)
 			show_help
 			;;
@@ -251,8 +259,6 @@ save_stash () {
 		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
 	fi
 
-	stash_msg="$*"
-
 	git update-index -q --refresh
 	if no_changes
 	then
@@ -291,6 +297,36 @@ save_stash () {
 	fi
 }
 
+save_stash () {
+	push_options=
+	while test $# != 0
+	do
+		case "$1" in
+		--)
+			shift
+			break
+			;;
+		-*)
+			# pass all options through to push_stash
+			push_options="$push_options $1"
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	stash_msg="$*"
+
+	if test -z "$stash_msg"
+	then
+		push_stash $push_options
+	else
+		push_stash $push_options -m "$stash_msg"
+	fi
+}
+
 have_stash () {
 	git rev-parse --verify --quiet $ref_stash >/dev/null
 }
@@ -617,6 +653,10 @@ save)
 	shift
 	save_stash "$@"
 	;;
+push)
+	shift
+	push_stash "$@"
+	;;
 apply)
 	shift
 	apply_stash "$@"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2de3e18ce6..3577115807 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -775,4 +775,13 @@ test_expect_success 'stash is not confused by partial renames' '
 	test_path_is_missing file
 '
 
+test_expect_success 'push -m shows right message' '
+	>foo &&
+	git add foo &&
+	git stash push -m "test message" &&
+	echo "stash@{0}: On master: test message" >expect &&
+	git stash list -1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.301.g275aeb250c.dirty

