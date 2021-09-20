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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A39EC433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6606112D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhIUC73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239258AbhIUC0b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B42AC1E3262
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i23so32619104wrb.2
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pic6YmM0DWsnEf+G2fMJILTfU4jfWOTt7Tj45Xt3BLI=;
        b=bzH+zQ+PZluL/Jaxqw5FcAxbNAKfdwY9no96UUDvgT+rJ7qcIcU++qsfZNiSsH1o+C
         qWPP6WH84ABymFxK54bSziPlsm4W1CBFB9Nblyt6MbqRQeGcs4D6mMQIj9xNJvOl1bwG
         P1XSskEhSJo2VZ5FQFcrMuV3fXFsRfmBPHRC3ygx51Yj/XqxHf+AuWHgKTF8e44eoOAS
         JPmDqflwkXLLhEiHyO6haEdJzFllYzWPmrUudac5Fs3DQGFBAsemq0FlgNPqNhuVkEtb
         /cqn5ynaJQgE3ha7pd4TDVuSux6MiZ6WNvYd3yUBfHHQeqUZpbOWjkBsIGv9Aw3U2CXD
         BABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pic6YmM0DWsnEf+G2fMJILTfU4jfWOTt7Tj45Xt3BLI=;
        b=GvOFh0WDpkul4VUMLCny+rjyM2MDtwUPWOmGoI9pTcE26QQs+zRSJgQSdqXNUWXL2D
         bxO4Tafn+tkUyvrHBMxxS2RqO0/7fgueCcEaDn5EnTA635bVIXG+rD3vgU50bnqoLSss
         VwPBAOk8VkTjDx9qLB5hHavNgENL97DMYPdzgduS7xkyM1IVaiKDLECnayPu514zvAME
         T0kE6K3uiEoXlFAf9iVViL2BErH1ZJTzguSK+MTwZ/pF/IjCPO3arYhdnbbB0+MJel96
         MYT1KtJtQ3IBdXt4YjGFF0k5r0Vm+yHvyLWsTl80GFhJcomM40pdGa660WXzhnI6SaP8
         DMXw==
X-Gm-Message-State: AOAM532c2deUd5KOq5HUFgyL/FF71VgQo8SEaoluphM+eu+nMi2rjYAT
        gX8tmocHiW8YHZXfBOuTiq2gX2BzXesB8g==
X-Google-Smtp-Source: ABdhPJw5aQPsOr82e1LYVUrIerNy3edIxJz19/Xp+yMGfQC+ouRFZaAZ4eZ8YhkHiiIAvQ1T0e3gCQ==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr30596304wru.137.1632164667885;
        Mon, 20 Sep 2021 12:04:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 02/17] fsck tests: refactor one test to use a sub-repo
Date:   Mon, 20 Sep 2021 21:04:06 +0200
Message-Id: <patch-v7-02.17-612003bdd2c-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
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
2.33.0.1098.g29a6526ae47

