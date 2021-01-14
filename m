Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B4FC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F7123AA7
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbhANXgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbhANXgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:36:09 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E4CC0613D3
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q18so7518702wrn.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jNBZdogUuxiWN0YVkrO+rrGRJK3Y4RWQuE7iZOORy0c=;
        b=r17N/o7evu5syOPvXKmLWnxMYTEotrpLnaoUvBNYdoUkzenYL57Z3O9UQ+fH3EiLPq
         A8aydbBTVHflMvFioqGd9im0/g3A0kvl+ox1SJJH/vVxCOHJlOr6imnRqvPyd9DKavrX
         7T6T/YZPz/4R97H5xKS3Jy64k8UacRBB39DXFO7Hc7nwXAIYXXV+nsyaZvxfc9F47lvC
         GdCdvp2QouCm6MroGiXfHbEmi3nOYYyS3htzBYBN4MqoG13Ss4TBiEOvlmbnnlxpKo0n
         jyiwDmxM9mTuUvsfsWw//D+cvvAgVofp7QSKsVKa5akeL3MPAd6FDt6ZDCmJ5eHQ1UG+
         qJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNBZdogUuxiWN0YVkrO+rrGRJK3Y4RWQuE7iZOORy0c=;
        b=jq3pdfCZhTC2ZuS164vWFV3YJ1ThW1OjVws16fWHZXKsifpw8zGokjem1sCM/No8QI
         kzYuvLALjAG4EB00fAnzUFLI148giVHXq+PGa9QgOtNEEi59bqlif4QML4eXGUWVQY8r
         SSS47RRW/IIYDremxpi0W8VS/xxmsndDgooY9pwoLXhpI2Qc/Mt0T7M2HJa4VDvfMmZh
         tH7J5I4saoVy1fMRKUJV1WUdHmM7tKkugJ6hHE/8vU6P5UtLhQ45UAYK89SVAYobatH+
         +rbmcO3FhXmNmaG9QvHyHcavY/RNOBH4dztuIPqQTNxkwZhDR1mQ6w5LYLX4yc84MYsW
         JaLA==
X-Gm-Message-State: AOAM533ExlO4TXbyI+ZbXKILAU/8hhoZdlwuXteCzBKVifPmCs0A9q9R
        m0YGiM0UXiEw4D73TcJs1nEHq5MXARbCTg==
X-Google-Smtp-Source: ABdhPJxUmQFKb69QaLi7VrmiTpmpmxGJn06H0v2lpkHN6L7AK0rY8o9a0MYqdXDNSQTlILu+JllSdg==
X-Received: by 2002:adf:e941:: with SMTP id m1mr4991857wrn.240.1610667326986;
        Thu, 14 Jan 2021 15:35:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d13sm12352118wrx.93.2021.01.14.15.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:35:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] tests: use "test_might_fail ok=sigpipe grep" when appropriate
Date:   Fri, 15 Jan 2021 00:35:13 +0100
Message-Id: <20210114233515.31298-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20191115040909.GA21654@sigill.intra.peff.net>
References: <20191115040909.GA21654@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change tests where the "grep" might exit with non-zero to use our new
"test_might_fail ok=sigpipe" wrapper. A subsequent commit will show
how useful this is in combination with "set -o pipefail".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0090-cache-tree.sh              | 2 +-
 t/t5703-upload-pack-ref-in-want.sh | 2 +-
 t/t9151-svn-mergeinfo.sh           | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 5a633690bf..2e69ab138b 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -22,7 +22,7 @@ generate_expected_cache_tree_rec () {
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
 	git ls-files >files &&
-	subtrees=$(grep / files|cut -d / -f 1|uniq) &&
+	subtrees=$(test_might_fail ok=sigpipe grep / files |cut -d / -f 1|uniq) &&
 	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 != "" {++c} END {print c}') &&
 	entries=$(wc -l <files) &&
 	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index eab966985b..44238b7409 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -16,7 +16,7 @@ get_actual_commits () {
 	test-tool pkt-line unpack-sideband <out >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx >objs &&
-	grep commit objs | cut -d" " -f1 | sort >actual_commits
+	test_might_fail ok=sigpipe grep commit objs | cut -d" " -f1 | sort >actual_commits
 }
 
 check_output () {
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 4f6c06ecb2..dc8491c14a 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -18,19 +18,19 @@ test_expect_success 'load svn dump' "
 
 test_expect_success 'all svn merges became git merge commits' '
 	unmarked=$(git rev-list --parents --all --grep=Merge |
-		grep -v " .* " | cut -f1 -d" ") &&
+		test_might_fail ok=sigpipe grep -v " .* " | cut -f1 -d" ") &&
 	[ -z "$unmarked" ]
 	'
 
 test_expect_success 'cherry picks did not become git merge commits' '
 	bad_cherries=$(git rev-list --parents --all --grep=Cherry |
-		grep " .* " | cut -f1 -d" ") &&
+		test_might_fail ok=sigpipe grep grep " .* " | cut -f1 -d" ") &&
 	[ -z "$bad_cherries" ]
 	'
 
 test_expect_success 'svn non-merge merge commits did not become git merge commits' '
 	bad_non_merges=$(git rev-list --parents --all --grep=non-merge |
-		grep " .* " | cut -f1 -d" ") &&
+		test_might_fail ok=sigpipe grep grep " .* " | cut -f1 -d" ") &&
 	[ -z "$bad_non_merges" ]
 	'
 
-- 
2.29.2.222.g5d2a92d10f8

