Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5EE51F406
	for <e@80x24.org>; Sat,  9 Dec 2017 20:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdLIUki (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 15:40:38 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34689 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdLIUkf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 15:40:35 -0500
Received: by mail-wr0-f196.google.com with SMTP id y21so13867530wrc.1
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 12:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5jkbwKx5+DDC8Eg5uYiKtD1CdvaabZc3vHnxUZQI1Q0=;
        b=e7GACb66DM1s+eNUphNFFD15xmu9a93oBtQ4iWK+SPOWd6WAxCFcDeNtkuwEuecfX3
         I0DUCdNSTylORCJNEeIAprrsWm8RSGjPqqyMY9T8FpQ3YjN9pcqafOXx0RO6HtjXVxLH
         bmYuJcOy97gfwPupw0JBSqOXwO09Au11RuQnHxi0Cuky8DW6ZmO1zb/PUARuQ2+KUa/w
         Y6TKJoh8s0+dzKBvUIZgsw+XGMj2wBFq7rSvAaFWpa9wuhj/agjan4xrBB3OqCO3Nikz
         80lRcHwiwhVTMgh+66MVLOeVRmVsYaCZ35Mjk3INY1haZVYx4L9WCt4H109FiPt28zPy
         p34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5jkbwKx5+DDC8Eg5uYiKtD1CdvaabZc3vHnxUZQI1Q0=;
        b=p7ZdUMy3w2MEPKdxqGMJKiM4ZblOuT7ThDA8S7x2erAnP22hR0VMoU8PqkRUldQJdW
         2JtgUSHQYPci43gAKHaurma/3asUkeNxd4DkCNjNmbAYgQJKUO3NjXZp7hSXg4Y5A5HO
         dpz/kWqH5NhY2pgozDfBZycWX+dLBvdcLgQmzhn2BltECj56RxC9woloy5+Aiqn7q5is
         U0s+Fh04B4fcGp8sXITHlrpqPDDV3T93vYL8K7wlYfwq7AN/IcZJcXsavGmoEH2ZcaFI
         7IPOWViuKyrSg0Dx2aB4wQQwKF+HwpFTNvWiO3WtKmagp7xveoVc8vOVzg5znkk7F78z
         bZRg==
X-Gm-Message-State: AKGB3mIO0KAtCS0F6vyyZRJhUQj3bImftLDWMFvbouxW7ecpgdvie0Ta
        6IebokOK2LvlSCsAxKvYEOmnmOd4
X-Google-Smtp-Source: AGs4zMa0tHABVRvdkdt9Y8OwWpLmk7C+AzNJ4U8roCplWFhjgpspxq/YA3g/lrCNs9uupDOm0yuuUA==
X-Received: by 10.223.196.194 with SMTP id o2mr5854746wrf.246.1512852034175;
        Sat, 09 Dec 2017 12:40:34 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v18sm12491283wrv.37.2017.12.09.12.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Dec 2017 12:40:33 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 5/7] diff: use skip_to_optional_arg_default() in parsing --relative
Date:   Sat,  9 Dec 2017 21:40:11 +0100
Message-Id: <20171209204013.10997-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171209204013.10997-1-chriscool@tuxfamily.org>
References: <20171209204013.10997-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Helped-by: Jacob Keller <jacob.keller@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 28e1ab168f..3f14cdace6 100644
--- a/diff.c
+++ b/diff.c
@@ -4563,11 +4563,10 @@ int diff_opt_parse(struct diff_options *options,
 		options->flags.rename_empty = 1;
 	else if (!strcmp(arg, "--no-rename-empty"))
 		options->flags.rename_empty = 0;
-	else if (!strcmp(arg, "--relative"))
+	else if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
 		options->flags.relative_name = 1;
-	else if (skip_prefix(arg, "--relative=", &arg)) {
-		options->flags.relative_name = 1;
-		options->prefix = arg;
+		if (arg)
+			options->prefix = arg;
 	}
 
 	/* xdiff options */
-- 
2.15.1.361.g8b07d831d0

