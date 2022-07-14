Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF9FC433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbiGNTkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240635AbiGNTkB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:40:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52441D32C
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:40:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v16so3880627wrd.13
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6UJdv3K0kTgAA6wYDJ3g8i+QiAw7NGl4foKsXfp8768=;
        b=P/25D0u7NsehC+0ggUmfluslhUuYLsswskf+EQ/5RuSYB8VH7q2kB4HVaxruKUxCZv
         tSTFvs+zeacgidv3BJPfd32Mt11tCdYvV9Ox5oZgHyRuAFXFCw9EB3rdbELMpO7md5LY
         6d9c3vdEEnnrX9D3DHWt3Zw9s+dsPko7BzOeLoMKOUs6h+QnszZNJaWhT3zy26rV9bnW
         lMTQfAeCl6pb39yhyuyMMUScsOHDInmEKwHLTSmlKjY33Hu0HhYoR0rD0ek98AWyirxX
         alI8iru81DaKb/8yYbVBVZvREhqzIalycV6zJeSLoHE/0dtTH908y1UENkBKid7qkdYP
         K9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UJdv3K0kTgAA6wYDJ3g8i+QiAw7NGl4foKsXfp8768=;
        b=VKvTWkFXF92NNuWSHwq8qBAlMksod8SkeeaAzfoz+VXgp69k8Nho00YgKyRWEachP+
         OlKYOnqorv9gHKvU/uYuSHEtiCMGhmvd86p0FR7N8ybbuU6edVhBz2CkEj7Rk+3bcyly
         2HvzRh1nF5Hub6SUEYvHB0vYa0r8Ubu7yIJWCphWOEPL96dTC1GndBrMK8vxim1L+4fE
         9gqTD5QXSH9kxv++UV+tkyHDcP+cYJKWoPx/uLZ4Evrpj71Z5wp7ohbZhyJSGHo2v4WD
         4qjoxsoD9KVljSS6uvnzW1mTQuWPXtAN62IKyCg79xOzS0LJ0pZNqhvWISoto6AF+mAb
         yp6g==
X-Gm-Message-State: AJIora8i6lAsSwILM+5nBj6PMlD6g1neoxoB0+a8xn15tOpBAZGOHtDT
        0tRFeVOiwjeO5vJW/KsM4FZQcbIlGQzXhg==
X-Google-Smtp-Source: AGRyM1tI8Rx93QbfpM/4Mb+HDdRBK5lpw1YGThHI2rLaGenYsQEH2YbFzIckKFp8N8LZU6attRJMfw==
X-Received: by 2002:a5d:6c67:0:b0:21d:b9bf:5e1c with SMTP id r7-20020a5d6c67000000b0021db9bf5e1cmr9703737wrz.133.1657827599047;
        Thu, 14 Jul 2022 12:39:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600018c900b0021dac657337sm2145145wrq.75.2022.07.14.12.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:39:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] CI: consistently use "export" in ci/lib.sh
Date:   Thu, 14 Jul 2022 21:39:43 +0200
Message-Id: <patch-06.10-7cbf8191105-20220714T193808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.996.g651fc6e809f
In-Reply-To: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "ci/lib.sh" script to consistently use "export", for
e.g. MAKEFLAGS we were exporting it, and then assigning to it, let's
do it the other way around.

Right now this doesn't matter, since we in
e.g. "ci/install-dependencies.sh" source this file, and don't use
something like "env(1)" to retrieve these variables.

But in a subsequent commit we'll "export" these variables through a
wrapper (and to eventually write them to a GitHub CI-specific
$GITHUB_ENV file). This change makes that subsequent change easier to
read, as it won't need to do any control flow refactoring.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 3591919ba44..44039152ebc 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -79,7 +79,7 @@ export TERM=${TERM:-dumb}
 NPROC=10
 
 # Clear MAKEFLAGS that may come from the outside world.
-export MAKEFLAGS=--jobs=$NPROC
+MAKEFLAGS=--jobs=$NPROC
 
 if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
 then
@@ -88,9 +88,10 @@ then
 	CC="${CC:-gcc}"
 
 	export GIT_PROVE_OPTS="--timer --jobs $NPROC --state=failed,slow,save"
-	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
+	GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
 	test Windows_NT != "$AGENT_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+	export GIT_TEST_OPTS
 elif test true = "$GITHUB_ACTIONS"
 then
 	CI_TYPE=github-actions
@@ -118,9 +119,10 @@ then
 	}
 
 	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
-	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
+	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+	export GIT_TEST_OPTS
 else
 	echo "Could not identify CI type" >&2
 	env >&2
@@ -187,6 +189,7 @@ linux-leaks)
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+export MAKEFLAGS
 
 end_group
 set -x
-- 
2.37.1.996.g651fc6e809f

