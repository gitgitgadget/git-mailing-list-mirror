Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B67420248
	for <e@80x24.org>; Fri,  1 Mar 2019 17:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbfCARuo (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 12:50:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33690 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388466AbfCARum (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 12:50:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id c13so9339643wmb.0
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 09:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vK92IY4EcXeD2VZW3m6ilFyPCJQrxzPLz4K5M53xwT4=;
        b=ZC242BLcYKgtW8EvOtz/o/v+MZHjc3G87e6WASPAZWfilKXuFjw7Wx/WGhvFc3nXfj
         Vr24Vp/yYi5x3NMbW8a/XfLtCK3uwmR67m6awFJr3NzdnFBHMw/DfwbEV8ZGYfWylGom
         HrUXd0l6AZTCKj0Dr3hqCHFydRZYD5XyRlCZP2eYmi1yEvgvdTbmlR5NKA96NTPQiI7w
         rR6/HlNfSUuxH8yIvTyEGRHyUAP1bu0FEfdFdSxjriVuWaSZLVWr7gZ27ienmxwko+VT
         NzqZyc1DyaL2hf0RaBk30ONHkC20LfwFZ1P97Ab04O0uiQxrVE7Ou3TLx+KAeCd6xqrG
         Qaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vK92IY4EcXeD2VZW3m6ilFyPCJQrxzPLz4K5M53xwT4=;
        b=ZFcCXfzL4VUqmTU0Z5o3SsiRVx7kHxNTj2oWk7c9pOPZ/trlJ1SJ/scB9wEBjdVYmm
         RYkF1VE2lN0TswG4qN3tVW4WELrmMyy4B23arYDqfHXbIZNpVWXPCQyqM+5vwznYf9Nf
         VlkW/3R4NpD5pBU5NVyyVUsRN1onEpxVGgL5Y5jSghHUi/f5WVO2EQIr8LM/Z6ZKXAQH
         QXfj9vPVKj8GEQ5smI1Zo5XoS5WsaKkfMQ01KIKUFWKCSDpy2Ks2zW6ZrBaMkRpo78NC
         GhOvT5jMiwSKCTRh7e2BhCNch6kYgR8qh0ubfLhMGssLt0cG5+hPKDIuk9RO4dO3RTDC
         DT4A==
X-Gm-Message-State: AHQUAubBzUTSxqRxndxQ0AzmR3uWq12dNEDgpT4rMhmaeTUj2qxP8XVU
        i+x9W01WjleI18q3iYscEZ7zauEm
X-Google-Smtp-Source: APXvYqzJxIBRvcoVe+EJRHcrCaybDRQzMn6D/3hpZBPR3o5LDb9iY2qvzn9/PsrviAkBpQ51S+Ling==
X-Received: by 2002:a1c:9d94:: with SMTP id g142mr3996999wme.125.1551462640239;
        Fri, 01 Mar 2019 09:50:40 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-112-206.w86-199.abo.wanadoo.fr. [86.199.35.206])
        by smtp.googlemail.com with ESMTPSA id o8sm11672247wma.1.2019.03.01.09.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 09:50:39 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 2/4] commit-list: add a function to check if a commit is in a list
Date:   Fri,  1 Mar 2019 18:50:22 +0100
Message-Id: <20190301175024.17337-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301175024.17337-1-alban.gruin@gmail.com>
References: <20190301175024.17337-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid naming some commits, name_rev() will need to check if a commit
is part of a commit list.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 commit.c | 12 ++++++++++++
 commit.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/commit.c b/commit.c
index a5333c7ac6..fcb3e9245f 100644
--- a/commit.c
+++ b/commit.c
@@ -524,6 +524,18 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
 	return new_list;
 }
 
+int commit_list_contains(const struct commit_list *l, struct commit *commit)
+{
+	const struct commit_list *item;
+
+	for (item = l; item != NULL; item = item->next) {
+		if (oideq(&item->item->object.oid, &commit->object.oid))
+			return 1;
+	}
+
+	return 0;
+}
+
 unsigned commit_list_count(const struct commit_list *l)
 {
 	unsigned c = 0;
diff --git a/commit.h b/commit.h
index 42728c2906..c9df613b0e 100644
--- a/commit.h
+++ b/commit.h
@@ -165,6 +165,7 @@ struct commit_list *commit_list_insert(struct commit *item,
 					struct commit_list **list);
 struct commit_list **commit_list_append(struct commit *commit,
 					struct commit_list **next);
+int commit_list_contains(const struct commit_list *l, struct commit *commit);
 unsigned commit_list_count(const struct commit_list *l);
 struct commit_list *commit_list_insert_by_date(struct commit *item,
 				    struct commit_list **list);
-- 
2.20.1

