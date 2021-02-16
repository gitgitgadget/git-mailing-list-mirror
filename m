Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C8C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FED64DEC
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBPME1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhBPMBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:01:54 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7E6C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:57 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id a207so1049943wmd.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WglvXT6/1jplKaAoQ0VwDYbfBFpdIS1c/Y7BJiZ2EN0=;
        b=mORRfKycBq2sjy47Xmurp63AHilG5Kg4aZaD0PDel4XfDwYCBn9YI2ZrJZzCmmK/iZ
         QxvFFnbYLbRJGdOImy8gqp/IK9Q2DkxaCSCMQzMrbZLYgQrEiqrr1XAHcbvMaaxql9Sb
         x43G4jxLx4Bib4dZejhPF+XWSFLQJ2QLvYjIz2oB4edvnoldJKyDryPJi6lz88YSWow3
         lqaR2Ktv4v6EPrnHsxDCmr1IsNAFFEFRe+dncLReVu9fU3rZGLGl/0vB6vxcJ57o8wrb
         28fnCAZ4uQy4tEAznjsI3JceRocToddWsNPGcIkW5oCC4SPalZR0srjlL/dO+uf7bdV4
         ZJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WglvXT6/1jplKaAoQ0VwDYbfBFpdIS1c/Y7BJiZ2EN0=;
        b=DG9Dh0F9d4vkKzdw7HeRIYE61RQRxQUntB1a9TeQNeYvv3uQ9t/S7qn2BLpxmjZDUd
         EybUOMc6MA7o1eU+8j865/ttbkoHRLbwBbRrpF6320MLfMUlfnfR9T/1xx/wZTEBhex3
         zmvHhvYnRkxhZWQBYR2KMf89LBRssyELrti6P3s/RLniGdCvpYGg6xsPzeJFWmSskrgN
         eZnGTYrz7SMOmOG0jfJY1B/vdtnd8WzNGZ+63sK379WfkckXE3kWcuXbVaLfOjeYvZwA
         0WYyDGlJ0z1BIyHLNG6sNcZE9E92BQSQcGjt38yDWGHKU7pr39HxqDQr5reKCMsUdDVz
         hSYg==
X-Gm-Message-State: AOAM5303ZMrMmgI9+EQEuBpOXcjzMDEvY4paHBqnvJX32WIWr2KvspAK
        RHt68WK5LvVYjPVbI6zdgCmw+ZsbFZCwsQ==
X-Google-Smtp-Source: ABdhPJyhG/BKI6K4u573xjihpY7PLnDc1J+VIiKOoxA9+6UlDlwD9/gnmrTPhRU6EYyuhKhgUhX7Qg==
X-Received: by 2002:a1c:b783:: with SMTP id h125mr3118389wmf.186.1613476703696;
        Tue, 16 Feb 2021 03:58:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/22] perf: add performance test for pickaxe
Date:   Tue, 16 Feb 2021 12:57:52 +0100
Message-Id: <20210216115801.4773-14-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the -G and -S pickaxe options and related options.

This test supports being run with GIT_TEST_LONG=1 to adjust the limit
on the number of commits from 1k to 10k. The 1k limit seems to hit a
good spot on git.git

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p4209-pickaxe.sh | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100755 t/perf/p4209-pickaxe.sh

diff --git a/t/perf/p4209-pickaxe.sh b/t/perf/p4209-pickaxe.sh
new file mode 100755
index 00000000000..f585a4465ae
--- /dev/null
+++ b/t/perf/p4209-pickaxe.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description="Test pickaxe performance"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+# Not --max-count, as that's the number of matching commit, so it's
+# unbounded. We want to limit our revision walk here.
+from_rev_desc=
+from_rev=
+max_count=1000
+if test_have_prereq EXPENSIVE
+then
+	max_count=10000
+fi
+from_rev=" $(git rev-list HEAD | head -n $max_count | tail -n 1).."
+from_rev_desc=" <limit-rev>.."
+
+for icase in \
+	'' \
+	'-i '
+do
+	# -S (no regex)
+	for pattern in \
+		'int main' \
+		'æ'
+	do
+		for opts in \
+			'-S'
+		do
+			test_perf "git log $icase$opts'$pattern'$from_rev_desc" "
+				git log --pretty=format:%H $icase$opts'$pattern'$from_rev
+			"
+		done
+	done
+
+	# -S (regex)
+	for pattern in  \
+		'(int|void|null)' \
+		'if *\([^ ]+ & ' \
+		'[àáâãäåæñøùúûüýþ]'
+	do
+		for opts in \
+			'--pickaxe-regex -S'
+		do
+			test_perf "git log $icase$opts'$pattern'$from_rev_desc" "
+				git log --pretty=format:%H $icase$opts'$pattern'$from_rev
+			"
+		done
+	done
+
+	# -G
+	for pattern in  \
+		'(int|void|null)' \
+		'if *\([^ ]+ & ' \
+		'[àáâãäåæñøùúûüýþ]'
+	do
+		for opts in \
+			'-G'
+		do
+			test_perf "git log $icase$opts'$pattern'$from_rev_desc" "
+				git log --pretty=format:%H $icase$opts'$pattern'$from_rev
+			"
+		done
+	done
+done
+
+test_done
-- 
2.30.0.284.gd98b1dd5eaa7

