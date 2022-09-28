Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6C9C6FA82
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiI1Ikd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiI1Iju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E743E75
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m4so4292284wrr.5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=q/apW+AVEn8ig4tDUHJM7o0W2CCM/n6k6O+SSNKMEXw=;
        b=fPy6pqO+zz1bM6kwF3/ETz+ivSC0/gtBFHAsVpwlN85S8mYqILf2GVy4gg157v2t5r
         6cIwvSF6Cahtkg3+48vOtYnsojVuEdn5envWeW/4hX0lhaa5sY7f2y7Vuz7zYNO42l83
         9iopCtm7179yaNBgDPdHztcHULJWTftiot6Ya7OmwZqXfYmKatuW7EnpndMsGQIw/w9/
         PxEFp3ZUFeOuGrA6uTEMICC6t/tpz5PxnfOIA5BdawyjDosmnDLpIiq8OYfD5XIGlp8W
         oxKr9NC0SLAeCVJfhefX969ff8ZubmaVksSGXMIdrzpexDlVYi8DaDFZe1aPibsNesxL
         2olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=q/apW+AVEn8ig4tDUHJM7o0W2CCM/n6k6O+SSNKMEXw=;
        b=yq+ghgJXVD/TIPPWbcnkAiMENGrjU0mRwDelRQVmsZ7+MY7JqNUaFJkOXysXGjTKhA
         O//lI5wtFfLMqdcTP58E+/JGKOEiLRY4pRiYvPftt0+HXbNXucW9SOAZoShDqN7y9Tdd
         KMeHUnQAlSNGe5SvBGGVbh3XSuKaAgyD6rg4e4m+80c/ASvkb1dID+FojkMUMHzA+8Xb
         w6VgkBwH36ydP0fmmA6Qwxaux9UJ5aNqJV/6BS2OXuT1S+W15pUmUPayOP6PCrjva75k
         gHzIulAkdegdVCvluzpT7pD1NS7jf7U6GreL5FX9o4b1p92JCqHM3eGCujaIf7JskCve
         2lMw==
X-Gm-Message-State: ACrzQf3H+LIrEp0/k9adrcK8kBaztax6snwdROmmh6aj+N5GIqxAJwN0
        EyW+AGUs0i9FcbaNk/c0AmM6T7/rOa4BEg==
X-Google-Smtp-Source: AMsMyM5nr+YDI/09NldMgFxmRvrELObrER7WCEljcfH+FWW5tq7KKNqVF7jT793YnyOn35ojW3i0Wg==
X-Received: by 2002:a05:6000:18d1:b0:22c:c347:8f9d with SMTP id w17-20020a05600018d100b0022cc3478f9dmr4018701wrq.358.1664354386382;
        Wed, 28 Sep 2022 01:39:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/35] doc txt & -h consistency: fix incorrect alternates syntax
Date:   Wed, 28 Sep 2022 10:39:05 +0200
Message-Id: <patch-v2-10.35-93e63821bc6-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the incorrect "[-o | --option <argument>]" syntax, which should be
"[(-o | --option) <argument>]", we were previously claiming that only
the long option accepted the "<argument>", which isn't what we meant.

This syntax issue for "bugreport" originated in
238b439d698 (bugreport: add tool to generate debugging info,
2020-04-16), and for "diagnose" in 6783fd3cef0 (builtin/diagnose.c:
create 'git diagnose' builtin, 2022-08-12), which copied and adjusted
"bugreport" documentation and code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 builtin/diagnose.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index faa268f3cfb..23170113cc8 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]\n"
+	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
 	   "              [--diagnose[=<mode>]"),
 	NULL
 };
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 28c394a62a5..474de9ec647 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -3,7 +3,7 @@
 #include "diagnose.h"
 
 static const char * const diagnose_usage[] = {
-	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]\n"
+	N_("git diagnose [(-o|--output-directory) <path>] [(-s|--suffix) <format>]\n"
 	   "             [--mode=<mode>]"),
 	NULL
 };
-- 
2.38.0.rc1.925.gb61c5ccd7da

