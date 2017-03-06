Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75DB21FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753918AbdCFJvk (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:51:40 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33087 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbdCFJvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:14 -0500
Received: by mail-wm0-f66.google.com with SMTP id n11so12767402wma.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gpVuXkuePUhWAFA1GvyZGppPAJDrZVqgna6iHxdIkwU=;
        b=I5IyhbfXhWlN25YmOykDg9hUwXbU2itMLPWOizXjB/HYBRPEXksw9h3FcrFKIFKB5m
         Cg8DwC8vM24InGlwknj5i5An5k5DErzXLyT9h6Ow63XmMQynlj9P9OBGPYsqTu0bm0+f
         aBmBMLhRLZL//n/bd2/UFLX2ACqS/XAO0gwi7qhr4E85A7yYW0MJdepKlgJTkOZO5Sx4
         iq/pT3QXrydCN5q9hnFp7Cj8Y02DsZbMVOg8ErE7Cf0Fq81+JJo2BfUbbe6/yLt8q6Ts
         Mtad72d6uCScTfGRc9RGtAg6hgEPD/W+xDwlEulqRoY78uqj913PIvbYXq4tvDbgQK/4
         bwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gpVuXkuePUhWAFA1GvyZGppPAJDrZVqgna6iHxdIkwU=;
        b=eiATYYAxscMiLCjo15f+ulv5/rd0Dyh53I73IPsrBQGLcvMB8/XbDdkFm3aaoA7hqU
         M3QtuiuhKh6i/4/BklsuWqhusUHwuIA1lmkYvu1K0Qjy1gCMI8YkYHO0Mjxg9AalHBVm
         iNeDugZtOdTq1OuWjM1J7xtm02U4CggGQX0By6NVhEORuJEzyK+AYsYSNaDOFG/7ZGsR
         Wxnm7nnFMo+v/eRv4y3SMKaCSbdAMttsiYKkRzUTM8Ff2nHUZxL7ILwQiU/lKinSjN1k
         JcXGn6KzyqhcMwFKPjo+eLWaFjZ/OBKJgSP0Sj84Dq3m2KN2LyQXADwE5RMvJHWgYaJP
         DwAQ==
X-Gm-Message-State: AMke39mblJ9CxrAr/Nnzew75oH59xW3u0chVx4U81dq8Y8ELmMv6MUcs+M1EumfUP3M6xA==
X-Received: by 10.28.226.4 with SMTP id z4mr12698854wmg.135.1488793345346;
        Mon, 06 Mar 2017 01:42:25 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:24 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 06/22] update-index: warn in case of split-index incoherency
Date:   Mon,  6 Mar 2017 10:41:47 +0100
Message-Id: <20170306094203.28250-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
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
2.12.0.206.g74921e51d6.dirty

