Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55529C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 15:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3B223B09
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 15:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgLRPPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 10:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgLRPPO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 10:15:14 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB888C0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 07:14:09 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id w124so3115793oia.6
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 07:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ybjt0KLjS6UKf63pln+Z1v/8Loxvju+eJJrllvwGaHA=;
        b=E4hsHdVKQ3AWZBY2dfi2ZmezUNH7wTdBcuc99f6Etb0qj0XA+e1vH21EW0QRg3K/Dc
         RFewo0SxVmkoNKcV+1BI/SDHduqC6tIL6gnFJCucy213RvLDZY7Y3CWUVeF47yD+bt3D
         4Ga5kyWttTDFbkvykqAR1pZNB87KrdG76INMQ7VHubMn0NT6GHsZSvkh3Z241DO3EGk2
         iVbcHHhNRZBlP/bj84orXbzUInv3aBBi67lGRXFsG0wb95yL+Zuyiz1bOLkw0WsjlnEk
         hublK9esOwx0IOt1i/lsr6M9Ad3iqeyDAfiZAXLnn3+e/ZAkhgv1U/dEAfeDrA6AUnxi
         S2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ybjt0KLjS6UKf63pln+Z1v/8Loxvju+eJJrllvwGaHA=;
        b=tD6q8PRNCf8gsqwV7p0OZzzoGVVBBBh8jZpI4wLacVz0RJXzskM10H1lx7gd9Qk1/t
         qHtSBt5TOmvXocc/mH7J1Gmvu7F8J3kHsmVOMvjbLffRYk6cKbdZCFren212VjvyaAob
         4iRo06cXdn+vRhP1CeB50Lthr7ooQYPTYz7Cyn9tRUCWl3C/Yvr7aWSEcY4E+NlyYbzz
         H+m2ueXFdHcK2rB5u3j6tq9+6yh/8OtpYxsxfm5J6kdk5zM2JfznfNc/IX8e9O0fjCj/
         ejpXUqt059bn9KjB/MzO0ZrOx1iXv/gLJEsaCXu9TZYYplcGx2kF2j2H0kPMs/VnWoPs
         kyiQ==
X-Gm-Message-State: AOAM531vlStpP3ROvKnzAAsCAxSrK+LdkG0DVKEgEHCxGUwqjCqKnJ8k
        aW7TmvbDXYSvt3ivO4QH3ipEgh+vYBQtzg==
X-Google-Smtp-Source: ABdhPJxonHibis7wxkEZCCy5dFwk/SASGShZBhsTNkzmzrKJXMV0dlClW94C0LAHVgIJF59kkEUabw==
X-Received: by 2002:aca:d506:: with SMTP id m6mr2995128oig.113.1608304448970;
        Fri, 18 Dec 2020 07:14:08 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t24sm2004879oou.4.2020.12.18.07.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 07:14:08 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] test: bisect-porcelain: fix location of files
Date:   Fri, 18 Dec 2020 09:14:06 -0600
Message-Id: <20201218151406.1193792-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit ba7eafe146 (t6030: explicitly test for bisection cleanup,
2017-09-29) introduced checks for files in the $GIT_DIR directory, but
that variable is not always defined, and in this test file it's not.

Therefore these checks always passed regardless of the presence of these
files (unless the user has some /BISECT_LOG file, for some reason).

Let's check the files in the correct location.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 34099160ed..6d5440d704 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -926,14 +926,14 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
 	git bisect bad $HASH4 &&
 	git bisect reset &&
 	test -z "$(git for-each-ref "refs/bisect/*")" &&
-	test_path_is_missing "$GIT_DIR/BISECT_EXPECTED_REV" &&
-	test_path_is_missing "$GIT_DIR/BISECT_ANCESTORS_OK" &&
-	test_path_is_missing "$GIT_DIR/BISECT_LOG" &&
-	test_path_is_missing "$GIT_DIR/BISECT_RUN" &&
-	test_path_is_missing "$GIT_DIR/BISECT_TERMS" &&
-	test_path_is_missing "$GIT_DIR/head-name" &&
-	test_path_is_missing "$GIT_DIR/BISECT_HEAD" &&
-	test_path_is_missing "$GIT_DIR/BISECT_START"
+	test_path_is_missing ".git/BISECT_EXPECTED_REV" &&
+	test_path_is_missing ".git/BISECT_ANCESTORS_OK" &&
+	test_path_is_missing ".git/BISECT_LOG" &&
+	test_path_is_missing ".git/BISECT_RUN" &&
+	test_path_is_missing ".git/BISECT_TERMS" &&
+	test_path_is_missing ".git/head-name" &&
+	test_path_is_missing ".git/BISECT_HEAD" &&
+	test_path_is_missing ".git/BISECT_START"
 '
 
 test_done
-- 
2.30.0.rc0

