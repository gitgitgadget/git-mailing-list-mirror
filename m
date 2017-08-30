Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73725208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdH3GwX (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:52:23 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33574 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdH3GwW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:52:22 -0400
Received: by mail-pg0-f65.google.com with SMTP id m15so4476623pgc.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GtWgrTCk/1j+eolyMrtrByMk+MXjxRURFTM9OCAS9HY=;
        b=onNr6hQV8xBAeqQ1+oEcPquNik6Aql3S6gutDuEYFShe5FadkWQiyMMOZ/7zzfVnAi
         koSlnGBL8J51k1DpaUdi2GGqaAPr/co3NaFc5YjngDJTagSow2BnV4QthaYA7iAcY2Ju
         2iiUex8iF/m8awSnt7Sa6my8JIVXu2jbbGrtAe/CHxbgZYrCATamoFherUCKcMgX6wdA
         o69DYnLTQYPET2LvQ8H6/f3mrNKU9O6Cl7eaoVRcQaoY92vejjJj+GbtoQGd+NsJ++HU
         UuyjO4gBO/sBbb3Ri6039KESRjUCeLZwkLx73+mRd5Gvlw7Nfy76Afeoe8om0jIeMMot
         u8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GtWgrTCk/1j+eolyMrtrByMk+MXjxRURFTM9OCAS9HY=;
        b=Dokqa9DtDBNhUFoABIBZ8IrTxbMElvd4K23+ejM7I8dgNQwsNnWw2D5/+mt46nE6vv
         gCiWK3sNKWlogfBaDufnC6sCRHFEe4Rm0okDEuDiOHN+pX+BZqONyN28pqLNoKJKioN/
         z9qV5qUixFtw+siktIUOWpX4F6snIxWC03sb3bcpXVGCr3j8v8qaAVr21KkJmjklc1kV
         thcRzTm4uI+JbGq7M3T5s5FAxG5BpvnXsQf8ZmobzagQyXevyTaphPHN0K9C5imrwN/L
         A/034SfxmRBrGVwsIFWLXHxfUG4TrYIYk04S9VMzoVw4wStDbZUEXh4u7Cll2SXe2Vz9
         RDdQ==
X-Gm-Message-State: AHYfb5hmkQjRefZj3XE1kJzpmjfbINceAOn3rnsSTt4pqc4qf1iqa/dw
        LQ9DqEmZMdOi0p7xuZQ=
X-Received: by 10.84.193.131 with SMTP id f3mr736208pld.50.1504075941906;
        Tue, 29 Aug 2017 23:52:21 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id w6sm2144721pfb.13.2017.08.29.23.52.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:52:21 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:52:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 02/39] repository: introduce object store field
Message-ID: <20170830065219.GC153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

The object store field will contain any objects needed for access to
objects in a given repository.

This patch introduces the object store but for now it is empty.  C99
forbids empty structs, but common C compilers cope well with them and
this struct will gain members very soon (starting with the next
patch).

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Are there any straightforward ways to avoid the empty struct?  Should
the struct have a placeholder member to avoid language issues with an
object that would have size 0?

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
index f107af7d76..566753ed4b 100644
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
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, 0, 0
+	NULL, NULL, NULL, OBJECT_STORE_INIT,
+	NULL, NULL, NULL, NULL, NULL, NULL, &the_index, 0, 0
 };
 struct repository *the_repository = &the_repo;
 
diff --git a/repository.h b/repository.h
index 7f5e24a0a2..9633ad10f5 100644
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
@@ -25,6 +27,11 @@ struct repository {
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
2.14.1.581.gf28d330327

