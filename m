Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76061F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeFZHbP (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:31:15 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33807 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeFZHbK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:10 -0400
Received: by mail-io0-f194.google.com with SMTP id e15-v6so15028224iog.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bJzC4TfSzsi7vXPcwK5fI7wdZ3yeX9trYj2boBOOHuc=;
        b=jpNNPF+xulV8y2oxx/V4J9FXJHnNF7UaOqaBUzuTrWsxW2/VMv1bKpo1Sn4fjUpopl
         s1g6tLEaSPyuOMCmaAZbnjfh4G8VzhWBeagT3X2OcLJgQEW6DKChlQGs1AF+yIr27833
         ++ZDozUO+62RhcAlSwGo5PxIOETWbF0Z0z4fNDZSHWP7ZtniTcbuG9AcghEz9IdN8TNG
         dbSbWtC53JrIv/8rNYAe2YGlITMC+y5/MEAuLDWIqjMThCv8BluzC8iXw40d4kOgc8LY
         XY7l51YNJPTzCSv5guRUSs91j5+3lsTzxZ49f5aVPSr2OUU4IfAgoyJKWGyvQw2buUBA
         cJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bJzC4TfSzsi7vXPcwK5fI7wdZ3yeX9trYj2boBOOHuc=;
        b=IRloEfuikZrbpoRFyEZZeCoA6SteCs2RhYtd/nOGmIS/niuz4qskp/EFGYlytt8zEx
         xZURwl37LE1+gtNWy0xHzoS27ECNQmPqM3p+y+HgrtiqVoZoDvNrVj8I3go8sd7PVl38
         b/82XfzEY8/vGLrfxPsngOoflwVJLNqOvYQBbG2lC+VCnnIaqbL9rUjrl6lC8Pfkqkd5
         syPLg+p/K4VeecItbPL2Ietg12KcvyhucsYfVmUtwD0dpj5gIF3uL3N15apSFY0tgTPU
         uvoiyeW3J3acoCgCNWizwVNSRPDJdAE6u0fImbnFpTktlC9L8t1xUJ6Db7S05+lsBOmJ
         LuIQ==
X-Gm-Message-State: APt69E1DvEJ4MSWsDcusB+UZKF544EoalzkiyZd92FKyNG7aHTCVVDL1
        VVWvFfICmUstLl81RWGf3L8WpA==
X-Google-Smtp-Source: AAOMgpdV5WzSkJZxlfVNQSouZxWCH8PHoIzxdRW60flaIWknTLMiXN4gj2Ln0D9v+JZNgmBHLAofXQ==
X-Received: by 2002:a6b:5d09:: with SMTP id r9-v6mr298208iob.170.1529998269721;
        Tue, 26 Jun 2018 00:31:09 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:09 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 20/29] t2000-t2999: fix broken &&-chains in subshells
Date:   Tue, 26 Jun 2018 03:29:52 -0400
Message-Id: <20180626073001.6555-21-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t2103-update-index-ignore-missing.sh |  2 +-
 t/t2202-add-addremove.sh               | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index 332694e7d3..0114f05228 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -32,7 +32,7 @@ test_expect_success basics '
 		test_create_repo xyzzy &&
 		cd xyzzy &&
 		>file &&
-		git add file
+		git add file &&
 		git commit -m "sub initial"
 	) &&
 	git add xyzzy &&
diff --git a/t/t2202-add-addremove.sh b/t/t2202-add-addremove.sh
index 6a5a3166b1..17744e8c57 100755
--- a/t/t2202-add-addremove.sh
+++ b/t/t2202-add-addremove.sh
@@ -6,12 +6,12 @@ test_description='git add --all'
 
 test_expect_success setup '
 	(
-		echo .gitignore
+		echo .gitignore &&
 		echo will-remove
 	) >expect &&
 	(
-		echo actual
-		echo expect
+		echo actual &&
+		echo expect &&
 		echo ignored
 	) >.gitignore &&
 	git --literal-pathspecs add --all &&
@@ -25,10 +25,10 @@ test_expect_success setup '
 
 test_expect_success 'git add --all' '
 	(
-		echo .gitignore
-		echo not-ignored
-		echo "M	.gitignore"
-		echo "A	not-ignored"
+		echo .gitignore &&
+		echo not-ignored &&
+		echo "M	.gitignore" &&
+		echo "A	not-ignored" &&
 		echo "D	will-remove"
 	) >expect &&
 	>ignored &&
-- 
2.18.0.419.gfe4b301394

