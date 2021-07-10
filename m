Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D528C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8DA613B9
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhGJNkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhGJNkR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792FEC0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l7so15549990wrv.7
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0wtNCi6n9mi6lr0mjYqJ+R0Pn3kumfRQ63uTav2298=;
        b=flIKrnSE8visd7g5iJFTzaUFMAPPvmquyI/FxsEakDZr4rQ4tC0MMQESwqdQmBAap9
         iqwrfst8i2E7yUDWZr02dbg1gghrHecCWvfW/KaBA8ZGxJXpXiArfqj6mgCBrh/tdzg6
         Gd4El+dyVvVVQBYlit67veMrJ/KCb5KTktblexTtcdL3iBWhDRYwgkYztVkB5y4AWPJE
         h2f1bWuJom8jmM2XvP3GEhuJFUCiGKoNENjB/Vs6M2zdQse6O1phTaQwHz/HVyQWW7lc
         YxKwZi6T73sKUsd99sWCqScVhAmKn2VGpQalzLYKBoug7EKVkPq8bjHactN3urcWyJAN
         8XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0wtNCi6n9mi6lr0mjYqJ+R0Pn3kumfRQ63uTav2298=;
        b=RBmf44HM0PBuXfNnh9PBPt5el4VgY4ARnDI52oT+bF9+1u7H0ectXuQ/XrbOx1zDZw
         a5qwSD7SnyqRfPh7LuAz5aTIcGLoMFTwvc+6XqflbcEHCyvhQcCINAw6zXtiYBAPeq7O
         hrLWbVMMicj11vILj83Gr/KFt2IRcUemL5LNXADjzuwsUZ6FGuXEUJBoO0sbahcCfCvY
         XODPZuxxRNzw2ck/trigKh0Fu9uIXT/jIOHh0jpPzywR6SZWD48rm6Q9lZzBWrRVRToy
         GHfBbsJHIPVSHXXjjjtTEC2mJAdahLUnaRX/x5FyzFUvod2VWUwtA5kIoiDL1MaRrTAc
         oL0w==
X-Gm-Message-State: AOAM533JxhaY4G/et03DQdVQchS7Poeoa89VrMABSU3M0EzHKIBSn09E
        VGUh3hXSobw86mSOOk5wchdcNuNRfXwJIA==
X-Google-Smtp-Source: ABdhPJz5Zo/O3rAc8dPEZVsVQ7gbc4mx/mBDy1QOEyesMXQOs8vDpxQbiqK1gj+pNJ9A6doukMEllw==
X-Received: by 2002:a05:6000:18c8:: with SMTP id w8mr39369182wrq.90.1625924250710;
        Sat, 10 Jul 2021 06:37:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/21] fsck tests: refactor one test to use a sub-repo
Date:   Sat, 10 Jul 2021 15:37:04 +0200
Message-Id: <patch-01.21-a1259cdedcb-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
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
index 5071ac63a5b..7becab5ba1e 100755
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
+	git init --bare hash-mismatch &&
+	(
+		cd hash-mismatch &&
+		oid=$(echo blob | git hash-object -w --stdin) &&
+		old=$(test_oid_to_path "$oid") &&
+		new=$(dirname $old)/$(test_oid ff_2) &&
+		oid="$(dirname $new)$(basename $new)" &&
+		mv objects/$old objects/$new &&
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
2.32.0.636.g43e71d69cff

