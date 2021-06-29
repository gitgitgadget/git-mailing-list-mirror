Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EE3C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F1E61D05
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhF2Gvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 02:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhF2Gvi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 02:51:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4170C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 23:49:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id u190so17634229pgd.8
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b0gsw/LopsUeOV179nKeYy7M0Z7eTPDGi4SmjTtelKc=;
        b=q2cpb3nH+WNhEub+iQKd4GTQLDpQ4tK9uYUKMb7abue9IIonbS22fQm98ZsJMbI7Rw
         Ud6kqP5GH/VG64mOrXiCoTvC6TN+RF13keW/oLozjVaoX3jYYYrYCI1Ywa3MBuXL5YO3
         DaFifnK/9flDe0wVd1fhLHRCJn0OtQSQJIH/SXkwnfwkWd0wxMhrynsT6upycYzaQBIN
         5uL0tuxxkeR5CI0nzbPiQeA0stzDdY/rrUl50kd4ra3iF5oZkUZ2GyLuuH5dNLoW1G6Y
         Mvx5z0NrD6sQyr6dbwl4dVws947w/qzOluifSOotTc4Yv8apNXfZH3zPX2Pnq3vCd+BY
         11nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b0gsw/LopsUeOV179nKeYy7M0Z7eTPDGi4SmjTtelKc=;
        b=fMdzlTpX4sFlurOq29EsSnp8ZTfYAx+lN+3UmD0Lxk4GI62ZeJjw06Xf9gtohiFJmk
         LyPUxCztWBuEdPxDGdt/WpNBtOOIFxas/VoptC4Ve5AnUrQ8ICZ3f6tus7JKRi9Fvw5D
         LtB1mYMNT557nYYoGedm0Bf4v4TqKw6bHlMFwB+0MSzHD1dCjQlF42epT/M/rigML/pa
         tyJLF4XtWuhwTLlC2ZJ0KLWvnaNRULJ2QwV4+5TcwdclI/8QouMKFKHkk9zMza0gBd9i
         BaGvMQ+G+ptLklSWJSD2MnNMRvh/M5nk+ONrvQgoT1onETqs9qBdmXjveLYx43X1eyeB
         5T3Q==
X-Gm-Message-State: AOAM532OU7V2k/e6UNYiD24/IDxAS4txxcGVcq1B1xKrJVrNionMUeTJ
        JSRZ45zqoby0QUMlNpbbKdE=
X-Google-Smtp-Source: ABdhPJzTtIF5QxYM5c1z+Ahv2/p5IHWsmsCAnj3JMZsJN7XH0/MlGWTf1iG2GM64fGVOFAevQNvzVw==
X-Received: by 2002:aa7:9409:0:b029:303:1db:94d5 with SMTP id x9-20020aa794090000b029030301db94d5mr29252777pfo.72.1624949350416;
        Mon, 28 Jun 2021 23:49:10 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id k19sm17319031pji.32.2021.06.28.23.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:49:10 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     jhatton@globalfinishing.com
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] rev-list-options.txt: fix "not be not" typo
Date:   Tue, 29 Jun 2021 13:48:04 +0700
Message-Id: <20210629064803.11944-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CY4PR16MB1655C5F8225B32A2029EADE2AF039@CY4PR16MB1655.namprd16.prod.outlook.com>
References: <CY4PR16MB1655C5F8225B32A2029EADE2AF039@CY4PR16MB1655.namprd16.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Hatton [1] reported typo in Documentation/rev-list-options.txt,
which is fixed by s/not be not/not be/ at line 900.

[1]:
https://lore.kernel.org/git/CY4PR16MB1655C5F8225B32A2029EADE2AF039@CY4PR16MB1655.namprd16.prod.outlook.com/

Reported-by: Jason Hatton <jhatton@globalfinishing.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5bf2a85f69..5200f18d2c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -897,7 +897,7 @@ which are not of the requested type.
 +
 The form '--filter=sparse:oid=<blob-ish>' uses a sparse-checkout
 specification contained in the blob (or blob-expression) '<blob-ish>'
-to omit blobs that would not be not required for a sparse checkout on
+to omit blobs that would not be required for a sparse checkout on
 the requested refs.
 +
 The form '--filter=tree:<depth>' omits all blobs and trees whose depth

base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
-- 
2.25.1

