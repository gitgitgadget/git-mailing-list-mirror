Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124921F744
	for <e@80x24.org>; Mon, 11 Jul 2016 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbcGKRXk (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 13:23:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35742 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932580AbcGKRXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 13:23:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so1954707wmg.2
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 10:23:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dmzYhqnZtp6SlaR5WFxndPv4kuUqWDVKzDmLfTH6LMc=;
        b=rgCfl8d8CnmHhhe1FrU0VpoumZljAlYn1U7xtLzDBy8ZuDk9KM6n95glCw2U2sm0VU
         wRE1Ghgfqawn4VA0us/Cr0Ml+2MvfIzmhQnXvwSzlgqnvesdY+vhRcnga0crfVPnrH/j
         he1v/WbAiXy+5aH1o++NO7C7pCc6oqzGZDyrSdXALhtqaAcT0Y5GguxHrmKYycLyJVMo
         mch+yiivc61uNi6hmsJgy/xArP77EY2YdMPusf3joE9B6yHwzA3joj1fs6YTROL4TWiS
         V6Q0nCpSriT9gKMdqtjY8ASbiRobzBDewg1PUH0r9oOQzT/TqDHRgiLSTSexhP2HElbV
         O9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dmzYhqnZtp6SlaR5WFxndPv4kuUqWDVKzDmLfTH6LMc=;
        b=dQUhuxlrYgJy8p79zaEv5fbnugViFggCFNLlzlZ9w2R4Y0tPbjgADLYm85zcnbYnpj
         lDhP4DxYdNhVwI93m591XXUppNFFHaiBFbynKvONwb8qqjr7XDqMUNIp5mTkRRWlSWQH
         NLHAkhdrtLfNtk6Z+jWj6ES9SgkJN9K9xM9CnpUBxBsF5F4Dk8sFJI+/TTn2214GHPLQ
         M28eHi3pEL2cbRSmV9McakyfEuIe7fSeY3jiWSpEC+EUjyYK7S7BPPvyTum7ZAEDfzQq
         sDXbADwBSKdBWBzXZXj2mEps0SLY4U40dzM/rVCilmW4v7pR7ltLZhxgPaSsZgX7O7Me
         9VPQ==
X-Gm-Message-State: ALyK8tL3XgoxCBXuSYWE3Lr0DGStAi+JuYDRtRDXOQqiOiNj8vnwaPzL3f+0ZSuCEFwFfg==
X-Received: by 10.28.9.200 with SMTP id 191mr19839609wmj.39.1468257799339;
        Mon, 11 Jul 2016 10:23:19 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id si2sm829442wjb.19.2016.07.11.10.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jul 2016 10:23:18 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/8] config: add git_config_get_split_index()
Date:	Mon, 11 Jul 2016 19:22:47 +0200
Message-Id: <20160711172254.13439-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.250.g7087ccc.dirty
In-Reply-To: <20160711172254.13439-1-chriscool@tuxfamily.org>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h  |  1 +
 config.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/cache.h b/cache.h
index f1dc289..5296a50 100644
--- a/cache.h
+++ b/cache.h
@@ -1695,6 +1695,7 @@ extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
+extern int git_config_get_split_index(void);
 
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
diff --git a/config.c b/config.c
index bea937e..318194b 100644
--- a/config.c
+++ b/config.c
@@ -1656,6 +1656,16 @@ int git_config_get_untracked_cache(void)
 	return -1; /* default value */
 }
 
+int git_config_get_split_index(void)
+{
+	int val = -1;
+
+	if (!git_config_get_maybe_bool("core.splitindex", &val))
+		return val;
+
+	return -1; /* default value */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
-- 
2.9.0.250.g7087ccc.dirty

