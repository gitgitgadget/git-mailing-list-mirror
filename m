Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E03C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLOJ7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLOJ7M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:59:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C4C2C134
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:11 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m14so2458952wrh.7
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKhBS7qSxRaKu9gxOB6W951SkAx8S38zzVpBihycuro=;
        b=CaZkjB8pYWQRS0sXy3CnbGLQWLj1PcpmSBz9Xapkf8LTDP/RhAtpjhJb0MW627ilqd
         V5w2ZbiweDUN9eAEevi5LIluo5YwFxmUJJwydGGcnC+L1uTKYXAFqBssfTUJpsrZlef4
         S7UCTVs65Lk2nlDDiHHEkO41BgZXH/mfdGlrIxJOuFGRYTMt9wQVruYFUdm0MPbuZL0p
         AVc7G4m05QrA86ujcBJh95A0eEUmAFdGJOyPQoFxQLnrhnu/Pt+4RJA/5LvnAccdNLPV
         Qoj3jOKQ7aoVCE5xse4LlpM56/1t9zNdTmnq6449Zr7NXCn8NG2PnKZ2Iy640SjHE1pO
         18Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKhBS7qSxRaKu9gxOB6W951SkAx8S38zzVpBihycuro=;
        b=HSV/2aayjQnCOVTC+JR4vapQnQs6jYtBC/nOQSUojvY9FZGBPWZpAtKpyb7r2QeFi3
         pLhSY8/v6tgZ/H/KJPyAgRTmbXl5oSP6U0XbfPys4IfOp59ZyJigPDJpGYT0C8qtz6EY
         i09B8AgmG/zQFCUsddp+uZMkGAWbvR+2sIw0xp7AZ37V1UK/46XHZBAAZ3BJmhDzz6on
         ExA2fYmd+44tOZtSPjWqe/qkL0vAkYRDoszM+j0M2Y+Hjrre8R1GqaSXFqjbuz/9vMKY
         Z4uXWUCS7qK3qBgwTcx5SorEz9jc35A0Es99yKr6/hMhJ7s29lAu1eFk3Rs8rI5wWcxi
         4bRg==
X-Gm-Message-State: ANoB5pnJ0v0YF4URU0mWIbnar0uasnBwXVg0nQS8SW/T4NhSLR8x1/0W
        SGAsWwJUwIg4oCKi2na8WihFG9XfQmhCQg==
X-Google-Smtp-Source: AA0mqf7jnd+4S6ZfqADOi5sXf+AqLfA2fEEdId3g41lkNdUMbYIEKDD0T/+IdQMbySztq/3MjhnY9g==
X-Received: by 2002:a5d:4888:0:b0:232:be5c:ec7e with SMTP id g8-20020a5d4888000000b00232be5cec7emr17793124wrq.58.1671098349534;
        Thu, 15 Dec 2022 01:59:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b00228cbac7a25sm5495948wrn.64.2022.12.15.01.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:59:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] builtin/rm.c: use narrower "USE_THE_INDEX_VARIABLE"
Date:   Thu, 15 Dec 2022 10:59:00 +0100
Message-Id: <patch-1.6-3517389f732-20221215T095335Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the "USE_THE_INDEX_COMPATIBILITY_MACROS" define with the
narrower "USE_THE_INDEX_VARIABLE". This could have been done in
07047d68294 (cocci: apply "pending" index-compatibility to some
"builtin/*.c", 2022-11-19), but I missed it at the time.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index d4989d4d863..2cddf921951 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds 2006
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
-- 
2.39.0.rc2.1048.g0e5493b8d5b

