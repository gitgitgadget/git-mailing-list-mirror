Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E92C4707A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2387261263
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhEWI5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhEWI5t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:57:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845AEC06138A
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j14so23534980wrq.5
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UpeMz3y3RWSIHk9RE94ubJZ4MOERpwjJonYtxayf4BM=;
        b=qGBwf5qAEhbaoVpIYSIhuOyXPnkF0wCdyAgh1si/qJC1x2AcD9gRe8g3ACfBRgVGAN
         R6V6z3Pnnvr6CKU17egqWg4SBXKlFpFJFqZIiczR+GLiH5+LeCflTRSe7b+D1niurGvU
         v8aGx2lwIX3NTp38EtQjUyzhtPD8GaFtcyaqDlWeVXpV3lqXVDf5NaCLSnrS5uj9UbBw
         +J5rC0f7el8ZdOrzC9vbSD1iQaJpzcyatRieZUw+YZMMzG+A6H0BbxCeiYVftiMbNMcP
         j+jxMyOecdT3Z3wB6ymR3GZzdKAsWKMqZGqht7M04SeFrdTiauvT2SxWazldgfIpnltL
         r8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpeMz3y3RWSIHk9RE94ubJZ4MOERpwjJonYtxayf4BM=;
        b=ecgHIcL45AxMSucBBoLOF4bGkSmq2a2LHt0BvKf+cQdbgBXrcSqqlf2wft93G4kwwq
         F3DhlRBzcuJBZyMarqRq6ViyxXdyr1Zgg59gAtLvsIvuZOzVom0slEBUJ8s9i1g3IfLZ
         Rb+YiFis3+dZG3pidXgHQ6L7zGxw6yF6UWOiY2McUZW2GgVTArFds5cQoJdse5e8wpfQ
         GfJTrPFQAeQfpfGd6TRaeEN9LmN9V7Lz0+k+ry04KNne2GCM+wg9wZQvbTDSaLvqVvXV
         7dEGpx6SeqaEbIeXGa3Qbgl8CoRrPBcCiaUqbAMKniSDhUixm+Y5Fi5QxfDwL/VoD50Y
         fJfw==
X-Gm-Message-State: AOAM533YC27qr7PyaUpijt17Pcote3DSt3RPo/O4dvGPxJHOGDxs9snu
        1/NghD84gvEZxcA4RDCOfRAYPZ10nxYermJk
X-Google-Smtp-Source: ABdhPJz8b3Q2BSAFWtf3dwv8v4yZbYB37Hdj0/T9pvQ/7bdDZM0t9tNheY1r1OEiJrzWW2Ujfg4wjw==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr16752172wrs.403.1621760181822;
        Sun, 23 May 2021 01:56:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15sm9577839wrt.54.2021.05.23.01.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 01:56:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/13] send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=true
Date:   Sun, 23 May 2021 10:56:06 +0200
Message-Id: <patch-01.13-71f890dc60-20210523T085231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g05cb3eebfc
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com> <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for the "GIT_TEST_PERL_FATAL_WARNINGS=true" test mode to
"send-email". This was added to e.g. git-svn in 5338ed2b26 (perl:
check for perl warnings while running tests, 2020-10-21), but not
"send-email". Let's rectify that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 175da07d94..cffdfdacfb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -18,7 +18,7 @@
 
 use 5.008;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use POSIX qw/strftime/;
 use Term::ReadLine;
 use Getopt::Long;
-- 
2.32.0.rc0.406.g05cb3eebfc

