Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF101FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 21:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbdBLVy0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 16:54:26 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34655 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdBLVyY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 16:54:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so16202951wmi.1
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jkjJtUOqTLRi79CyjZ5sG0DYQGFc2eXiAgzbcUr7TyU=;
        b=RdiblTRKoFkbS3RoOzDVVoxw5XTZ9Wc6jvBHJveAdDGpUAD8RZTXZjUDIymLSB34gY
         oj2FhiNrgrIpN8116LsfOnQcc2IIxlv5YIgBFhWG1sPZ4mcyGQqi1Q56+GnDVg2HXKss
         iuCIc19m9jfjTml3UqlXm0LdQ1i9IxBP/oX6vSnL2GFK626cRhWYkWxnZ31fnsJE17KZ
         CpPxbSHs12/A4oVucELbUmTIQEoi591wXF2QixHsUvXvTCKdocWjAekJL4Y5K8KlR7kz
         Eof4Yd3M76j1k2SOxnfZsrOviiWC35fFghBlreHtG8HA2an7BInxoNYPKcO5Y5oy9OsN
         yutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jkjJtUOqTLRi79CyjZ5sG0DYQGFc2eXiAgzbcUr7TyU=;
        b=MFvWmiiV7SGbe5gU1GZi52tRAiUDbyN3AVVIqj7ZSstlP9eKG/ThHIqHbQmCZdCjBQ
         CXeoX9zQw8Cqg19fRBHNYgqKCDksinW81+6YdK4v5Y3c4iIJ8VEiBI6YRTb+oKbN4M/H
         G+LwjbS6BpT+eiPDvsvc4mD9Eqo4pLiQJyR95tkqXoBKqaXr+ccbjnei9jmTuT272x34
         ufBuyB+ZNqzpGIYeZ6uIUw7dFLxXpX+rVHvF8mfMsRHE7tNUOyZfjJT+/mi0wTeibbON
         Edtwk5wD/d6vdwT5jM07etho/cYQCRbPcBHtORqbXM+P2gVe3cOgEkMqlMJtje3xCYPC
         hTdw==
X-Gm-Message-State: AMke39koK+rr+wNKMrLH8LNK4Ij2fCc1kdWKSfsf7UcB0X3SP4UjWVxEB+37N/KeZJaNIQ==
X-Received: by 10.28.55.68 with SMTP id e65mr16524141wma.62.1486936462703;
        Sun, 12 Feb 2017 13:54:22 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id c58sm8223691wra.57.2017.02.12.13.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Feb 2017 13:54:22 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 2/7] stash: introduce push verb
Date:   Sun, 12 Feb 2017 21:54:15 +0000
Message-Id: <20170212215420.16701-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g86e6ecc671.dirty
In-Reply-To: <20170212215420.16701-1-t.gummerer@gmail.com>
References: <mailto:20170205202642.14216-1-t.gummerer@gmail.com>
 <20170212215420.16701-1-t.gummerer@gmail.com>
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
 git-stash.sh     | 46 +++++++++++++++++++++++++++++++++++++++++++---
 t/t3903-stash.sh |  9 +++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

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
2.11.0.301.g86e6ecc671.dirty

