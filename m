Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A329C433FE
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E048D60E96
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244025AbhJPJl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244014AbhJPJlv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A338C061770
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g2so4274826wme.4
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sEIwjiHa2SZKEvpq1PpEPKl5F80/cPDk5R6pxZHMiE=;
        b=NSUU44sCNOYgoXA/2B/ZYgm0d2uLcpwUMyZcWbFYw7MyHIuUYCz00t9rWfJhrxCMqz
         Yv9gVv9pqon6PLAIl25RFZpPmnhcQ1LKvsMnDwYgKD8bvPaiLIgyC0ZQv5afPm5Y+2z7
         xJ5F5Ik2uu0RynFOb8CCUXYP9NkVP1G7MemeRV0M7aFGXO9SVboyHRNauJjx6AilnXi4
         lBjiLXSJO1lBmpO+M9GKWJaws4OpzWR2LWhZwzt8l3Um8xJHp+hW9fDwAoX8Ffa2d50d
         adLkMR0DAKSLnXh1Ij9UIALYfArD6kZtSKHRS2UtMsJ7gtBMCtVzfhEw3AkVjXkOWVQJ
         kr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sEIwjiHa2SZKEvpq1PpEPKl5F80/cPDk5R6pxZHMiE=;
        b=v2pQz1/qla3pOtR7YoUN/JZl/1V0do0N7wMHDsXD97Bhsvw+1gCwtKjE4Wre+HS4we
         AqJG54XwhRDXhEsSLYCrUmqvmXRegHQys7gPhSKtiptO9Kv4DoKMKbcQKMhAvG3V7WD5
         eXgsTTqLiKPDAGeJ9zSYLQVPY4cgV9C+R1nk/OM0JGHBxwFlClk48mC2Ae/Yr5VXKkP2
         70CHnPIKJjl2KI0QH15kGLu1MxRSfjT+6ztYrVF7v8AYVwQjFddr7jSfwao0iFdDzZrX
         aAQYRHlCNV3Hq85fTvijPSAPo24DbLQ74Ja8gOdNkovlpUYYdG0Sx3rawoRDZueLD4fC
         PXnA==
X-Gm-Message-State: AOAM532fqLLUXaBLG8gw+EgGrNgjkNxeZNBmr4GgK0dS1aS20HIgeAka
        aFaYyFl7FOOpjhf9QdELzL4NZGo7c/LjFw==
X-Google-Smtp-Source: ABdhPJytH0cyWNrbcDf5CwaeqpDDKiU60HwowWtRpzhuXO2oGcweSGAQGWWX8KkWjQ0VqQDKBRltxQ==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr17587950wma.174.1634377174666;
        Sat, 16 Oct 2021 02:39:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/21] reflog tests: add --updateref tests
Date:   Sat, 16 Oct 2021 11:39:12 +0200
Message-Id: <patch-v2-06.21-d3242f5f687-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests that cover blindspots in "git reflog delete --updateref"
behavior. Before this change removing the "type & REF_ISSYMREF" check
added in 5e6f003ca8a (reflog_expire(): ignore --updateref for symbolic
references, 2015-03-03) would not fail any tests.

The "--updateref" option was added in 55f10565371 (git-reflog: add
option --updateref to write the last reflog sha1 into the ref,
2008-02-22) for use in git-stash.sh, see e25d5f9c82e (git-stash: add
new 'drop' subcommand, 2008-02-22).

Even though the regression test I need is just the "C" case here,
let's test all these combinations for good measure. I started out
doing these as a for-loop, but I think this is more readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1417-reflog-updateref.sh | 65 +++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100755 t/t1417-reflog-updateref.sh

diff --git a/t/t1417-reflog-updateref.sh b/t/t1417-reflog-updateref.sh
new file mode 100755
index 00000000000..14f13b57c6d
--- /dev/null
+++ b/t/t1417-reflog-updateref.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+test_description='git reflog --updateref'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git init -b main repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+
+		cp .git/logs/HEAD HEAD.old &&
+		git reset --hard HEAD~ &&
+		cp HEAD.old .git/logs/HEAD
+	)
+'
+
+test_reflog_updateref () {
+	exp=$1
+	shift
+	args="$@"
+
+	test_expect_success REFFILES "get '$exp' with '$args'"  '
+		test_when_finished "rm -rf copy" &&
+		cp -R repo copy &&
+
+		(
+			cd copy &&
+
+			$args &&
+			git rev-parse $exp >expect &&
+			git rev-parse HEAD >actual &&
+
+			test_cmp expect actual
+		)
+	'
+}
+
+test_reflog_updateref B git reflog delete --updateref HEAD@{0}
+test_reflog_updateref B git reflog delete --updateref HEAD@{1}
+test_reflog_updateref C git reflog delete --updateref main@{0}
+test_reflog_updateref B git reflog delete --updateref main@{1}
+test_reflog_updateref B git reflog delete --updateref --rewrite HEAD@{0}
+test_reflog_updateref B git reflog delete --updateref --rewrite HEAD@{1}
+test_reflog_updateref C git reflog delete --updateref --rewrite main@{0}
+test_reflog_updateref B git reflog delete --updateref --rewrite main@{1}
+test_reflog_updateref B test_must_fail git reflog expire  HEAD@{0}
+test_reflog_updateref B test_must_fail git reflog expire  HEAD@{1}
+test_reflog_updateref B test_must_fail git reflog expire  main@{0}
+test_reflog_updateref B test_must_fail git reflog expire  main@{1}
+test_reflog_updateref B test_must_fail git reflog expire --updateref HEAD@{0}
+test_reflog_updateref B test_must_fail git reflog expire --updateref HEAD@{1}
+test_reflog_updateref B test_must_fail git reflog expire --updateref main@{0}
+test_reflog_updateref B test_must_fail git reflog expire --updateref main@{1}
+test_reflog_updateref B test_must_fail git reflog expire --updateref --rewrite HEAD@{0}
+test_reflog_updateref B test_must_fail git reflog expire --updateref --rewrite HEAD@{1}
+test_reflog_updateref B test_must_fail git reflog expire --updateref --rewrite main@{0}
+test_reflog_updateref B test_must_fail git reflog expire --updateref --rewrite main@{1}
+
+test_done
-- 
2.33.1.1338.g20da966911a

