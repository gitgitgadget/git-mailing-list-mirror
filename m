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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BA8C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D318611ED
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhFRS1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhFRS1s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:48 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0E5C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:37 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so10554213oth.9
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SKUdI/eXoS4KI0sXQ3uhGAKhlse6UmMtt7eTNP8YLRE=;
        b=nzNPLtMelNImxtFyM31EBJGx8xjaADwJEOfcfLOzAsiV2RjaxZHjWds6NZdIhSzi/R
         HFe5vM5CZe5U8unEgV3G8IDBaYDYbzrBuB+cQk24m7HGdHyN8oREF7Aj4tEBgxeBJhe6
         c3ttDDRSbGaVBz3mN40zkU30akte6OHVFR61Ud4+2yjt42FGmI53fURqrAw/VPKmpRIw
         m+sytkydwo72fCBjQ+f4DYbCm7AxuDlBO95+rg+Lrkt00BjlBhO0TItA+5r1TeKc9e+i
         ApYtXvRJJvnXWEJ7sISAR7MTu5TZ/m+TuYAji1pZ/OVhy5mQWnbtyzDGubld7szLdp3I
         fxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SKUdI/eXoS4KI0sXQ3uhGAKhlse6UmMtt7eTNP8YLRE=;
        b=X67pGcqIBMkACdqPf5qIQsjfFLxO/d3gzepjaO3OvkDhWu/k6xI2nfGHmmqdcbV6/x
         8p8jNTOVoiBigSNJNMCBIOCDM0Ubd/79KmJkqZpn/XDMprzovuad80VTHeguuvrefRwq
         73rIZ/6cyX5I1eC36mOv11eZJLGKM11afs1lDhGbZqCSXSkYfMOt9EDnbYvnMmblplUR
         hunNc3IA09Jwfd6pWy6aScr8/5aCZyKmKII/K2jZYvQBEqvvXuD3Ee8+YSp72d9VDlZo
         YdF6+YNn/V86RlzKRD/CZgiqdHD1sTqxEA/t4z7lcMZes8QVZOdtmMBn9ppBqUgEyRiR
         j9IQ==
X-Gm-Message-State: AOAM532iVQlL0idTbyUJJ0dJqgClnrVa1xX1DjknUgeexfk+iEGwnuhc
        lKd6T9y0jbEQjIyZC6MWTnJtnhm75oe0pw==
X-Google-Smtp-Source: ABdhPJwVTBlD4iijMt8gqZvzJb1JGDFy1ZV/IdC0mDiZgx7Wx/laKh+ziGXl6zUTWIxT6EfGxamK5Q==
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr10458662oto.17.1624040737005;
        Fri, 18 Jun 2021 11:25:37 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p5sm1926529oip.35.2021.06.18.11.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/45] test: completion: fix currently typed words
Date:   Fri, 18 Jun 2021 13:24:42 -0500
Message-Id: <20210618182518.697912-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They don't match what we are supposed to be completing.

No functional change.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6b56e54fc3..bffe1b0928 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -489,7 +489,7 @@ test_expect_success '__gitcomp - option parameter' '
 '
 
 test_expect_success '__gitcomp - prefix' '
-	test_gitcomp "branch.me" "remote merge mergeoptions rebase" \
+	test_gitcomp "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
 	branch.maint.mergeoptions Z
@@ -497,7 +497,7 @@ test_expect_success '__gitcomp - prefix' '
 '
 
 test_expect_success '__gitcomp - suffix' '
-	test_gitcomp "branch.me" "master maint next seen" "branch." \
+	test_gitcomp "branch.ma" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
 	branch.maint.Z
-- 
2.32.0

