Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D28C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 12:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiLGMDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiLGMDd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 07:03:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AEC30F4B
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 04:03:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id b2so13413064eja.7
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 04:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K+rDcoybi1LIw52S+cKQ43ThTt1fD4L33OtLBMzpHc=;
        b=YANxVQooBZZZ0KlYycDgv1W80s++0PcN3ptoLyXYOrEMzbX4qolZMsM5o/Dqh1qWKJ
         dgJdCq8OweioyUi2roVrFooTPP8YW27Emfx2J2PclsZ3vhxs5UoSv6TaKj0OCbKETFSJ
         VvueosJsg7yYpkQhQmMGhMGH8uktpzi6aVOy8eyfv9iHo3kZ6jc8SHCijgGKVF2Aj5Mh
         YqZE3xr3AM5f+guzwUO9pQIZLSQnIcPgzfRL65SuYQwqhg0CDZXd+cgjSgXvxmW7QU6a
         Lg2HP2y/93j2aphR+HzEe4Ci8SYk/J9P+MR3/pqKHmP6QlCVkJ9uAJYTES/huGBoTdXj
         MQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K+rDcoybi1LIw52S+cKQ43ThTt1fD4L33OtLBMzpHc=;
        b=3WY7wxhlbo+ZNQiBg7SAVqvKoXFRrAop+VecEG6n2qvkxseMv8iNCQDoezpzrMQFU7
         7rAJZcf82fbMq+aCj133DPhdwL/7xxV0nATuO+01b7yDGhNZCMmmVur8hEiei7QMxZgr
         troHMlyVvR1VzHOQjnGNoHzlrhlBZ9Beryqnqudtg0fGhXEXAaVzo3HbRpu16TRA/3E9
         Ok0G7GlWlQCdhK1zDC58gCuumXodiv0xDXM7MJy+hHJuI6VM1IG2cZFVTlKhfrTw89U0
         rlJxZDb49UAZhIPLhtsUYl4jhPlEi1zHbQoX8c7mhw80XjipHORXORK9FL+LkqmusdEr
         Sm1g==
X-Gm-Message-State: ANoB5pnGHe5AvSiKctfE05brM0xDd46pu6XYIIXTHc+MCc+dKrECKTb7
        f62nTCbTx8lfzRXy3HNZw4WedMqJ7mM6Pg==
X-Google-Smtp-Source: AA0mqf4YJl0Gn7359VkgfVTdvg/F24EcTZj50zd/V/vc2D/oc6wy9JYo5NdaZg65A6sBxBivo2eEqA==
X-Received: by 2002:a17:907:2b23:b0:7c0:cd83:1b51 with SMTP id gc35-20020a1709072b2300b007c0cd831b51mr17418971ejc.397.1670414608394;
        Wed, 07 Dec 2022 04:03:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ky20-20020a170907779400b007c0ac4e6b6esm7632733ejc.143.2022.12.07.04.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 04:03:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] CI: don't explicitly pick "bash" shell outside of Windows, fix regression
Date:   Wed,  7 Dec 2022 13:03:15 +0100
Message-Id: <patch-v2-1.1-c34fd06623a-20221207T120220Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1019.gce04d262ea9
In-Reply-To: <patch-1.1-08dc682926a-20221207T031459Z-avarab@gmail.com>
References: <patch-1.1-08dc682926a-20221207T031459Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "js/ci-github-workflow-markup" topic was originally merged in
[1] it included a change to get rid of the "ci/print-test-failures.sh"
step[2]. This was then brought back in [3] as part of a fix-up patches
on top[4].

The problem was that [3] was not a revert of the relevant parts of
[2], but rather copy/pasted the "ci/print-test-failures.sh" step that
was present for the Windows job to all "ci/print-test-failures.sh"
steps. The Windows steps specified "shell: bash", but the non-Windows
ones did not.

This broke the "ci/print/test-failures.sh" step for the "linux-musl"
job, where we don't have a "bash" shell, just a "/bin/sh" (a
"dash"). This breakage was reported at the time[5], but hadn't been
fixed.

It would be sufficient to change this only for "linux-musl", but let's
change this for both "regular" and "dockerized" to omit the "shell"
line entirely, as we did before [2].

Let's also change undo the "name" change that [3] made while
copy/pasting the "print test failures" step for the Windows job. These
steps are now the same as they were before [2], except that the "if"
includes the "env.FAILED_TEST_ARTIFACTS" test.

1. fc5a070f591 (Merge branch 'js/ci-github-workflow-markup', 2022-06-07)
2. 08dccc8fc1f (ci: make it easier to find failed tests' logs in the
   GitHub workflow, 2022-05-21)
3. 5aeb145780f (ci(github): bring back the 'print test failures' step,
   2022-06-08)
4. d0d96b8280f (Merge branch 'js/ci-github-workflow-markup', 2022-06-17)
5. https://lore.kernel.org/git/220725.86sfmpneqp.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I forgot the Signed-off-by in v1, sorry.

Range-diff against v1:
1:  08dc682926a ! 1:  c34fd06623a CI: don't explicitly pick "bash" shell outside of Windows, fix regression
    @@ Commit message
         4. d0d96b8280f (Merge branch 'js/ci-github-workflow-markup', 2022-06-17)
         5. https://lore.kernel.org/git/220725.86sfmpneqp.gmgdl@evledraar.gmail.com/
     
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
          - uses: actions/checkout@v2

 .github/workflows/main.yml | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9afacfa0b33..1a86f6a8ce1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -265,10 +265,8 @@ jobs:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
-    - name: print test failures
+    - run: ci/print-test-failures.sh
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      shell: bash
-      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -297,10 +295,8 @@ jobs:
     - uses: actions/checkout@v1
     - run: ci/install-docker-dependencies.sh
     - run: ci/run-build-and-tests.sh
-    - name: print test failures
+    - run: ci/print-test-failures.sh
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      shell: bash
-      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v1
-- 
2.39.0.rc2.1019.gce04d262ea9

