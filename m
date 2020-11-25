Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F4C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A3F2083E
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jurhebBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgKYXeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 18:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgKYXeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 18:34:46 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E6FC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 15:34:46 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f16so288116otl.11
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 15:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPwoMuVaPfNexQrz6S1uob394a3FX4L3NdElVOD58Sw=;
        b=jurhebBFzrxt5ed5KU4oS77GIlto93b5hH3+fiwbJJmG+ByHEJub3Z/JsUEDzBzL9g
         PQ4j3dLAqWH+cjXxq1NUbz0BTSHs5IZsiON4Fx+X0Wk+msyKguKTxa3pAOvAw0gGnT/0
         huFfcGIW2bumds/GswdV8w+mACuzpKfbEklbjkFEkE2ymwrmf5QLdM8AuRA+I3qDhxLA
         yam4zyUGTE+0m8Tw01uGhOrY5jc1txrT2mPw4wyQZyfa4otnk2HK/b6MNfYGMHHPP1T5
         eaZtQikVe0y+qwM28uKbuzPh/rrApLtREoSZnV1r5k3UGzzGXZK/0U63pOJp+soRhXjQ
         zk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPwoMuVaPfNexQrz6S1uob394a3FX4L3NdElVOD58Sw=;
        b=h7X3XWmc+nUEf7W49oQABIrXMMbWcmJVI+t5gXkZCTERkpmM0G6AXISnT+GOUJlBe6
         I6ddMs7OZVgpNPDkbOyZuRKpS+p3ChXZCI43pVB+qkadkK0ISKsc8Pj3ANK1IZQsbdjR
         OCVuZvcI9hwyxJrT6W9Hd0HFSN7ELv8ofVBdqp+EehbLyVu0Yeph1xMJlxjyF7zsAt1V
         GIlabCGngQF0ZWyfi6KAgDy3mqnosxML4fN4QSR1ZfZv0VwMI4qP4uebfASPUa+Djz3h
         sNeEbNcmw9pBclq1dwniLz1iMyXciJlsRoXJ4VR0KwiEbjbwzZ6ySetl6Wcl0QZG2Ei1
         dILQ==
X-Gm-Message-State: AOAM531y6jIZmOoPjHhtb6ehfohgBPbc1hpvplpVUr4VkUAbpxUNLRMN
        /tk+48uiZBxwwiiCSZEDlb5FGCo5UePD3g==
X-Google-Smtp-Source: ABdhPJyR6Cww5ifGXc2mjr7+AaKt9LsbbcHvpv7YbJXIm0v9j8aMmuOuZsAvfJGdmkWaPPA9tio/KA==
X-Received: by 2002:a9d:5381:: with SMTP id w1mr442343otg.7.1606347285399;
        Wed, 25 Nov 2020 15:34:45 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q10sm2168348oih.56.2020.11.25.15.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 15:34:44 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/3] refspec: make @ a synonym of HEAD
Date:   Wed, 25 Nov 2020 17:34:40 -0600
Message-Id: <20201125233443.63130-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Basically $subject.

Since v2 the tests have been revamped at the behest of Junio.


Felipe Contreras (3):
  tests: push: improve cleanup of HEAD tests
  tests: push: trivial cleanup
  refspec: make @ a synonym of HEAD

 refspec.c             |   5 +-
 t/t5511-refspec.sh    |   2 +
 t/t5516-fetch-push.sh | 105 ++++++++++++++++++++++--------------------
 3 files changed, 61 insertions(+), 51 deletions(-)

-- 
2.29.2

