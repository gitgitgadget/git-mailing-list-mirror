Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DDDF20248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfDPJhf (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:37:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34199 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDPJhf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:37:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so10132465pfd.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mO9v1cGsqvkyzXV++nfuBYrqsEBe8PasqJK716GOFYU=;
        b=W5mbbuI4A21tUboNZv/I0nxF5cPc/qF/FFwmSd6QY/WDyPJ0xWVMP/kVHgCD8i3m7t
         45J2k4kaQ1lOyLvvh0j93WvAnCZQlx8mFnAxDJfq/gcNok0DtsNpESF+r25ROtOrBIiM
         N/5+K2unlcO3W5FM73h5oeXXoOLX+nptVqRH75APCMrba+DmJc3MOCzTXBQwJjkXs0ni
         EMmC5TVzCMyAQwlJiQuqK/fR6dW+dM/eKv/Lmgh75pAvFqYqH8gjiIYJ9zFE6hlxEKSC
         v+LcPznzBqOCrFGDgZsZOh5GpFjU5Ta6qDNpczi1Iqp5QT/Pf+yUMmRC+EodYgE1eWpR
         JI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mO9v1cGsqvkyzXV++nfuBYrqsEBe8PasqJK716GOFYU=;
        b=sUeZPugOJKhM2wUk8wWaHKLmZZig6fKLcuJss0OwwnitbE1tArJZyItYceNtkW5dJw
         zCJk2gkn9wugSRln/xm5+V8Wi01if+Ju0c1vbAjJMHYQWVe0+ZRRthxJW3kdcCqL6d9x
         5ZAIZQdgPeTCkpY/efhkUK494APQMuZynGD39gRUyuvJdbidn02aQYOI+w+UxPZ7eIfI
         g/z/HVJ4sl1ZNxRN8k2tZUyBwxfAUTABR2FJUHbuHjHHUEtcGVMYOEVweWppTEZPN4ad
         iC8oZMiYxZ2vFwXWAkJ7inEh5/6JDUllnFK7GkVD6MCmJyn8IiftoWVesthamKoXe2iI
         v0/A==
X-Gm-Message-State: APjAAAValgeO3oQwlIhkweeAZtgtqXvktFbyctCUE4yFMmmg6z8XVPS4
        UPKCX1YbMXlIPYrkvzhPWjh5RnYV
X-Google-Smtp-Source: APXvYqwDDIKhdLZ7RCOnS5o1AbwSZKWAbaC2yIJUXi1g+Ls/fxYw1B8bk0IFj07aPboX2zyvfluhkA==
X-Received: by 2002:a65:408b:: with SMTP id t11mr71258485pgp.372.1555407454432;
        Tue, 16 Apr 2019 02:37:34 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id q74sm93141705pfc.111.2019.04.16.02.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:37:33 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:37:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 30/34] sha1-name.c: add repo_get_oid()
Date:   Tue, 16 Apr 2019 16:33:37 +0700
Message-Id: <20190416093341.17079-31-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h     | 3 ++-
 sha1-name.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 2149dc4f56..f6e87194d0 100644
--- a/cache.h
+++ b/cache.h
@@ -1380,7 +1380,8 @@ enum get_oid_result {
 		       */
 };
 
-extern int get_oid(const char *str, struct object_id *oid);
+int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
+#define get_oid(str, oid) repo_get_oid(the_repository, str, oid)
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index 64a50d1291..953df0d692 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1573,10 +1573,10 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
  * This is like "get_oid_basic()", except it allows "object ID expressions",
  * notably "xyz^" for "parent of xyz"
  */
-int get_oid(const char *name, struct object_id *oid)
+int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository, name, 0, oid, &unused);
+	return get_oid_with_context(r, name, 0, oid, &unused);
 }
 
 
-- 
2.21.0.682.g30d2204636

