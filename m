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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6678C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B220B61206
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbhDLRQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244125AbhDLRQN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1FEC061345
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id 12so13746825wrz.7
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5DnJYyEqXaaZt7P1BjQc30tGULTiNnYyXebNWcRDuA=;
        b=Iip9mHNEp5a3YjkNaaBB21/zCUQrETqXdveaoC9GuE/JJ0SepqEUNvEMn0rvgBDvZa
         +3MUr6TX2Z9RPRReV7pVMl7jhZWneHJ4XWP45xRQFqgmDuMA1AEmff/skKLvfzs0YA9H
         KzxfOPw+rlEpsr9cZ27/gsZFNwDl7XRl7eCJLRuIYhGT7Mll3Q08ZdGvS/Bk0sU4tqG+
         s0NBmWde95WQnR/RL80/lzP/xX0DqKPPPWWihI7V3qHVR14bfTQ7EB+4/ApYkPohFX6I
         bMRKyEGSeWloWAXsyCXYnR8yPSIYmos6gEUh5PwW44tItcojnXGCUcYSEXc0KHyMmymP
         nJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5DnJYyEqXaaZt7P1BjQc30tGULTiNnYyXebNWcRDuA=;
        b=MtWZIX4fqfFubBRTPzGctnp1mH9dzLncuTXlIPlP/2VmvfQ0OXZ1mE9zOYCC8drTEr
         6Aqu1JCwk5VwMuES7eUNPZ1d04+OGfgednN8BrLPRrwTD/8uI2LrFavEZIxwQoV2hr3A
         U4dz/Kd3yvotTRznDWnumrBYRyGavHJ8ckx2rZqJXLyt5aDvxCD9BnpHAoKx7emjBgf+
         FdpwuvMG9z/W7u9l3YGS3TauAXTVFuP9+Do+PbE2L4PwEULwkG8vYESQLO4Cf03mxB4G
         uPCEbPu29fWIuYzcoM7mjLucQa4pm9fEBVI6Iz4aqQK7Qn/O5U4STU3qCLBuNrtUGVA/
         po/w==
X-Gm-Message-State: AOAM531TN6b5U6I+oqzddHfKG1MGwiIE576HI/lKsXwBRhdJcWhVvxUW
        syHfqs4oyPcJMc7JCWGdG3bX+1yEL876oA==
X-Google-Smtp-Source: ABdhPJwhvWklxbWNzePk+qfGgkLc9JG790TQCTuHRejzgm0DWjjGRte/aXlAq02dO7Xt/hKRfUjnBQ==
X-Received: by 2002:a05:6000:1249:: with SMTP id j9mr3496445wrx.416.1618247746357;
        Mon, 12 Apr 2021 10:15:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/22] perf: add performance test for pickaxe
Date:   Mon, 12 Apr 2021 19:15:18 +0200
Message-Id: <patch-11.22-97616d741c7-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
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
2.31.1.639.g3d04783866f

