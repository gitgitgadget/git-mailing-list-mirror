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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5A9C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 11:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2ED610C7
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 11:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242243AbhHZLjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 07:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbhHZLjg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 07:39:36 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81241C0613CF
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 04:38:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c17so2883844pgc.0
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 04:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nee/yQ1Cxf//1KGi5Cp2ZxgfZ9WL9YQWrJscp/fxHCw=;
        b=ItgaL5K5W9J/YO79WEhuBB7C5kU54G221gE1Ds3oFnOJZ1n9LORsZ1IV4WBlYf7SDE
         IMIggRPi4qgPP+ZD+yfhS7XWvFsg259gYFzbVzSHKNRYNYlQHLcttm8C0W+BIpVaVzmZ
         pedkBfotjJgqGsobqhU8QM8fPbRN5feFYigJugGbclrFDcW/LfXsrW4E46vFrIgD+LJd
         0lnzT3YVZqfcK76aQUqNm3/ryJkYgbDB5pQqZUND2rEzgQ55jggc9Qswt6msN9psohSv
         8Kp7rXG/G91NORI61vWYsDpfiYWk6UsMHZUySLiuXhtKb/EB/iBClF/QKS5TSRun7Z5C
         MPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nee/yQ1Cxf//1KGi5Cp2ZxgfZ9WL9YQWrJscp/fxHCw=;
        b=fpz/9ijolW5FEzweokynFzfw+pHkAy/0quY6R+KsSgNHVASM4hprgwckMIrVopaLR1
         KL1tTmdqj1yFenZVa0BcAo5XeH9e2UoxFPRGkMXEaokPxOH+S4F7d9HaMplDa4QvM90u
         2JkkDiHcMlJ+pw2Gya+lfCz6NfZs7M4DNbzFyRwY5YEY7vGyXyF+UCCY5VzsnmKm/ucb
         P+8Wvnui9LkB4tevmFQHwyJfmGtj5obC3qTtzBdkmeednQH9gwwtoKqRewWzTS879QEW
         HF1dwEUwElslg7mAjbv/ite9nUkFvJF591pUJ2jM9XalaUH2gAvbQLAgHod6SZfBkVcu
         cFZw==
X-Gm-Message-State: AOAM531bW8XfAZ+B6No6K3CNVqAmegm6CVuJGOlL6Sl1wqwLUtBL+CiA
        fMN0FXqf87Ny6azn8CxD9pL9wBP2P6ZhIw==
X-Google-Smtp-Source: ABdhPJxhS2EtLoWq+ucTfAI3tCBIXUB9aTfsQfnEOFb0OfaWMlTPm6Zc83QJcXwXmr7NfymCgC3OZA==
X-Received: by 2002:a63:5024:: with SMTP id e36mr3019243pgb.66.1629977928913;
        Thu, 26 Aug 2021 04:38:48 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-8.three.co.id. [180.214.232.8])
        by smtp.gmail.com with ESMTPSA id gm5sm2414717pjb.32.2021.08.26.04.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 04:38:48 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, felipe.contreras@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/2] make: add install-stripped target
Date:   Thu, 26 Aug 2021 18:38:23 +0700
Message-Id: <20210826113824.50078-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826113824.50078-1-bagasdotme@gmail.com>
References: <20210826113824.50078-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the target that install Git with stripped executables

The executables that are going to be stripped are all of $(PROGRAMS) and
git. Because they are installed over various directories (bin and
libexec/git-core) within installation prefix, the location of each
program needs to be found and pass it to $(STRIP) program.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d1feab008f..b8a3a64422 100644
--- a/Makefile
+++ b/Makefile
@@ -3102,7 +3102,12 @@ endif
 	done && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
-.PHONY: install-gitweb install-doc install-man install-man-perl install-html install-info install-pdf
+install-stripped: install
+	for f in $(PROGRAMS) git$X; do \
+		find $$prefix -type f -name $$f -exec $(STRIP) $(STRIP_OPTS) {} \; ; \
+	done
+
+.PHONY: install-gitweb install-doc install-man install-man-perl install-html install-info install-pdf install-stripped
 .PHONY: quick-install-doc quick-install-man quick-install-html
 install-gitweb:
 	$(MAKE) -C gitweb install
-- 
2.25.1

