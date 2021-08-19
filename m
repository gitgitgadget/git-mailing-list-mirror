Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00AEC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 05:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF8D6108B
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 05:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhHSFCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 01:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHSFCa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 01:02:30 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A48C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 22:01:55 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o123so5793284qkf.12
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 22:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4XwYLEBHS1+Re/mxW7G8sXf/GexCs6vxkx25IJ2Heag=;
        b=r2bJK0dO5TrQzWPED+N4DAy3XE7JdbpMlN2FFF4wA/NtNzukABuzm9G8HvuFHWf/Gg
         XiiUwOoM9yMdGEn6slpa1xBzSDWsPHwyaAKRnVOXuMrLhGh9UshHqKULpXO8Cv5ok5cI
         v6Sj5Vjxl/mAQPsnPDcIkVKMZd5LWavG9BaQwvV+oX2mzfmlYX8QcNFric45hUS9Iru1
         mjr1buUAohIkXahSVlgmPK1ADap830TfzZi2jFD8LrkOkLGVoe5SPK8W89LkDhHM+V7j
         N7pGpPAgXtIzFZKBmcaMTd4b2UM5jkcz6Do+MWuMgC8TEBfAyOOYcy6mqGElAQ4ohPoC
         y46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XwYLEBHS1+Re/mxW7G8sXf/GexCs6vxkx25IJ2Heag=;
        b=HLwZAmmJwUh8JMYSF2PsXnjFB0DOtvImmqFjQ0/NFnNnaV0/QyC2Oi2o6x5eMwWiG7
         ZYElEebKb3igSRfRLyDHbyIcrdfaTf4ehRGIOaVDXnTcBi1r+qA31mnEDBSLYdIFJjIp
         uU2awMdIq0gP0F1qOwsj6+FHJitxjNzoBgsJoBXABjnPlrM01okT/kwNbnEf5Falfr9h
         zWmq4XOyww7/6sphHyA4vKtDXHaWfrpVXEleyQj9n4QfewEu52h8Kz4KQjvYy1LtkulG
         1fYPCw9VMyPAJq3Ql9FbVjVTUDGHKmaiBew81LG6jcUE6Rqg3fnuGhrcCUKUU7152CE0
         /b0w==
X-Gm-Message-State: AOAM5313BGwcbNZ0Syg5KtlzZnap350kLhXx/HAExW2PRi5/fLsYskyP
        rYjz1B91FB0GtqC8CZiiBEtM3qLyrfo=
X-Google-Smtp-Source: ABdhPJw1RiOluHg9NyO/t7wTVIOAXI2sWlkcOEn39d58BPRfo+UOApuDx+ohKHSFJlfu7+OnU5Vrag==
X-Received: by 2002:a05:620a:1298:: with SMTP id w24mr1914610qki.61.1629349313948;
        Wed, 18 Aug 2021 22:01:53 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id c4sm840034qtd.62.2021.08.18.22.01.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 22:01:53 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH] t3200: refactor symlink test
Date:   Wed, 18 Aug 2021 22:01:03 -0700
Message-Id: <20210819050103.25995-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.476.gf000ecbed9
In-Reply-To: <YR3WS1AnqCuiJWyX@coredump.intra.peff.net>
References: <YR3WS1AnqCuiJWyX@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

d1931bcf0d (refs: make errno output explicit for refs_resolve_ref_unsafe,
2021-07-20) add a test for a crash when refs is a symlink, but it fails
on windows.

add the missing SYMLINKS dependency and while at it, refactor it slightly
to comply better with the CodingGuidelines.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t3200-branch.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd17718160..6d8700664e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -109,17 +109,22 @@ test_expect_success 'git branch -m n/n n should work' '
 	git reflog exists refs/heads/n
 '
 
-test_expect_success 'git branch -m with symlinked .git/refs' '
+test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
 	git init subdir &&
 	test_when_finished "rm -rf subdir" &&
-	(cd subdir &&
-		for d in refs objects packed-refs ; do
-		rm -rf .git/$d &&
-		ln -s ../../.git/$d .git/$d ; done ) &&
+	(
+		cd subdir &&
+		for d in refs objects packed-refs
+		do
+			rm -rf .git/$d &&
+			ln -s ../../.git/$d .git/$d
+		done
+	) &&
 	git --git-dir subdir/.git/ branch rename-src &&
-	expect=$(git rev-parse rename-src) &&
+	git rev-parse rename-src >expect &&
 	git --git-dir subdir/.git/ branch -m rename-src rename-dest &&
-	test $(git rev-parse rename-dest) = "$expect" &&
+	git rev-parse rename-dest >actual &&
+	test_cmp expect actual &&
 	git branch -D rename-dest
 '
 

base-commit: d1931bcf0d5ef75cdaf836347f4aefce902a6a38
-- 
2.33.0.476.gf000ecbed9

