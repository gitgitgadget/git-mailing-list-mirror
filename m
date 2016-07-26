Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9843C203E2
	for <e@80x24.org>; Tue, 26 Jul 2016 04:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbcGZEOV (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 00:14:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36352 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbcGZEOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 00:14:20 -0400
Received: by mail-pf0-f194.google.com with SMTP id y134so13043511pfg.3
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 21:14:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qasMub0hMeEDzfVDhaK3OblcoYrLxNl7pZY3hDAkTF8=;
        b=SGFVS/+Fz9jPj75lOw1Mxs3/PTFXFsPotadXqX5s8zZ8vYyr0qyMHKwKFv+mFowmC+
         OykKwmCcAJie5GUprQWW7HKN79gRI6D9GFOC5FXRX5VmAR7c0IVRGYF/WsLaqLt/lD6f
         jMSn/UvPHYcuX0m0OH8/EMyN+2YUklNTJ972UoPsJkh1cVnPZ2fpv8GjgTS71vvLDMNA
         o7MstONyM6tUlAs/ibQzc7B5bpTEEnuC8Lgbn+RHLRwVYKavLqf5No6+BtQpP22UNGuu
         NZrwOjM6mIWDBBLXVyiWEN7mCnMNMIO3oTTn5uDFoFCdf/qZ+yVtDw+w/RriZp2UYsOb
         J8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qasMub0hMeEDzfVDhaK3OblcoYrLxNl7pZY3hDAkTF8=;
        b=fOK2WpR2Xp4Fv3HOCfU+blR6WVi9fL+ZL8zk6mMJl17yaD6lsXWHIyJJNZBs1gFZXt
         n/xIuc317nWddRAsM31TACrl0MHJDiFvWlGKbCOk+LzDeg0UvzTANqQ00F8e7DosAkks
         4wsc0zqPpHNrZfCBNj2MgJTB/YMTiEnZ5kv+HLT9vsXkGEfXHXJvCMrHJTQjjhB0Ra4r
         CJed1vhltzPczTCF8Wfmvf4eleRjy7cVpv+WZrUZJez3sm76HfN72ZkwewE66NzvBkVT
         VWTPVTanFaNFdQSM8BopXaINv71anrdRcBr+s8+Bq1+LsLFUdRcJJOjTjJDUNNXzYcYF
         dUKg==
X-Gm-Message-State: AEkooutupNjcA70cJai1Z7Kf/xoXrOvULpv6YTBzT90JHR9+pfGwme78vqE2GFmV714xKg==
X-Received: by 10.98.57.90 with SMTP id g87mr35626085pfa.106.1469506459525;
        Mon, 25 Jul 2016 21:14:19 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id a21sm8759877pfe.81.2016.07.25.21.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 21:14:18 -0700 (PDT)
From:	David Aguilar <davvid@gmail.com>
To:	Git Mailing List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brett Cundal <brett.cundal@iugome.com>,
	"David A . Greene" <greened@obbligato.org>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH 1/3] t7900-subtree.sh: fix quoting and broken && chains
Date:	Mon, 25 Jul 2016 21:14:14 -0700
Message-Id: <20160726041416.9438-1-davvid@gmail.com>
X-Mailer: git-send-email 2.9.2.466.g8c6d1f9.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Allow whitespace in arguments to subtree_test_create_repo.
Add missing && chains.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/subtree/t/t7900-subtree.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 3bf96a9..431a2fe 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -16,16 +16,16 @@ export TEST_DIRECTORY
 
 subtree_test_create_repo()
 {
-	test_create_repo "$1"
+	test_create_repo "$1" &&
 	(
-		cd $1
+		cd "$1" &&
 		git config log.date relative
 	)
 }
 
 create()
 {
-	echo "$1" >"$1"
+	echo "$1" >"$1" &&
 	git add "$1"
 }
 
@@ -73,10 +73,10 @@ join_commits()
 test_create_commit() (
 	repo=$1
 	commit=$2
-	cd "$repo"
-	mkdir -p $(dirname "$commit") \
+	cd "$repo" &&
+	mkdir -p "$(dirname "$commit")" \
 	|| error "Could not create directory for commit"
-	echo "$commit" >"$commit"
+	echo "$commit" >"$commit" &&
 	git add "$commit" || error "Could not add commit"
 	git commit -m "$commit" || error "Could not commit"
 )
-- 
2.9.2.466.g8c6d1f9.dirty

