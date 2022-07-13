Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1DBC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 04:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiGMEUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 00:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiGMEUV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 00:20:21 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B195AD9E13
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 21:20:18 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10c0052da61so12693433fac.12
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 21:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcKauLQI3tVjLlLN+oxJ1qVrmQ8ZLpc8GV9n1WApuvY=;
        b=L/iW3r2Fxe08sVDWCmmR49/Iqq6ejZUHhKPMHKfNMOu/ExtzSOyx0Zg8S8JyIqrTUT
         4qnBQ8htO133BFrMYKfpuspCscLSMjOIvunrZ1kfqBkDoWcYbqVhCgVjNuZZ36eu+u9h
         mfb+uiGXyLnxyTU9xRv380ZZpST/EMnWjaNQGEAYivSWdCMN7rDiiliSvS6cOXjp9eMg
         iYIOnCdojKWqt54nvFUXP4sLSp/IU2FmtyAC0OoTh7wfl7CA/Y9KclglAeS9koPZOG3N
         uXLqkHK0G/P0rH8wr3B8MgtEdusqbJ9cGm8Av8GcaXw0ZFxEuBGkDHid6vfSHhoYyaT+
         +XcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcKauLQI3tVjLlLN+oxJ1qVrmQ8ZLpc8GV9n1WApuvY=;
        b=rmXClPxH+T8wjNnniwjiOeDsPtPrq58GZhVQ9fKHyYq/YR65lKQeDveQjWT1WGkvfN
         lnRXGmooS4mhs3YAIOUH+JRrMk6ekGpMquE5PVWSU63Tr6lG/SyFV0afG6Wm0Lacf9wn
         +yhtpRdNZBnkpJc2IWfHrvz/xP6tU6fZfrx4IVm5gOdSq2Cdbfab9vOOIJlznES+YIG9
         gh+S1gKVUmaHvJ3g3B9oenl/pcbAUfuZck1OlZVz5lhlV8jQXORQ4l2Ud4lq2rMPn5RI
         RJKCd2VLgDxOxA2JKddUZE862KhtzpotpE19AdCAA71vXd0GDR1UB1l3AUf+uW8WH/yK
         J84w==
X-Gm-Message-State: AJIora/ILqnRG4Ap2VcpvwUq6iz651xuLk9IBT1un+dVSZLTx3VFnxDY
        ogUfNLGZ4p7KUc4ljDNWUQyMwJmizDVL5w==
X-Google-Smtp-Source: AGRyM1v0UChxhb+T3is6znzsn9AryWM0VlTcb75z6a2emfoDlSGMetgc71d1/QLyt7kcIcpfl23uyQ==
X-Received: by 2002:a05:6870:c08c:b0:10c:94ff:adb1 with SMTP id c12-20020a056870c08c00b0010c94ffadb1mr774843oad.157.1657686017427;
        Tue, 12 Jul 2022 21:20:17 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id eh40-20020a056870f5a800b000f342d078fasm5649062oab.52.2022.07.12.21.20.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:20:16 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] checkout: fix two bugs on count of updated entries 
Date:   Wed, 13 Jul 2022 01:19:54 -0300
Message-Id: <cover.1657685948.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes two issues at the "Updated %d path from the index" report at
the end of a `git checkout <paths>` operation:

  - Delayed checkout entries being counted twice.
  - Failed entries being included in the count.

The first two patches add tests and the third implements the fix. I came
across this while working at parallel checkout, but only managed to get
back to it now.

Matheus Tavares (3):
  checkout: document bug where delayed checkout counts entries twice
  checkout: show bug about failed entries being included in final report
  checkout: fix two bugs on the final count of updated entries

 builtin/checkout.c                  |  2 +-
 convert.h                           |  6 +++-
 entry.c                             | 34 ++++++++++++--------
 entry.h                             |  3 +-
 parallel-checkout.c                 | 10 ++++--
 parallel-checkout.h                 |  4 ++-
 t/lib-parallel-checkout.sh          |  6 +++-
 t/t0021-conversion.sh               | 22 +++++++++++++
 t/t2080-parallel-checkout-basics.sh | 50 +++++++++++++++++++++++++++++
 unpack-trees.c                      |  2 +-
 10 files changed, 115 insertions(+), 24 deletions(-)

-- 
2.37.0

