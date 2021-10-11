Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA92CC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 19:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8358C60F43
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 19:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhJKT2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbhJKT2G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 15:28:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC7BC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 12:26:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e3so25843548wrc.11
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZANoYut8zipPZdwsIERSG1Oc9oru7+jYg+yvvaNhrJ8=;
        b=hOjQ12GSIpj7iOtGTiBuM1CK2WTYuLfYfI8On2Ne6+tOp0hYPtLh9f0iAqcgUpYX5W
         hgq1jZP0iatWM5wbXnMzHlRECZ9SOY27G3M97g6NACqJ090gC1jXUIQNnZQ5haqJUGoO
         veZLXUWLvGK2N76ZJnuYcoxXxz9a9IiQkOqKZ6RAcYm/NMgY++ePfA4FQoTLqeRDjI1r
         OvBkieM3CnIahM+IdprRUGorzir5Tb67mZ73dEErpe5ayL2GPv6E7yWhw/T+f2FBj1xx
         4U0g7N8uyi5j3+TwZvVaZl3tLt34qcQ71Z5aiC2aDl7XP4pM4DkhrwP22hbieIE+2lho
         3OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZANoYut8zipPZdwsIERSG1Oc9oru7+jYg+yvvaNhrJ8=;
        b=gfTHd2yy7fxijxJejhwAgi5vhXUHM/N59qeHntwozfwi1ntolKxKKisAb1FTdmAtGl
         7rH9vE2fp6f5O8u7BZYY0hB/OsA2tZR0BVbW6u8CWd+h/WyRClnRDBYkXdYHy8rfF00k
         ylv1flL8O4nlhXMjGeHwkk/iyG2QSKd7Z78Rwu7QJSFiAk9hjOjSBltf69bSFIf/nfHQ
         oDR41Xk16b5II6upJGR/FYyyzItM6ue/NNkjnFHohklLvjn+0HzXutGyefbEdLxPblwW
         1YCBOkPoKZyXgqtOtCevj1cujka0pf7j4oe7xyMRRq1Hzm6KrZQLOdQAqWpctVfZgWfc
         7x+g==
X-Gm-Message-State: AOAM533yQnVdwyC6mQRtgbplurVzKOCv6VYqbdo/yAEX5oSWCHjGypOy
        IrSsvr4Gw7IpNV2qbkDs0F3k2yzc8/4=
X-Google-Smtp-Source: ABdhPJy3HQkF0+Ug0mFeR30MFEtKw4qGOM6WdFmpZ9QN2wVH9cHso6SeuRsw4WHl4Tlo7QPfZCwAnA==
X-Received: by 2002:a1c:ac03:: with SMTP id v3mr911625wme.13.1633980364130;
        Mon, 11 Oct 2021 12:26:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:2c2:db70:6136:8fe1:d969:6eb6])
        by smtp.gmail.com with ESMTPSA id b19sm423627wmb.1.2021.10.11.12.26.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Oct 2021 12:26:03 -0700 (PDT)
From:   Robin Dupret <robin.dupret@gmail.com>
X-Google-Original-From: Robin Dupret <robin.dupret@hey.com>
To:     git@vger.kernel.org
Cc:     Robin Dupret <robin.dupret@hey.com>
Subject: [PATCH] http-backend: remove a duplicated code branch
Date:   Mon, 11 Oct 2021 21:25:46 +0200
Message-Id: <20211011192546.1571-2-robin.dupret@hey.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211011192546.1571-1-robin.dupret@hey.com>
References: <20211011192546.1571-1-robin.dupret@hey.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Robin Dupret <robin.dupret@hey.com>
---
 http-backend.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index e7c0eeab23..3d6e2ff17f 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -466,9 +466,7 @@ static void run_service(const char **argv, int buffer_input)
 	struct child_process cld = CHILD_PROCESS_INIT;
 	ssize_t req_len = get_content_length();
 
-	if (encoding && !strcmp(encoding, "gzip"))
-		gzipped_request = 1;
-	else if (encoding && !strcmp(encoding, "x-gzip"))
+	if (encoding && (!strcmp(encoding, "gzip") || !strcmp(encoding, "x-gzip")))
 		gzipped_request = 1;
 
 	if (!user || !*user)
-- 
2.30.1 (Apple Git-130)

