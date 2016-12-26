Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 629412049B
	for <e@80x24.org>; Mon, 26 Dec 2016 10:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755580AbcLZKWr (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:22:47 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35755 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755059AbcLZKWk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id l2so26995313wml.2
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U6mCZEpSffA0BD6QgHYoqFIqwuz0hsLb8itNyLtudgg=;
        b=U0y4oE7wALq/GKeWm1VVUFZw3di9e/5souzh7tQf6wiv4Uj8XaNxzAIje2O6Ud0YA1
         oCiegqr7hcuSCBNg3mG7k4mDgoY3tzJZoHNiqieISO5GiJ421H8QRnvy6mJDh0kWBBgx
         6e51PnU37Zq6yBOtorshV3M/BVY7iOJZL7LBHxgthft0kC8gaKyM2ZG8tu6XkeVfBowD
         JpUAcybgC45m494wlbuBpN1/x7JM+aE9mxSq9D+7i8w2qsrHuqx8x6zHFmu8FhZDymgp
         qOwn5dh9IPChpDiPbrNJ2sq+ApYOLRtVtyU6qOYZJnJcl5vYPfqu9y9/y82qXmsF9VQZ
         xjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U6mCZEpSffA0BD6QgHYoqFIqwuz0hsLb8itNyLtudgg=;
        b=PhhrDvqICq07ONIK6G/tCwqM1YUi/WXIb1yJKimoNhy+88ewomcPeVDwOH806PP+IJ
         W3dl0s9Yt80osQnUoa+1Q+I/dY4l1TieJiXj6FBY8oCVOfP+OhmEK3PLz0yZ9g2WuRwB
         QHljqpfVZmt2EutnKAEygOF/8bV5bcybJKYuEQ4635k+BLq5Ulfi1FC3QQeO29YRdoZX
         fqwoOQlLsFMygC1XIzF5vm+F4I7ff1nwbMrrYWKENAAAoYeyZlq9ikR5vE4Z9xU92C/I
         pve9euNHa0ZtS16S/cPr9RcfpyWAiBIrbg6agEPB+YrcqnBPdm4Ato6HtWZk7SkL7lEI
         o8CQ==
X-Gm-Message-State: AIkVDXIGJurTcwql1OGMYJZGO89XMcdwfo7emeXPPu0b7x5xHY5NrLcaeMHz3mM67G784Q==
X-Received: by 10.28.30.146 with SMTP id e140mr23575674wme.112.1482747758664;
        Mon, 26 Dec 2016 02:22:38 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:37 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 05/21] update-index: warn in case of split-index incoherency
Date:   Mon, 26 Dec 2016 11:22:06 +0100
Message-Id: <20161226102222.17150-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When users are using `git update-index --(no-)split-index`, they
may expect the split-index feature to be used or not according to
the option they just used, but this might not be the case if the
new "core.splitIndex" config variable has been set. In this case
let's warn about what will happen and why.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 24fdadfa4b..d74d72cc7f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1099,12 +1099,21 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (split_index > 0) {
+		if (git_config_get_split_index() == 0)
+			warning(_("core.splitIndex is set to false; "
+				  "remove or change it, if you really want to "
+				  "enable split index"));
 		if (the_index.split_index)
 			the_index.cache_changed |= SPLIT_INDEX_ORDERED;
 		else
 			add_split_index(&the_index);
-	} else if (!split_index)
+	} else if (!split_index) {
+		if (git_config_get_split_index() == 1)
+			warning(_("core.splitIndex is set to true; "
+				  "remove or change it, if you really want to "
+				  "disable split index"));
 		remove_split_index(&the_index);
+	}
 
 	switch (untracked_cache) {
 	case UC_UNSPECIFIED:
-- 
2.11.0.209.gda91e66374.dirty

