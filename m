Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F160DC4332E
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C0D6508F
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhCERHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhCERHq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 12:07:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA76C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 09:07:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l22so2087726wme.1
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 09:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9bYxnWT1eHHWGWfysmgHlFH2lu/AG24plq/+MsIMw4=;
        b=qKlYe+AUhBib2+cdt/NK+yp35TH0F6DM2mHG7bzmDBdBXpsmnglxzZx+15gAF3Vlqp
         vr2T+BlmMMQGeLIXn9j0ysBLyahVaqQb4bu3DoyhArDQSjYve+hcF/fzEm9NnKX8lkIL
         bVLKbbutPRC2MfeIirLMIReCYNbQhBTbp56y32gAfWmYp3sXO34LYOHoBoMjCoRC9Lg7
         dk1Z9KRvCsbXW7G8b6cZBzZ6FTrVKEAwtUUbnNfdvXPhxMy26uJjSFmQ8+s+iIinuBaY
         msIDknRu2m1l2AZWUcBRN42QGuhs1NDRHtCZHqC3uXur140BWJSglaDloQ7v8kymnTL7
         qoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9bYxnWT1eHHWGWfysmgHlFH2lu/AG24plq/+MsIMw4=;
        b=JrbL6ekxC4UePlHmYcIsDq8s1ndix8sYANSYE6uLwI4R3om332x4Rj/rUHR74SRY7C
         HW2+YAjextZW+zGGUkA6wszkJ5OVlNSj1yP9l115++es98i6I2KoRMuBHznlptsUBriq
         NM1D+hXvYAH2vb8JOuC+twbh9E12ZpRFh16L+6WgwaKNQBaw1Iydof54aw891Jj0LI4w
         aj0ULLXEmIK8E0avDvxG9SOGL1TAAeZ97uWgMUx/4s7/5RCiyXwNYnLFmHDDPtHIJ+L+
         Z2FdPx+BhpoQpjSrJJLe5d5fuNHG41yXQIKeUytLoNEol+McBMEtGhW/92y4ip3uYSWe
         rBdg==
X-Gm-Message-State: AOAM532UeTvL170D9lYaFz0fHUhDrq7sFYGfS56WJsKYdqYaht9HK1TV
        TOJu4mCY2/UIYPxLHOKrPqbGFWmh6oqW9w==
X-Google-Smtp-Source: ABdhPJzonipVzCL1MC8JXu6E/e1zB1vbEjx+gBxwQIBx3s+vnAnYb9HyaxSW7Z2TRIwkd8Zg+1/Meg==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr10098798wmh.152.1614964064919;
        Fri, 05 Mar 2021 09:07:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4sm5115328wmq.12.2021.03.05.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:07:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] Makefile/coccicheck: allow for setting xargs concurrency
Date:   Fri,  5 Mar 2021 18:07:23 +0100
Message-Id: <20210305170724.23859-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210302205103.12230-1-avarab@gmail.com>
References: <20210302205103.12230-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the SPATCH_BATCH_SIZE facility added in
960154b9c17 (coccicheck: optionally batch spatch invocations,
2019-05-06) and bcb4edf7af7 (coccicheck: make batch size of 0 mean
"unlimited", 2019-05-08) to allow for both setting
SPATCH_BATCH_SIZE=N, and also to have a more advanced SPATCH_XARGS
argument.

The reason to replace the "$$limit" is that now you actually see under
V=1 what argument your program will get invoked with.

The reason for the "9999" limit is that if you e.g. try to define an
"$(XARGS)" which is conditionally an empty string or not depending on
this setting then e.g.:

    echo $(FILES) | $(XARGS) $(XARGS_FLAGS) $(SPATCH)

Over multiple lines with "\" will error out. I think just setting it
to "xargs -n 9999" as a trivial workaround is the best solution here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 798a0517131..9fa715e4037 100644
--- a/Makefile
+++ b/Makefile
@@ -1203,6 +1203,25 @@ SPATCH_FLAGS = --no-includes --patch .
 # Setting it to 0 will feed all files in a single spatch invocation.
 SPATCH_BATCH_SIZE = 1
 
+# For the 'coccicheck' target; SPATCH_XARGS can be used to manually
+# tweak the xargs invocation. By default we invoke "xargs -n 1", and
+# "xargs -n 9999" under SPATCH_BATCH_SIZE=0.
+#
+# Setting SPATCH_XARGS overrides SPATCH_BATCH_SIZE. To get concurrency
+# when targeting a single contrib/coccinelle/%.patch use e.g. "-P" if
+# your xargs(1) supports it:
+#
+#    make contrib/coccinelle/strbuf.cocci.patch SPATCH_XARGS="xargs -P 8 -n 8"
+#
+# Or a combination -jN and "xargs -P":
+#
+#    make -j4 coccicheck SPATCH_XARGS="xargs -P 2 -n 8"
+ifeq (0,$(SPATCH_BATCH_SIZE))
+SPATCH_XARGS = xargs -n 9999
+else
+SPATCH_XARGS = xargs -n $(SPATCH_BATCH_SIZE)
+endif
+
 include config.mak.uname
 -include config.mak.autogen
 -include config.mak
@@ -2859,12 +2878,7 @@ COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	$(QUIET_SPATCH) \
-	if test $(SPATCH_BATCH_SIZE) = 0; then \
-		limit=; \
-	else \
-		limit='-n $(SPATCH_BATCH_SIZE)'; \
-	fi; \
-	if ! echo $(COCCI_SOURCES) | xargs $$limit \
+	if ! echo $(COCCI_SOURCES) | $(SPATCH_XARGS) \
 		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
 		>$@+ 2>$@.log; \
 	then \
-- 
2.31.0.rc0.126.g04f22c5b82

