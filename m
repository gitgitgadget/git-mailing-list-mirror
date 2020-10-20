Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3671C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858DF21741
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfMEIB8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407572AbgJTNlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407561AbgJTNlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 09:41:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BD7C0613D1
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j7so2179988wrt.9
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BZCNOpOS7y+zBmTEmsVLBXdb2nimnuuH0JJV82Rd7II=;
        b=pfMEIB8ICn+dBpMrZEWa4r0L217v5+4w11PWXpzyzbS1ScAS7RIjkfJiQewLPRpGV2
         +2prq/8lee7gvAVEk2qV/LpJod3KjYbmnTyf550/78AmddarNOgeuC4HvTQGbtxCUuZm
         ePJ2c+aQOj+f74UMpf3qwkaW6tPK4XXaP0BtGz5wsMKOrto6Oa6BMcC8s/jU8HSGVgBp
         FtX9dsjg+dE0+SOtoyBzaf8UY4zGgI+533MLcYDVUdZhy3f8sLX2q1jiJfrpyZUpaPmo
         3Hfi/54O0V6fDdYrc8bcf2tr5UUQGYskzsWqNJq0yQrBxn6ptqQXpkunaAyRXsbDY5JY
         Okcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BZCNOpOS7y+zBmTEmsVLBXdb2nimnuuH0JJV82Rd7II=;
        b=YpMSmqKo2X9GkOd2OpVtAnrhOPUO/k0C1UfIhb5UskZ0leaRe8X6r2hghj+btDeg85
         y64yDA/PITYIMJ2FJ9UZW5F68uIxVwzOH7/cczbT3D+SBmwsphRdsz3rtXcIP0qQYKV5
         mol7gmnhpWglHRjkIen2NF6H6M9lZWNQ3YKhjylw9it0pwJGm8RCnXLMeoQLCa3a4nym
         LC50bli7sbMxxMP9F6TSMsEJA94d5K5BMsR8drUFkHfyIFUWynhYXJ4JWYEdXZDDXLXH
         LSTrldrxO9UiZsPJCSQ2sF1UV24x2rXdFmrABytUQb1/P1UUAftWxMv7EBW/MqM9NEzj
         fKQQ==
X-Gm-Message-State: AOAM532ulDNc4zahQzvGxjZkEAfIJOIgpXyvDCOmdEJaFhtnqMJ2tlSs
        cKyepr8MZCy0HVlSwAFAtkrHH53wBrk=
X-Google-Smtp-Source: ABdhPJw/R2Fv7bZu1MR9Cn+jF4Hg0sUOjjSbxWcwytIQd5LUyhXDfPoem0k9IWwWWK4Hd1ay0JhdKQ==
X-Received: by 2002:adf:92a1:: with SMTP id 30mr3652418wrn.269.1603201271006;
        Tue, 20 Oct 2020 06:41:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm3116175wrj.60.2020.10.20.06.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:41:10 -0700 (PDT)
Message-Id: <b534cd137a833de802d6d95c1affb8d2d8f7de85.1603201265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
References: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
        <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Oct 2020 13:41:02 +0000
Subject: [PATCH v4 5/7] perf lint: add make test-lint to perf tests
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

Perf tests have not been linted for some time.
They've grown some seq instead of test_seq. This
runs the existing lints on the perf tests as well.

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/Makefile             | 7 ++++---
 t/perf/Makefile        | 5 ++++-
 t/perf/p3400-rebase.sh | 6 +++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index c83fd18861..882d26eee3 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -34,6 +34,7 @@ CHAINLINTTMP_SQ = $(subst ','\'',$(CHAINLINTTMP))
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
 THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
+TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = sed -f chainlint.sed
 
@@ -81,17 +82,17 @@ test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
 	test-lint-filenames
 
 test-lint-duplicates:
-	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
+	@dups=`echo $(T) $(TPERF) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
 		test -z "$$dups" || { \
 		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
 
 test-lint-executable:
-	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
+	@bad=`for i in $(T) $(TPERF); do test -x "$$i" || echo $$i; done` && \
 		test -z "$$bad" || { \
 		echo >&2 "non-executable tests:" $$bad; exit 1; }
 
 test-lint-shell-syntax:
-	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS)
+	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)
 
 test-lint-filenames:
 	@# We do *not* pass a glob to ls-files but use grep instead, to catch
diff --git a/t/perf/Makefile b/t/perf/Makefile
index 8c47155a7c..fcb0e8865e 100644
--- a/t/perf/Makefile
+++ b/t/perf/Makefile
@@ -1,7 +1,7 @@
 -include ../../config.mak
 export GIT_TEST_OPTIONS
 
-all: perf
+all: test-lint perf
 
 perf: pre-clean
 	./run
@@ -12,4 +12,7 @@ pre-clean:
 clean:
 	rm -rf build "trash directory".* test-results
 
+test-lint:
+	$(MAKE) -C .. test-lint
+
 .PHONY: all perf pre-clean clean
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

