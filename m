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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C41C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB46564E04
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhB1TzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhB1TzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 14:55:16 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93035C061756
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:36 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a22so24292786ejv.9
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROcBY3xmbFk9G6qTD5u7PekmlBIGTUEaX9f1sbOyKTc=;
        b=pSyzi8xW72vN7No/KgLE2FnTuz57szNdIIcCglwZYKZj5Cv7mqLJpIZi7nh9I+tb2F
         4q0bjU1AoAAGerjFSgcDdGWBXUYq1ub6p6wCjpVbT1TVDMHYKP23T9jvlRYSQEP1wZIA
         8UwywYZ0yALDiSq/6M9BefEef1/Ae9yQBMTvL2p/BJhuxZqvmbRvxWPkwcPcMGtaS+/E
         zg05QfMQihGZB04T6GZ3nTyR185CtoGjgqKKBcaBKqq1Qt6eeZTetj5UvyPFU00mgqzH
         0EbuWZHzpUttqwcJD29orao4qoxhVIjnwaQaZRVg9POiBdwrFZQtH52tQ7HGutypKInD
         REWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROcBY3xmbFk9G6qTD5u7PekmlBIGTUEaX9f1sbOyKTc=;
        b=TpY6TtVvvAK9mId7M5WEbXnIz/pcXjbxrhlC7qfzU8xc6jnCEOgeXWCdusAeAkIAIW
         J04w9jMZPiEEOiwsrm2u2BkMkgo+DAE5whSqRA9ZTA70oxOM367LF2VnsrC8kfhJlRcb
         uKVsrWQ/nHJI3LFS4F4SpjSoS5IhLNHuNF2ygAiE+1BkWSK598HqLNyzu5YXUnhblOEM
         EDBb+E/Y6dfog7LEFT2YCBVdYiN+5D7DKQ5alW08s4WWtpFpoipbJP/1cOHZqQyELYrF
         IGGNUZ0IhvN5xhvXbpAWoIiNV6u//DPTMyFGeQPzC3H3CFd/p2w5vyiMfkQ7XUD56GGm
         nipQ==
X-Gm-Message-State: AOAM533CCwzN9JBu7AaKLVWxHgV2kpzeYhEV3rXw1xfyt7T8cVkAoFoM
        h/oK62C/jWWjlWBStlhXUA7/+8qkLRnsAg==
X-Google-Smtp-Source: ABdhPJz5gOXRNhbCaDxwltzw44l5yiji4cWMO99lujY7soBdaw2MLzv3r0iBhDPbiDaHX5owA+8Vww==
X-Received: by 2002:a17:906:39d9:: with SMTP id i25mr12959879eje.226.1614542075070;
        Sun, 28 Feb 2021 11:54:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm11295554ejl.1.2021.02.28.11.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:54:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] describe tests: improve test for --work-tree & --dirty
Date:   Sun, 28 Feb 2021 20:54:05 +0100
Message-Id: <20210228195414.21372-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.116.g45ec00aa00
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de>
References: <20200223125102.6697-1-benno@bmevers.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve tests added in 9f67d2e8279 (Teach "git describe" --dirty
option, 2009-10-21) and 2ed5c8e174d (describe: setup working tree for
--dirty, 2019-02-03) so that they make sense in combination with each
other.

The "check_describe" being removed here was the earlier test, we then
later added these --work-tree tests which really just wanted to check
if we got the exact same output from "describe", but the test wasn't
structured to test for that.

Let's change it to do that, which both improves test coverage and
makes it more obvious what's going on here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6120-describe.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e89b6747be..7bc2aaa46e 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -183,24 +183,24 @@ test_expect_success 'set-up dirty work tree' '
 	echo >>file
 '
 
-check_describe "A-*[0-9a-f]-dirty" --dirty
-
 test_expect_success 'describe --dirty with --work-tree (dirty)' '
+	git describe --dirty >expected &&
 	(
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+-dirty$" out
+	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+-dirty$" out &&
+	test_cmp expected out
 '
 
-check_describe "A-*[0-9a-f].mod" --dirty=.mod
-
 test_expect_success 'describe --dirty=.mod with --work-tree (dirty)' '
+	git describe --dirty=.mod >expected &&
 	(
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty=.mod >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+.mod$" out
+	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+.mod$" out &&
+	test_cmp expected out
 '
 
 test_expect_success 'describe --dirty HEAD' '
-- 
2.31.0.rc0.116.g45ec00aa00

