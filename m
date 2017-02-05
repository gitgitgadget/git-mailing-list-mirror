Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4B441FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 20:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbdBEU00 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 15:26:26 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35936 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbdBEU0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 15:26:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so17899348wmd.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rPLeUD40G5ADNKE0LdpmdoiG4ZGWNXhUau8Bd5xyZcw=;
        b=nBxc7vuSiz4af/swztlcWhRKIMjHEQfhyVUrYCblRrDckjhQ+u2AAUraU8y2pRHgUP
         +SCef87fdxOSzJxAZ2OGoIBNIJacIUPux5QEjsezVQWQo2jbHM3GFv1hUimqhr4XYktF
         0Yxpr1/dmEjMBX+xCQH//qJQuPHf86arL05usxdxHWqmpdPfJi0Gav8LTeW80XAfLVi1
         sDr0+wkuJAuGJ917Jklsa2Qa/HpsNg1VSqkOM3rp5pvpC9eFoEFcmv0X5I8y5zj4v0Im
         Cw+5Sr7zS/7Vdlu/z23KH1B4+/JEIaaf3feY1KoAdCgcC2ITX98Cc2Ivc24eCl8OQGXn
         jXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rPLeUD40G5ADNKE0LdpmdoiG4ZGWNXhUau8Bd5xyZcw=;
        b=Zbrg1uuvFfKY8SIKX+MNxXBV1awUyHOk0mzM/uU0oMMs4HBqdEL0bGSpR0EP056ghv
         ZnXcGKEoGOTm0pEEKwxm60wjWGSdlQaFbtkd2GkKS/JMpjvFGRBhMfFwVqBs3L0k8Oeq
         fUWtBkuL7W4wKtw3KaQkdb5uTps7pKBWrGry5EeAphBZLW8EPuGMxbHzTIyan/23Q9uR
         QDS98oitT+RUOgonXUrDWOK6T+VLrk3x/UpCj337al/DZVIAJTrSQGRJo75OwSqd7QzM
         3hD2czpF8buUbobQNlQMyNWIVIAB3xDWmcrSXjaEnfWVL48GAPo5HiKQ/xMtwGuA8ZQd
         ojGg==
X-Gm-Message-State: AMke39lhy5TpOhTJr061Oqbo0LDqyqdZHjYtv/4D8ZJKNw/eBavIuKq5hzJ/0FWx7Ec54g==
X-Received: by 10.28.48.78 with SMTP id w75mr6599266wmw.55.1486326382492;
        Sun, 05 Feb 2017 12:26:22 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id y97sm9040430wmh.24.2017.02.05.12.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2017 12:26:21 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 4/5] stash: introduce new format create
Date:   Sun,  5 Feb 2017 20:26:41 +0000
Message-Id: <20170205202642.14216-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc0.208.g81c5d00b20.dirty
In-Reply-To: <20170205202642.14216-1-t.gummerer@gmail.com>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
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

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt |  1 +
 git-stash.sh                | 50 +++++++++++++++++++++++++++++++++++++++++----
 t/t3903-stash.sh            |  9 ++++++++
 3 files changed, 56 insertions(+), 4 deletions(-)

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
index bf7863a846..33b2d0384c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -56,8 +56,50 @@ clear_stash () {
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
+			stash_msg=${1?"-m needs an argument"}
+			new_style=t
+			;;
+		-u|--include-untracked)
+			shift
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
@@ -265,7 +307,7 @@ push_stash () {
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
-	create_stash "$stash_msg" $untracked
+	create_stash -m "$stash_msg" -u "$untracked"
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
@@ -667,7 +709,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash "$*" && echo "$w_commit"
+	create_stash "$@" && echo "$w_commit"
 	;;
 store)
 	shift
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 21cb70dc74..b859e51086 100755
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
+	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.12.0.rc0.208.g81c5d00b20.dirty

