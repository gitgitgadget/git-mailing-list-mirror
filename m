Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B244520259
	for <e@80x24.org>; Thu,  8 Dec 2016 23:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932839AbcLHX6m (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 18:58:42 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35741 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932311AbcLHX6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 18:58:37 -0500
Received: by mail-pg0-f48.google.com with SMTP id p66so835324pga.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 15:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YmCSxq9mfp1svt8gzVEzHQmjpntcnAZHqkvuNrGE5HU=;
        b=mpjfy/8dEXEbTb+eZIF+7Zj6UcOWuHvoAIs7bncv0AtOV5AJyZQqNg7F8zKQFwsReP
         NUDnd7ljblXEg2+Jxs/nQnL/k8dk6YJonuO/iVUAkAK6WQbPPp9eJN38Rc7c94fMDSBW
         sx7WtYbnHDHlohHYsWTqTeRuoTIDrR+CFKCw7WZHa0cmffyy5AR3KFsm88V1Mdqigns6
         afn1xTyvW+rHxtlo4F1T/ghj4zCFKXyLRPkOcQDBz7YeTgr+mSW7BUs0pgO5cSk1vWid
         zhCINVREu1DFzdtVTaMPyf9qmEHbJYfAYtWg2RJYmwmyGtB7BGxmPgHDumBF4kQY6o31
         GtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YmCSxq9mfp1svt8gzVEzHQmjpntcnAZHqkvuNrGE5HU=;
        b=SKL4Wse0cSchWieOyfatVRuKyxgtMdTmoa/T7OoIyLxRkQzn8cUVHJlS/rIaWg/mwK
         i54tmSSG5qFiEtwp0Yd6UU6RpnxiET7/4oElh9I6kNd8fCfR4CmlQK0q7LPjV3pWV2+3
         qaK37Od6D6VOodCWu7cNmdRc4osZ1vPIjuCZroojJnp37jb0ibyjAiWNUAlkcy9+jTgH
         IE6/ovyk7jAPkv4dVDTIyT/9rM+U6SNIdmXkvPN0BNrjVt46BvxvU4lXDAhyeAWjxh7Y
         GbuG5QPuffM7Jtx4a60UWnWduL1G8N8NJz0xDGpLNs7TOf/0R/RNbEGlS2XKya+SQf3R
         K17A==
X-Gm-Message-State: AKaTC00eHa/hfhMjUBjxxju9zD3YDaQHFz5V6/9Ar9ZgBM/GHZX0KphNz4ktPBT99KZ+A80V
X-Received: by 10.99.52.10 with SMTP id b10mr138413158pga.42.1481241515767;
        Thu, 08 Dec 2016 15:58:35 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id a7sm52505499pfl.87.2016.12.08.15.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 15:58:34 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com
Subject: [PATCH v2 3/4] real_path: create real_pathdup
Date:   Thu,  8 Dec 2016 15:58:13 -0800
Message-Id: <1481241494-6861-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481241494-6861-1-git-send-email-bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1481241494-6861-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create real_pathdup which returns a caller owned string of the resolved
realpath based on the provide path.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 abspath.c | 13 +++++++++++++
 cache.h   |  1 +
 2 files changed, 14 insertions(+)

diff --git a/abspath.c b/abspath.c
index b0d4c1b..df37356 100644
--- a/abspath.c
+++ b/abspath.c
@@ -198,6 +198,19 @@ const char *real_path_if_valid(const char *path)
 	return strbuf_realpath(&realpath, path, 0);
 }
 
+char *real_pathdup(const char *path)
+{
+	struct strbuf realpath = STRBUF_INIT;
+	char *retval = NULL;
+
+	if(strbuf_realpath(&realpath, path, 0))
+		retval = strbuf_detach(&realpath, NULL);
+
+	strbuf_release(&realpath);
+
+	return retval;
+}
+
 /*
  * Use this to get an absolute path from a relative one. If you want
  * to resolve links, you should use real_path.
diff --git a/cache.h b/cache.h
index 7a81294..e12a5d9 100644
--- a/cache.h
+++ b/cache.h
@@ -1068,6 +1068,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
+char *real_pathdup(const char *path);
 const char *absolute_path(const char *path);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
-- 
2.8.0.rc3.226.g39d4020

