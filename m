Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C705C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 16:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjEHQ7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 12:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHQ7l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:59:41 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016554EFB
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:59:41 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1aafa03f55aso26070695ad.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683565180; x=1686157180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dLUhuF6uOKYAoZSfwaPr08LEFMr3AKQHlQqMsgFWks=;
        b=2rCdO1PKDUJ94pjVJ2JPq5gDocNNQW2gL+05bdbKzp1CaoXN0TQA4fWs/uxxChsPYp
         8DuPgFqA595QjX271Dx1ud9MENH7ZKWJuq7aGZIhTaDh3WKdd2Tj79J2kKlA0UyC+PSS
         CP8JefNJg/w0OV7aAdu13heeD/6yf5iuW3Ne5s+j12t7iXP8ZlxEHdIMUXgU/jTzRP0Z
         JCCc7+RXqwoCtYnkJ+HMaPtydBoN/ANWWtXgianed44zP6tMJq/tRhMkJMnAzV+mPOql
         2JIrlDzfOGdKhVwGbEOzh2UYpgr7tP4J6cmZJxcRVJHGxlbQ/CeHmubj67px9uiFagFt
         DCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565180; x=1686157180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dLUhuF6uOKYAoZSfwaPr08LEFMr3AKQHlQqMsgFWks=;
        b=Bk5TBwvvUF6JzCBC46y8lZPOmqvvg/4wolKHGY6Ekit8H/XWnReuIkj6eDrBEPRQDA
         X2/4Rvd9BTqfIIDAWTmnuJ5Ms6tZYN2LYlYFmeMbLV2GDwJkJ0l95zSYUviNOYH9Nyy4
         FgO8Al/qv+cA8L6LmwW6AMFaF6GrZTBTeDdObihsnrufTxi/9t3FRniXEclj8G4YZVY0
         uBW73U77ysTQTpK7eu9MnfdN7JDlKkoaodaJ+FRjedFwcKwCB4EfD8dYfzTqbe8sc+gJ
         L6zW/hETr/VM8AA0VC0YdvvhXaGX7mF3goWuTQISmeSH8HKyAkOZ2R/vD+D+xuHBpVX2
         ggwg==
X-Gm-Message-State: AC+VfDzZaOFGwDHRBy+Ms5gishSPp1liy4PvqdDpdrRuMcEPw2eB/fxB
        RSBP9W+Xksy/xi5H9rBHKHt/FKUfpNEncMA++YGAQS9kkclNKpCwXbocZDCjUUZkS5g9uNztgyi
        4p54AKh9nEvzRfJuR5oQM9Omr0fDWA1vgz0MgkyGpQexpa5CgL8clafsP5zUrPZ94qw==
X-Google-Smtp-Source: ACHHUZ4hRz2icClf3P7VOpkgNNF1rmdD1ShUwoG1NFs/yWd94ADT1S719vgrr1RaWsJKcnEEldytMKq3ptfK8XQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:bf4c:b0:1ac:6b92:6609 with SMTP
 id u12-20020a170902bf4c00b001ac6b926609mr2091755pls.1.1683565180319; Mon, 08
 May 2023 09:59:40 -0700 (PDT)
Date:   Mon,  8 May 2023 16:59:02 +0000
In-Reply-To: <20230508165728.525603-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230508165728.525603-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230508165908.526247-1-calvinwan@google.com>
Subject: [PATCH v4 1/7] strbuf: clarify API boundary
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf, as a generic and widely used structure across the codebase,
should be limited as a libary to only interact with primitives. Add
documentation so future functions can be appropriately be placed. Older
functions that do not follow this boundary should eventually be moved or
refactored.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 strbuf.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c..c856253216 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -5,7 +5,11 @@ struct string_list;
 
 /**
  * strbuf's are meant to be used with all the usual C string and memory
- * APIs. Given that the length of the buffer is known, it's often better to
+ * APIs. The objects that this API interacts with in this file should be 
+ * limited to other primitives, however, there are older functions in here 
+ * that should eventually be moved out or refactored. 
+ * 
+ * Given that the length of the buffer is known, it's often better to
  * use the mem* functions than a str* one (memchr vs. strchr e.g.).
  * Though, one has to be careful about the fact that str* functions often
  * stop on NULs and that strbufs may have embedded NULs.
-- 
2.40.1.521.gf1e218fcd8-goog

