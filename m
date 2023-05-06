Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AE8C77B75
	for <git@archiver.kernel.org>; Sat,  6 May 2023 11:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjEFLeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 07:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjEFLeP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 07:34:15 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F07681
        for <git@vger.kernel.org>; Sat,  6 May 2023 04:34:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643a6f993a7so999034b3a.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 04:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683372854; x=1685964854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Mk95BIPkc32gT5qtH7D3/p04WC/eaYTC8+ii4HdLEY=;
        b=HS32KJYaEkZa/28Y2Gu/1abY+h2l9FY7V8YqQp9H/qjXFyKUvJW1at2N9yWWV4ogtz
         Zx5utblE91UUAmjXT3dTBIb6nbdQTd9HFr4O6H/WvFOiWkiXiubLB6PgvHNyoPkJ7BP+
         432CMp9M3uTDFrPt8r0uqL9SW+9TdRUXjyyq7gPIqoaU4hM6TEupsvEPgSOozSGLDhwi
         e8mLPGwIFRL6bb4CMHKAjZbpEYGqW9TqC0vbzoor+t5Un1vlSah6bPRlch4L8WUFCCvh
         9af6+H0OsqtCsi/xkQhl+bLaT37ODrOcn9ddWzbJp/n4wlGRg+AblIDT/HEVW+SBiiXo
         1sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683372854; x=1685964854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Mk95BIPkc32gT5qtH7D3/p04WC/eaYTC8+ii4HdLEY=;
        b=kvjxnbAyhMn7lK+fHkQSGe7xevf2pA0sYrHBwyiG4ucaeTyDpsDpCQojndVgs01jpV
         Pfd0EoitJf8MakS3n8aOjhYLI8R23fpp+BX9u5RfudIn3jnabAHrpSAzPACVHRVQEjqp
         o0fo/6Ker0OWTTD83jRLYmgUoUhPwZ1EEn/pa338rYF4ErfM7bgGDIe9hgU9bNuOBau/
         kpFwaohPX/ARWwBKr3+3d3n1Itpl9PYvVDaZGrcDFurc/8zqKz8Sf3YA/3ANBN0ijvZm
         b0HZFeNfEnzFlt7VWJKA75YM4fa5aq2q2TuRMuefk8G+YUMghkcqTCYRExy91qW81rEe
         o1pQ==
X-Gm-Message-State: AC+VfDxqklk70EIsmUwCiRxLKSu6pbZI7cDDNPC05ZxzoYkBDCu2p8Nd
        Ldqjg18SpdmxnDk4UIqkOsw=
X-Google-Smtp-Source: ACHHUZ7vD7sGc04UB+WRQrRwOdvTdMO2BC4vHHMe6dxZVoNxm2HxD4F+3Fkg0APoaTzzK7b7/GuTaw==
X-Received: by 2002:a05:6a20:a110:b0:f4:3935:4470 with SMTP id q16-20020a056a20a11000b000f439354470mr6080767pzk.8.1683372854330;
        Sat, 06 May 2023 04:34:14 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id e19-20020a62ee13000000b0062e0c39977csm3001244pfi.139.2023.05.06.04.34.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2023 04:34:13 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     --cc=avarab@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com, gitster@pobox.com,
        adlternative@gmail.com
Subject: [PATCH 0/1] push: introduce '--branches' option
Date:   Sat,  6 May 2023 19:34:07 +0800
Message-ID: <20230506113408.61529-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.446.gf331623a.dirty
In-Reply-To: <20221205133525.60464-1-tenglong.tl@alibaba-inc.com>
References: <20221205133525.60464-1-tenglong.tl@alibaba-inc.com>
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

