Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B14FC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 02:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702FF6103E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 02:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhIPCjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 22:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhIPCjK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 22:39:10 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1860BC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 19:37:50 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id b14so4382418qtb.0
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 19:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6X1vyjN/6Fi9vlMm0MHrXECtd1qMD5xC0rBYa6v+mRw=;
        b=RbJx8DJwxfh2wn2kr1c8wZt7oVJPMZyDVplK9MtJ6Evp5yQwxWRXaPWLJOhEr7rgqm
         ZFTpL4EsRdi/LolnCWL073P8Wg5T2RPRWf3ni8juc3b5yuLOQVxZMF/PQtIrmdlW7wKd
         x9BgRurHE1T9x3/+tNp7XkS+noV/9i5VJEnUnYnOVtW0gSsw5xBUrx09Qcub33Z6aB9r
         2w7qKMbACr9dMJnJ2gUOIHzR3AYAt1yyRveSvigjMiiM7kQGbP5qaFfyUftiASAUfVHb
         8Q3mR9lm7c7eUDwf3a866YaA5fYWvZe3Ov01Eq0hb96Rx8Ev34kXG8NcsciuNWNBlMNW
         owUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6X1vyjN/6Fi9vlMm0MHrXECtd1qMD5xC0rBYa6v+mRw=;
        b=zH5Xs0hIV9rha3P+ZX+ugezf3QVa4FOpa81QyXBo8ZKnykqYvQPKlJWRMY0t/td/EA
         r4ZSrRFA+HihR4Np6fGAT80OFaCk9X041f4H515CupfsIqY4hK3BMSBTC2VZfhmL+RWa
         GCAf1IkFgnZambkiSCByAOfih0XWPR3FG8Od1NKdjPG/0szYlsuFNUUOeNxz711iYaGd
         lAiFdzu0gSHDw/0vuWh7flyICDfJD0qZ/wTASu1YDAjSaqIld1BZVSWftCFbdhtR3meP
         G/bSB/n2rzi68Ankwle5qkKtMno4PxzHHqiE8UcQHrSH3ezNpoalkUK1zKJukrIFW9/7
         GFBA==
X-Gm-Message-State: AOAM531UPqqeeNq2Txem1rJW1QPmcT7sD9fMLHPugGhdF1wqcjaRUMVW
        n0YnPZ3U9t3V95x1I2XN0onNkxmF4ZI=
X-Google-Smtp-Source: ABdhPJx0fcuF/2nPq33G5be95Mw6/GckqIuqcathU7vdwCooVzVRZKb8NoDIyiWJYl1399SMrpsL5w==
X-Received: by 2002:a05:622a:c3:: with SMTP id p3mr2965344qtw.7.1631759869100;
        Wed, 15 Sep 2021 19:37:49 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w20sm1498753qkj.116.2021.09.15.19.37.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Sep 2021 19:37:48 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/2] t0000: avoid masking git exit value through pipes
Date:   Wed, 15 Sep 2021 19:37:06 -0700
Message-Id: <20210916023706.55760-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210916023706.55760-1-carenas@gmail.com>
References: <20210916023706.55760-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

9af0b8dbe2 (t0000-basic: more commit-tree tests., 2006-04-26) adds
tets for commit-tree that mask the return exit from git as described
in a378fee5b07.

Fix the tests, to avoid pipes by using instead a temporary file.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0000-basic.sh | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index cb87768513..545ff5af13 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1270,26 +1270,31 @@ test_expect_success 'no diff after checkout and git update-index --refresh' '
 P=$(test_oid root)
 
 test_expect_success 'git commit-tree records the correct tree in a commit' '
-	commit0=$(echo NO | git commit-tree $P) &&
-	tree=$(git show --pretty=raw $commit0 |
-		 sed -n -e "s/^tree //p" -e "/^author /q") &&
+	echo NO | git commit-tree $P >out &&
+	commit0=$(cat out) &&
+	git show --pretty=raw $commit0 >out &&
+	tree=$(cat out | sed -n -e "s/^tree //p" -e "/^author /q") &&
 	test "z$tree" = "z$P"
 '
 
 test_expect_success 'git commit-tree records the correct parent in a commit' '
-	commit1=$(echo NO | git commit-tree $P -p $commit0) &&
-	parent=$(git show --pretty=raw $commit1 |
-		sed -n -e "s/^parent //p" -e "/^author /q") &&
+	echo NO | git commit-tree $P -p $commit0 >out &&
+	commit1=$(cat out) &&
+	git show --pretty=raw $commit1 >out &&
+	parent=$(cat out | sed -n -e "s/^parent //p" -e "/^author /q") &&
 	test "z$commit0" = "z$parent"
 '
 
 test_expect_success 'git commit-tree omits duplicated parent in a commit' '
-	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
-	     parent=$(git show --pretty=raw $commit2 |
+	echo NO | git commit-tree $P -p $commit0 -p $commit0 >out &&
+	commit2=$(cat out) &&
+	git show --pretty=raw $commit2 >out &&
+	parent=$(cat out |
 		sed -n -e "s/^parent //p" -e "/^author /q" |
 		sort -u) &&
 	test "z$commit0" = "z$parent" &&
-	numparent=$(git show --pretty=raw $commit2 |
+	git show --pretty=raw $commit2 >out &&
+	numparent=$(cat out |
 		sed -n -e "s/^parent //p" -e "/^author /q" |
 		wc -l) &&
 	test $numparent = 1
-- 
2.33.0.481.g26d3bed244

