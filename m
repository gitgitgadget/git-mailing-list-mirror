Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A96031F461
	for <e@80x24.org>; Wed,  4 Sep 2019 21:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbfIDVkz (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 17:40:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44934 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDVkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 17:40:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id k1so145562pls.11
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M7P/VyUKHPRNx5N0ZNmEBjuP9rYtiOj2Sco5SE2laf4=;
        b=TUvRvMcNm/KzYKQs1RkXKDwqbOiHaI1ZeBrZ11dfD1TbnNKwr/gPPXcXZWwDJLayWz
         jus/MjweqHL7r2G7mPitGdmb7jwe43CPnwBImCnhzAAXdBR2BEPfTXf8GA/cemTQzsLu
         OvRjqWfMzjySgb+2ZTtNurSPDNJGMWi57IfUsBSeXcYWEdCSw/SIQF0UGMPpTZeZujyF
         aOLtWaIAQD2balc7QWuPbj8lkgEiX+bfXWgoCwgE+kH0ZgXjNCgGSHC0HVfuuvMYalRv
         2qnPiWvYMaYHPQzBdW/2zpNAvDboPsm941s3s5J3NMKcc/yMCT3cYtYqnakLkTGtCJfy
         H7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M7P/VyUKHPRNx5N0ZNmEBjuP9rYtiOj2Sco5SE2laf4=;
        b=PanmbQ/SyOvWnHrA6gd+wF386N8Rk5Jo3edKCVqtJhqac7SU8TcbkMe7bvq/CBIoQY
         NgpeRVyr4wC0yDd8kXxU6JqMB8gEzTwT3BvUkdwI5qmMzvIPurZoMyMoURIN+Y0p76DA
         b6X3x9vMzYQu8vVrw/ZpHM9Zo3TBnnW3J+NDSIbvrEEZFjhqwEuWKfuf6Jauj1/kY8nZ
         yw3WMv05nbSrt7/jZZ1z4ovOqeuxuQIKjBJZ9oVfGvH6qAkaU0J0EwxJObC+sTKDayY5
         5oYwKg8GosZBKpi8B8B0e5Q145O7BCS9/O/jlB+Zpk1VUW27B7AKgdEAI1nWNGSVYPI0
         NGrw==
X-Gm-Message-State: APjAAAURgxba3elI5RvIJXy67mOGs+23YDlDrJlYzWXTzDz703vu6+Kg
        PXyDKlqi9sXSlGr8wWw9r5M=
X-Google-Smtp-Source: APXvYqyJmdPOkGY50aOOx6AkSSksTm7mfyMV/VV9+jNKic6X8sw/LAhXyqh9W8zl1lNPZIlU3mi9mA==
X-Received: by 2002:a17:902:4201:: with SMTP id g1mr42980176pld.300.1567633254596;
        Wed, 04 Sep 2019 14:40:54 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id o35sm79281pgm.29.2019.09.04.14.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Sep 2019 14:40:54 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 17/16] t3427: accelerate this test by using fast-export and fast-import
Date:   Wed,  4 Sep 2019 14:40:48 -0700
Message-Id: <20190904214048.29331-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.19.ga495766805
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.v2.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fast-export and fast-import can easily handle the simple rewrite that
was being done by filter-branch, and should be faster on systems with a
slow fork.  Measuring the overall time taken for all of t3427 (not just
the difference between filter-branch and fast-export/fast-import) shows
a speedup of about 5% on Linux and 11% on Mac.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
This patch is meant to be added onto the end of js/rebase-r-strategy; an
earlier version of this patch conflicted js/rebase-r-strategy so now I'm
basing on top of that series.  The speedup is also less impressive now
that there is only one filter-branch invocation being replaced instead of
a handful.  Still a nice speedup, though.

 t/t3427-rebase-subtree.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 39e348de16..bec48e6a1f 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -59,7 +59,10 @@ test_expect_success 'setup' '
 	test_commit files_subtree/master5 &&
 
 	git checkout -b to-rebase &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git fast-export --no-data HEAD -- files_subtree/ |
+		sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" |
+		git fast-import --force --quiet &&
+	git reset --hard &&
 	git commit -m "Empty commit" --allow-empty
 '
 
-- 
2.22.0.19.ga495766805

