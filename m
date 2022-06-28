Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1563CCA480
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344793AbiF1KQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344788AbiF1KQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:16:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBBB2FE6B
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n1so16917007wrg.12
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rID3yRz1EHlirMZEoAol6J1WJhiTl6liP2Fv596eIl0=;
        b=oEVkSKhexdnrtL3PEK2aLveseZVTJZDKdQCqFUJa50bQ+nl0OiRFVFqpmdBb3NBXO9
         HE04y04rX5aUgWv7N8bXeBnYU/mfC8GssIGNc3iiMckWz851IJMyatMZ611ZEajGoEzT
         XogNROfA0tPnJkv0TliUv7EUnBBs6eeoiE194JBpwY6gtFhDVS9pezMQblN+aod9/fuO
         oYf7BR4uThm2+8eW81WUqFWcTmzATNxaRA6pfHUNxmwFJPKAjdHx+1AvkUyC5ACRRs7X
         50Ld7Mex9ZI0ZQypupAtIW9dtr+BGSjYViqtMoUAAzlFq3HInCIkFwhz2fl3WXzl+kEr
         OxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rID3yRz1EHlirMZEoAol6J1WJhiTl6liP2Fv596eIl0=;
        b=6qZmiRPN+mKApPg5z8BFLodKToT2Mkj8tZuyJhZkSDv1sEkVbL5Cbe5G04exXRDAQg
         iGLzkeUIFpL5PDeHRDesU489T9wO4M5KQk7fi7mYCUlmaSfqWE6CQQOy8NJ+nx15dv5Y
         /OqtBUFCwSBtQLRiQu3DKMU7b2F4Xocs/fJfJ3nRaKvD2gB4ok9rFHVnYjX8rGqUFiWy
         QtFl0FtNq7F8C38g3It+inoHpCLoqSXono7V1geCMBm/DKQPDOcBvvbLriEe9ghYbXCr
         +xu3B39W9reeuaaVzlzd24IocCOrxcYar+ZvQhjUXAxRR3yLDhaSsSAPCOXzX/qWTZ7G
         +wyg==
X-Gm-Message-State: AJIora+n7N26Wt5OJlUN9H+0pATQCVaiYSutjRI58Yf+8WODbLFqXT44
        yf5QUaDdtqvMvtk6gm++YAYDB/C1M4tcRw==
X-Google-Smtp-Source: AGRyM1tgXgdGl2r/nFCAAMRllZhcavmwNUWa4qDIcYgr9b9nPyP2uAD3w3xx10dbWW4AUaqxgbwl6Q==
X-Received: by 2002:adf:d213:0:b0:21b:8b4a:24be with SMTP id j19-20020adfd213000000b0021b8b4a24bemr16520306wrh.234.1656411373344;
        Tue, 28 Jun 2022 03:16:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c2f0100b0039c54bb28f2sm552595wmn.36.2022.06.28.03.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:16:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/8] Makefile: build 'gitweb' in the default target
Date:   Tue, 28 Jun 2022 12:16:01 +0200
Message-Id: <patch-v3-7.8-571c9c10319-20220628T100936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

Our Makefile's default target used to build 'gitweb', though
indirectly: the 'all' target depended on 'git-instaweb', which in turn
depended on 'gitweb'.  Then e25c7cc146 (Makefile: drop dependency
between git-instaweb and gitweb, 2015-05-29) removed the latter
dependency, and for good reasons (quoting its commit message):

  "1. git-instaweb has no build-time dependency on gitweb; it
      is a run-time dependency

   2. gitweb is a directory that we want to recursively make
      in. As a result, its recipe is marked .PHONY, which
      causes "make" to rebuild git-instaweb every time it is
      run."

Since then a simple 'make' doesn't build 'gitweb'.

Luckily, installing 'gitweb' is not broken: although 'make install'
doesn't depend on the 'gitweb' target, it has a dependency on the
'install-gitweb' target, which does generate all the necessary files
for 'gitweb' and installs them.  However, if someone runs 'make &&
sudo make install', then those files in the 'gitweb' directory will be
generated and owned by root, which is not nice.

List 'gitweb' as a direct dependency of the default target, so a plain
'make' will build it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index a5f29c11681..d150be4dc32 100644
--- a/Makefile
+++ b/Makefile
@@ -3155,6 +3155,7 @@ include gitweb/Makefile
 
 .PHONY: gitweb
 gitweb: $(MAK_DIR_GITWEB_ALL)
+all:: gitweb
 
 ### Installation rules
 
-- 
2.37.0.880.gf07d56b18ba

