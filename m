Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B55C433E0
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1C261998
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCVMMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCVMML (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 08:12:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED7AC061762
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:12:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k8so16425464wrc.3
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQnCFw1BEYVg25f9ca4131xk2iPjNkwiZNnOeQNTq1Y=;
        b=rLdkM7eHZeExN065tuyObscXCPFK66b8RZVW3ACnN/eE/F8xeCsoOt0qrfb46uFtv5
         qiQJZmUwp7ERTZeDTvT9PB4NIu++attlz0t+UuWE7ZVIfwr/3sOWAm1q6avRc57pCqPd
         vCFRclqVwoexn3z4aBA/dEKLZ66M1HgLIl/hbx3/vHjbNVf1Xu7FH2ZKcpiecN/629Vl
         PpjJUT9KhyWHQKm37iCuBfU15jiwqVHSOGJ3mxDrH6NDUu34ZaSF+UQxy8K72/l0VQbq
         lRNa/vVpM1s24bgbmdpIGTncdlPcijOdlJ7D2pJyhZuhEJfR2I0aYVjKvkKN8MTYmiDF
         woDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQnCFw1BEYVg25f9ca4131xk2iPjNkwiZNnOeQNTq1Y=;
        b=imtqew7BfZQRzqcSKFSFvhPiEU32oB1aPkmB7AHRaazR+jPgJR/ko2uo9rN6Q3HceX
         HrQZY1lgiP+NDlCMzoQLUnHTXAC/iJBw0VUBeCr+b13JbBX5ju71dSSRAciVx9Zsuuds
         TB6p1fX0aoJbQSSgCBnPJvtW6ElFGYqWzdz7eI1z/dwiO8Mcz9459nJU+lMkM6eUK8+W
         lU0AbB8QFQ0IZBk+ryVL5D3VqAIalkaYCemT8RHcTjJttuxlPGH/kdM2wbMr9982F6Vf
         TaZY2/53dCp1lkQLdG0rRxHbxWOdjQFexK4E8rnncase0TG0PoOLb8YqZo3XKQ7TVou2
         8QTA==
X-Gm-Message-State: AOAM530kjDKzv1hHYfEVksEYWSUVUHJwBX9s9awZBfbuAh+DJly4EuJw
        /J5pptljvE3uKmqHd5MN2MSUunKD9nzVSQ==
X-Google-Smtp-Source: ABdhPJxpxqVGHKLngtdIl2uMcOBJBXbLr4JUcNF+xBifYJZJnHdtMhCTHmxlh2S5WHI8KtUcRlta2Q==
X-Received: by 2002:adf:ab52:: with SMTP id r18mr17833239wrc.65.1616415129382;
        Mon, 22 Mar 2021 05:12:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j20sm15621142wmp.30.2021.03.22.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:12:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/4] Makefile/coccicheck: allow for setting xargs concurrency
Date:   Mon, 22 Mar 2021 13:11:49 +0100
Message-Id: <9d5814dacdc281389c4cb163ddbe4b749e6c0852.1616414951.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.285.gb40d23e604f
In-Reply-To: <cover.1616414951.git.avarab@gmail.com>
References: <20210306192525.15197-1-avarab@gmail.com> <cover.1616414951.git.avarab@gmail.com>
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
index e43a9618df5..eaac14275bb 100644
--- a/Makefile
+++ b/Makefile
@@ -1206,6 +1206,25 @@ SPATCH_FLAGS = --all-includes --include-headers-for-types --patch .
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
@@ -2866,12 +2885,7 @@ COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
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
2.31.0.285.gb40d23e604f

