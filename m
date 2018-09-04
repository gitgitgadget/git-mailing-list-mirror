Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0AAA1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeIED3U (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:20 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:38367 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIED3U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:20 -0400
Received: by mail-yb1-f201.google.com with SMTP id f124-v6so1804054yba.5
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L0l6mma+vCYOvkUGx7FMwejWxS4BRxfNnZIl2OE4SJo=;
        b=VbIlKag7tNO+StIFYzqCZmAUXelPRnt+0po5VVffcnu/UpSqr3CYtFBPcpqkHTnZjS
         88DvtaxAAeb+2ZsWEpZ5ayHgXCg2AfCTaLUp3Z+wk1XpaKEncnDpxvroA/glnH80vPHo
         of+g4EWy1ohGyDlGfjaf4mUqjca3nUyTTd/wQlD/OJT5kQDxhc45tOilca4ysp5j2iT5
         UUE/xVLNsvrB+vhveRc7e+t8zQoCVkLd8MlsMKB4ZkaVNnN+lUX99IvPmr3APjdnEuUo
         sDOqtmEmdECJxDxbzt0EbP+zD5aySu26Esq59fzYpdIhDL39oysZX2DEtUPovC7ECnwc
         pE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L0l6mma+vCYOvkUGx7FMwejWxS4BRxfNnZIl2OE4SJo=;
        b=aDOGXPDlFNpDlpQE2+jlxfFYGGo1+lrGKyZTMMAy54WkkE/SiUfD4fV0R5G0+fEyhG
         dKyL651ARK5jFZGEW9yfp8WU7tFuvD9K4JP8GUhsWBCUDBJAkzp9uQvo7rVe8Kex4nX8
         5lQuAxl+H4Yzvoh5Zmgr9XkA+fZCjqJsy1WUIAeGhlYAwzrSDt4luIG8es1Ergh6VGkN
         5t30qPbZeu7S3+ggQgyQsrUQ91symaeKQmIiWvoDvfQ9bsDIltTbxZHKQ72hZ7/zsp66
         VxhEidysR6yA0gFHnefB/pmzqBqAzLNrwac6SbzjTA0icQlLMyYnmosxmjIElLF+Wdtu
         +UeA==
X-Gm-Message-State: APzg51AvKb01mnn7LeUjX82icY7xZ8zI+eaFK3oMoouQvL7FL1gqh7im
        i7s+49UPhNtke1CTBQpl+CX5lDXaAlLBJdbezFw6XtuVwd7OIdpk/nvaJ42UaJfLMGTcxQdZyr5
        xEvsBsOQWjNyhDQwSEgiQlEfGMjYeY7jYneMhFG87+Ds776fyRuo+G3FZRVGR
X-Google-Smtp-Source: ANB0VdZbxWRfUYhr7/3weZOTzyGYnmwvT85fx3505VdI6/Pth72jHT1RWP/w3yhL594Yo7HR/h6RFws40q97
X-Received: by 2002:a0d:ed82:: with SMTP id w124-v6mr9313330ywe.116.1536102123872;
 Tue, 04 Sep 2018 16:02:03 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:41 -0700
In-Reply-To: <20180904230149.180332-1-sbeller@google.com>
Message-Id: <20180904230149.180332-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 03/11] sha1-array: provide oid_array_filter
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1-array.c | 18 ++++++++++++++++++
 sha1-array.h |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/sha1-array.c b/sha1-array.c
index 265941fbf40..7eada4d1811 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -77,3 +77,21 @@ int oid_array_for_each_unique(struct oid_array *array,
 	}
 	return 0;
 }
+
+int oid_array_filter(struct oid_array *array,
+		     for_each_oid_fn fn,
+		     void *cbdata)
+{
+	int src, dst;
+
+	for (src = dst = 0; src < array->nr; src++) {
+		if (!fn(&array->oid[src], cbdata)) {
+			if (dst < src)
+				oidcpy(&array->oid[dst], &array->oid[src]);
+			dst++;
+		}
+	}
+	array->nr = dst;
+
+	return 0;
+}
diff --git a/sha1-array.h b/sha1-array.h
index 232bf950172..b516ec4bffc 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -23,4 +23,9 @@ int oid_array_for_each_unique(struct oid_array *array,
 			      for_each_oid_fn fn,
 			      void *data);
 
+/* Call fn for each oid, and retain it if fn returns 0, remove it otherwise */
+int oid_array_filter(struct oid_array *array,
+		     for_each_oid_fn fn,
+		     void *cbdata);
+
 #endif /* SHA1_ARRAY_H */
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

