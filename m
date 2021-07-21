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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AECC6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E735761261
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhGUWR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhGUWRx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:17:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C03C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:28 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g12so2235641wme.2
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cEf1xRD2P0TRa0UR6b4B94ry55kqqrQ6cD9UNsUfTBE=;
        b=lvR5OHp1SFzcjvJBkYW1EI71oU2h6yunrmE89kOIeZJPktjGv+hBjtcBqpyBb7SA9Z
         slX1nwsNWt3Keze0UMWhrN0W46ftdxioL7ZNpA+mw+9JcOnicw9Rc2Ku/SarpFKii7UP
         lNHJHYrJsLVW9Ia0FXb68Nb4naEDcYUgJx7ASlEkIJlYhks/NGKnJvza20oQbgrqphv9
         pn8waSmqmmadL2SJ48wuDFipvRHq9FN8Gw9ba9LvOA/NuZBIx+dUKqTWbszDN0AOP943
         aBdX5abzT7wMXoIYmKdEs0pE03eJs7aI/4oI9o5w+CbtyAsJpwKX1D6kZMvURfTjpAtf
         isJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cEf1xRD2P0TRa0UR6b4B94ry55kqqrQ6cD9UNsUfTBE=;
        b=ccrqPmGuzSHvucf4l8ZrVRyxCiiuYxreC4HsoQsYYTo5GbDNTn+O9gSmtaGF1A9LK9
         xq4nE9vuMjfELxIXHX37qxWMLy9ARuTrnJutvQgXD5TuhG9mQ8z1fVYur+6p1QfJptLq
         ZsHk0C/PPoHY4k0PT0yUFm2wG9Ko/pE1iIHH6dkNx1ToBlOxBiY71exX8eEot+K9fzY0
         KQzHR2snf/pMVmIRXfqUIRA1cdCnpnmfnGWu9uHxtkryYhPKXESk2ZkUX9tm8Rn/voBe
         N5vaNVLXkS10+BP1Re5n+3U7vaGCEkMW0hBwk4o5JslH460DNUcZ0OFbNldGg6XdaUs5
         CD7Q==
X-Gm-Message-State: AOAM532aEmhgut8ZVmCWJwnz7+aGfO+49RdJEpre2Z3o2WVCdIvhhk+6
        Tx+fX2pGxtE1pdmZv7QHkGXozdbt42w0hg==
X-Google-Smtp-Source: ABdhPJxj01fxtsl14kX62ryEqgPWfV/vA2K7B2dFtd8XrOwGYXox6QOjapUrAR7JSABXK3D0ypO+Cw==
X-Received: by 2002:a05:600c:3581:: with SMTP id p1mr6303430wmq.150.1626908307006;
        Wed, 21 Jul 2021 15:58:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g18sm23129818wmk.37.2021.07.21.15.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:58:26 -0700 (PDT)
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
Subject: [PATCH v2 3/8] test-lib tests: stop using a subshell in write_sub_test_lib_test()
Date:   Thu, 22 Jul 2021 00:57:42 +0200
Message-Id: <patch-3.8-7d5ed335a36-20210721T225504Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com> <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that this function doesn't handle running the test anymore we can
do away with the sub-shell, which was used to scope an "unset" and
"export" shell variables.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 8f3f6dddcf4..727b0850e9b 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -1,20 +1,17 @@
 write_sub_test_lib_test () {
 	name="$1" descr="$2" # stdin is the body of the test code
 	mkdir "$name" &&
-	(
-		cd "$name" &&
-		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
-		test_description='$descr (run in sub test-lib)
+	write_script "$name/$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
+	test_description='$descr (run in sub test-lib)
 
-		This is run in a sub test-lib so that we do not get incorrect
-		passing metrics
-		'
+	This is run in a sub test-lib so that we do not get incorrect
+	passing metrics
+	'
 
-		# Point to the t/test-lib.sh, which isn't in ../ as usual
-		. "\$TEST_DIRECTORY"/test-lib.sh
-		EOF
-		cat >>"$name.sh"
-	)
+	# Point to the t/test-lib.sh, which isn't in ../ as usual
+	. "\$TEST_DIRECTORY"/test-lib.sh
+	EOF
+	cat >>"$name/$name.sh"
 }
 
 _run_sub_test_lib_test_common () {
-- 
2.32.0.955.ge7c5360f7e7

