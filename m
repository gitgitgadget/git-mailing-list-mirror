Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543A21F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeBMBWy (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:22:54 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38932 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933053AbeBMBWu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:22:50 -0500
Received: by mail-pg0-f68.google.com with SMTP id w17so8741870pgv.6
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q43GImzCOkN+9Ft5hQOsZlGhDSksiBk5G/3o9mcH9AY=;
        b=R6t2j2hH7ZZIPNDQhkwg7mERbe5HOoqDU+vpGx/5dRGU7WPwfJPtK1/6tVizafiEl7
         p0MW2cyrgNNyGOS3NEUhq+UDcB2SkM20dlMA8iGJfeOxT6QY8XVXnjLa3K2LF8JzTZ2j
         EWRYz88fAy2F0uG1+6imPTrHdilYsak9AAw+LdAXXW1O77XlGDHBeuqJGUul9gPyjVi0
         MwJbANNCMwY4M97UA92zRHnUwe26f4q0uIs9xuqDfXf6c0jQMdFf+oLdGS66BRi3IlaF
         zpuBlCgFtv5HhcjOekDnbLu0pwxuKUq62rF/6Jm8adT9nwhhtvITcHeNc85MEby1vX59
         JEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q43GImzCOkN+9Ft5hQOsZlGhDSksiBk5G/3o9mcH9AY=;
        b=GxNHoeuo8ToLgVu2uYH2LQMuKnMGNqApXH/ZVYyc9hwZDpr3UaUXd9IzNKJaqVLnyX
         a3IfsfriKZM082mYQ4NbMnZP8lrJvv5B2cDDDf4LpnVeumpIVxtrbw6OMRb9i577QntJ
         pLlO6Rod3bTRRehQ5eqDcaPnZZNb6X/NyxhMoIV0Rm6IrdjmYwj4S8zjntOOurhisK7l
         pShSMGFYBFwKdKB+49y58ofGzV5IjwYPbneqrXsqmy9jLXrMlVc3rXb6nmWgmYuc8v3O
         z9lgNX9OdGpbLxd4/yZdiJYPRLr7hzWYQr4UnBfoxUrs0vzFXi0Oyl3Wl1bsRM20glFH
         M/hQ==
X-Gm-Message-State: APf1xPAgWPt1e/yHU0x81xsWPPyW/6OqOSfjPdxxkhnC6DRac5iBmUZJ
        mcKmXtnn+GFHaoGO2bagK8G7fQ==
X-Google-Smtp-Source: AH8x225H/0TTJQyomNuMUzgYYb8W8GFSDMnKz0ixNFw8I5CPaxEAnjI9k4GGCZ2NDr/M+t8FA0kHiA==
X-Received: by 10.98.16.9 with SMTP id y9mr13527278pfi.189.1518484970172;
        Mon, 12 Feb 2018 17:22:50 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f7sm23091288pgq.66.2018.02.12.17.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:22:49 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/26] object-store: free alt_odb_list
Date:   Mon, 12 Feb 2018 17:22:18 -0800
Message-Id: <20180213012241.187007-4-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Free the memory and reset alt_odb_{list, tail} to NULL.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/object.c b/object.c
index 9b5b65e189..d778f09717 100644
--- a/object.c
+++ b/object.c
@@ -446,7 +446,24 @@ void clear_commit_marks_all(unsigned int flags)
 	}
 }
 
+static void free_alt_odb(struct alternate_object_database *alt)
+{
+	strbuf_release(&alt->scratch);
+	oid_array_clear(&alt->loose_objects_cache);
+}
+
+static void free_alt_odbs(struct raw_object_store *o)
+{
+	while (o->alt_odb_list) {
+		free_alt_odb(o->alt_odb_list);
+		o->alt_odb_list = o->alt_odb_list->next;
+	}
+}
+
 void raw_object_store_clear(struct raw_object_store *o)
 {
 	free(o->objectdir);
+
+	free_alt_odbs(o);
+	o->alt_odb_tail = NULL;
 }
-- 
2.16.1.73.ga2c3e9663f.dirty

