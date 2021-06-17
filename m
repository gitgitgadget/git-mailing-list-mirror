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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1CFC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7339660FDA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhFQKoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhFQKoR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:44:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90C0C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j18so2938347wms.3
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBGjz2fkuFoI+S640MMDPBx+MIG9joqhsHVO9Ilqn7c=;
        b=pdUGF7CmKYqnKdKrLpo46CyQN6qP7Bmgoc3hS+cUVLP6qXNuEt15QyMT0fRNWbUfCe
         Pk07UAkAAovYpFbH964aOH92ffnqj8uVbbn6pzI3/FLU3ZNB1Gs5k+KGQH7E6coQ+kKU
         OyLy8ayLPfHHzhkt10fNovBEufhICGj62H+rL7s0CekSaeY7Lvs9CEjvhVVNp9FmBBeH
         4iG+mqNLBiUgmzfdHHHE9SMN2sGdSWULKd6RrgGZo0yMztzs8oe2WIdi41mUNMOkDzPG
         48JXKTbVd9mZNUaKknr4i/lcfHnk6tVbCfltGeyo96zQQy3AbKyZvxzsNj8Ob33/4Hh7
         JOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBGjz2fkuFoI+S640MMDPBx+MIG9joqhsHVO9Ilqn7c=;
        b=Jp5nqSc8fiHDnP61BGzihpkWE/lDv68Ljh3FM4vYqjDGA7XtFCp+iX8K9byoYt0/oD
         6YRngknNADyDjs1/lOvEoR9T/FIk/I7QaJqlCTv0zBtd6CbXLflX33UUdYVPeXUPfHby
         Gy+IRIRp/MV2PHOzim9Z7xbenAYMwcBGtZUmU53YyENHa/NXRhSbjImtA5u+tQXxdBDu
         EUX9IDvrf+3G+y4wNB/svkHCmiyTExtPrcvh82YNekarkjjkzEatZJIUv+PICvNVHd66
         4oRtN5xx9J9UIkHfdLmWi7eJ3XNjvydc8F/9ggPCwXY0OjhNTgHlksqSyteNWRDkdsjc
         +RHg==
X-Gm-Message-State: AOAM531HlcJ/xxcEuqUNqTD1dG9qN+/l3THd73Ci0tj8iu258jsCbv3U
        J54sDo3ZAkPi5X0tFc+D/QwjVQZA515FMA==
X-Google-Smtp-Source: ABdhPJyKZCViR89wPwUeU0QvrPtNYl2OmAh8KGqA3eo7lotHOQ+HlYX5KpDWbh3jSogrzmzfR5hCpQ==
X-Received: by 2002:a1c:7210:: with SMTP id n16mr4172204wmc.75.1623926528178;
        Thu, 17 Jun 2021 03:42:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p10sm4784607wrr.33.2021.06.17.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:42:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] mktag tests: test for-each-ref
Date:   Thu, 17 Jun 2021 12:42:01 +0200
Message-Id: <patch-5.6-f4c41be92d-20210617T104011Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com> <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "for-each-ref" for all the mktag tests. This test would have
caught the segfault which was fixed in c6854508808 (ref-filter: fix
NULL check for parse object failure, 2021-04-01). Let's make sure we
test that code more exhaustively.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 67f6ecbe88..bb71303399 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -78,6 +78,19 @@ check_verify_failure () {
 		# will always fail.
 		test_must_fail git -C bad-tag fsck
 	'
+
+	test_expect_success "for-each-ref: $subject" '
+		# Make sure the earlier test created it for us
+		git rev-parse "$bad_tag" &&
+
+		echo "$bad_tag" >"bad-tag/$tag_ref" &&
+
+		printf "%s tag\t%s\n" "$bad_tag" "$tag_ref" >expected &&
+		git -C bad-tag for-each-ref "$tag_ref" >actual &&
+		test_cmp expected actual &&
+
+		test_must_fail git -C bad-tag for-each-ref --format="%(*objectname)"
+	'
 }
 
 test_expect_mktag_success() {
-- 
2.32.0.571.gdba276db2c

