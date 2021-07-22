Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5E9C6377B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4361608FE
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhGUXYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGUXYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:24:09 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A54DC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:04:45 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u11so4805106oiv.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hCpHK+Kjwfbv2BZ2eKcNZKpr7kConNGdm7aP93kEqLo=;
        b=M+ZMO50ynrnqlQ0v0m1rXdVK4Gs38kurJUk6yWDf0k5gNWEO+aKYwSGcWAr1YAE0DG
         a0S1vQYO7rNKRlbrwWCmbiyP8Fl58ZCEKJ/82MnuKwYZsYavC5ncsl+4ewh5LN309ge8
         XNETc29XfddsvGc0guxIedE6FW6OaF0YzO2gUfZ02mU/yjpgZAO8mAg5ycwZvHJOtsMA
         WD+jA0r7cryOUIwc0TmkyJbDfa5WjkYeu1FevJgqV7HbpWJgZII+/mtsYj1MTwWXb6/e
         4h9L2IKf8sKXTZVvyD/8zvsGzV1LmpuQ+4voX8GxQ+7LJ+dTEF2MA8/f62v730qzOw7P
         Y2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hCpHK+Kjwfbv2BZ2eKcNZKpr7kConNGdm7aP93kEqLo=;
        b=JP+UC4pnwUS96sxy+BIkZ9uzshW6OAz5WCJnogNJXmT6ppAntb1Jvr8julhMKZUA5s
         9dzN8Ohmci/0+UQsl8q3BnHl0/CaO+2Irftuf6p6MD4/CCBoJ9Xvlev3Zj5XzkTy8Qun
         czBacpeDNSldZQ9FNIv+2aeQRTl0baKhz4mQWspcGLyjCd10nyZj8+A+A98SOLVdYdZm
         +EfipdctvOdqOE0WrUSwN2nhaeo8VFz/KetL6M0uAwd5J7Jq2MW0tUCWthZ6UM6sU2cl
         kWR4TNTIJANUQI+3apBhaNKIPlFNI5hc2XX4PATqAIuUA2yzbWwnXPiBWGA39vn5SyuV
         c7Jw==
X-Gm-Message-State: AOAM533Lm9W+h6tCfnOlacUM4x/b7Qrg974jyAR8tkkICgaOXOC3QBWr
        Vy3nP8Zh0XX/uGGYGHBFk9sM55unHEMqFw==
X-Google-Smtp-Source: ABdhPJxNVwWuEa9lkNzEM53hTSAy7292tOpQ7wNrHMESzS3rW3gBqEjnJ5N6iZdZ6UQY56bo+oo8ug==
X-Received: by 2002:a05:6808:683:: with SMTP id k3mr26302963oig.171.1626912284690;
        Wed, 21 Jul 2021 17:04:44 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y76sm5220444oie.55.2021.07.21.17.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 17:04:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] test: diff: use merge instead of pull
Date:   Wed, 21 Jul 2021 19:04:41 -0500
Message-Id: <20210722000441.1898891-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No need to call `git pull --merge .` when `git merge` suffices.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4013-diff-various.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 7fadc985cc..447cf269da 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -65,7 +65,7 @@ test_expect_success setup '
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
 	git checkout master &&
-	git pull -s ours . side &&
+	git merge -s ours side &&
 
 	GIT_AUTHOR_DATE="2006-06-26 00:05:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:05:00 +0000" &&
-- 
2.32.0.40.gb9b36f9b52

