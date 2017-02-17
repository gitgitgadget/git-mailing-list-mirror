Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A644201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964795AbdBQWlX (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:41:23 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35301 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935122AbdBQWlK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:41:10 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so4783413wmu.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5KiLlFP5CpGuBmGivMNuo442iHZ34qrdffnMTrlf0FE=;
        b=eTfVytixFzGmORnIT+cZTTcarkIAcmGp8uv6rn9SriBUMNIdBmzWRRJfspyEjGcXET
         1abGZ9ZzBlFlrZ0luh6YmA+GoyeooiwZSrPWjhjA2X4c459OVdnFoffkycBIlKRm6CyJ
         /PI8Zj0OiPwJ2jOsnfylcZZ5zQ1D9+kEWbWd/uxTZSoeoIbECJTQyyVlMts8rNNzsbo1
         Z96PE7iF80RK2Q09e2Kj5ibxs/lE8jEMa8LEQb/FCu/HN+51i55zUZ50/kas+SvvwmEa
         gh0/YCKE7WC9Va7M6X5hSYU8EFKsSAqwkdUhJRgdmkYbm+H4eAnGLyOauoghiAxGinXd
         tMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5KiLlFP5CpGuBmGivMNuo442iHZ34qrdffnMTrlf0FE=;
        b=QvezHK3KVtX8XJqGKzGWY6z40BpKTLsWUqQYp54pPa4AKpfC0E1QMYXOcUJ6Ix7eqS
         ehCtydVsQdqv9snGtQmd4fV8ISTMTETVqq8DM057DKxatwYNR688GvEZuCd3Qo2hCE/3
         g+4+/9BH9Zc4qnYgqV+JswRJeyJGFL7yX/fbR2txxMsh1YZA5dUfBOZdyS6tANIY8AFl
         xhdOQxkTyLs12P9uvnulAbXsiIYEv1oyAWCFG9lCzQZuVPGDC5xZNQRNw9xgLKps+ZfY
         9Ttt6mUNlugD6reZW8c/OjP3tTfyK2RS32RE+jStveuJrzL55J9P3fbjVZBR0nVOjP0F
         6EuA==
X-Gm-Message-State: AMke39k9knUQ+Uuk7n78AO05zdgIlDYNUcGTMiU3bhSvnHQN6zw8zvE/12NcH4UyrEHmig==
X-Received: by 10.28.181.145 with SMTP id e139mr3437171wmf.103.1487371268239;
        Fri, 17 Feb 2017 14:41:08 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id v128sm3302241wmv.2.2017.02.17.14.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Feb 2017 14:41:07 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 3/6] stash: refactor stash_create
Date:   Fri, 17 Feb 2017 22:41:38 +0000
Message-Id: <20170217224141.19183-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g27b9849079.dirty
In-Reply-To: <20170217224141.19183-1-t.gummerer@gmail.com>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170217224141.19183-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the internal stash_create function to use a -m flag for
specifying the message and -u flag to indicate whether untracked files
should be added to the stash.

This makes it easier to pass a pathspec argument to stash_create in the
next patch.

The user interface for git stash create stays the same.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt |  1 +
 git-stash.sh                | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2e9cef06e6..d93c47446a 100644
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
index 8365ebba2a..e76741d37d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -58,8 +58,23 @@ clear_stash () {
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
+			stash_msg=${1-"BUG: create_stash () -m requires an argument"}
+			;;
+		-u|--include-untracked)
+			shift
+			untracked=${1-"BUG: create_stash () -u requires an argument"}
+			;;
+		esac
+		shift
+	done
 
 	git update-index -q --refresh
 	if no_changes
@@ -268,7 +283,7 @@ push_stash () {
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
-	create_stash "$stash_msg" $untracked
+	create_stash -m "$stash_msg" -u "$untracked"
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
@@ -667,7 +682,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash "$*" && echo "$w_commit"
+	create_stash -m "$*" && echo "$w_commit"
 	;;
 store)
 	shift
-- 
2.11.0.301.g27b9849079.dirty

