Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AAEC433FE
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26CBF6112F
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhIVLVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbhIVLVe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 07:21:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97167C061760
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:20:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u15so5660146wru.6
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYp3IJpHarCI3PMsmCXib4rW0UCMLELg4Ta6lFwCJXw=;
        b=iPJJyuSBHXq73gsz9nAQjbOFPX8y+XTT0n439bPFzLCSYRM8h0qBkKSEZuRPSs9Xp6
         xyFkvCr8OT7fipa0Fzxi2w4lCz6KukP+PnUkaU6jPAOgOhGQbZ52m+hiQKYVLuq3Juso
         XYVeAx4KnoYqwcfGQO9B7B9YVVOO3ue9NZ5wwLu4RRnEUb9IF/DE9CYJY65UZ0sKDjtC
         lERDL1KhC1/sXXv1QiQsK5ImfZm6GC2vQy2u1tU9dSGE+t54gipr2B5BzRcA+QoZwJRJ
         EBQh9YqAXbiLMcrX5KIh6pEQqlz0X8sfIHj3yeLtADj0o+tOAosoul+JKkZeqOvamp6N
         qofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYp3IJpHarCI3PMsmCXib4rW0UCMLELg4Ta6lFwCJXw=;
        b=DgAftFPn9LkSFTOwAWGuslzno30fD52FRJXd5pzkqvxnhoLeiqyhBAX+v0VYELlRb2
         X3IHin04iKgtpmxSsmfCK8eBUDgtRZIcGJ963CFVYBzHRHlfXORybrDNP9jKRC65kzfK
         /Q6iib5oN3LS+Ea0k5mXVw0eFWl3ouNerejbzuT/a6t2pmG5/denH24awUDrpuVfrNC3
         N/DbTVBwh/rBAGTme19kiJH8pdbM5XC+6tYBNEs8RvaYyK8/qvzucyV3tfWkYX3Clf2x
         YeiBSpFBiTvnMFuFF+JHo1CuhS5mMSmqZ6O1MNybga654gBcw6MKSj2oEEse3HykEzB2
         rb1w==
X-Gm-Message-State: AOAM532fC+FK7J/imYvo41yatulqu6lmClMDjoZE80dOBNlkKkuXRahZ
        ofke2AMCBDaD32JeTyiTh1nUcwgix0XgQQ==
X-Google-Smtp-Source: ABdhPJwH0j2oqPW8N/YGD1QKnKs3ya8GkEs/eQtP7I/uCZGP8QIlaV/tdLJ3GYp4j+v/Hl96S9WbcQ==
X-Received: by 2002:a05:6000:2c3:: with SMTP id o3mr11197880wry.214.1632309602856;
        Wed, 22 Sep 2021 04:20:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d70sm1679165wmd.3.2021.09.22.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 04:20:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/7] test-lib tests: assert 1 exit code, not non-zero
Date:   Wed, 22 Sep 2021 13:19:52 +0200
Message-Id: <patch-v4-6.7-1e0a49c1a70-20210922T111734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g9f062250122
In-Reply-To: <cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com>
References: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the testing for test-lib.sh itself to assert that we have a
exit code of 1, not any non-zero. Improves code added in
0445e6f0a12 (test-lib: '--run' to run only specific tests,
2014-04-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index cdadc0c7fc2..56ee927f0c4 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -11,8 +11,8 @@ write_sub_test_lib_test () {
 }
 
 _run_sub_test_lib_test_common () {
-	neg="$1" name="$2" # stdin is the body of the test code
-	shift 2
+	cmp_op="$1" want_code="$2" name="$3" # stdin is the body of the test code
+	shift 3
 
 	# intercept pseudo-options at the front of the argument list that we
 	# will not pass to child script
@@ -48,33 +48,30 @@ _run_sub_test_lib_test_common () {
 		GIT_SKIP_TESTS=$skip &&
 		export GIT_SKIP_TESTS &&
 		sane_unset GIT_TEST_FAIL_PREREQS &&
-		if test -z "$neg"
-		then
-			./"$name.sh" "$@" >out 2>err
-		else
-			! ./"$name.sh" "$@" >out 2>err
-		fi
+		./"$name.sh" "$@" >out 2>err;
+		ret=$? &&
+		test "$ret" "$cmp_op" "$want_code"
 	)
 }
 
 write_and_run_sub_test_lib_test () {
 	name="$1" descr="$2" # stdin is the body of the test code
 	write_sub_test_lib_test "$@" || return 1
-	_run_sub_test_lib_test_common '' "$@"
+	_run_sub_test_lib_test_common -eq 0 "$@"
 }
 
 write_and_run_sub_test_lib_test_err () {
 	name="$1" descr="$2" # stdin is the body of the test code
 	write_sub_test_lib_test "$@" || return 1
-	_run_sub_test_lib_test_common '!' "$@"
+	_run_sub_test_lib_test_common -eq 1 "$@"
 }
 
 run_sub_test_lib_test () {
-	_run_sub_test_lib_test_common '' "$@"
+	_run_sub_test_lib_test_common -eq 0 "$@"
 }
 
 run_sub_test_lib_test_err () {
-	_run_sub_test_lib_test_common '!' "$@"
+	_run_sub_test_lib_test_common -eq 1 "$@"
 }
 
 _check_sub_test_lib_test_common () {
-- 
2.33.0.1225.g9f062250122

