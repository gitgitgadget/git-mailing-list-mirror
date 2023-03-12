Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C723BC6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCLUQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjCLUQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:16:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0833725947
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id er25so12692280edb.5
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678652130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgSq2BEB0xF42jwRYRTu1mJl7/fw7pc2jBu5sMhfKUA=;
        b=PzCYINe3sHJIh7b9HC6lc6zbsgyI7lW+orw6G8HpEpR8iZtvTiOQjZf+50u0brKDu6
         s8IrRwcEsbytThSSybJ3MdySQeuaRjKE+PR7PC2WBJK8HZX+Zjm6BUeGAmH7ENQL/2lx
         hRLjr02rO3YcN0x/VXQMC8b7/cbkBAOh1fZjdc7LxU+qQwSz6VOwndr3LqjGeLTExAVY
         J2IsAATQjxZ3bqVzFvzqVJMoOPZzqRChusfBea44CwwkOLunC4WdBgqqenXX4rIRQoX+
         Bx+JvvAufOPwX7ZXhNLvEN+dWMyVOxEQmMqtuUdDncW2KFEmV/Rtw4/SsyjaTX1pSO5U
         11UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgSq2BEB0xF42jwRYRTu1mJl7/fw7pc2jBu5sMhfKUA=;
        b=57YNCcu+aIOrlzEdOEmpFIll65GBcnlArquBPZbchAT4nVs+3YaHkgMdyOpWSXrIgk
         FPwvW1p4lvFmf/lkbLbogDRYB2dS+XCIqxrAXFe0dRbBORSRemPcnnyEAnuAlIFKGves
         s4Cxd3xATaRWo68qxC7ucQViN4gtsZD1sSEq3opIfbJuGo2+Ki93Jfb0DgF8b7rSnzcn
         3fr2myhP+rWEeWif/BoYgpHdN+tbEYH/78gk+RyoVFT7dPuwbNvCuREFcQF+tcbxYIhM
         Y7gfdFKXrs6wAAe08iZVhDGfmEJHL38z9dVrB9pNFHBkKhIVGFtm/0dOLbdF/BFMUSx/
         WDmg==
X-Gm-Message-State: AO0yUKXaUyXAnl5y7ert469lRQ7mPhDAfBi1iSI8l0R2o8vBmIeyT1Wu
        BWMY+eWARAU3rB/Y/jm1O627xcGKe+rutg==
X-Google-Smtp-Source: AK7set+DwAG9pXaAvQHck75XzO/V3LEOuq6kVYfITuvNjcI6+52clKFm/sCuaVosx84ZqJFJbBuEOw==
X-Received: by 2002:a17:907:8a06:b0:889:ed81:dff7 with SMTP id sc6-20020a1709078a0600b00889ed81dff7mr40089089ejc.9.1678652130080;
        Sun, 12 Mar 2023 13:15:30 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id hz17-20020a1709072cf100b008dceec0fd4csm2570344ejc.73.2023.03.12.13.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:15:29 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v1 3/7] t1010: assert empty output of mktree
Date:   Sun, 12 Mar 2023 21:15:16 +0100
Message-Id: <20230312201520.370234-5-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Builtin "git mktree" writes the the object name of the tree object built
to the standard output.  Tests 'mktree refuses to read ls-tree -r output
(1)' and 'mktree refuses to read ls-tree -r output (2)' in
"t1010-mktree.sh" redirect output of "git mktree" to a file, but don't
use its contents in assertions.

Assert that the output of "git mktree" is empty when it refuses to build
a tree object.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1010-mktree.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 3c08194526..31ea2ec0bb 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -60,11 +60,13 @@ test_expect_success 'allow missing object with --missing' '
 '
 
 test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
-	test_must_fail git mktree <all >actual
+	test_must_fail git mktree <all >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'mktree refuses to read ls-tree -r output (2)' '
-	test_must_fail git mktree <all.withsub >actual
+	test_must_fail git mktree <all.withsub >actual &&
+	test_must_be_empty actual
 '
 
 test_done
-- 
2.39.2

