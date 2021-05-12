Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB34AC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C795613EB
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhELXWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349174AbhELWal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:30:41 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1477AC06138C
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:15 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so964613otc.12
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vKWJhHosL1A8utaqFpxMsBOjLO2+K+0RxBhCpDWIs0=;
        b=LZ6KLUQRtKZpI7Y/XvsdmdBFO7ykb0C73+0umWMJP6Vg2M8jSzbrJrw7H2oQg+6tbj
         H8ucw8HDEFCmTgUyzNlaD+0hSataI7XWCpQiipazZLpZ0zPug9UPtreaBp754LeGJbOD
         POz31sWoNvL8SG1ryul53p6n7nTRmiwgq0D4mDUWN1ciNwbYczje2R1PUwXS4aQOPIn2
         /wt2lqIkNH3+vN2o4KAgCRDSzRS8lVbxJgTClJppuCTllf3vFvMvHXQc9mY9fGEBegF6
         Tt8BUG3J+loTlpxcn076plUliusDMb9lnPqYg7G0swGb9sdcGb1UCtowUGNkSdHQF7Pm
         NPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vKWJhHosL1A8utaqFpxMsBOjLO2+K+0RxBhCpDWIs0=;
        b=aCAu8zwk/hShyXWfsxkoyjLzS30Hk27AZ8ppUhmD2AgXUek56/r/AnbDX5RAUoefn2
         q8ouKk4ZZ3LQ7E3WcrVSEVUkL7/54ycNyVfzJZM8DKDOkaXv+pz9390CiNbpmUt/p4gO
         OEVoLSFU9JMevPxD4/NYP6vHO8vHheQFE7r9CagTdn1piqvs9HhS7QW2u/zCn4QH2Bd1
         mUCVloc8TYPvDFPdSMkIsErc3dVg2wnrWeYUMrBrPC/jZYeRbM+8wRyzAtOn/EL+NgLm
         tQH+bXHbWrA45GCO5A4yD/Yg9FKuCAfbzgNZgardVH/XcZ53DygLN5t8wNaUxZY5w1gJ
         fFrA==
X-Gm-Message-State: AOAM530654VWbdg01d3aHYQZUA1/9LjQeawpReXGsIna18t0tWPbr9RR
        LioyhpgWtWoDSvZqcRIH067Kh5/ZpJrD1g==
X-Google-Smtp-Source: ABdhPJyQ2tOLznNrrzv30WqG+2zGRl47opCLKRgfSqoRne79i1Yo+D3sNWoZKBh//petDIdrFF+h9A==
X-Received: by 2002:a9d:3423:: with SMTP id v32mr32760666otb.168.1620858494272;
        Wed, 12 May 2021 15:28:14 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id f30sm300630ooh.10.2021.05.12.15.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:28:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/8] doc: asciidoc cleanups
Date:   Wed, 12 May 2021 17:27:55 -0500
Message-Id: <20210512222803.508446-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is an attempt to cleanup a bit the Makefile regarding asciidoc stuff.

It does not enable asciidoctor direct manpage creation, that's in a separate patch.

Felipe Contreras (8):
  doc: standardize asciidoc calls
  doc: add an asciidoc helper
  doc: disable asciidoc-helper for asciidoctor
  doc: simplify the handling of interruptions
  doc: remove redundant rm
  doc: refactor common dependencies
  doc: improve asciidoc dependencies
  doc: join xml and man rules

 Documentation/Makefile           | 45 +++++++++++++-------------------
 Documentation/asciidoc-helper.sh | 17 ++++++++++++
 2 files changed, 35 insertions(+), 27 deletions(-)
 create mode 100755 Documentation/asciidoc-helper.sh

-- 
2.31.1

