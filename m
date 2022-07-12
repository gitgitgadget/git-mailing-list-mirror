Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DA0C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 08:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiGLIB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGLIB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 04:01:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E363A24958
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 01:01:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so7197426pjf.2
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FW+bR43PxAahbHlC6G2mxYq1ah3vde7GbWi8Z8slbTE=;
        b=U4EnlcE4AUZAhTk0zAnoYg3XSFB0SOFd/xgpzFai+9cdrbExujG86vjz2MrwgJUHw/
         0aGq05R5maD9wCSuHA5Y8cAKzNyIovhEmaDQWbwBIzidkyzx2kMJ94283WMLQmPITvEc
         iLbhd+gPt+PJBzSB2exPzWjYz6h4hwmY6o9oslRotULvB/9nXnYlbv4U9QRXet939Rue
         byu/FVvnXIaTmr7TIkLSrlnzH/338/sR1eHLZU8VJRzl6WxNhwpG8KQUHcRJWqZJqGWg
         XvtSKKYoSniQht1l7ZTVl7VvfKzNI0ViHP7ZiCNxA5FK+ufte5ljkpO/3CHgNKElbSiw
         xtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FW+bR43PxAahbHlC6G2mxYq1ah3vde7GbWi8Z8slbTE=;
        b=emwcGtHsTLioJ3X/M0IN/XqdG1ERqPLIlhH0j/GkazDF3vixLM3TqplSRiq5ZhORnn
         9sFO1E/eo0WYEXL6Pwv7449W/XLdhuKOqD7wfji+nz5nOrul35hZgF22je7sXDJPp4k6
         ao3tGPZUSfQg7Lgpj0F472iwPWKMeAEiybWwz/9DpdGjddEZJL20sGS6vqCbFkQ9+01H
         K+nooMqu96gclVYDGV2R/5RN0yx7PtVC4B9qpRN/mjS4TQ+cBSA4GTWDyc1jKAJLz7zW
         L0ErG9/xyp7b6dvakJ1nWVsobZ603JRh9SG0+Wnbu/k84F4KXmwkywU4DBQtS5dlzShb
         uLag==
X-Gm-Message-State: AJIora+LavnWfFjc+A66BHMtt4mvbJpThXuND+hUl+uQVioqk910o4cX
        4Zg4yaAas7YWZv6usY9fI3ghvA==
X-Google-Smtp-Source: AGRyM1vQpsv+RWxenRvx4aLS7FacOnMdaPUzSXCMf2a+tP8LkjKF8llOrpd3aXhYfSqlX/9QIMCKiw==
X-Received: by 2002:a17:903:1252:b0:16b:a568:4f7d with SMTP id u18-20020a170903125200b0016ba5684f7dmr22959377plh.103.1657612916378;
        Tue, 12 Jul 2022 01:01:56 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id r26-20020aa7963a000000b0052ac12e7596sm4988574pfg.114.2022.07.12.01.01.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Jul 2022 01:01:56 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, peff@peff.net, git@grubix.eu,
        me@ttaylorr.com, Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: [PATCH v1] t5330: remove run_with_limited_processses()
Date:   Tue, 12 Jul 2022 16:01:43 +0800
Message-Id: <20220712080143.11843-1-hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656593279.git.hanxin.hx@bytedance.com>
References: <cover.1656593279.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

run_with_limited_processses() is used to end the loop faster when an
infinite loop happen. But "ulimit" is tied to the entire development
station, and the test will fail due to too many other processes or using
"--stress".

Without run_with_limited_processses() the infinite loop can also be
stopped due to global configrations or quotas, and the verification
still works fine. So let's remove run_with_limited_processses().

Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 t/t5330-no-lazy-fetch-with-commit-graph.sh | 25 +---------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
index be33334229..2cc7fd7a47 100755
--- a/t/t5330-no-lazy-fetch-with-commit-graph.sh
+++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
@@ -4,28 +4,6 @@ test_description='test for no lazy fetch with the commit-graph'
 
 . ./test-lib.sh
 
-run_with_limited_processses () {
-	# bash and ksh use "ulimit -u", dash uses "ulimit -p"
-	if test -n "$BASH_VERSION"
-	then
-		ulimit_max_process="-u"
-	elif test -n "$KSH_VERSION"
-	then
-		ulimit_max_process="-u"
-	fi
-	(ulimit ${ulimit_max_process-"-p"} 512 && "$@")
-}
-
-test_lazy_prereq ULIMIT_PROCESSES '
-	run_with_limited_processses true
-'
-
-if ! test_have_prereq ULIMIT_PROCESSES
-then
-	skip_all='skipping tests for no lazy fetch with the commit-graph, ulimit processes not available'
-	test_done
-fi
-
 test_expect_success 'setup: prepare a repository with a commit' '
 	git init with-commit &&
 	test_commit -C with-commit the-commit &&
@@ -59,8 +37,7 @@ test_expect_success 'fetch any commit from promisor with the usage of the commit
 	git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
 	test_commit -C with-commit any-commit &&
 	anycommit=$(git -C with-commit rev-parse HEAD) &&
-
-	run_with_limited_processses env GIT_TRACE="$(pwd)/trace.txt" \
+	GIT_TRACE="$(pwd)/trace.txt" \
 		git -C with-commit-graph fetch origin $anycommit 2>err &&
 	! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
 	grep "git fetch origin" trace.txt >actual &&
-- 
2.36.1

