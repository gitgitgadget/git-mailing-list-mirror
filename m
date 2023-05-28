Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ACFC77B7E
	for <git@archiver.kernel.org>; Sun, 28 May 2023 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjE1Tpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 May 2023 15:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjE1Tpb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2023 15:45:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294D2AB
        for <git@vger.kernel.org>; Sun, 28 May 2023 12:45:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f606a80d34so17313975e9.0
        for <git@vger.kernel.org>; Sun, 28 May 2023 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685303128; x=1687895128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iFMGUNRSMliBIQkDMQ8+9ztZpDwMqU1oCr25l7bCwBc=;
        b=szemSkDfE55t2A2Ta6p4ZerkJ6SwFb0WKteCFX6H+AwLC2cW7W5Y9aMKIV9B56Gvbs
         oHAYGPgAlyUkGQ7b0t0cxVCR1LKpRNPw3YbkJo7BEqUjyAJjORWVRUGmwh6yQW9au54n
         bD2hkQe+/28nL8V8skRwvMe0ThvCiApoJYdb0zUZ/+3dxwIVe7HFgi1GhjPmt/Wa+E/B
         0N1vcViUKRfIOSLHeNvh0rmlLVmS5iU8FlWHIz8PMuXwcD7JQ6yGkojxO/S+VxeqWH8Q
         hx+SZjwFubY1krCythN1rdOz09G4bfY3XpKCg9up8XDXikPRX5Ev1+hJ/yAXys660FW4
         0Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685303128; x=1687895128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFMGUNRSMliBIQkDMQ8+9ztZpDwMqU1oCr25l7bCwBc=;
        b=YH27peBqBOavZDb0QTYUHWPJfNXEXaYnQQ6VRmA6gq9bMFUglcZCCRa+Pky4UDhyvP
         D4/7Cdb8c7TS1BjMFyG9QRtR5zVYrMPur5skkxcD7E/NE7nN7t0c/vYFfRRBSzW8O6st
         SsFUlb7PAiwhVYNjoA4BksrvzinAbXkEyR4XmyUhXBw72sw8CxkFZ0UX6m8XBnXC+C38
         wlDz2cx6NajT+tzB1wkUY42Zk6GDlmFqqL6fQhgmxN56njmwZ0o4FQ2hq3CU8feQ8xpo
         bdKRwf29Bv/6dTdPqO4jfeNvjGWv9ld0rjljWFOra0Pa/6r4WaarrNfQ04UKweROutC8
         ghAA==
X-Gm-Message-State: AC+VfDzo/GOrAoWZL+0L8dTxctw0lNd2W807ybaS4wTjLgQDPiqofeIu
        +j3j2jTIFiMvF/TEIIBbEKyS+85Ymdc=
X-Google-Smtp-Source: ACHHUZ6pN9xBA7VvMoSyXjAOXtBaPfmXAoX6owSsMwjd64eoDSeZZxT6LHirrefysURSYaeHraPZeQ==
X-Received: by 2002:a1c:770a:0:b0:3f4:2365:e5ac with SMTP id t10-20020a1c770a000000b003f42365e5acmr7002610wmi.13.1685303128031;
        Sun, 28 May 2023 12:45:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020a1c720f000000b003f6cf9afc25sm11883194wmc.40.2023.05.28.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 12:45:27 -0700 (PDT)
Message-Id: <pull.1538.git.1685303127237.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 May 2023 19:45:27 +0000
Subject: [PATCH] doc: gitcredentials: introduce OAuth helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, msuchanek@suse.de, sandals@crustytoothpaste.net,
        lessleydennington@gmail.com, me@ttaylorr.com,
        mjcheetham@github.com, M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

OAuth credential helpers are widely useful but work differently to other
credential helpers, so worth introducing in the docs.

Link to relevant projects.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    gitcredentials: describe OAuth credential helpers
    
    See also discussion
    https://lore.kernel.org/git/CAGJzqskaM80+8+79yUf435tP93Sk8sFu7marCvyimE=2gOKnog@mail.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1538%2Fhickford%2Fhelpers-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1538/hickford/helpers-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1538

 Documentation/gitcredentials.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 100f045bb1a..d2a7249d52b 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -105,6 +105,19 @@ $ git config --global credential.helper foo
 -------------------------------------------
 
 
+=== OAuth credential helpers
+
+An alternative to entering passwords or personal access tokens is to use an
+OAuth credential helper. Many popular Git hosts support OAuth. The first time
+you authenticate, the helper opens a browser window to the host.
+Subsequent authentication is non interactive.
+
+Two cross-platform open-source OAuth credential helpers are:
+
+* https://github.com/git-ecosystem/git-credential-manager[Git Credential Manager]
+* https://github.com/hickford/git-credential-oauth[git-credential-oauth]
+
+
 CREDENTIAL CONTEXTS
 -------------------
 

base-commit: 79bdd48716a4c455bdc8ffd91d57a18d5cd55baa
-- 
gitgitgadget
