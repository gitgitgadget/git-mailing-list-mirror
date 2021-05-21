Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F133FC04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40EF613AF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhEUWqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhEUWqb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:31 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1354DC06138A
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:06 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s19so21103848oic.7
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0UHkz8iIyqQOrGKccEIv1QFJPRJOSrxTYI4GYhpVDPM=;
        b=EgRzlADmgbjQ13HFfTf8gaXy6FID+NF5+U4IoeOXVxg0q/QvbIjeiNjL2RhBxSz10A
         TwOJ/Fk2gUOCZ3iWbrrCnfGwLIq+xcgkYOSzSo9vyvIkbpfL+fEdioyonjBZGpJ3b+5E
         7LwqiuoBwEU900AZ9PrkdhtL5tVF+7Q2T+h5gYw6IQw2zLNlFreXSnNDnjAuQaNX6z2t
         B4Yxj2SxApPHzNG+PwLWVpP9uSMM5LUuHKftyxep4ZtTdQ66fdhfmKDmI+0mq8SrCdFp
         Ot/ZNnc0DUBcHotSTVaUPA1k39hYclCiJq3qomTbJaCB2nObQDygj9dHPRgG9ljh0CVx
         oAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0UHkz8iIyqQOrGKccEIv1QFJPRJOSrxTYI4GYhpVDPM=;
        b=Jfex1NJTH3ypQdbZwAIkBYjbQR7JH3EWJ1vcwhuPIHcM0cNgb5H4oK0O3/RQdrxvK1
         CeqfIB6RgALEhZjqf8ixWPKF9gTrYOzxN2UxZXYFeHOErW49s0CY9DV3JKUiSl1OFLyG
         7/jJijiIpJgEU76pHLE9jb5r4ZWeQAMD63YovcSsE16bgaYB0W3qMhZXvly85JIu3v3M
         iIKRm1owwDymhntViOrYrRo3bonpavn61sWdQHODkarS1q5whF65d2Afx18t/L2nQlGN
         Z6t0VSa+I3XSKx0IVVReshVnCy+zBdSVUlaCFeZ/YWYCJiKDZlaTziwIh3HUpXeIjQUF
         KN/w==
X-Gm-Message-State: AOAM533VtUeyCjEavSd6EMd3s8LXQYx2YOU5vZWjXIXgsX8PQC5wNYX/
        frURZwl4p2ybiEkX1VxNnAj3pNNYG0jKlg==
X-Google-Smtp-Source: ABdhPJyXMRLOpdMXsvCjJOwLOZdqeujCQtfzdftDOZh7uXDmFGkqQONWsP8cljUGX/IcdNcIaF8e9A==
X-Received: by 2002:aca:c488:: with SMTP id u130mr3831281oif.0.1621637105207;
        Fri, 21 May 2021 15:45:05 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x11sm1555561otr.36.2021.05.21.15.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:45:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/11] doc: add man pages workaround for asciidoctor
Date:   Fri, 21 May 2021 17:44:47 -0500
Message-Id: <20210521224452.530852-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently asciidoctor doesn't convert number character references
(&#xx;) correctly for man pages.

This hack fixes the issue with minimum changes elsewhere so it's easy to
remove when fixed.

Fixes doc-diffs like:

            so line count cannot be shown) and there is no difference between
            indexed copy and the working tree version (if the working tree
            version were also different, binary would have been shown in place
-           of nothing). The other file, git-add--interactive.perl, has 403
-           lines added and 35 lines deleted if you commit what is in the
-           index, but working tree file has further modifications (one
+           of nothing). The other file, git-add&#x2d;&#x2d;interactive.perl,
+           has 403 lines added and 35 lines deleted if you commit what is in
+           the index, but working tree file has further modifications (one
            addition and one deletion).

https://github.com/asciidoctor/asciidoctor/issues/4059

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 6c4153f628..954acb3e7d 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -4,6 +4,12 @@ Asciidoctor::Extensions.register :git do
 
   doc = document
 
+  # Override attributes for man pages.
+  # https://github.com/asciidoctor/asciidoctor/issues/4059
+  if doc.backend == 'manpage'
+    doc.attributes.merge!({ 'litdd' => '\--', 'plus' => '+' })
+  end
+
   inline_macro :linkgit do
     if doc.doctype == 'book'
       format = '<ulink url="%1$s.html">%1$s(%2$s)</ulink>'
-- 
2.32.0.rc0

