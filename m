Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBF0C77B7F
	for <git@archiver.kernel.org>; Sat,  6 May 2023 11:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjEFL1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 07:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjEFL1x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 07:27:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A463B3C11
        for <git@vger.kernel.org>; Sat,  6 May 2023 04:27:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aad55244b7so20375575ad.2
        for <git@vger.kernel.org>; Sat, 06 May 2023 04:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683372471; x=1685964471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Mk95BIPkc32gT5qtH7D3/p04WC/eaYTC8+ii4HdLEY=;
        b=cL9yuRKevTlEFlH1tRp2nR8Fjnf7e7bvc7jqFsFEf+qqJCQFALEZph9WV7QnrnDTCU
         sAx4QRxIEk8r/aXuj8xZHiYDkUEnC7aq6SMRXK6luGrNQmcV2H6HOpOUyLMmJeyYHYsH
         r9KVOExVI6Prlv05zwLRbENY5zYpAjoIBQAHlatWj2MwuhJQX4sLs1Vi6qSPKjinTNMd
         HxDi6AlE7zZw1qwKFZsE9xeEY3MbFwAC4TL4tVxtXMQ+bdBkx9KKD+LdTVRQUYwEvLdZ
         NAP/RdPdGAb20HIBnvcNOY/4+tyQdG6aexU0azMA8bdDyQ3ku7vd0+HJOhI8KdvTBgAG
         eeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683372471; x=1685964471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Mk95BIPkc32gT5qtH7D3/p04WC/eaYTC8+ii4HdLEY=;
        b=aXdNk0ERB5ZxpfHH+PCrA8aPnPEXm3TJ1M8G87CzzT/hDywy9JB5EUL9owZvYMaL57
         1walRjqirU6cnl3NsnG8PD2LM3cRIrRFnxaupU2bI3MwzZzN0hKgH/YR1J/wdDAPgxJm
         6QX+YmTXieyTiYabo2G4j3oq1Pg7bD25d+yjKyHJNIEOqf/iLi80pGgQl0Unxb25FndU
         br6btiERprm6qZxmqnOyqfKFZ/0LmtLsgE2VPtgvBB+W7VIddHuKG5j0CLJUYF42roSq
         o1SWJVKpmOEc6kbI+Hp3cuB1zhzTx5KJsHmyQTTHR9vB5AQbxGlEGEfIb1jXxqBvqv3C
         34tQ==
X-Gm-Message-State: AC+VfDxaDHvjQHQ8loFkVu8M2Yt3R+I9HBzAHkuT69pz//vTSOVOnTA1
        ALg1MrljVaKMvjzeAPo9ybY=
X-Google-Smtp-Source: ACHHUZ7mbnTKhGco+9OLr1k8IoNO6YcIooCmBKpG/HsB2oUZQQ0ek6WUDqUAXWDyFXQUN2sTrUEfBw==
X-Received: by 2002:a17:902:c410:b0:1ab:c04:362b with SMTP id k16-20020a170902c41000b001ab0c04362bmr5442093plk.0.1683372471060;
        Sat, 06 May 2023 04:27:51 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ea8500b001aaeba5ce0fsm3402920plb.68.2023.05.06.04.27.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2023 04:27:50 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     --cc=avarab@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH 0/1] push: introduce '--branches' option
Date:   Sat,  6 May 2023 19:27:39 +0800
Message-ID: <20230506112740.61454-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.446.gf331623a.dirty
In-Reply-To: <20221205133525.60464-2-tenglong.tl@alibaba-inc.com>
References: <20221205133525.60464-2-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Based on the feedback I got from the previous RFC
patch, I made a formal patch with some additional
test cases, but I don't know if the scenarios covered by
the test cases are sufficient, if not, the cases will be
improved in a subsequent patch.

Thanks.

Teng Long (1):
  push: introduce '--branches' option

 Documentation/git-push.txt |   3 +-
 builtin/push.c             |   7 ++-
 t/t5523-push-upstream.sh   |  12 +++-
 t/t5543-atomic-push.sh     |   5 +-
 t/t5583-push-branches.sh   | 115 +++++++++++++++++++++++++++++++++++++
 5 files changed, 135 insertions(+), 7 deletions(-)
 create mode 100755 t/t5583-push-branches.sh

Range-diff:
1:  9c9438c3 < -:  -------- push: introduce '--heads' option
-:  -------- > 1:  b16bdfe6 push: introduce '--branches' option
-- 
2.40.1.446.gf331623a.dirty

