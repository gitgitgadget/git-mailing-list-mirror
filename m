Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E699C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D17613D8
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhEUWis (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhEUWir (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:47 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1CDC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:23 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id h9so21141086oih.4
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pswKRjqSmEQtoeNs6BztCFLOKuD6NGg7hYBvW2ja2Uc=;
        b=h7yINgI+s3YVwr4HQt9cNmYpBtI3J0i1jX+YMVeWQD6+RAphZMvXNJv3JNZzhiiPRc
         swF9pkJHY5YM+7Y3nBMs/UXVFrCUshrN5y4by5EgUa8AzSPAYkqRubPiNXcB+g/OmWld
         zePz4B88tFKWzU8o7lFsF572SqVoysIyrMOVsnMsFGLY5DdK72e2/pVBY3uC808/J9K6
         TpafuUNKy+q78nR9XmqEeFNOG6t/dd1HuihhrrTHrA/DYAAlfmarRVxitZ4WlYD2pzee
         0d9FCEr/IwGjYgN3tx1Abg6UfPo8KCZ2FDUWTGRavL3jcVlXiSzV0FKZd4NPFyEthnwc
         n9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pswKRjqSmEQtoeNs6BztCFLOKuD6NGg7hYBvW2ja2Uc=;
        b=jlyqoKmajrR03a919LbhibErQ8m0DjyVp6epJkTt71Du2w9/yPuLIvq03mpkd60fHW
         MotPecBKJXF8G0JXFJA/qXwDsr+d7quy2fBip+umocX/ylZRgPTV02v6PpK3LQ3hOxEU
         WXa+JOJtX6sYL55oHbfL9uI9JP8PD3XuPRqQuQWyum1w/SgMnpXrDRCXZcLeGu+dAptJ
         Qbr3l1TZXG8smFGqoAXaSuBLio/IFjssER4Hibga/xLlPgUg5IW6swloRWwxac2BXeTO
         GJBU/SyjXInkg3JqLI8EEFT6Uj9Y2vv49zNa37WJl3xQBusPIWk05ypYL4fhcSkBw6j3
         /Hqw==
X-Gm-Message-State: AOAM532lyHohQzFP1tZvSXlzt1UWREDDoqAzDTpL66tcJ44DvYCsNxzH
        oh+tHftBa+rYqG+JJcnobOtqvFOzEM2PFw==
X-Google-Smtp-Source: ABdhPJwM6IGw+PDTGyC7kaKB7WJ7pG0MPUlY6xh9l7UJWOAMDNGVQ9Qu7rFn/IoJ8/4vq3PruBbrgA==
X-Received: by 2002:aca:b5c4:: with SMTP id e187mr3871803oif.149.1621636642521;
        Fri, 21 May 2021 15:37:22 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id n13sm1431187oov.30.2021.05.21.15.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:21 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/12] doc: asciidoctor: specify name of our group
Date:   Fri, 21 May 2021 17:37:01 -0500
Message-Id: <20210521223701.526547-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doesn't do anything, but otherwise we get a random name.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 51981af13c..b36317e4d2 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,6 +1,6 @@
 require 'asciidoctor/extensions'
 
-Asciidoctor::Extensions.register do
+Asciidoctor::Extensions.register :git do
 
   doc = document
 
-- 
2.32.0.rc0

