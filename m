Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C2A1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 19:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfAUTuY (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 14:50:24 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39364 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfAUTuW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 14:50:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id u47so24856834qtj.6
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3p+p72AyL7LyPzc8X9PKKJGnbDwxT/voGvI4ovNy9LE=;
        b=JpCsNwD2JG+zIikn62FLNTlLp0G8T/gf6roOQytxT3qUBpnfi0BmQkzNwH22LuB0Lp
         BdB0gG1/4Sq3p1IMidRGc8O6eP3ui3kOv3wmmpY3Lcu6kmGV/dHMYCrkSjI9qKMaS+5k
         zlE2xPS0HtnYd3yfm2MswXMe5E/p1XoAD7P5GCNDlASfRfUou4dgPFO0zx3+hUEjpXAX
         /H6tLaGdoDLESSv1G8owABY5FlDp+N10bB8ESruarwLNP3iEEev2Vm22B+8zkQxHPTNV
         lyd/3RmDPEH8zaeMPpTCzMtFeOGzc0FLkYrWcrrWFGJFZc8E5a4tGU7lXk7VWpNDyZqr
         imdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3p+p72AyL7LyPzc8X9PKKJGnbDwxT/voGvI4ovNy9LE=;
        b=hVviLxWWi0HBYh8toGOucsc3eTfyigPcJ8wFOAajq6+ikcB6H8fwW8ATaxf4aO+e+b
         i7z4rTe12Lp/2G1pswCWUKr7Ma5IYNkAN/cw3ElRBwtulZjNvXOw9rqTAR7ZLsjPrZi4
         HEzC4NOW+8VPC/JeJ0sJteCz8EHThngZ2ZfNBogywe1C463vQK6ucXcJVAAKMTHoQyUV
         eeStt/WH3bvFZ7qEHE+UEPKMesd11k/3WCWEesclzpYs/JApv+E6UvG8UDeDHuDrfFaO
         9wwe+fdACtYvxlMgU/1T8dS8Ijl8WPnZ14aj7NQALMAAeLXSGqo2hBmzRYY34gTx8E+K
         ZUZg==
X-Gm-Message-State: AJcUukdP4vSDBhZSAe9tOcfRQAAHx3ctiMFAvBrq0wh8qSFwV397+PBd
        sedFta8AuD+z5qeLOqMxpqP+h0Q05HM=
X-Google-Smtp-Source: ALg8bN7IIQK3v7Bh63LnmamHA7TBkzgEHJZ2mnzG5RyeZ1TGccqaZJ3iD06FS6lVhmGvOOy/Ul3EOQ==
X-Received: by 2002:a0c:b044:: with SMTP id l4mr27184587qvc.80.1548100221202;
        Mon, 21 Jan 2019 11:50:21 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n62sm22760625qkn.43.2019.01.21.11.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 11:50:20 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     asottile@umich.edu, benpeart@microsoft.com, gitster@pobox.com,
        pclouds@gmail.com, peartben@gmail.com
Subject: [PATCH v2 2/2] checkout: fix regression in checkout -b on intitial checkout
Date:   Mon, 21 Jan 2019 14:50:08 -0500
Message-Id: <20190121195008.8700-3-peartben@gmail.com>
X-Mailer: git-send-email 2.19.1.gvfs.1.16.g9d1374d
In-Reply-To: <20190121195008.8700-1-peartben@gmail.com>
References: <20190118185558.17688-1-peartben@gmail.com>
 <20190121195008.8700-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

When doing a 'checkout -b' do a full checkout including updating the working
tree when doing the initial checkout.  This fixes the regression in behavior
caused by fa655d8411 (checkout: optimize "git checkout -b <new_branch>", 2018-08-16)

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/checkout.c         | 7 +++++++
 t/t2018-checkout-branch.sh | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6fadf412e8..9c6e94319e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -592,6 +592,13 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
 	 * Remaining variables are not checkout options but used to track state
 	 */
 
+	 /*
+	  * Do the merge if this is the initial checkout
+	  *
+	  */
+	if (!file_exists(get_index_file()))
+		return 0;
+
 	return 1;
 }
 
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 6da2d4e68f..c5014ad9a6 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -198,7 +198,7 @@ test_expect_success 'checkout -B to the current branch works' '
 	test_dirty_mergeable
 '
 
-test_expect_failure 'checkout -b after clone --no-checkout does a checkout of HEAD' '
+test_expect_success 'checkout -b after clone --no-checkout does a checkout of HEAD' '
 	git init src &&
 	test_commit -C src a &&
 	rev="$(git -C src rev-parse HEAD)" &&
-- 
2.19.1.gvfs.1.16.g9d1374d

