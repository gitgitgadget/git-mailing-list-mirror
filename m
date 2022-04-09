Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A897C433EF
	for <git@archiver.kernel.org>; Sat,  9 Apr 2022 12:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbiDIMat (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Apr 2022 08:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiDIMas (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Apr 2022 08:30:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2986245
        for <git@vger.kernel.org>; Sat,  9 Apr 2022 05:28:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z1so16570453wrg.4
        for <git@vger.kernel.org>; Sat, 09 Apr 2022 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=zRD4jqsG/KRFdORdvTzEYyQdrniiHZsO1KtEATTFAHg=;
        b=i9Q46JRjMyQE4ku+jxzMLS4UxKk14GZICGZ1uTemnxv66FaFrkB+5kFnUWCIi6FhW8
         iJ41eOu5BhlxsF0OaSCc66s3Le0jsXmMmY0dMFp+FfN5JZ285CEQp90yMAv+tbTtX1yl
         8N6w3+zi2k68cno7urGOfZ0D/EdYMM0RWheZApUgY+Ju136I0PtIAnAbI/EJdxDnQf+S
         DNpHFviGlmIq5OFKfWSfKA98BhRxLg0yUZsU0nhc2UZnNDIgmNxVmPopJsvpLM5n1bpo
         c1D7qhkzJX5wgdPE6AegLGubIPwDGdG495oQ8zmmBO2zoa6wA45c5vvhF3MJtfGHJXO4
         KnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zRD4jqsG/KRFdORdvTzEYyQdrniiHZsO1KtEATTFAHg=;
        b=LIDU8NyECVjXMjV02o6F2A2itehnQHukcY4uRvlBRxPwF5oXtTSbg/cmLMobMI9zSf
         1V0jw1hHy46OkL5WU8RHh9lWKklHvljtTz8RPEUklgbQy9lypfcz/UPAdNlNInwm4JWJ
         hNpAs++fAvSy6DBVP2PW1uA3SgFZuqiSS60pCEHdc3lEI7LBvaivztp8hZ31dnHI+WR0
         d/D6kmheRCTKaHyqekY8oFEgt3qBhY7sxUcT6c1TDixFMJ4uF/dg2hsdvbyCXvH9kzgH
         FonjzHf/HPGssqH7XuJY0dsbTQSywuOxZ3mAVxL3weHy9oBa3DZxhFFcjrUT/eVfCBqn
         lYWw==
X-Gm-Message-State: AOAM531G79RChfji4OA1gg3l9AXHaCuF5dgRQg/Y6yKypGGes9fch7IV
        rntqdZB2s3dQwFVYOKM1OPq1G4rwD9Y=
X-Google-Smtp-Source: ABdhPJxRxHRUllZKVWvazN3KP7uRKuOd/okreygFtNy6MD72B0C6fzeOC6g3CGBEB62S3Cc15YGsjw==
X-Received: by 2002:a05:6000:15c5:b0:207:8fed:f1f1 with SMTP id y5-20020a05600015c500b002078fedf1f1mr7536358wry.316.1649507319471;
        Sat, 09 Apr 2022 05:28:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b0038c7d1086a7sm13874974wmq.1.2022.04.09.05.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 05:28:38 -0700 (PDT)
Message-Id: <pull.1210.git.1649507317350.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Apr 2022 12:28:37 +0000
Subject: [PATCH] tests: make SANITIZE=address imply TEST_NO_MALLOC_CHECK
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elia Pinto <gitter.spiros@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As the address sanitizer checks for a superset of the issues detected
by setting MALLOC_CHECK_ (which tries to detect things like double
frees and off-by-one errors) there is no need to set the latter when
compiling with -fsanitize=address.

This fixes a regression introduced by 131b94a10a ("test-lib.sh: Use
GLIBC_TUNABLES instead of MALLOC_CHECK_ on glibc >= 2.34", 2022-03-04)
which causes all the tests to fail with the message

    ASan runtime does not come first in initial library list;
    you should either link runtime to your application or
    manually preload it with LD_PRELOAD.

when git is compiled with SANITIZE=address on systems with glibc >=
2.34. I have tested SANITIZE=leak and SANITIZE=undefined and they do
not suffer from this regression so the fix in this patch should be
sufficient.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    tests: make SANITIZE=address imply TEST_NO_MALLOC_CHECK
    
    I'm submitting this now as it fixes a regression introduced in the
    current cycle. Having said that there is an easy workaround (once one
    has discovered GIT_TEST_NO_MALLOC_CHECK) so I'd be happy to wait until
    the start of the next cycle given I've just missed -rc1.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1210%2Fphillipwood%2Fwip%2Ftest-malloc-asan-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1210/phillipwood/wip/test-malloc-asan-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1210

 Makefile      | 5 ++++-
 t/test-lib.sh | 5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 91738485626..76d187991d2 100644
--- a/Makefile
+++ b/Makefile
@@ -1267,8 +1267,9 @@ PTHREAD_CFLAGS =
 SPARSE_FLAGS ?= -std=gnu99
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
-# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak target
+# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak,address targets
 SANITIZE_LEAK =
+SANITIZE_ADDRESS =
 
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
@@ -1314,6 +1315,7 @@ SANITIZE_LEAK = YesCompiledWithIt
 endif
 ifneq ($(filter address,$(SANITIZERS)),)
 NO_REGEX = NeededForASAN
+SANITIZE_ADDRESS = YesCompiledWithIt
 endif
 endif
 
@@ -2861,6 +2863,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
 	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
+	@echo SANITIZE_ADDRESS=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_ADDRESS)))'\' >>$@+
 	@echo X=\'$(X)\' >>$@+
 ifdef FSMONITOR_DAEMON_BACKEND
 	@echo FSMONITOR_DAEMON_BACKEND=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 531cef097db..f09e8f3efce 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -535,9 +535,10 @@ case $GIT_TEST_FSYNC in
 	;;
 esac
 
-# Add libc MALLOC and MALLOC_PERTURB test
-# only if we are not executing the test with valgrind
+# Add libc MALLOC and MALLOC_PERTURB test only if we are not executing
+# the test with valgrind and have not compiled with SANITIZE=address.
 if test -n "$valgrind" ||
+   test -n "$SANITIZE_ADDRESS" ||
    test -n "$TEST_NO_MALLOC_CHECK"
 then
 	setup_malloc_check () {

base-commit: faa21c10d44184f616d391c158dcbb13b9c72ef3
-- 
gitgitgadget
