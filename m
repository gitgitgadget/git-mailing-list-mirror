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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93387C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA222342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbgLPSwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732259AbgLPSwG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:06 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5385AC0619DE
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:51:03 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o19so25353328lfo.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaSmZ/RBecu+NFyjcFfJUxhbi320cgCBZWTJ9QUWVDw=;
        b=LCG7jhccGx+mZio3CxOJ4/5RPLjqaisEjM1sFOQDCVG4rqea2eH+FVvp7EyiUXzDGX
         kqpH451BXMELBk5Qy78WSOHMjT8fXa2kaZ4T1WmZ1DUz6fdIEPkm0OrjtepokjNtMnv8
         KVhVld6OW90qQ8HUcvornDTDwPAO5fNKgkB80LzldzUdsYPetYXYK7r6lAMoDPZipHAe
         WKscFJ/CqLXJ/DbYlTJYjxqrowEoVVORdAwuc/r1JzU2fEKHcztevXGq11e8uxsmq8sC
         uR8yv6BssYbI6Wl2p6ol6A/UA4d5mCvuxjs0EEUxhew0oy9MuvAR98BNZxLd0QhnmdXR
         y1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaSmZ/RBecu+NFyjcFfJUxhbi320cgCBZWTJ9QUWVDw=;
        b=jVKkSD4qsmz8XDm16mK895neCVx3xyNJhqBQvw81o7G0/KWm/7izIyvmI5bShK1T+h
         G2w/1c5ahyw3dzBdVZykbh4BS/lcw2aX7XaGSJCl98UHLhdFgCvW+9gvNFEW/ZPh6ZkP
         7xsRoLQUNgCGFeiJXJr2BSuvBDFVeFsgnWVZGhS60Sapc8Z7C1hngHcOkCCbxzE9Sxoi
         pRzfG8vIK4i9URwTH/9EDZE2lO9ZITZp7yRlpyrhn76mCmPjqF18pGVBTSJQFoR9DIIk
         d3sqHCI3gNXMVEjM5GXKtyVlP2b5i933/CzLc+N1rLgO/x5twzdOggUma4IjyxY8h7uq
         5rvg==
X-Gm-Message-State: AOAM530i1nUPB8jW/Scrjpz5X7g3jGvH7WnixshEFJiVMJ9Bx9GivO5Q
        4+gpNcmiYylkJTZr6iJDXnw=
X-Google-Smtp-Source: ABdhPJzsVVM1vzUoSOgXMIMiuPE3yV18h2tsTJwK5ssQq8gzyf9IEgCqEXZOecZPZAVf5wTOJ2u3UQ==
X-Received: by 2002:a2e:9296:: with SMTP id d22mr5891373ljh.197.1608144661081;
        Wed, 16 Dec 2020 10:51:01 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:51:00 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 31/33] doc/rev-list-options: document --first-parent changes merges format
Date:   Wed, 16 Dec 2020 21:49:27 +0300
Message-Id: <20201216184929.3924-32-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After introduction of the --diff-merges=first-parent, the
--first-parent sets the default format for merges to the same value as
this new option. Document this behavior and add corresponding
reference to --diff-merges.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/rev-list-options.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 002379056a07..96cc89d157d2 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -130,6 +130,11 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	this option allows you to ignore the individual commits
 	brought in to your history by such a merge.
 
+ifdef::git-log[]
+	This option also changes default diff format for merge commits
+	to `first-parent`, see `--diff-merges=first-parent` for details.
+endif::git-log[]
+
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
 	for all following revision specifiers, up to the next `--not`.
-- 
2.25.1

