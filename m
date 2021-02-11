Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E66C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EF064E44
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhBKTs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhBKTsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD32C0617AB
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:23 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x136so4366626pfc.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e9FC9Rb+YR3BZHhsXijpSxgv4TfHEHmdAKhcZMs8egg=;
        b=tsDS3HYU1qxaFFnvoLfOm6M+eJDaPB3l2+xYVcl4nuKIIiHx8Ro0F/hBd2XKkCHbK2
         +/rB8UxSQIjWWQFFqZxgNurLVjdNiQrFj8oP1SGR4AzZgwUB5CxXNCiilAEtumRNBJ9U
         B6tgPMJGF3KPt/a1EsJmB/SGk0AhfKyuDvFy4S85rY9DZ8tQgXoLjo8O/EkfeW2krl73
         oNO3TbOpu6A0pn0AAkGNcItxgYOxAQhYatdC6jZsc56TIOTjxhLiPw4j4R1UxV+JmQMG
         3Qdkwy1vxjB/lrnliR9MdIoaZR/p9nt6Wtm4U2+zJ4yLLs12lVnpfFkmUsnmTQBcGWyc
         7yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9FC9Rb+YR3BZHhsXijpSxgv4TfHEHmdAKhcZMs8egg=;
        b=iQ9ebSjrjyKgCNVOWh489N4PxiOYVQ6D9iNa1wmPwEzXC7Ca0m29yCgZVmjfIeBdDT
         ZmRJwCBlBkJnUNSCxQpaS41mC0Ef0nKLLF5RjBicWHkuLusGc87tDZGD9HLvDmXh5r1S
         FeeG9YlKC8HcYHOw1wWMIGs0pp6IhlzskXU8SU9BhBpkflFOIHco/L7zKc9zkqi7/FHX
         s9qCAJodmko4xBOkc09cjQd9pAnRz50+z/qkqLZl8IW88BTWp6vytL8upye/XfLUeq72
         05O5S6JY6eODzp9TdSXdichbsBeqsJqNLkD0GrjT0S6ggP6d7eM5ASpASwUNPB1ZBP+m
         lJ4A==
X-Gm-Message-State: AOAM532fvms7pHS8BEVcFjLcsPKyF0w6oqUJLKaf3RFjNtvOg0HIST/o
        342spLQen3urCSKenVByoprGAmC7nN474Q==
X-Google-Smtp-Source: ABdhPJyyjNQZLZwIdPpq29iOGmScmhNLH1el4zB6XUpMfq+mw6nLfmCIkAI4o2Evlvkad7CaIk5pwg==
X-Received: by 2002:a63:5525:: with SMTP id j37mr9692921pgb.191.1613072842771;
        Thu, 11 Feb 2021 11:47:22 -0800 (PST)
Received: from localhost.localdomain ([47.8.36.172])
        by smtp.gmail.com with ESMTPSA id a141sm6524778pfa.189.2021.02.11.11.47.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:47:22 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 05/10] t7001: remove whitespace after redirect operators
Date:   Fri, 12 Feb 2021 01:16:59 +0530
Message-Id: <20210211194704.28913-6-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211194704.28913-1-shubhunic@gmail.com>
References: <20210211194704.28913-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to Documentation/CodingGuidelines, there should be no
whitespace after redirect operators. So, we should remove these
whitespaces after redirect operators.

Signed-off-by: Shubham Verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7fd4341988..2e49e9af81 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -156,9 +156,9 @@ test_expect_success "Michael Cassar's test case" '
 	rm -fr .git papers partA &&
 	git init &&
 	mkdir -p papers/unsorted papers/all-papers partA &&
-	echo a > papers/unsorted/Thesis.pdf &&
-	echo b > partA/outline.txt &&
-	echo c > papers/unsorted/_another &&
+	echo a >papers/unsorted/Thesis.pdf &&
+	echo b >partA/outline.txt &&
+	echo c >papers/unsorted/_another &&
 	git add papers partA &&
 	T1=$(git write-tree) &&
 
-- 
2.25.1

