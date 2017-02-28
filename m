Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0EB201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbdB1Uet (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:34:49 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33564 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdB1Ueh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:34:37 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so4156362wmv.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4yXlo/KhKHkpajit70a5EBOZr3jObWSTI95PF+/abuU=;
        b=F7aw/dqiz64zWaK6HTWjdJbjEtacnYGiwIk5YVcNncMi13p8Zw0UPigEITwtVMjBgF
         MjDC3opRzoHvtetXA4fbAkYcYS0BVusXD6IMMii19IcUXAPNjpKutt9IzLkVJJ5ywh1t
         ZgHw7cTZGx25fvxNMIJA2II7b8+0rqR8uIwgHZzMgChXXzx6u/fJvm+W+MYEwsLMjr3m
         jom4w/kW9c3cfMAhlJKXnYfEBGxvRNDMK9UMz4YhPg0KsEsrRxdhFcAJ2Rhl40SVC336
         m4lM72Cm87KATyeBHIRu+iQcwWLK9+GQ0mgT8Ch7TqdnX7JJvkJmNFn7boCGnr79RXMt
         hJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4yXlo/KhKHkpajit70a5EBOZr3jObWSTI95PF+/abuU=;
        b=O4uc2pHPv7JdCwrW81pwzjjL9vbePJIBSL/VOtLOTN8d745pSPJS3i8zRdAkCVhy51
         TRcQzDFUXhClwyMeYE/r7T/kTpSFPkxsee0tiPIX221BM9PzKHxb7vRdE0PMQbHAWmVa
         Rl8zJJ7ky+6k3ahCAn/DkqTQbzOy+Iqx89E+Xbi6Zyu4U4i5oMBXXIc/7cFfavT+aN9j
         WWYJl+gHnyKA4pb7ubnEjFq4kVO+yo132ezyw9buc/8+h6+WSucq25tXoI7Yq87zHy3H
         G1nxubSGJe8lSs/sbeSRYmudKXZFXv5ejdfOJ0+rVsO7DqFdmO6OF/WW9fNdrbs53qUW
         Jd5g==
X-Gm-Message-State: AMke39lNOdouHFDJyldIF5f4H1XoWQGPgqP4/hMUD2uo8VD+s9VhtZfZ1lBs8ZF2Rr7FDw==
X-Received: by 10.28.227.213 with SMTP id a204mr357734wmh.120.1488314028483;
        Tue, 28 Feb 2017 12:33:48 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 94sm3714215wrl.50.2017.02.28.12.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Feb 2017 12:33:47 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v8 3/6] stash: refactor stash_create
Date:   Tue, 28 Feb 2017 20:33:37 +0000
Message-Id: <20170228203340.18723-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.428.g67fe103aa
In-Reply-To: <20170228203340.18723-1-t.gummerer@gmail.com>
References: <20170225213306.2410-1-t.gummerer@gmail.com>
 <20170228203340.18723-1-t.gummerer@gmail.com>
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
2.12.0.428.g67fe103aa

