Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D60C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 10:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346876AbiCOKD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiCOKD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 06:03:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201554CD5E
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:02:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so1833117pjb.4
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awySxKc5xFhxnHHFzRkvKyVHisBgxWuN4aZqsIoaCts=;
        b=C3kKR80Vosf4VI1hBj7HZgJsCnKzIZluK98aTuZCo5ZgAqs0Ed2HAk8j2Djv7P3hn6
         U+Dsrqy2BJd+81x/nIy+/WgcknvJ5JAFQchhW671Y56CfCx9rrVdP2WZzYjH2GgIKOW8
         iCjHagV0z6uR/GxClpDa4Z/ET2j4aDAdklpPk9zhJuL5edsF3GKZdoz1+lRD5qIjTcSb
         fmaGe5/gMJpC1F2R9dTttSB+u1qpfZ78qW0fhRYStLW63urcU0M7WcoZjlwrdhFh9k9q
         LDwDqroZ6inWVg+7TWzTP4WMNFsQ1xSy+XQjR/p4GHYtXDEB60Ox+0YBqergHNscTOMb
         rbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awySxKc5xFhxnHHFzRkvKyVHisBgxWuN4aZqsIoaCts=;
        b=qwm19QmzwbStHXDEbg1l8oqGP3A+7VQmcEnQP6MAC+Mps9HE8YGAroQJDfzVALI2v/
         kee4+54Jt9FCh4b0EMkB9EirqDiiopDm7ey3M3xiN08qCnrvTXsynPfurgtVIy6Q+OVa
         bdvZLg9IEKrQaeJOs+iKjW+pQfalniarVHwM8UbiBs4QLuJPbqOeiX+idSXDSKqzLwSX
         2H/mn4HR+dJ1gSjMcnMx6Az/kXk/ucLyWtgXux0RY+Tg6K//anqy8eM+LSH3L/S4iMc7
         jWpKFyt2ffdsNXnqHh8R+ELcndVxdkGBavpacisJhtAQoGcBwZtvMFdx8jEpOv6kXArP
         q5aQ==
X-Gm-Message-State: AOAM530i6TrKBNQ+QPfGH/khJBoXnmOyPlnEm/2ZcZnv8aVkUigF3SrJ
        46UPmiXZQRYe1xuQgxQRrmdG6h8gSyI=
X-Google-Smtp-Source: ABdhPJwe4i4053RedtyAelxH6YEF1FJuGGDMRIm0rD4x6euOyAx81cDzn2Earq8QZDnAxTs1Uzeswg==
X-Received: by 2002:a17:902:e5cd:b0:151:da9a:2b98 with SMTP id u13-20020a170902e5cd00b00151da9a2b98mr27249554plf.94.1647338535300;
        Tue, 15 Mar 2022 03:02:15 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.90])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm24316041pfh.177.2022.03.15.03.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:02:14 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [RFC PATCH 0/1] mv: integrate with sparse-index
Date:   Tue, 15 Mar 2022 18:01:44 +0800
Message-Id: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Integrate `git mv` with sparse-index.
The performance tests and ensure_not_expanded tests are not added yet,
cause I want to see if the added tests in this patch are on the right
track.

Shaoxuan Yuan (1):
  mv: integrate with sparse-index

 builtin/mv.c                             |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 34 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+)


base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
-- 
2.35.1

