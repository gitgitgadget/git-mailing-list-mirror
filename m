Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37360C433FE
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346660AbiEaRqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346655AbiEaRqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:46:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53B7986E7
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e25so9048221wra.11
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avn+beNTKh5SCcvGUsrOLu5negnum5wf3QkTSSlW2iE=;
        b=mgL9ouFKs6Kov4XpY3TQ0upgxldtwW/LVlrnKoa3svZCWRduCdacdIPkZDj307oz37
         VdfzWZcNJ9AzYk3Vcr/lBkYsGhA1noFfeKNubv5wlpXdaBvQ6VsnZtcwkaP7B3N4qfCs
         zzdMDupVRrUQL7QWjEXVOmaPZGg67mus0TZlOCNDBARg6VWScZaSvQWp/KvI/Q3Xsve4
         w/oDUSO0Zyq/0xHLsD/pGDK7s7ZQYqXhUw3vHSpxVkUafpNs5acTQvIDsz8dk5Y3/npN
         cptYDf49hSsEql/nu7ZDvsad2gCAfgslecRPCREpXfzuQv9ecY/vfbAwTFIk5wyV+TV9
         501Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avn+beNTKh5SCcvGUsrOLu5negnum5wf3QkTSSlW2iE=;
        b=DtKnqoa+WWbRIn0gweHGFfoNUX5sAu67ajxYsUYjdmfoAGLu4M80nEuBNBI29PF95u
         99PJeKP3o8UiCag8h/76kXHjdBzysHB7PiMx2NN+ZIiDllSay9fa71PB1Un3ctzqFjz1
         vlxK8K7lU0d7heKfRG1d3Qc7bZsqcmltH+cEbW8UVEpKPxySq9jsDg8qc9duem2OVtH1
         h6Al4JqTWXLIJFoMIokRlhYsUEdxQwFrCdLPDOxbWoOqIk7b4n8h21RHK41NMG4PZIwo
         AIrfpqgYgBm8ZCuuMTYPvilM9v8vKLZynFYYaPoZAV7NACgZQ61mmh1qQzsRjDwuFDe5
         Zm5w==
X-Gm-Message-State: AOAM533qMjPMqikDkMjpMMZIfHiMBTHoFk+rrIzPv9Ub6KgvrVeWcNYb
        DOgFh+WvkN9fPK1FkqU9TSZOXw/rZLzLPw==
X-Google-Smtp-Source: ABdhPJyjsVGK7ANdHSp1O4dmKVAG15CbGC5koQH849DqOQm3nOVlYcjg0deZIVOBVMXmpso7UduO6g==
X-Received: by 2002:adf:e612:0:b0:210:2058:a85c with SMTP id p18-20020adfe612000000b002102058a85cmr16923987wrm.449.1654019185729;
        Tue, 31 May 2022 10:46:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b003973e27b789sm3826656wms.27.2022.05.31.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:46:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/7] Makefile: build 'gitweb' in the default target
Date:   Tue, 31 May 2022 19:46:00 +0200
Message-Id: <patch-v2-7.7-69428540886-20220531T173805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.g036c05811b0
In-Reply-To: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com> <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
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
doesn't depend on the 'gitweb' target, it runs 'make -C gitweb
install' unconditionally, which does generate all the necessary files
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
index d251838c554..63057b10634 100644
--- a/Makefile
+++ b/Makefile
@@ -3042,6 +3042,7 @@ include gitweb/Makefile
 
 .PHONY: gitweb
 gitweb: $(MAK_DIR_GITWEB_ALL)
+all:: gitweb
 
 ### Installation rules
 
-- 
2.36.1.1103.g036c05811b0

