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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E81C433E1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4016199F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhC1C6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhC1C6j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:58:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61962C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so9379372wrt.6
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gSIHxbCnMsiRLcIsrmXLZn9bI0N3Yk1fSXWfLmsObuk=;
        b=r7SnBtqr4UffkJ+gp60NzfTezlpTP7oZXsNoKEelXzOvGJpMxYwiePnCp1hZpg1KNe
         Nz0t2qYYyw/sFtzyakMyMUAQ7JHlfk38NyxSLm5Gbk1iuuQxP8OkBG7+7QEyHysNBKPj
         FdcCWJ6wDd2cuOW1MP+ZbV3oOwooSyi9EszHFeoQHg8mznM9ThWauIeS1WOFMBr2UCsZ
         p7lz2xNvhq+VoW9+G+VF1FS0z7G5lR93Mj+5/wUbAdizQT4eaSKjGl7QQMwexWIlajKh
         04xbdBpulu79cjstCAt4T9UeloU4WLDC4Z47tfyUSvNr393PGNbRo6zWJgH+G0rx3UMm
         Tx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gSIHxbCnMsiRLcIsrmXLZn9bI0N3Yk1fSXWfLmsObuk=;
        b=DEdomz0CPvG2aDt1Z/mLPwY/PhTX5C7MBW1N6ZiDTXJgZCfGgn+PE2PJmCU2TuXqB0
         N8EPWB8D5lDJZO9jp4JN/k44ZEIFxEO/3WnhLB2m64Vkt9zSRYvs0CwV5C+jRmtSNfj0
         +wMVSoi6V2lYvmz6Ymqsk7L0Y40UieHeIjBgtni39I892jlEqBl2mnsIfpcb5x0yXcOv
         gF8IFhs0CNCAgXsaeBFFofC8+QBC16z1+fIk8kTAnqdgbTC+aiugSQwAMUiLe2Hc0vic
         9HhOBKO5eribWbJ2IsnfsLryuQjt/4Z4gAL7A7fypWSqJqhdkaH31kx0vSRjoUNDUJj5
         3EHQ==
X-Gm-Message-State: AOAM533xV0n5c4B4yq4FA/GxC+EdB5wYBma4ZG1YmuM5odrlmQb9pJN6
        ie9Hn1a6pZ9/xC2VW6Leor7zvpcZ5Rh3Jw==
X-Google-Smtp-Source: ABdhPJyVTG7v7d9l6FLNk5ejYq1gY6I12byF64D8bKxbPO16CTjjaVVRS1FaW/JktsqDOSHTe0ssgA==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr22282486wrw.334.1616900317918;
        Sat, 27 Mar 2021 19:58:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y1sm17629421wmq.29.2021.03.27.19.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:58:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] fsck tests: refactor one test to use a sub-repo
Date:   Sun, 28 Mar 2021 04:58:30 +0200
Message-Id: <patch-2.6-3e547289408-20210328T025618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g91d8e479b0a
In-Reply-To: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
References: <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com> <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor one of the fsck tests to use a throwaway repository. It's a
pervasive pattern in t1450-fsck.sh to spend a lot of effort on the
teardown of a tests so we're not leaving corrupt content for the next
test.

We should instead simply use something like this test_create_repo
pattern. It's both less verbose, and makes things easier to debug as a
failing test can have their state left behind under -d without
damaging the state for other tests.

But let's punt on that general refactoring and just change this one
test, I'm going to change it further in subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5071ac63a5b..1563b35f88c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -48,24 +48,22 @@ remove_object () {
 	rm "$(sha1_file "$1")"
 }
 
-test_expect_success 'object with bad sha1' '
-	sha=$(echo blob | git hash-object -w --stdin) &&
-	old=$(test_oid_to_path "$sha") &&
-	new=$(dirname $old)/$(test_oid ff_2) &&
-	sha="$(dirname $new)$(basename $new)" &&
-	mv .git/objects/$old .git/objects/$new &&
-	test_when_finished "remove_object $sha" &&
-	git update-index --add --cacheinfo 100644 $sha foo &&
-	test_when_finished "git read-tree -u --reset HEAD" &&
-	tree=$(git write-tree) &&
-	test_when_finished "remove_object $tree" &&
-	cmt=$(echo bogus | git commit-tree $tree) &&
-	test_when_finished "remove_object $cmt" &&
-	git update-ref refs/heads/bogus $cmt &&
-	test_when_finished "git update-ref -d refs/heads/bogus" &&
-
-	test_must_fail git fsck 2>out &&
-	test_i18ngrep "$sha.*corrupt" out
+test_expect_success 'object with hash mismatch' '
+	test_create_repo hash-mismatch &&
+	(
+		cd hash-mismatch &&
+		oid=$(echo blob | git hash-object -w --stdin) &&
+		old=$(test_oid_to_path "$oid") &&
+		new=$(dirname $old)/$(test_oid ff_2) &&
+		oid="$(dirname $new)$(basename $new)" &&
+		mv .git/objects/$old .git/objects/$new &&
+		git update-index --add --cacheinfo 100644 $oid foo &&
+		tree=$(git write-tree) &&
+		cmt=$(echo bogus | git commit-tree $tree) &&
+		git update-ref refs/heads/bogus $cmt &&
+		test_must_fail git fsck 2>out &&
+		test_i18ngrep "$oid.*corrupt" out
+	)
 '
 
 test_expect_success 'branch pointing to non-commit' '
-- 
2.31.1.445.g91d8e479b0a

