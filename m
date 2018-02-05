Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7494D1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeBEXzi (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:55:38 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40102 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeBEXze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:34 -0500
Received: by mail-pl0-f66.google.com with SMTP id g18so85273plo.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UJIQYYAalnAv0aV9riBxTkl3b8rod5Z3vQARcI27U5M=;
        b=vG7if7TE9L493yRo8+L0/wmdw3ceQ9lCkc4lVADar1M2WuAFr7rnNlVLhBk38cHX7q
         s7mmKrM/xigReuoSGuCq4oA/D1mM2DBdfK7Txwnz1Vd2UCSeTrrRSfcKFwUxR5hztSiw
         jkzCmEcQbSR/nztDeNIdXaeFwM61l80duWHUOhkXelC6+wT/NVJs47TfICDTQ9Etf6MM
         CzBO8mQdFRnDlQRWflzah6KTF4oMSpbpODl7g5akP+FyIucW4OMZFOT8QJGtY924w+WW
         h1e47qatp++jSAjawO4GTX/MkBnjZD7nAwJBt1KpDiMXk+9W8mKzi6SUuUoomaoAwiUj
         U2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UJIQYYAalnAv0aV9riBxTkl3b8rod5Z3vQARcI27U5M=;
        b=WU9kAVjzCnV25NNLPXQvZquvEVO3NOIoFw10iJiFKvzu0naNB/EITdrN3ZNrftdvQ1
         mji12MNltWBGcLzkX5wiW7EcI0lgfF/OmTp4Z9ZqwGvsb/IxQg1LvmdyEiB30y+6QtfT
         Nm7UrkwVNOyuvesX2B1R1OSXpN8ZpNaJdahojuc2ZRhFSSaI4Ano+iPPHwR7ZO9K81op
         Yt6inbxej9Q3Dg87tSx2vU5tARJsR9N6uKvhgTsnayYcrnpE7hPj/gfQaI39ijds/f3M
         VgZgxx6Pq/QGguw8N9I0K/qbqAzYCk0zUcL/TalCppL4dsoQJcVo22tRfUzT4mCynTE6
         KvEA==
X-Gm-Message-State: APf1xPBp5sgJQDfK8cFAdrkbjfPJFrhkcEMPa0hMNaUcCmz3zFuEw6e/
        pO4bH7kn6sNxwwYj03WlhzyVZlln2sI=
X-Google-Smtp-Source: AH8x22549ZB/jOoNrZW60lpS9ICIABL+l7MHutCVMkMxDbisrDp7uPb3p0HIsIlkKtByENPnZv7FMw==
X-Received: by 2002:a17:902:12f:: with SMTP id 44-v6mr472207plb.403.1517874933154;
        Mon, 05 Feb 2018 15:55:33 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id b9sm14048556pgq.35.2018.02.05.15.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:31 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 001/194] repository: introduce object store field
Date:   Mon,  5 Feb 2018 15:51:55 -0800
Message-Id: <20180205235508.216277-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The object store field will contain any objects needed for access to
objects in a given repository.

This patch introduces the object store but for now it is empty.  C99
forbids empty structs, but common C compilers cope well with them and
this struct will gain members very soon (starting with the next
patch).

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 8 ++++++++
 repository.c   | 4 +++-
 repository.h   | 7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 object-store.h

diff --git a/object-store.h b/object-store.h
new file mode 100644
index 0000000000..05722cdde0
--- /dev/null
+++ b/object-store.h
@@ -0,0 +1,8 @@
+#ifndef OBJECT_STORE_H
+#define OBJECT_STORE_H
+
+struct object_store {
+};
+#define OBJECT_STORE_INIT {}
+
+#endif /* OBJECT_STORE_H */
diff --git a/repository.c b/repository.c
index 998413b8bb..0ec9648f53 100644
--- a/repository.c
+++ b/repository.c
@@ -1,11 +1,13 @@
 #include "cache.h"
 #include "repository.h"
+#include "object-store.h"
 #include "config.h"
 #include "submodule-config.h"
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
+	NULL, NULL, NULL, OBJECT_STORE_INIT,
+	NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
 };
 struct repository *the_repository = &the_repo;
 
diff --git a/repository.h b/repository.h
index 0329e40c7f..ba7b3b7cb9 100644
--- a/repository.h
+++ b/repository.h
@@ -1,6 +1,8 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
 
+#include "object-store.h"
+
 struct config_set;
 struct index_state;
 struct submodule_cache;
@@ -26,6 +28,11 @@ struct repository {
 	 */
 	char *objectdir;
 
+	/*
+	 * Holds any information related to the object store.
+	 */
+	struct object_store objects;
+
 	/*
 	 * Path to the repository's graft file.
 	 * Cannot be NULL after initialization.
-- 
2.15.1.433.g936d1b9894.dirty

