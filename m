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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0FCC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B66D6121E
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhDMJnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhDMJnp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 05:43:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C478C06175F
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:43:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so770859wma.0
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPn0xukANaADK47ElgM2KHOFTvVwi8Zqo6/y2Xt37b4=;
        b=EDJmArK/lKoQcY9skMQeBP0FiaJ4EX/AHmT8emvDQWTilMbufQIik1ix/rqgZVP8VG
         DGqM4WhyFjz5QoAlfqm8pel2VCncAS+I+aQ0//h3ltG3oEJwOgmxdWOX9RQ2ZdvVtglF
         +10eXhnHa3EkknrLCm/qn/VejQGt6ljmQNU/1vVv+1Xaj3z8YxHj5+fMiI0OB829rwNg
         5lTqwm8Iqs+1INjSrUKCG9YKY5yPoG+vW3CVQ3XmHdZpPPpY+yT+Yp1a6d1/eMeOjgst
         i6y96++7sgeuxx+EOo9pGbT5BcMqwpV3skYb/2t1xL3DK8V84pxqy4eGeJKxNfaafG4K
         ID4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPn0xukANaADK47ElgM2KHOFTvVwi8Zqo6/y2Xt37b4=;
        b=BzqZRVcu0K9pynlaljKVwh3oNo6hLfvcgOwYY6Ozbvyfee7oG2/GEoY6AT257+v8Vt
         Js3QhnbT57DHWyRSszytuTnZHuVi1ZmC90eQAbkgH6lhI5+/Fz76X+l+e37+AfJXsKC0
         f69lQh8N4AaWixzY/qPiotbOu3czzSB+7SRaWAKnhue9xdVSWRacnxG10Et7piIAFp/6
         trf46y0oKM43LI/siLEqeLWk7JfFilN+KYSnVgL9NAQqYX3m3sWjDnJ0iPvWQOIpZIcL
         M2nz+wqrIUf+mr0nAx7DAYDh1awGQB/I+wvS+ayGC3ydnkTtogEXemGuIJM/uJiUJgJO
         L5IA==
X-Gm-Message-State: AOAM530KOBpv1sWHuK4ku/npXJIYBdCPexOMZX1T/aoZgV7dlEF5N9CP
        gnk88hvihIYNxN/SCjoB1bzPbkg+vOZf0A==
X-Google-Smtp-Source: ABdhPJyLQNUtUMPF3z6/CdYXGDoZkCE6LtjkHVWjq+Yd7WJ5EqWZLohCtbXfqsQ9UUV22+bbKiNqjg==
X-Received: by 2002:a7b:c857:: with SMTP id c23mr3351038wml.28.1618307002952;
        Tue, 13 Apr 2021 02:43:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p14sm4622877wrn.49.2021.04.13.02.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:43:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] fsck tests: refactor one test to use a sub-repo
Date:   Tue, 13 Apr 2021 11:43:05 +0200
Message-Id: <patch-2.6-5a2cd6cca9c-20210413T093734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.645.g989d83ea6a6
In-Reply-To: <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
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
2.31.1.645.g989d83ea6a6

