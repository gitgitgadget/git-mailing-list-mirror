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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1748C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B0964DD5
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhBIW23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbhBIWXg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:23:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2FFC0698FE
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:42:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o24so64145wmh.5
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7SlsPaJHgRSLB/ATAtQygxTdFpLK4ADK+gtOv+dIx8=;
        b=XIqXyavrn4yttR4LFtsyGl3uBYVhdHJZYOPBYcvdNUzfzdbl3e2hAJey0f2/FioWu4
         bUFx8wSx//wR6V/CPT2kF5yxJjhDVFM2wLn+5FWchs5h63qCpz5Ht1cxyqFCvGb5Tf4E
         Z6lfVcw6KQ4gSv6M0hK0a42iONV+yTShEC8jnXs+Q5Qfz1BtcY/ugpbwvUXB1JUiQSTu
         UHm1cgI35YlHjXSJ7tnw53T6gPPwQSgev2Zv9lJNFSvz++83Bt7JU2R42/7GrXi6tgcI
         MhLWh2jiyKtJ0sBetA/QwKv0x8e/C7HnT3SoYf53+9N2fdGdk6LhJ749f9lq6nmhFxRq
         kFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7SlsPaJHgRSLB/ATAtQygxTdFpLK4ADK+gtOv+dIx8=;
        b=t+0gNdoqZ6wx6Bg7Y/xesPyCgirabHrCArHCFkTqXeqhmyGeYT6OcJJGAwFPoSNCyc
         tEw2xjm3z00LoSgc3389DJpGMr4XEmLf9pdkQBLZb9qJHAloQQyg/paX4sdeZNzohBY9
         xt+50Sds1bzFTxQbkBJm/T6jRnagywZiueCWH/f8FgOCnv/t1cSPSacpGrhrEiUloXUC
         E9VGaSwBFtadQFpzONX5ClPitTehLc3SA4JDZZSyCQBHlNI0L6e7LwzuGe0SHqdOeGAC
         rvQGJNa9R1q2bdfs8qFrG4EfXlblqOmCpGcOevd88by0oooJTAxQoVBQXXmy35E/flMZ
         3gVQ==
X-Gm-Message-State: AOAM530vRaP43jJ6dUl14DzVk5XEgAI0jDovLinLmhMxor/XNVrE53+7
        0TFyNOyNGAEvM0wFUMvzRfgMWL6mRUPk2Q==
X-Google-Smtp-Source: ABdhPJw8f3ib/281RvAXOOg0b15Ra8P8oKb+gtcK7Nn/6wotyrYHthBfEPGRXMrklGNpX8peMvqOzw==
X-Received: by 2002:a7b:c206:: with SMTP id x6mr91679wmi.81.1612906933111;
        Tue, 09 Feb 2021 13:42:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m205sm38710wmf.40.2021.02.09.13.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:42:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/12] test-lib: remove check_var_migration
Date:   Tue,  9 Feb 2021 22:41:48 +0100
Message-Id: <20210209214159.22815-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the check_var_migration() migration helper. This was added back
in [1], [2] and [3] to warn users to migrate from e.g. the
"GIT_FSMONITOR_TEST" name to "GIT_TEST_FSMONITOR".

I daresay that having been warning about this since late 2018 (or
v2.20.0) was sufficient time to give everyone interested a heads-up
about moving to the new names.

I don't see the need for going through the "do this later" codepath
anticipated in [1], let's just remove this instead.

1. 4cb54d0aa8e (fsmonitor: update GIT_TEST_FSMONITOR support,
   2018-09-18)
2. 1f357b045b5 (read-cache: update TEST_GIT_INDEX_VERSION support,
   2018-09-18)
3. 5765d97b71d (preload-index: update GIT_FORCE_PRELOAD_TEST support,
   2018-09-18)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 76062db2964..61bda88245c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -462,36 +462,6 @@ export GIT_DEFAULT_HASH
 GIT_TRACE_BARE=1
 export GIT_TRACE_BARE
 
-check_var_migration () {
-	# the warnings and hints given from this helper depends
-	# on end-user settings, which will disrupt the self-test
-	# done on the test framework itself.
-	case "$GIT_TEST_FRAMEWORK_SELFTEST" in
-	t)	return ;;
-	esac
-
-	old_name=$1 new_name=$2
-	eval "old_isset=\${${old_name}:+isset}"
-	eval "new_isset=\${${new_name}:+isset}"
-
-	case "$old_isset,$new_isset" in
-	isset,)
-		echo >&2 "warning: $old_name is now $new_name"
-		echo >&2 "hint: set $new_name too during the transition period"
-		eval "$new_name=\$$old_name"
-		;;
-	isset,isset)
-		# do this later
-		# echo >&2 "warning: $old_name is now $new_name"
-		# echo >&2 "hint: remove $old_name"
-		;;
-	esac
-}
-
-check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
-check_var_migration TEST_GIT_INDEX_VERSION GIT_TEST_INDEX_VERSION
-check_var_migration GIT_FORCE_PRELOAD_TEST GIT_TEST_PRELOAD_INDEX
-
 # Use specific version of the index file format
 if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
 then
-- 
2.30.0.284.gd98b1dd5eaa7

