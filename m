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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A7AC6377C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60B761263
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhGUWSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhGUWRz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:17:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE27C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d2so3878776wrn.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trXAgveWKvc/T7VHAkLmpfOcSo7Zd8J0v99WO/Opktk=;
        b=PuX/brNBDB3joCl20CEjkUJwEZeuICvacVPfieb9T8uH11M/ahwlmiMJc/9sXi+9SV
         qF3kqwqiVlAVxvRFKsmWEhCx7K+0dCeb9eQScnnzCNVcLUp+WfUqI4WIaGWx5sqBUkhc
         xiCCWPc25HogAmKyzLfPFNXzuFilEawxZhJh7Dk5RcTJBqUYjNSVUb3y+bBWOjIuA8e6
         T7AHo2cAj4rQDnjZ68RZXsi3J2x0lPGg1Dr+9Nb9LHT8cXh2Fs6aDpiqagdKS+80WnNw
         HMDPyPa7pcXR+/oToklDv+hQjDyYPKS2i9X+PcidvL7/TiZuNpQFpwyVNc12TF2UccDr
         8cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trXAgveWKvc/T7VHAkLmpfOcSo7Zd8J0v99WO/Opktk=;
        b=FAzCYR8m/HZ+Tpe3pz8JYhNJ7e7dMyA+aTfYeYUmTO4k/jwkF/f4gGvqYpvMWyCXpo
         EjTDPVQ5wr2FofYYd/dRxNUgYr/+RxvwB4QBt58m7DCfAz7C7e0olrBOLUJyCNfdq8Pm
         oSdig4iRkzuL4TIKp7cjhEpZ1qi/JjfuRkEYa7biw2/IP4LDnWOwApb3jLb5zD98O8cl
         e/60hdx2AozJlg4VLe3Ne85/38NBc2la4J5Bvc/PCJ7qzf/G7qAFqyYVQdLFKtZUYhsR
         wSkcLwNu8y87yd4D/ImjARAOGH1l9DtRelpx5cVsSnAfYK3h7yJxlLXn6BOP+/3ud7dw
         /+4g==
X-Gm-Message-State: AOAM531PiBXvv52PAo+nsSSHwiVUxLmd7zZ1HmKJ79cxAI/9U/4EFDUX
        WOTRlaqnUYtlux7BzpoQ16VT+pNGhJaw6g==
X-Google-Smtp-Source: ABdhPJzSQaDyPQMds9K4iG+EbEFWPQGRzGuua1u4rBsLiKy6L8L1oBB+wyLwT65P+hWFb1YPsth/ug==
X-Received: by 2002:a5d:55c1:: with SMTP id i1mr45522636wrw.77.1626908310024;
        Wed, 21 Jul 2021 15:58:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g18sm23129818wmk.37.2021.07.21.15.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:58:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] test-lib tests: refactor common part of check_sub_test_lib_test*()
Date:   Thu, 22 Jul 2021 00:57:46 +0200
Message-Id: <patch-7.8-ae0226e164c-20210721T225504Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com> <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the two check_sub_test_lib_test*() functions to avoid
duplicating the same comparison they did of stdout. This duplication
was initially added when check_sub_test_lib_test_err() was added in
0445e6f0a12 (test-lib: '--run' to run only specific tests,
2014-04-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 96a4e6e259a..2fde75e8863 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -109,18 +109,22 @@ run_sub_test_lib_test_err () {
 	_run_sub_test_lib_test_common '!' "$@"
 }
 
+_check_sub_test_lib_test_common () {
+	name="$1" &&
+	sed -e 's/^> //' -e 's/Z$//' >"$name"/expect.out &&
+	test_cmp "$name"/expect.out "$name"/out
+}
+
 check_sub_test_lib_test () {
 	name="$1" # stdin is the expected output from the test
-	test_must_be_empty "$name"/err &&
-	sed -e 's/^> //' -e 's/Z$//' >"$name"/expect &&
-	test_cmp "$name/"expect "$name"/out
+	_check_sub_test_lib_test_common "$name" &&
+	test_must_be_empty "$name"/err
 }
 
 check_sub_test_lib_test_err () {
 	name="$1" # stdin is the expected output from the test
+	_check_sub_test_lib_test_common "$name" &&
 	# expected error output is in descriptor 3
-	sed -e 's/^> //' -e 's/Z$//' >"$name"/expect.out &&
-	test_cmp "$name"/expect.out "$name"/out &&
 	sed -e 's/^> //' -e 's/Z$//' <&3 >"$name"/expect.err &&
 	test_cmp "$name"/expect.err "$name"/err
 }
-- 
2.32.0.955.ge7c5360f7e7

