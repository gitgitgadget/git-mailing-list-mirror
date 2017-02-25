Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE02201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbdBYU2e (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:28:34 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34791 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbdBYU2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:28:31 -0500
Received: by mail-wm0-f66.google.com with SMTP id m70so7817679wma.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+CK/aWZUb13psTGf+uKBhkr0YCzOw3vM7EP3VZo+YMI=;
        b=oXtpaLXJNk6HdMtbdguZ1VGUWQeJyDMZ/fG5sNEG5gRT6EV8onF4Upa68KfoSXzwEe
         3PTSfBm7dN0d6Og7WV6qSMeRLRZGsjKUW0ScYnILswSHTjzYrDedxeAfO7JkMT1CJCCe
         KwYDMRpijM8CfBYwbWixRP/BLs8KmmU4LeKUcsjn2NJwC2iqCBtMHZ8puaYXsbNFgn2P
         tgVUy5laX6f9eS+ruiAJP96ye2EmqD/BSXGbAYWKodYrA8c0bq394xcsXP8uSAB88Pup
         gBJrfxeVCW/BgsB6+ERNo4zFsaqxPN8xV7a9bwW4cSdz0TUraAICZrjJwtOycIqU1wfW
         /Fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+CK/aWZUb13psTGf+uKBhkr0YCzOw3vM7EP3VZo+YMI=;
        b=YZa6LckUGiXeyVQ9Dje/2zaXw9KL//uLTxRf/g9hWUijyHfDs+M3UE2u/SlEbqynUe
         0lgQfDH4+1+kJPdceSQiuCskcmQkRyoOR+nocE9qbjJbzdeRi/bOxV49orcTkSGmOYjj
         EwG+6oYVxU9zSSVytMY59uLWT2on39qdYdJy28jC7TDrJmngocXqs+lsiYit5U6Vtlwg
         eIZky8R52vTGDnPRMqul140ozZVXb5x53gdO5+t+tsBretY20NuyLeYlWE1I+y4KUHur
         2FeDsunwdeAzJRRgDJB0e/kcNIHp5wpvMCsVJsWPrzp1OdpvD9stSUf1d9ff5X5ZiT/a
         FibA==
X-Gm-Message-State: AMke39nqqz2NQrT6cqOLVPsIdw4C+e/QakNFmE5kCfhxxgsRdwZUi0+WP/I+0f7Wu8NGhg==
X-Received: by 10.28.68.6 with SMTP id r6mr7363665wma.57.1488054451932;
        Sat, 25 Feb 2017 12:27:31 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id j39sm15502325wrj.45.2017.02.25.12.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Feb 2017 12:27:31 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 3/6] stash: refactor stash_create
Date:   Sat, 25 Feb 2017 21:33:03 +0000
Message-Id: <20170225213306.2410-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g275aeb250c.dirty
In-Reply-To: <20170225213306.2410-1-t.gummerer@gmail.com>
References: <20170219110313.24070-1-t.gummerer@gmail.com>
 <20170225213306.2410-1-t.gummerer@gmail.com>
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
2.11.0.301.g275aeb250c.dirty

