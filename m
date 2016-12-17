Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373DC1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758439AbcLQO4n (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:43 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:33744 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757264AbcLQO4P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:15 -0500
Received: by mail-wj0-f193.google.com with SMTP id kp2so18014915wjc.0
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0pWh04Xn4c0CKBC4UnmLg5J0E2E6R2AZVYLTkVFREPs=;
        b=rmtCDmYDrBTlYpIw2B4eY1oSC6vJEup5adRvGD7ug51FQctG+QlE+85TFGIq8mLJXY
         YjE15TxJnZTc9+Fn7NYnmgSZIJOcuRfi+hVnHsOD9DrQcVnGZu/VD/DHjHyGKUVvIEN1
         x8ZU9LIgBgQenfwzVBK5TtNPL/RTwAHnNqdmMoO2ReqjfWsvVIFdlb5SYS4Yv5xN/KrF
         3D5LcY6SMyZMEZQ50JFEk7SPnrBYXmSSofBOI7kD48oN56oNeeBDJc5ScJlywFpQr9Pb
         +30eahBQ+QslR9AiNKYTtyFquaB9mcokGkEqWr+osI5+0QIxMQV8vK668yLmHOebqxce
         aeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0pWh04Xn4c0CKBC4UnmLg5J0E2E6R2AZVYLTkVFREPs=;
        b=YsNgAyhXbQSK4X6Cb/WvX6jFDq+4L+d54UuQKOKlzpkPU8vQCtI1xFtk48M3Qoh2LU
         p0kTp5fger74+lDyalw3BNQtFlIGYxYbYM6Hk9rTGsIW7tShJMQYuMgDbN9QWgvgbBCQ
         sUy+LOAher9aGtpqQG72ryqkELIet1RojqF/3UGhnljy3pOb1phnocze9HeQkmm9QJXe
         VEOeQ5f9dll8aZ+zSvnzUkz76OK2QiHZKsIcoEeItN9ccKuMu8yqZk10lbpRrGxG+eva
         KCz1YJ8jn6c7u31Y70N4CfakQWC2MiWzyIdXisJs8C9n97WOXW5ZzKjEWT84JKj8PGGW
         EtcQ==
X-Gm-Message-State: AKaTC02HutuUkJYPbpPEH6LrYZKChHBnMFiDOpwJvLXI051BYnO1N23WPqZ0NKlpJ+IRAw==
X-Received: by 10.194.86.67 with SMTP id n3mr8133852wjz.105.1481986568727;
        Sat, 17 Dec 2016 06:56:08 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:07 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 05/21] update-index: warn in case of split-index incoherency
Date:   Sat, 17 Dec 2016 15:55:31 +0100
Message-Id: <20161217145547.11748-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
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
index b75ea037dd..dc1fd0d44d 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1098,12 +1098,21 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
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
2.11.0.49.g2414764.dirty

