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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BCEC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02046140E
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhGBKHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhGBKHs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:07:48 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16F3C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 03:05:15 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so10751857oiv.1
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hrk2zwt+unEoqEBHlq0I3hIwCoAT6uNObT5ehaAZSsM=;
        b=k1bTCp7p02tD9QIkiJ+bedJywuFsxH8ofuELhKP4ZwLxuw6RqZKoyKROnYrxxCAT8X
         864OprQP2gAtBkGeuCgoBfAZkr6TCF7GRZiK4n0XxnmO1V1idb2zCRJcv53ZYAMOXghS
         D5tAWlV7BPXNnSHNx5JwkWfCZTsYWJyXlYlx7hVZMSJhgEFwjqkvSjSJBJiPprt7Y/I+
         1bILqnGs3HyicMV73U8sTF1NTbsbJhvrWtOp2ZwtJjPaFiCEzrSwkU3UjNi8frnwgSQO
         S8Sf4ezznsHunSiEhTi5qyUiQ5i8yn+jiyIbsmzK0zmqfPMw0SRaNFs9skwdjeOvTHoL
         M58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hrk2zwt+unEoqEBHlq0I3hIwCoAT6uNObT5ehaAZSsM=;
        b=GVDAv/PKdB6rYDLqRObxQ93h9i8MQSsvuNqGwE0yOK3AFRnC8QYFvwbovDM57SMZJm
         bkJcRw7EvnQmHGxy7y8t9nnMxpTVyYQ8vdbXPlhF/0rqV485zyXLMPDlFfT0bzHJnyuX
         s0jdThUzgJpFpaymrB4+gi3JslWUDdg+enaSBBa1k8xu2j0Mg9YTvetPUS/VSljrges2
         dpUy8C4UM1johj4WMV7NzdtTF+nyLoVGhS0ajCzyYRQg6oc0mszs3CI+HQm8JpDRnBhC
         ncszTly3e5QDXwq1PWpnk+sOBgA1j8+Bun1B46mYnHXJ3wlNoofCh8ko8ykPUPm5XsjK
         LLrQ==
X-Gm-Message-State: AOAM531hC8nU+HisWUbzZILtmiiI7oH36meC4Rh8o21LHaTT7MUMZjRn
        u8o3uhW0BU0bH8IWjVHpShT+MZYvYemYFQ==
X-Google-Smtp-Source: ABdhPJwdEQQiry7TEk/5NgmgxoEk5c28MXIyXkXfJ6wXC6TVfPsvUYKSVa2Dxt1nDv54/vgoljF3FQ==
X-Received: by 2002:aca:f254:: with SMTP id q81mr3272270oih.29.1625220315205;
        Fri, 02 Jul 2021 03:05:15 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id p9sm503937otl.64.2021.07.02.03.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:05:14 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/5] config: initialize origin_type correctly
Date:   Fri,  2 Jul 2021 05:05:05 -0500
Message-Id: <20210702100506.1422429-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.94.g4574ca548c
In-Reply-To: <20210702100506.1422429-1-felipe.contreras@gmail.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cf->origin_type either is CONFIG_ORIGIN_CMDLINE, or it's something else.

Don't override that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 9172c96c54..666fb2c689 100644
--- a/config.c
+++ b/config.c
@@ -2087,13 +2087,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	if (cf->name) {
 		kv_info->filename = strintern(cf->name);
 		kv_info->linenr = cf->linenr;
-		kv_info->origin_type = cf->origin_type;
 	} else {
 		/* for values read from `git_config_from_parameters()` */
 		kv_info->filename = NULL;
 		kv_info->linenr = -1;
-		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
 	}
+	kv_info->origin_type = cf->origin_type;
 	kv_info->scope = current_parsing_scope;
 	si->util = kv_info;
 
-- 
2.32.0.94.g4574ca548c

