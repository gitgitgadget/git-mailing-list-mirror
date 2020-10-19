Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B6EC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D11E221FC
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxW+AF9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbgJSWrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388622AbgJSWro (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:47:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFCCC0613D0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i1so1526495wro.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4whkkzAcsD6AS56O5NC31PASZfujLSOt9YgYJW3lzEs=;
        b=jxW+AF9gbmAQGVlz655y27og0+zhbRh4E6dAb7rlfXWnI9OmplvxfOVXeQsXzoJlK/
         R6vV9RDTq3ohKURIxgVPtf55P2Q5/2bxFJJdiZ5n8iO5FxwDnY0t7yJ2YQP6Wh7h8HnS
         2NEG1u0cPisAbPUEmjF4/ksWz9h+57Qeww9DjRU0X8Y5yZjzJy0Gq3EybQoH3O9Yyctn
         QxKN5TXMrPEVysdDIdakuh+ud3eiB3tYbK95Zrin9k2jKVQJuOsAx3EMy2mR38xuT3kU
         B7LPj3Igo5hLuboNGI/eZ2yW9becV3f+LULyIQt/Ho25YG4SU2SAMlMRNss9CZvXSnxr
         dS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4whkkzAcsD6AS56O5NC31PASZfujLSOt9YgYJW3lzEs=;
        b=VgQjfv6XiZJkC8hZBFl3fKLe1ASiUl9p7Jc8amV3B00/EHx1dkhHy6EnjQv7eQ8GtY
         qWSoD7SnYYNxKX8agmxTmWRcWqBUp2V732IuzSF9w3E677AnHRuV/brdwyClNCYfcY3Q
         p+mbLnlq89VX4wOw8TTn92HL+LVU3QRQmeWjn2hKhUN/w884p9PV1alRJJnwJOhII/wz
         i7APQ+vvUxaHkB4Wd4PL89qSiBkSSxk61vKJb9T/PrBbYkXJ5wbrZiF+tQ3QvdPsqbkw
         Gcy4zQFEsp6FLl9WoNv+wAixbk7lzQexaJaoAdfpu4GyhUL1txV9jpvSLCHNYfDRHhb1
         fsYg==
X-Gm-Message-State: AOAM533dgKoM6mdYGPQCxcELyEqnWNea/W6trYj9u4JeKgNcoRVEb7Uc
        TYlOGi4MFamNXlnTTkpM/gN3t/qix18=
X-Google-Smtp-Source: ABdhPJxN7XyEvE+Dn8GX+PBVLXAhVu08btn4JB9r1PIy9fF9UG5MlFlcZYuby4E8PBis2tg85mxbOQ==
X-Received: by 2002:adf:f88a:: with SMTP id u10mr1577669wrp.1.1603147662633;
        Mon, 19 Oct 2020 15:47:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z64sm63739wmg.19.2020.10.19.15.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:47:42 -0700 (PDT)
Message-Id: <28c1e488bf644786af071e66b73450baa47ccc44.1603147657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
        <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 22:47:35 +0000
Subject: [PATCH v3 5/7] perf lint: check test-lint-shell-syntax in perf tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Perf tests have some seq instead of test_seq. This
runs the existing tests on the perf tests as well.

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/Makefile             | 3 ++-
 t/perf/p3400-rebase.sh | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index c83fd18861..74b53af2bd 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -34,6 +34,7 @@ CHAINLINTTMP_SQ = $(subst ','\'',$(CHAINLINTTMP))
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
 THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
+TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = sed -f chainlint.sed
 
@@ -91,7 +92,7 @@ test-lint-executable:
 		echo >&2 "non-executable tests:" $$bad; exit 1; }
 
 test-lint-shell-syntax:
-	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS)
+	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)
 
 test-lint-filenames:
 	@# We do *not* pass a glob to ls-files but use grep instead, to catch
diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
index d202aaed06..7a0bb29448 100755
--- a/t/perf/p3400-rebase.sh
+++ b/t/perf/p3400-rebase.sh
@@ -9,16 +9,16 @@ test_expect_success 'setup rebasing on top of a lot of changes' '
 	git checkout -f -B base &&
 	git checkout -B to-rebase &&
 	git checkout -B upstream &&
-	for i in $(seq 100)
+	for i in $(test_seq 100)
 	do
 		# simulate huge diffs
 		echo change$i >unrelated-file$i &&
-		seq 1000 >>unrelated-file$i &&
+		test_seq 1000 >>unrelated-file$i &&
 		git add unrelated-file$i &&
 		test_tick &&
 		git commit -m commit$i unrelated-file$i &&
 		echo change$i >unrelated-file$i &&
-		seq 1000 | tac >>unrelated-file$i &&
+		test_seq 1000 | tac >>unrelated-file$i &&
 		git add unrelated-file$i &&
 		test_tick &&
 		git commit -m commit$i-reverse unrelated-file$i ||
-- 
gitgitgadget

