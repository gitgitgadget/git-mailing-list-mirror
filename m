Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3149C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 15:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbiHOPLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiHOPLd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 11:11:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E61DA4B
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:11:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z16so9385130wrh.12
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=QzzhX+Qt9+q/IBHtNlNduzoXOL4/Xbi0jMiIcERhYDI=;
        b=WF1sgftFHUsdPdzuAOgEghG6OdZQ1CE2gNQ/nkJNVOMWWvw82n+z8HSe9SBUu/scAO
         qVIqz2DxQg+KNKSjrUTpLRSR7QlN8jbt0y4QTMo7heufFkt8CFpmnZelTbOn7prd7f9T
         r4HJEEHfQEGovw3xrdBKx0/lLAbyCpNXbbrCwLu1pqC18E6SS9PVEWWlqMvv31IjD6cb
         Go30XKKOGPm2mwMGdb1L6hxJVp3lce0EwVxR281x6l/uDKtIe6oreACyez4jBdADwtGK
         XTO4JWPffBuUWgQnkAgxRce6hsNEusUnqwxbz+L0iedloJUJhGNRoEEf7+I/F1GH84nC
         P9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=QzzhX+Qt9+q/IBHtNlNduzoXOL4/Xbi0jMiIcERhYDI=;
        b=BBhsfj6usAxr6O449zVWTsZT0Z2365BYSmtuHhhlZiu3TUB3MPkysvLQzHLrydGrMm
         F/Qh6AnXt4Vo9K+XmPm6aHXK2jk/OEujXaNM7fjTkeYBD+XR+Vg0Ff/o8geLxRgaCgY9
         rd5NFYO6nmt33oysr0+huYfU2j/1+hK7aP4NdLvGLoLFCV6dTaZWHMqCmYyWEwoUe8f2
         K2fzOQfllXRLLLUN9s3HJnuByturP28CHk1q+q9rdG3Idn3i+x7tciozgz9KCNPOP3m4
         smputdMHWDRzZkIuEYk3zjJGaNF/g49sabgvYg/3tCyj0UGjyVFA6EfeopjOwggZlLeS
         jICw==
X-Gm-Message-State: ACgBeo0xsmTHshozDcJjBiDhZE3HzVIxuRkchFYCpEJLwJ+DXCQFANjt
        G1icMjOkCi785kHtnkwyNV9hJcgAw1s=
X-Google-Smtp-Source: AA6agR7pzav9w9tHMTfUFCk4BJSY40KCcEFD3ix/PXWDTL7/MufF68P8P7AAV43FrDV9oewkqtbwYA==
X-Received: by 2002:adf:fd4f:0:b0:220:60bc:3fc9 with SMTP id h15-20020adffd4f000000b0022060bc3fc9mr9070397wrs.398.1660576290593;
        Mon, 15 Aug 2022 08:11:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5942000000b0021e13efa17esm7636019wri.70.2022.08.15.08.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:11:29 -0700 (PDT)
Message-Id: <68bcd10949ec7767d1e0ee8e2f0730ca36bad1c5.1660576283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 15:11:23 +0000
Subject: [PATCH 5/5] rebase --keep-base: imply --no-fork-point
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Given the name of the option it is confusing if --keep-base actually
changes the base of the branch without --fork-point being explicitly
given on the command line.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt | 2 +-
 builtin/rebase.c             | 6 ++++++
 t/t3431-rebase-fork-point.sh | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index dc0c6c54e27..6d62e404268 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -218,7 +218,7 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	merge base of `<upstream>` and `<branch>`. Running
 	`git rebase --keep-base <upstream> <branch>` is equivalent to
 	running
-	`git rebase --reapply-cherry-picks --onto <upstream>...<branch> <upstream> <branch>`.
+	`git rebase --reapply-cherry-picks --no-fork-point --onto <upstream>...<branch> <upstream> <branch>`.
 +
 This option is useful in the case where one is developing a feature on
 top of an upstream branch. While the feature is being worked on, the
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b6b3e00e3b1..1a8344b890e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1240,6 +1240,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--onto");
 		if (options.root)
 			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
+		/*
+		 * --keep-base ignores config.forkPoint as it is confusing if
+		 * the branch base changes when using this option.
+		 */
+		if (options.fork_point < 0)
+			options.fork_point = 0;
 	}
 	/*
 	 * --keep-base defaults to --reapply-cherry-picks as it is confusing if
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 1d0b15380ed..70e81363569 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -50,7 +50,7 @@ test_rebase () {
 
 test_rebase 'G F E D B A'
 test_rebase 'G F D B A' --onto D
-test_rebase 'G F B A' --keep-base
+test_rebase 'G F C B A' --keep-base
 test_rebase 'G F C E D B A' --no-fork-point
 test_rebase 'G F C D B A' --no-fork-point --onto D
 test_rebase 'G F C B A' --no-fork-point --keep-base
-- 
gitgitgadget
