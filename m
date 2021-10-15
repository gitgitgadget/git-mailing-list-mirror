Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082C8C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E634E610D2
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhJOJc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbhJOJc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:32:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB326C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:30:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o20so25448460wro.3
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xH3ZamSBYU2F7EdOGIDlkqwbEz3N6zVI9+R8bSYlMZ8=;
        b=cpZR3m4/Fp4pHzAi8qNKa8ZRD25+CNaeZCUNoIWkH5UXfnR6RM83ISW88UIK891jpQ
         C55VpaEpY48SubSF58xemxyc+8+tD54tH5K9FGha0NUi3THtaS9Tv3JSK6COLcUlLsdg
         CIJ3Xh53p11YvcM8z4bpmbnO81g406MvVFlc3wjZ1nrG8a9fBXDAK/gupjQECjY/DsIs
         HYYi0HnK5vwWNA6O78Rw7eGns8RKJ0ouPnRDoQZD895LWKdGKli4LBNsSRCKPEAuS5yO
         7ExgSUOkyXxbCk7qWDqKmUlDRSWnHgzhXtXT/ua3AjYKGtA7BgyByxZV+GQo7hx9vM0g
         2iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xH3ZamSBYU2F7EdOGIDlkqwbEz3N6zVI9+R8bSYlMZ8=;
        b=e4GwByJnbw5RbHg81V5vcg8cWT7cb7NmY1reHVyPNMoFNRHI/NSYD39L2KrqPnfj6p
         mQMZ1F3zxpdf6V5STdplFvPVopeKow3D1nmmLW+H+6M1buGEpF8xh6UkE07zNmmwuUcs
         081xZb2EoSpl3Sx8isNftotjDi0ZHzcNtt8E3D95rQVFaQ6Ci8UzlKfcC32f30FExwgB
         DJp3NUeic2hASQx7ieTpmG4WzZYz6GGFQ+sntCTzzPhqWMjahHBxtm656a48Gmf2M+fD
         tP7udeFM4GGTRo0Vc/Pb/3XtA6Dyh1foLo/AsYE244h7XfShnHColb00dIlLUwBpOptJ
         HBTQ==
X-Gm-Message-State: AOAM530ZjwqjpJUFqEOZsmhy6QaDaHygF7V3AUlv+MOS3yu5M8Ln+4av
        sXdhLHL7Vpu8M00Va3U4PmiN4wakppuCuw==
X-Google-Smtp-Source: ABdhPJyfilWKSjkJuLDFVL79bXv485HOOnZUvvvWAe2nFvTejbuoH/kzslm3RDXfkJW/KUR7dBZykA==
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr12609688wrx.433.1634290220206;
        Fri, 15 Oct 2021 02:30:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k17sm4542735wrq.7.2021.10.15.02.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:30:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] tests: stop relying on top-level COPYING and README
Date:   Fri, 15 Oct 2021 11:30:15 +0200
Message-Id: <cover-v3-0.2-00000000000-20211015T092605Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are test-only changes to have tests that rely on the contents of
the top-level README and COPYING files use smaller artificial test
data instead.

The v2 of this series proposed to follow this with updates to the
COPYING file. I asked the SFC folks about that and those comments
might result in an eventual update to those files to clarify certain
things with git's licencing.

But let's not have any such future update be larger because we needed
to deal with this test-only implementation detail first, and untangle
the dependency the tests have on those top-level in-tree files.

As the range diff shows this is the exact same series as v2, except
that the previous 3-5/5 patches have been discarded, this is just the
previous 1-2/5.

1. https://lore.kernel.org/git/cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  "lib-diff" tests: make "README" and "COPYING" test data smaller
  tests: stop using top-level "README" and "COPYING" files

 t/.gitattributes                  |   1 -
 t/lib-diff-data.sh                |  22 ++
 t/lib-diff.sh                     |   2 +
 t/lib-diff/COPYING                | 361 ------------------------------
 t/lib-diff/README                 |  46 ----
 t/t4003-diff-rename-1.sh          |   4 +-
 t/t4005-diff-rename-2.sh          |   4 +-
 t/t4007-rename-3.sh               |   5 +-
 t/t4008-diff-break-rewrite.sh     |   4 +-
 t/t4009-diff-rename-4.sh          |   4 +-
 t/t4022-diff-rewrite.sh           |   6 +-
 t/t4023-diff-rename-typechange.sh |  11 +-
 t/t7001-mv.sh                     |   5 +-
 t/t7101-reset-empty-subdirs.sh    |  11 +-
 14 files changed, 53 insertions(+), 433 deletions(-)
 create mode 100644 t/lib-diff-data.sh
 delete mode 100644 t/lib-diff/COPYING
 delete mode 100644 t/lib-diff/README

Range-diff against v2:
1:  f834cf74873 = 1:  02342124582 "lib-diff" tests: make "README" and "COPYING" test data smaller
2:  f7cd2f31ccb = 2:  f555ebb7055 tests: stop using top-level "README" and "COPYING" files
3:  44375bece46 < -:  ----------- COPYING: remove mention of GPLv3, clarify sub-project COPYING
4:  ccb26274cc6 < -:  ----------- COPYING: move GPL text to a "GPL-2.0" file
5:  6fe2e601b13 < -:  ----------- GPL-2.0: update to byte-for-byte match the FSF's version
-- 
2.33.1.1338.g20da966911a

