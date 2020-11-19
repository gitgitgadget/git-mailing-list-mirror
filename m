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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E39AC64E7A
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7549246CA
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo0wCJZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgKSBwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 20:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbgKSBwO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 20:52:14 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6ECC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:52:12 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id n11so3857811ota.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0CPRKwSM6Qfv2Q6OiDNOGD07uETbKoQYOglgvR2Lqng=;
        b=Jo0wCJZoDyjWibHZ9tUf/TY57qdM4vqBJnGl9V946KDUmDemIP+BGyxYKjFKgFbiqw
         z3ZEzH84P0CTSH+vk5HeLPOf/JBxg+9BRmo62giHHfSkFnTZQ+Mo/yhcvto6lmUsKStB
         hOtK7BUe46cNULve1eZyi94O53Gy/ROcYe3bJg610W8G2RFzFKgtELMzdt2aZg7m6Flv
         hRbIa3EgDSZ97VNwj+59nme6YSTTKVfWACcYCz/JcpSGiKPtS4iSwth84lIucXd7fTwn
         iZ/rNZ9UugeO1yM48kIphn9BQ+5goKYgzeL7X+SzC5BWmGC3Z4heKpuBETTSifuwK+Lb
         ZLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0CPRKwSM6Qfv2Q6OiDNOGD07uETbKoQYOglgvR2Lqng=;
        b=EQ9uFG3q5Wve7Sv4H1fbUm7GCxL76p5Vnyj7VodxkSQmwAXPn5/2zCLfZA2JlnxQaL
         AWUKQWnluGOpPc4EtHaUjmJke5+Jv2yXrn8x43KfoLaJyzz38PzUKNa/dOaVZERaYCyH
         GPbSVApugm5Qx1fwXBgVRZ/IXa7b3isfQ0niEO870DPVl8Zs+GUOlVk5dWRx5LBODt1y
         5/zHPdvZy9RgAo+/zjhlHiyjUNUQNQioAwKTJ4oONR2XXxX4SpslGudXhsGQfKLyhTMF
         zRKhFlCgvyBo/tmQyi1RBycZsIGTjaoJIaL8eidwyUc0g/TNWLFnt7ZCkl2/uV9lBA6M
         GKSw==
X-Gm-Message-State: AOAM533Ds/ObMfNXFKTSpXH9Oek0Bd9HRVVQ5bKxsPkVsRu2AdTTRHAh
        3Rii7PYIWEGgsz4VtNGk11igNuhif5aYog==
X-Google-Smtp-Source: ABdhPJwq6DHna7NjUrUuE1PotmsXz9+otHbM4Li+ykY1iDxwepn2CG0L5EvIkXz1FgU27PNSEj6LvQ==
X-Received: by 2002:a9d:3b43:: with SMTP id z61mr8341432otb.178.1605750731912;
        Wed, 18 Nov 2020 17:52:11 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m2sm507408ots.11.2020.11.18.17.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 17:52:11 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] completion: bash: a bunch of fixes
Date:   Wed, 18 Nov 2020 19:52:05 -0600
Message-Id: <20201119015209.1155170-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is just the bug fixes from the previous series.

These should be pretty obvious and straightforward.


Felipe Contreras (4):
  completion: bash: fix prefix detection in branch.*
  completion: bash: add correct suffix in variables
  completion: bash: fix for suboptions with value
  completion: bash: fix for multiple dash commands

 contrib/completion/git-completion.bash | 14 +++++++-------
 t/t9902-completion.sh                  | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 7 deletions(-)

-- 
2.29.2

