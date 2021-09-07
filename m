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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4694C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A0460E52
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbhIGK7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245383AbhIGK7c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F7C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d6so13130386wrc.11
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/HWubv+axYRNPDzHdSSH0dhZV08i3gcrYKofoJlGdw=;
        b=j2YPvSxA3ooipiBd1y0VqHPSljnxT9blEQzC4LA5EyKefi0HsWPqzx9aAZh6X38vAY
         Xfl0z84+X1y7HjLd1upoPvc0bqTXUV3UGZ6x0MCv0QV1cm8OExt6smWb1r+YCus066fi
         apNyW9ZowBFKHerZF815nTxmmhrtf6eyKWoR3Ctn8iMCbviWtdDhgl8RN6nSyx8ZRnZ3
         /kmjpDbkhEzSURD6tDxarJU6Y05xB1tsGGzKDVdjX4DIN6D1llHJYrwbJK6/FF8Kmr1/
         F9GYPQ6Q31gBRHWnz+mAlBPHvb6M3Ocf9d9EzCsL9wE0yCXe1o3YQuB2l3xrCSZ3BAmF
         UiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/HWubv+axYRNPDzHdSSH0dhZV08i3gcrYKofoJlGdw=;
        b=EC5wm4qTQMIKurTUWcmQ90PBGcHpVdArB3hw6SHQzgytWjyjDxrbOcC1LqJ8XBToec
         ihhd5WlaeVXUuMmQ48k+g1he6AzmWkVscnQqev8VIrV5svqCwi4YKYc4b0yptbw3AAem
         uChuRUorndECPF24KcrsacCoibJF5N/YCQLw2Z0okxAzAmMS4PEjH9MtT/zsX0/IiVjg
         V11mqPwxxz3yenHa8kr17rvdSZIrScAeLFkREfnS+9fe353hhfT2xLRH2GU7Sy5Y95zi
         3LqQpu+Dwyr/x8MtkMitGhCiH5gzuCO+iprEloVTWh+oe0lETJKLe53ZVOteTLiqXAIL
         L+UA==
X-Gm-Message-State: AOAM530uZpWzI7rcA11jsUaDxvltfaF/cENUSYp+teM6vv7u9ctlPrdQ
        e9DWT9/fERnliY89KVTDlQB7elh7q80xYw==
X-Google-Smtp-Source: ABdhPJzsFNr1jKkI0QYQgqx6VmyIz5C41h0SQ1u9mfuSJIyIJUg6M7bM6Ea2Hrtzr43q3N1u03pULQ==
X-Received: by 2002:adf:9d47:: with SMTP id o7mr18458244wre.50.1631012304562;
        Tue, 07 Sep 2021 03:58:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 01/22] fsck tests: refactor one test to use a sub-repo
Date:   Tue,  7 Sep 2021 12:57:56 +0200
Message-Id: <patch-v6-01.22-ebe89f65354-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
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
2.33.0.815.g21c7aaf6073

