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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F9C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691B764F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhBCDaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhBCD3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA96C061354
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i9so3962363wmq.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGe6BqQs7a4AUYptU57wOt1q2O+PcDPFK/WGmHR9oSo=;
        b=bwJzmHgvtBmJAKvjPdN0KQfQ4D0yoWKgtLBRpQQY0oMVQl2beNgmUt6GfwKi+xdfRs
         RXDK++vvWmiEoQPmrMuCPrOqlh8fxcIJq3q06iAizkUMTqyvIiB+nlGzi+vUZ+MdHb8C
         BVLLxV5a6gSyt0lvsehiIBxHM2lU2U3vEBmSO7q9h+srtKJzNO6NyT3DDCUblD70Ct2I
         zrKZYpfoH4FplR+l5nzIQGLIqOko+MpLm51VhQiyCB/zqYNjLc4QgWQU3zEHwv2kkFq/
         3r2lYhJiHdrt6ve0fbBxLNCgOiFOW8hGp6Z4H5Sxfwiv07hfs/0WIkIHMELgwoE+k1VX
         QmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGe6BqQs7a4AUYptU57wOt1q2O+PcDPFK/WGmHR9oSo=;
        b=Erwp6w3kUlVpeJOYgAgQBFG9iT/FnnqMZMqrj171MeDkhSaYF4jxTyEWyqvoQsgkzX
         cdb+Hnj88/8Z1CqxLJmgdKU3foGkZV476jWDRIcnW80N66DxDBPsUbxeCuHSWDvhw7jm
         cW4x32tHFj5CQ7nA17XAIW+FhWkBCDLGMF1Igku/O7sVkotFqbbuScrLPFoEPs7OK8AD
         1XedgjYTYx3VRissZr6ickghn6lwgnrpLkf4eQAvzemUmVMkbVo6hwoJ0vtxNwb0uaTS
         fSJWJlbZB4yLqI3IN0TB3b3BcG2XcJMMrv+TFEt6DtyDQD2KPWLrGgnbleN4+RmLI/Xn
         jTAg==
X-Gm-Message-State: AOAM530d/TAF7Eqtj6RePrJrob0bSQNNRlPixORPazPGPJpw3Ec6Q330
        A7ZhfwKVMn8454FvVn81dErCH2qUJaL8Gw==
X-Google-Smtp-Source: ABdhPJxHlmScmiqh09y7cmBxiA22eU3ScrL581SfB5wVIFToYIwIRU3eNvcH57FzIBAzrhgynlTSUg==
X-Received: by 2002:a1c:9e95:: with SMTP id h143mr846844wme.25.1612322915335;
        Tue, 02 Feb 2021 19:28:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/25] perf: add performance test for pickaxe
Date:   Wed,  3 Feb 2021 04:28:04 +0100
Message-Id: <20210203032811.14979-19-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the -G and -S pickaxe options and related options. This
test supports being run with GIT_PERF_EXTRA=1 to turn on the full set
of tests, as well as GIT_TEST_LONG=1 to opt-in a full history walk. By
default I'm limiting the walk to 500 commits, which seems to hit a
good spot on git.git of around 0.5s per iteration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p4209-pickaxe.sh | 82 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 t/perf/p4209-pickaxe.sh

diff --git a/t/perf/p4209-pickaxe.sh b/t/perf/p4209-pickaxe.sh
new file mode 100755
index 0000000000..011a287d3b
--- /dev/null
+++ b/t/perf/p4209-pickaxe.sh
@@ -0,0 +1,82 @@
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
+if ! test_have_prereq EXPENSIVE
+then
+	max_count=500
+	from_rev=" $(git rev-list HEAD | head -n $max_count | tail -n 1).."
+	from_rev_desc=" <limit-rev>.."
+fi
+
+for icase in \
+	'' \
+	'-i '
+do
+	# -S (no regex)
+	for pattern in \
+		'a' \
+		'uncommon'\
+		'ö'
+	do
+		for opts in \
+			'-S'
+		do
+			continue
+			test_perf "git log $icase$opts'$pattern'$from_rev_desc" "
+				git log --pretty=format:%H $icase$opts'$pattern'$from_rev
+			"
+		done
+	done
+
+	# -S (regex)
+	for pattern in  \
+		'[þæö]'
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
+		'a' \
+		'uncommon' \
+		'[þæö]'
+	do
+		for opts in \
+			'-G' \
+			'--pickaxe-regex -S'
+		do
+			test_perf "git log $icase$opts'$pattern'$from_rev_desc" "
+				git log --pretty=format:%H $icase$opts'$pattern'$from_rev
+			"
+		done
+
+		# -G extra
+		for opts in \
+			'--text -G' \
+			'--text --pickaxe-all -G' \
+			'--pickaxe-all -G' \
+			'--pickaxe-all --pickaxe-regex -S'
+		do
+			test_perf PERF_EXTRA "git log $icase$opts'$pattern'$from_rev_desc" "
+				git log --pretty=format:%H $icase$opts'$pattern'$from_rev
+			"
+		done
+	done
+done
+
+test_done
-- 
2.30.0.284.gd98b1dd5eaa7

