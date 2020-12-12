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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20E8C433FE
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 21:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D5D22507
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 21:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407890AbgLLU7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 15:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392132AbgLLU7q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 15:59:46 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB6C0613CF
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 12:59:05 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id m19so20442480lfb.1
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 12:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Sil2ipWLaHzmM6B3ooqVKTDv95KPauqrEpWUGNSM5g=;
        b=b2S2L9o8GslxMlEk/J55YIe/Ze18t4mksPUgFujIbMD5L2M9EoI2Si0kGm6ywPsXt1
         6FWImLKg/YiTSW+3Nm93eqQub5KdqV69k94eNlVQ13zD1RjrN+PYzXonO9iUK6Cfh0SF
         C79HGAw8uuytFSc5J7bYUBcCfozl57+yWkoedY0v7Nw3zA+z7nTWrlEk+5naGpiUWf8X
         0HE23VEZ6Orv0oLMFMPgomGuQLUhhcN0RFKMMYsIJ2twEhWsJM0hthpm2c8mtBZP9+gR
         pkKRycd1TrYCb1rDTIuzBLROq8rnVEy4tsFV4rIeNnwpNMKBp4jAw5XmiwE8StQBlzxC
         ogzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Sil2ipWLaHzmM6B3ooqVKTDv95KPauqrEpWUGNSM5g=;
        b=Wxc45EJH6rMF6O0hvTNxVLNvTS3ZVgmbWVN2kIe+ut4HIuGG8nWT8Oxg+BLHo71bst
         t8DAQlEUB9x9u5aow2QLW3Zm9sJywI86Fq/r0lESzELLIli29fDz+H7KlrfLFXJWHqKP
         x35cjlZNe4ALcn6FtKGCgQyWIPfT5wURS1LU1MhfQT4ZU3tRhrzbTjkCS+j/azaSwaAo
         BDb+/I3zyRRIxmZcauCEwwilpaTeT7ZJMyNvMnJk6R7DzMHKVARBXSFHd3lAl1GTMd3B
         baFhxfTkVMJalIkhCKsfhc2l5tz9JnB+KO5MUzioS3hgXxDtfg5LVo9TxxjCto1Cogmw
         zLZA==
X-Gm-Message-State: AOAM533q9aANbFfyMUf2QQrqAvCCmQqPDRaUPuAt8RGDa8UbUbCaXAHY
        jDgzjwNDA8hAvcA9QVooeLBFJhTTaBs=
X-Google-Smtp-Source: ABdhPJxWC9phAbwyaXQ98o73Hp8chuQjNthlF+H/XeaP0+6zQ4+7yLMluwdlqPJ2cQFwfVyGKHNsrg==
X-Received: by 2002:a2e:3216:: with SMTP id y22mr7615055ljy.178.1607806743980;
        Sat, 12 Dec 2020 12:59:03 -0800 (PST)
Received: from localhost.localdomain ([213.24.126.14])
        by smtp.gmail.com with ESMTPSA id e25sm503454lfc.40.2020.12.12.12.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 12:59:03 -0800 (PST)
From:   Alexey Roslyakov <alexey.roslyakov@gmail.com>
To:     git@vger.kernel.org
Cc:     Alexey Roslyakov <alexey.roslyakov@gmail.com>
Subject: [PATCH] l10n: ru.po: fix typo in Russian translation
Date:   Sat, 12 Dec 2020 23:58:58 +0300
Message-Id: <20201212205858.1224141-1-alexey.roslyakov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alexey Roslyakov <alexey.roslyakov@gmail.com>
---
 po/ru.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/ru.po b/po/ru.po
index a77b462e62..3cf7b6ad33 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -11578,7 +11578,7 @@ msgstr "разрешить обновление ссылки HEAD"
 
 #: builtin/fetch.c:143 builtin/fetch.c:149 builtin/pull.c:226
 msgid "deepen history of shallow clone"
-msgstr "улугубить историю частичного клона"
+msgstr "углубить историю частичного клона"
 
 #: builtin/fetch.c:145
 msgid "deepen history of shallow repository based on time"
-- 
2.26.2

