Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA1DC433E1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86292084D
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt+Pj6Nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgHERwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgHERuG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:50:06 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF7C0617A2
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:50:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y206so12863167pfb.10
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzQP0fpTEenofZBakSUNThJaAXN5CPnFNEIP1yxLOdU=;
        b=Jt+Pj6Nl0wgKUMBhM1rt4JIgtwadLKRX0d52QEBy2ZeF1MyVwelQtHcbd7Ukser+bu
         YmTwYAQV6cUJsIQYQ45kWBraQhQrtTEhBoPEgVqfDREsmNU3qQCsnuS6RCd2oSrJGf1a
         PYIG0WSJLGQn5LRmqgYmnkDTB+oJRMPOZTGXQ61yQFFymGtHfOqxjJzOcCslXLPlCWuw
         EW0Q89CEBMdIScb0f9tJCZG1rgneuHOiTZ9FjhgO/cCe7tIY72wKHdSjZm1tn8QGmO4q
         W9RyVGLp5/AnVcEkbqeYOtX4nw53MrC1gwK0XTpFHGSxHKvsjP4xOSKQQBWHALRCFry+
         XgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzQP0fpTEenofZBakSUNThJaAXN5CPnFNEIP1yxLOdU=;
        b=RYT5Gz/AzEo9BEpQEqt1c+FT1zcNP1YwPxnUMSAknJcsFseN+//dQWuOx8+FlszM+x
         Co9atEvmsv0WXhqU27BYs8MQb05Lqnkpygqa5jKpmoKeaw6MnXjsZgbTkBb8Ii4yGeyp
         udDO1SDJE+71ywpGuLW5UBpdwKAIyYn5O+FNeMLasdBm4QHOWYcvGHNwNwsY00Eqs8z/
         G+L+CDJLPfyi7jeiQZpVCuqFPhskk6yLi0wkUPHRFNCkNTTY/jDxgEaUWJ25vRJX5afX
         1HiWpquCM0Qu0Hiqmb6bXoFq8aaIY0LcRtLZX4mlSEjaWMfNlD6Ist5j140eGyHgLZMD
         UYlg==
X-Gm-Message-State: AOAM530IiDzVqtdlZ+zz2IIesAkLvgEZsimNAeDZKQZq5F0I06bM3mEm
        h/iwD/1N5B8OnvE9qd/ucPC68g/Pgo4=
X-Google-Smtp-Source: ABdhPJy9byliB9mnGOaM9B4B3RjuoqyTuPyB9xaYfv18sRJWti3PuBnXNb2PRiqpXyBShsmhWt/TTw==
X-Received: by 2002:a65:6817:: with SMTP id l23mr3973522pgt.428.1596649800477;
        Wed, 05 Aug 2020 10:50:00 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.185])
        by smtp.gmail.com with ESMTPSA id z77sm4765150pfc.199.2020.08.05.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:49:59 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] t7401: add a WARNING and a NEEDSWORK
Date:   Wed,  5 Aug 2020 23:19:21 +0530
Message-Id: <20200805174921.16000-5-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a WARNING regarding the usage of 'git add' instead of 'git
submodule add' to add submodules to the superproject. Also add a
NEEDSWORK regarding the outdated syntax and working of the test, which
may need to be improved to obtain better and desired results.

While at it, change the word 'test' to 'test script' in the test
description to avoid ambiguity.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 145914cd5a..2db4cf5cbf 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -5,8 +5,13 @@
 
 test_description='Summary support for submodules
 
-This test tries to verify the sanity of summary subcommand of git submodule.
+This test script tries to verify the sanity of summary subcommand of git submodule.
 '
+# WARNING: This test script uses 'git add' instead of 'git submodule add' to add
+# submodules to the superproject. Some submodule subcommands such as init and
+# deinit might not work as expected in this script.
+
+# NEEDSWORK: This test script is old fashioned and may need a big cleanup.
 
 . ./test-lib.sh
 
-- 
2.27.0

