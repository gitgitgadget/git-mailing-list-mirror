Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651C8201A9
	for <e@80x24.org>; Sun, 19 Feb 2017 11:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdBSLLR (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 06:11:17 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35479 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdBSLLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 06:11:16 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so9572085wmu.2
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 03:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xUG3kJu3BSIy5EWqe/16rzjGOG5ONxzwsuyBgZJnOaY=;
        b=I1ak9NBcMG9e5e2Gi1LNhZM4z2QdoSXaCXl3SjNt86d9V1I+GqjurxD9MwGp7ioXUc
         7Or0UnGDm2zeRWR2nQBhiE7cxx6nDD0L9jaH6SbuAsn0omixZPIsHZfIIhjtXUo2rof5
         rpbUXMv9v/qA0FJfRjH9lv1cC2kYDyqRuA2X1I9dnuaV9VngHX6troaeTGW8CPsY5kG/
         KjdBQdGrEbnqKY3sXUOD51DdSuVJ8mLqHKxjlo/WlB6L/RtsVsdLTtWFlNOsf82ED1/b
         BmqaBqV1Wb9Pgg0/xsRVDJNQbSmOHxTfal8HNYQ+BcAIMR584xoTNqSeVZGSzGW5mRGg
         4qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xUG3kJu3BSIy5EWqe/16rzjGOG5ONxzwsuyBgZJnOaY=;
        b=k6ssQZlulo4RNoCvYwqxb80OQSsO3Y4ulHN7XcckHpu9dSQRMhXlq4NRIpzDxWIQfi
         eiXFKyEbsBXCAGTJ7+/9+wbc5MPpwV6T2hwcI+LqqL/+V+T7aOA0+LNdvASWO8Z9toIJ
         ZduFk5BkAKRsFgkGIZnHMjJS5UVTgjQyyASla0iCsBTwcgTMqzp+DgvGh+HY82ER0NOT
         Bg6bp/HtIfeRmSStWx72ZrlT+FWHCp+5oH+nh2YULHlhQGPH0O1890kqmICiIrV6vqRJ
         cII3uhr4K5jpChMKkj4pGnOgSHEAKJxnaRSk5cYmJzFaYwaeqbv0DZrMi5X2t4/j3slx
         AZjw==
X-Gm-Message-State: AMke39nHt8+d+zZCqKYan7enXHMNlkolkogKgz0kHAEijq8V0CdoTP1O8rb7uKt6BVOi4g==
X-Received: by 10.28.140.140 with SMTP id o134mr13849927wmd.87.1487502190491;
        Sun, 19 Feb 2017 03:03:10 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id g5sm20342878wrd.0.2017.02.19.03.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Feb 2017 03:03:09 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 3/6] stash: refactor stash_create
Date:   Sun, 19 Feb 2017 11:03:10 +0000
Message-Id: <20170219110313.24070-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc2.399.g0ca89a282
In-Reply-To: <20170219110313.24070-1-t.gummerer@gmail.com>
References: <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170219110313.24070-1-t.gummerer@gmail.com>
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
 git-stash.sh | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 8365ebba2a..ef5d1b45be 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -58,8 +58,22 @@ clear_stash () {
 }
 
 create_stash () {
-	stash_msg="$1"
-	untracked="$2"
+	stash_msg=
+	untracked=
+	while test $# != 0
+	do
+		case "$1" in
+		-m|--message)
+			shift
+			stash_msg=${1?"BUG: create_stash () -m requires an argument"}
+			;;
+		-u|--include-untracked)
+			shift
+			untracked=${1?"BUG: create_stash () -u requires an argument"}
+			;;
+		esac
+		shift
+	done
 
 	git update-index -q --refresh
 	if no_changes
@@ -268,7 +282,7 @@ push_stash () {
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
-	create_stash "$stash_msg" $untracked
+	create_stash -m "$stash_msg" -u "$untracked"
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
@@ -667,7 +681,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash "$*" && echo "$w_commit"
+	create_stash -m "$*" && echo "$w_commit"
 	;;
 store)
 	shift
-- 
2.12.0.rc2.399.g0ca89a282

