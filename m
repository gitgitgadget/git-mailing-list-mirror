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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B5AC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C986124C
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhDGW4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDGW4h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:56:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026E1C061762
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:56:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r8so685374lfp.10
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ilQ/QpCgaV0kdQYtTqfM5166jU7yNx17Nae+WbsPqDE=;
        b=VnE04BgDUoQxAUGSaAARrMVJZUc2YCa07xw7t/jpWTQpbeNo5NQgEL0tTVyV3l+SZD
         84NzoRp1WhTVIcy5V0rA/f4/0i6r9r+TBWkjtadtzEgNnXD2ffELyiiMqj4qUvfvWT5Q
         oPSWwNayhgUSyDFAZXPTKEptMuopR4Bra6gLG8OF/GR7RgkA4kxXtUjY8olgNeBS4gR1
         GmY8ozkjgkSYZMSxqYUIhp7OwCMSHbVxypBC0MS4SgPLOHOQ/8yoETfI88VyTVf6w6b0
         XBtZOaqDcG/qvrxm9xjB5oJO0+P93G1F19sKZUBo+MyPMWXK+quFmF9ndleQDqaEf8SA
         zyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ilQ/QpCgaV0kdQYtTqfM5166jU7yNx17Nae+WbsPqDE=;
        b=SiUfR6JqnZlwuesnJU6wjflfNEjLv9dXrpUqbB8UPUg32543ZGctETAC8ZZ2G7OAL4
         lz32GzG4b7gqIYO1+SBtgUqTFCERpxNPHYVtMhxCdpYEd/MucHujM6BG/1NmRcMr/h5v
         Z1bo9XdFIj8aGlBl+ju8RAFGqTWXLiIpNUzSDBvDW2VFwu+epmoKLpUKzljmhPRtux9m
         pISX6AqSYra5nK2LMl8HM9wohJfQdJlMo4kqAY0Z9I9mD7QZEFzQzNVKmSxaWDJKYMe+
         PzploSlorRofUmxqzKh7cd8R8S3CqboicbHyEv8tffXdLL6ssLzFgPrN6yMamXZRMBz0
         UulQ==
X-Gm-Message-State: AOAM5326t8cjRfvvLqftWYkNEVbaWp9ASKm6LfIYf+4+3hU5DcP/al1d
        dQqIZo/MCcYScnlQf2T8XnuEVinXY10=
X-Google-Smtp-Source: ABdhPJwJEvhpRliEQRNETUxXevzKh4RXTHEQlmfKpNRkvAq8qeeNep4LzLEpRy9v86pxP1N83f/N8Q==
X-Received: by 2002:a05:6512:3aa:: with SMTP id v10mr4077714lfp.308.1617836185597;
        Wed, 07 Apr 2021 15:56:25 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t25sm2580101ljo.102.2021.04.07.15.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:56:25 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 5/9] t4013: add test for --diff-merges=def
Date:   Thu,  8 Apr 2021 01:56:04 +0300
Message-Id: <20210407225608.14611-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407225608.14611-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new option by default should match --diff-merges=separate, so
test this.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6cca8b84a6bf..275a6790896d 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -452,6 +452,14 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+test_expect_success 'log --diff-merges=def matches --diff-merges=separate' '
+	git log -p --diff-merges=separate master >result &&
+	process_diffs result >expected &&
+	git log -p --diff-merges=def master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log -S requires an argument' '
 	test_must_fail git log -S
 '
-- 
2.25.1

