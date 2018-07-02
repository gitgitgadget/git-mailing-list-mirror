Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87121F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeGBAZA (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:00 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40139 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbeGBAYw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:24:52 -0400
Received: by mail-it0-f68.google.com with SMTP id 188-v6so9831739ita.5
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CU9fnSbmUQSwES3eTJZzoYrZQjtONWkdvjNF7d6kWTE=;
        b=ccj0fvOji37S0mwBtdQ5ty+ghT5h9IsMBkUERHa+vs2O2gX0mXJFgwgZ7YR1etPHMu
         /hX2tOh+JyBhKp8RztHFPz42lLxA9EmV3UkrXK2I6tA7uWF2UxyV0IU7/Qu96sOsI3rI
         JS1lav9mYDAmQ6ALQAPiauH/RLw995WibN+FmoperV7I7WT8tA9ElRNx8koSEluOsGNm
         T4qzUYCjdp2doyMkgyfXJgJ3qaqO/QYxFmzBX9HDA3sOgTTMOKO0VqEsg1ovZpngDcPM
         69jGo7KKv+5P0TTv73JXUwDc28Y15sbmguEzbJW6CUxVg4jfN4YXGR0gsNF70D0pVe9m
         Solw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=CU9fnSbmUQSwES3eTJZzoYrZQjtONWkdvjNF7d6kWTE=;
        b=U2LaY+/zU9Wm6PpG2zxKWSErgQRVluQ3xGUNjq8mCRJ2jSbf9eOzeZ6YBgoE5xiJ0Y
         9Wo6nfVCLv257RI96vErsccKhPEzE2b33gOhUzaJoABuv5F24MNBgTGDr1AdniW02vJW
         GVEnS6nAP6iA8uzyXz6d+gOPZQo1XY4m8Ju8O0M0RBN67XFqSQmfyD6Dhx2GtHfRL/BF
         TK1HTkk1w4rZrqkbHauWHtXIleyw5hbNCLo6GHixPNkldD/24iuO0hwppfAHoTVjz9cm
         bVBqfMe90PHdO4TBqvBmTJwCJrIjqCOn7q3o1X9BabbXKI0v5bR5I1foZjtmTW/+S0/m
         kSWQ==
X-Gm-Message-State: APt69E26db9YtF4focTm1mMs744LovB7T0DdvUfGoIXVNc9dFAeKDumH
        R88eScdFG0Z5vNQ4ONwgpfQCUg==
X-Google-Smtp-Source: AAOMgpe8b+vP8dx8XIPjPs9LARXomjXxudiKlUxc04I5r4f8HJ4HfsIJ9wunwyXz6wlwe+RzlS46/A==
X-Received: by 2002:a02:2422:: with SMTP id f34-v6mr19341811jaa.2.1530491091774;
        Sun, 01 Jul 2018 17:24:51 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:51 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 03/25] t: use sane_unset() rather than 'unset' with broken &&-chain
Date:   Sun,  1 Jul 2018 20:23:43 -0400
Message-Id: <20180702002405.3042-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests intentionally break the &&-chain after using 'unset' since
they don't know if 'unset' will succeed or fail and don't want a local
'unset' failure to fail the test overall. We can do better by using
sane_unset(), which can be linked into the &&-chain as usual.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t0001-init.sh   | 4 ++--
 t/t1300-config.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 4c865051e7..ca85aae51e 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -408,7 +408,7 @@ is_hidden () {
 test_expect_success MINGW '.git hidden' '
 	rm -rf newdir &&
 	(
-		unset GIT_DIR GIT_WORK_TREE
+		sane_unset GIT_DIR GIT_WORK_TREE &&
 		mkdir newdir &&
 		cd newdir &&
 		git init &&
@@ -420,7 +420,7 @@ test_expect_success MINGW '.git hidden' '
 test_expect_success MINGW 'bare git dir not hidden' '
 	rm -rf newdir &&
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
 		mkdir newdir &&
 		cd newdir &&
 		git --bare init
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 03c223708e..24706ba412 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -888,7 +888,7 @@ EOF
 
 test_expect_success !MINGW 'get --path copes with unset $HOME' '
 	(
-		unset HOME;
+		sane_unset HOME &&
 		test_must_fail git config --get --path path.home \
 			>result 2>msg &&
 		git config --get --path path.normal >>result &&
-- 
2.18.0.203.gfac676dfb9

