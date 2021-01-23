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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DEAC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE1C22CAF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbhAWNCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAWNC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 08:02:29 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0DC061794
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i63so6584954wma.4
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ImXUkZ6o3CFBgFdea1OS0wH2Fcn8MK141oZMsNbmFjc=;
        b=OjKQz4eSSzEViFFMPJ5uvZNNt2SABGtrTnIREXB6K5vZc1+WuqNLrWklQD2LF9HK8m
         DJg60uxUmbCtLWS6md9rM8aDGTihjQNEKzR/oYYLOKq8/U4QfYXKVXoum0+qBdNOIIIb
         TagxLIUYRNYDP0pmQuGbTjoEePyvV4jijEWoosT4RJ1T9J4Xlj2nFj4qG7rvxOq5MXot
         2fzCCVI+GdT4IJbJUKajkZqG0DliH+ulqUCgX6I2AVOxbBydTH1CsUk0nrin86OHzeAe
         S2+Jwvrxp2wBTu2HaalmvO2VazTaacRSxuePkpZovcxdHTiYG5LvqbEKJQLMoN7D27DF
         OSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ImXUkZ6o3CFBgFdea1OS0wH2Fcn8MK141oZMsNbmFjc=;
        b=Ru6J2Jkq/GofQQSuaXWCHGV/du9KDVNbzjSE9zvzlNvnEZ1BhcI8ZcvWrwhSJ3ZcD2
         idDppBBOAObzoELLkU0HY6wZbddroZjVP9RyKg/fd26xqxyK21HGOiPSbF16hiXeaiaD
         geqLnvuLE0zzuFgtQs+q4zcsoAs7EBK9GYi0uv8DDx63OG2UgyM4FrQdEnWYcEK2BlbX
         RsXdXbmn944mv/3LXtYR/uaPwaUTycXf2Q6ei+x9y9NqfSvOyyin/1uay1qsa2RkR8yb
         EzrUGBP3hdubebMidg4s0ixONtwacNBXDJlW8x2+/YUJ7G8YHUnDKxGBMaY1UbmyfnzH
         9PFQ==
X-Gm-Message-State: AOAM532uVrikCLF8cQ9LDFzdK/pxlvAb5k+NryWxkYKoiSdaypyM31iJ
        PI6e8vwiKowxQ8bNlQgJEVMZXADmPwTx6Q==
X-Google-Smtp-Source: ABdhPJxjKradDoxAVE2pEQx6JTl5JN4GcskSKvolg1e6o3L1cyC3KSY4VhCdpUVOky5eDj5JJBiBpg==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr8322815wmj.118.1611406869633;
        Sat, 23 Jan 2021 05:01:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm16750319wro.16.2021.01.23.05.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 05:01:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/10] git svn mergeinfo tests: refactor "test -z" to use test_must_be_empty
Date:   Sat, 23 Jan 2021 14:00:42 +0100
Message-Id: <20210123130046.21975-7-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87sg6s6lrs.fsf@evledraar.gmail.com>
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor some old-style test code to use test_must_be_empty instead of
"test -z". This makes a follow-up commit easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9151-svn-mergeinfo.sh | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 59c5847c5f..806eff4023 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -17,41 +17,42 @@ test_expect_success 'load svn dump' "
 "
 
 test_expect_success 'all svn merges became git merge commits' '
-	unmarked=$(git rev-list --parents --all --grep=Merge |
-		grep -v " .* " | cut -f1 -d" ") &&
-	[ -z "$unmarked" ]
+	git rev-list --parents --all --grep=Merge |
+		grep -v " .* " | cut -f1 -d" " >unmarked &&
+	test_must_be_empty unmarked
 '
 
+
 test_expect_success 'cherry picks did not become git merge commits' '
-	bad_cherries=$(git rev-list --parents --all --grep=Cherry |
-		grep " .* " | cut -f1 -d" ") &&
-	[ -z "$bad_cherries" ]
+	git rev-list --parents --all --grep=Cherry |
+		grep " .* " | cut -f1 -d" " >bad-cherries &&
+	test_must_be_empty bad-cherries
 '
 
 test_expect_success 'svn non-merge merge commits did not become git merge commits' '
-	bad_non_merges=$(git rev-list --parents --all --grep=non-merge |
-		grep " .* " | cut -f1 -d" ") &&
-	[ -z "$bad_non_merges" ]
+	git rev-list --parents --all --grep=non-merge |
+		grep " .* " | cut -f1 -d" " >bad-non-merges &&
+	test_must_be_empty bad-non-merges
 '
 
 test_expect_success 'commit made to merged branch is reachable from the merge' '
 	before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2") &&
 	merge_commit=$(git rev-list --all --grep="Merge trunk to b2") &&
-	not_reachable=$(git rev-list -1 $before_commit --not $merge_commit) &&
-	[ -z "$not_reachable" ]
+	git rev-list -1 $before_commit --not $merge_commit >not-reachable &&
+	test_must_be_empty not-reachable
 '
 
 test_expect_success 'merging two branches in one commit is detected correctly' '
 	f1_commit=$(git rev-list --all --grep="make f1 branch from trunk") &&
 	f2_commit=$(git rev-list --all --grep="make f2 branch from trunk") &&
 	merge_commit=$(git rev-list --all --grep="Merge f1 and f2 to trunk") &&
-	not_reachable=$(git rev-list -1 $f1_commit $f2_commit --not $merge_commit) &&
-	[ -z "$not_reachable" ]
+	git rev-list -1 $f1_commit $f2_commit --not $merge_commit >not-reachable &&
+	test_must_be_empty not-reachable
 '
 
 test_expect_failure 'everything got merged in the end' '
-	unmerged=$(git rev-list --all --not master) &&
-	[ -z "$unmerged" ]
+	git rev-list --all --not master >unmerged &&
+	test_must_be_empty unmerged
 '
 
 test_done
-- 
2.29.2.222.g5d2a92d10f8

