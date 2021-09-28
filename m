Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63234C4332F
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2E861260
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbhI1CUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbhI1CUm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E3CC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x20so10536694wrg.10
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIzUQxPGKq5KMfj4KRupphPBQSuNyWG5kGI8GHhLclM=;
        b=ReviMLbgiaU0MFmTEiM49jy6FYmPO62TwkyxvMgB0M/bh/jVBv0DHV7UIVHfHiLPyZ
         T8RYrTqrp/jaP63swtTZg9C315UMYcFphv5ja7NaphNTE0dQlQ4GmkNc+IXsnYICBrmS
         xMnH2DPA/jNDWzqr2/Yq6ea7a3bF7EdDfPL/JdEfNdpahUfrai6mBS9T7XZm/Xv28iGp
         vtR/emn03p56/gm6amdDR8Gb0TrjqxMvZ3cNl75IL0IOHZNuBGYfEpDKPSTyNLiXiM6K
         yCx2pmTbK3pols9RDJwtUqfZna9D0Y9dDiptpnfSo0JfsaPPtD5pS2Uw5kziWd6qcyNE
         BteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIzUQxPGKq5KMfj4KRupphPBQSuNyWG5kGI8GHhLclM=;
        b=DeO31VfOP68zwD3Z4swX2z9luHWtcL2E6D12HFxGKNlF3Cp47952hU47+nHAC4ANo/
         rA0aLRl33vMM/8y3vqZm8uPGJNnHdDTlMC1Ce5JOrGc4yrqtBT9WRm3YsDMaMIB6qB1u
         SB4tmg9i30x0CWfcCVWG/Gak+vCRUKuGDpHy454gXmD2Sp/lOdJFtzQHz5SsEK1ZBr5N
         noKFQ9OT9+Cbg8yQ1qY5Xg07Kb8tF4stVuSaKxz96aEJ8tEiXhPVWMZ+TzSJxw6mXQZS
         1EGcNPzNKsE1pmawNppeJWPHpfCnxlC9lH0Wa4IMd8EHAlyCZCiclfZasucg2VRENYjY
         2tKA==
X-Gm-Message-State: AOAM531ED54wRqJmlM02qPlG2353f3uYyB/WRaZTqPSsMjhFHtSeiqiO
        lTBNdHGIRy8RwK5joScP+XWA+w1He6hVdg==
X-Google-Smtp-Source: ABdhPJxF/3wvQWwNZoqNshq3M62+ffb+xMIB2qOv5WpDcAlXWPoymhxtqTmEoafHo950rrsXKNssYQ==
X-Received: by 2002:a5d:4243:: with SMTP id s3mr3806183wrr.216.1632795541640;
        Mon, 27 Sep 2021 19:19:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 02/17] fsck tests: refactor one test to use a sub-repo
Date:   Tue, 28 Sep 2021 04:18:43 +0200
Message-Id: <patch-v8-02.17-e01c21378a4-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
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

We can instead use the pattern of creating a named sub-repository,
then we don't have to worry about cleaning up after ourselves, nobody
will care what state the broken "hash-mismatch" repository is after
this test runs.

See [1] for related discussion on various "modern" test patterns that
can be used to avoid verbosity and increase reliability.

1. https://lore.kernel.org/git/87y27veeyj.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 969bfbbdd8f..f8edd15abf8 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -48,24 +48,25 @@ remove_object () {
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
+test_expect_success 'object with hash mismatch' '
+	git init --bare hash-mismatch &&
+	(
+		cd hash-mismatch &&
 
-	test_must_fail git fsck 2>out &&
-	test_i18ngrep "$sha.*corrupt" out
+		oid=$(echo blob | git hash-object -w --stdin) &&
+		old=$(test_oid_to_path "$oid") &&
+		new=$(dirname $old)/$(test_oid ff_2) &&
+		oid="$(dirname $new)$(basename $new)" &&
+
+		mv objects/$old objects/$new &&
+		git update-index --add --cacheinfo 100644 $oid foo &&
+		tree=$(git write-tree) &&
+		cmt=$(echo bogus | git commit-tree $tree) &&
+		git update-ref refs/heads/bogus $cmt &&
+
+		test_must_fail git fsck 2>out &&
+		grep "$oid.*corrupt" out
+	)
 '
 
 test_expect_success 'branch pointing to non-commit' '
-- 
2.33.0.1327.g9926af6cb02

