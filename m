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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0FCC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB09B613EB
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhELXXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349215AbhELWas (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:30:48 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BDFC061343
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:22 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id d21so23598272oic.11
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRi2466CP0cJlmOzkeREA0c0wT/A3WjK/P+oCXNI5xY=;
        b=k8XNLjnXjvIhYuwtUaOv8D/2eR9YfKTvPjPzkVJNE2B68hz3szTlABxPaQpiSSkQy/
         ajxsWy39qqUSBfQhsmNGK2FlLR+HxW3GUlgYfbvLNwQYkX3UT696TvDZrW8CvbktAs6i
         WT7xX8w5UUy7mC4ikw4glzz1cMU1AucWevf/6MUC5vBLQ4R+Fh3qlXPlwLdd3LsZKfpn
         p4l4Nv9hwgGIujflu7wmGfSbF2FrZv7IVkrfy9xJn/McQOSx1H7PvPLWcBhNUpKg1dCX
         oUgR2yCi31skrirbtwHkutnoFvX6JNRjYwZtuPJq+fQVfhOD4qaqflg5kadd9vDgxwSz
         xDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRi2466CP0cJlmOzkeREA0c0wT/A3WjK/P+oCXNI5xY=;
        b=fouq2mLX2vgdDZA3cdmJEgHb6v6dlewg+Pmk1OpoUSIHsvReQfFHIC4OVwxwQvB/CD
         fZccriqzKSNmIlkpdNuiXbIRd+AcnE3FRw4rkh+98WTyEyHkkcXq2je+AKZz9LX9Uj6M
         ZGDkUAeWcZt3XY9cffMYnmUz/zqa+0/cFw1QsIdPKXdjAzlIN3wxuwyAe53SFlnfWyKO
         uki/AEwuAvYVmHMq279959ihPQA/VAV/Qlbmj8J2Ms77Le69ZpdghIunJIsfcFRnucHS
         5fJDBPinREW+UnVdl4Am/tA5omYxOsYPkwwWJpNEpikqewGGTVbrAVt27vRKYCQ4SS79
         k5Lw==
X-Gm-Message-State: AOAM530q41r9gbmrn5lnIHZEjob3iX6bYz4diSYZHAoX8mmwLrhhHKsU
        xQLRmfnp/t+si87jv4qgYPOgye6zF3Y5gw==
X-Google-Smtp-Source: ABdhPJx+DEonGkO5Xom/HQwJr5FAwZEgM0h+v6AIDbjwArZOoNR6GoH5IYYLl7CjzlP8KVAbQkFzhA==
X-Received: by 2002:aca:44a:: with SMTP id 71mr26590061oie.39.1620858501804;
        Wed, 12 May 2021 15:28:21 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id w10sm216030ott.75.2021.05.12.15.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:28:21 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/8] doc: standardize asciidoc calls
Date:   Wed, 12 May 2021 17:27:56 -0500
Message-Id: <20210512222803.508446-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512222803.508446-1-felipe.contreras@gmail.com>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By always specifying the output file it will be possible to refactor all
the calls in a future helper.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2aae4c9cbb..3d282a2797 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -388,7 +388,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt \
 	asciidoc.conf GIT-ASCIIDOCFLAGS
-	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
 SubmittingPatches.txt: SubmittingPatches
 	$(QUIET_GEN) cp $< $@
@@ -442,7 +442,7 @@ howto-index.txt: howto-index.sh $(HOWTO_TXT)
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
@@ -450,7 +450,7 @@ howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	sed -e '1,/^$$/d' $< | \
-	$(TXT_TO_HTML) - >$@+ && \
+	$(TXT_TO_HTML) -o $@+ - && \
 	mv $@+ $@
 
 install-webdoc : html
-- 
2.31.1

