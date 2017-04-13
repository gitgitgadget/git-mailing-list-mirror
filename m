Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF55020960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932071AbdDMSdQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:33:16 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36052 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754810AbdDMSdI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:33:08 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so34005038pge.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F/0vEKs9XgyWiryHwYSY9IR5okycMUAKLeDk+N+WCYw=;
        b=NrQZnT4Niv6XhOuvJCvVI3LXRFUUwlIaRgsscUh2pWz6x04Uc2PS+iO5KgMa5nN8O3
         sZINMYeT883Gtb7jgNMhCkOqtP3BFtyGrAQwozqh9g98Lb2S7bzsizxQMAKMnJspWZQB
         hdwFyAJJLr6fKIGUYpzK1rmtBVU4PDir41w1rSLKu+5zHHIAt+lSNJJmaGiN3t7NBpHM
         CosB9oixZjaMBUNlcsaVoZ7l+aOz6WfwtIi26HS6ogtrvRQzkmezPiSfI5gpJ8gOoDqi
         mn2yX8M4NTkZQXEEdl58i6zhVfH4+D7i6BaG/4vtb1MZHY33LPyDgab1Q49VVW8KQfh3
         vfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F/0vEKs9XgyWiryHwYSY9IR5okycMUAKLeDk+N+WCYw=;
        b=JByIvJW8pImo+mNATZwobN+iwzC7cEzYQbqeNVnR/w+ByI1zIw2zKiikT06kk0AIpu
         JOxC2+2S78JndexXfZVq1pIZ3mGDl8MBfLre16+ej3laY4hxey79ljFozNtHhdoujYWj
         mZwuHJumR++cP/H4BjXGOZS72sMNdRjigqSTCJTajWW7TuTpAjZ3Swu2IxgZQAhjuiPU
         yaq0R9sKt8gKBHJ3ZM2QBA2VRT5PeUleb4Z/qdbFQTiTp66REzViQyvZhMYgY8+xMQvo
         gKOl25HNHWIOR9nOXcKWaW13XwnwJakSNPTetrfQ3Dkwiyw078i7umlonP3782ZBlC+0
         ctLA==
X-Gm-Message-State: AN3rC/6BDSVH5HHF6rp3/ojP+0ev8ETkFv6ZEaWh9sioo1lnitcRHNup
        cnZmi8QlQ6g+2NlI
X-Received: by 10.99.125.75 with SMTP id m11mr4160575pgn.13.1492108382369;
        Thu, 13 Apr 2017 11:33:02 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 201sm43764654pfc.126.2017.04.13.11.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 11:33:01 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v2 1/6] t5550: use write_script to generate post-update hook
Date:   Thu, 13 Apr 2017 11:32:47 -0700
Message-Id: <20170413183252.4713-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170413183252.4713-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The post-update hooks created in t5550-http-fetch-dumb.sh is missing the
"!#/bin/sh" line which can cause issues with portability.  Instead
create the hook using the 'write_script' function which includes the
proper "#!" line.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/t5550-http-fetch-dumb.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 87308cdce..8552184e7 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -20,8 +20,9 @@ test_expect_success 'create http-accessible bare repository with loose objects'
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	 git config core.bare true &&
 	 mkdir -p hooks &&
-	 echo "exec git update-server-info" >hooks/post-update &&
-	 chmod +x hooks/post-update &&
+	 write_script "hooks/post-update" <<-\EOF &&
+	 exec git update-server-info
+	EOF
 	 hooks/post-update
 	) &&
 	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-- 
2.12.2.762.g0e3151a226-goog

