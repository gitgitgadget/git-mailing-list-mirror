Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C81EC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 04:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DEEA613B1
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 04:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhHPE6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 00:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhHPE6j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 00:58:39 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ABCC061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 21:58:05 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id db14so8680255qvb.10
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 21:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxoAm1FmNCLPP2lRxljSqN308rt+59wloeMaA4IsYlE=;
        b=tTPN7f0iGhwdlMuKRSrYNMolMrHdz6fQ6YtYuj16YO+FvjpaXe2hibhZ1bcWeTpvIM
         tj5+mY4CPe2K7UyE5C5H6Gf9ImC/lBISvOajRKkUVvW3RhdgfQegLB7cpBQUshKHnrv2
         4cuoAYZB6F0gFpYpC2AHE6rKmXtJqlA4vfuzmSxWwK3nIr3gXf2HYpBu3+RCKZOQ9LZc
         Ye07NM0XFFL3zLSH2cA+BkG2qwkp8S8WGDj2erbXiqtCKfYrPqc/wihoJHplMROu/F/0
         HhnlgwtO8/+zI0pOxa4Uc7dqmbPPbrbtuWdUeimm1Bxhl6lwcK6HWPQqDUG6ERTtZSbu
         TOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxoAm1FmNCLPP2lRxljSqN308rt+59wloeMaA4IsYlE=;
        b=cvP6YVHgfcpyUS6+eT+A+A1P/M2avninNSlwsfiX9SQhYjsXXyizIdafqRO3wITIcX
         tuTj5PIhTtKiZq38JWZV8aShoGHj+KSljjXD83mg+NrUOxT1KYJrZtQQCnKbdwQmWAP8
         hIY/GJbG6hLFR9SBq2wRtfv1LTpNXzuufiKF5c2n207r/IXnmZN9R0LDgOrJO4BEarDK
         e6EOX+b4OsZP3pEnEOTOsNhj9ufR4EDSpZCW2wxmyQGMvIWKlE7ccCfH6E/GKAUbZ5gs
         SM5LO5E+EvOnTjx6v1c5H8W0fz+94dFXBb1CVt5VuiyI1oXikP9Ugs2EjyA+yHmPk/gJ
         RREw==
X-Gm-Message-State: AOAM530Us1EKgOgDlfXQIf+SbH3dwmLTC9pqGb8V5ZWYd8Sdj8loam7U
        8VriY8CboGKdz5PmiONxU8B/TV/F7+U=
X-Google-Smtp-Source: ABdhPJwWbtaRQnee9Atni6J8WuSDE72OSi2gn3Hy2LVcxMrGsAl6ZIWaVJ5AdmGH3QG+xlA1JW4pSA==
X-Received: by 2002:a05:6214:1933:: with SMTP id es19mr14338411qvb.42.1629089882963;
        Sun, 15 Aug 2021 21:58:02 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h140sm5968194qke.112.2021.08.15.21.58.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 21:58:02 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] ci: add job for gcc-4.8 to GitHub Actions
Date:   Sun, 15 Aug 2021 21:57:50 -0700
Message-Id: <20210816045750.36499-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.476.g1b09a32a73
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unlike the other jobs; using an older ubuntu base image that provides
that compiler as an option.

note the obsoleted travis job used an image of the OS that is EOL and
therefore not available, but the compiler used will be the same, and
more importantly will fail in the same (C89 compatibility) issues.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
based on top of my tip for cb/reftable-fixes, but applies cleanly all
the way to maint.

a succesful run can be seen in:

  https://github.com/carenas/git/runs/3336674183

it adds 2m to the current setup, but gcc 4.8 is hard to find in modern
developer workstations (or even non EOL enterprise systems)

 .github/workflows/main.yml | 3 +++
 ci/install-dependencies.sh | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 73856bafc9..0f211173fc 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -297,6 +297,9 @@ jobs:
           - jobname: linux-gcc-default
             cc: gcc
             pool: ubuntu-latest
+          - jobname: linux-gcc-4.8
+            cc: gcc-4.8
+            pool: ubuntu-18.04
     env:
       CC: ${{matrix.vector.cc}}
       jobname: ${{matrix.vector.jobname}}
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 67852d0d37..950bc39129 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -72,10 +72,14 @@ Documentation)
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
 	;;
-linux-gcc-default|linux-gcc-4.8)
+linux-gcc-default)
 	sudo apt-get -q update
 	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
 	;;
+linux-gcc-4.8)
+	sudo apt-get -q update
+	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS gcc-4.8
+	;;
 esac
 
 if type p4d >/dev/null && type p4 >/dev/null
-- 
2.33.0.rc2.476.g1b09a32a73

