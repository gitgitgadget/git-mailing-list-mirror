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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F72C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4433C60F11
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhIVWJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbhIVWJi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 18:09:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC1DC061757
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:08:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q11so11184078wrr.9
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNb/lz0LdCEBHKr/Jc1jyvfKiZBAglfKd7TOteUI9+s=;
        b=XAKwAWU2BgUqmAyLBxkMxjUTnsdpFdC+guX91BVwQfY57Qk2Yr87UiODHsJivb85PH
         ButP1Q3ygnxYIH08xKMZlcPUFol/QdO0/IV+AogBjjDO5UVeEeJhM2MBenQtNZChw6Oa
         UfQnT4uDI2YDuxGRGqGvPoGpIDOFX+bszcifWpxKYFCmF3LrmhBKgjUf7/BA9z1bFd5J
         Ol5pG1EXCVspn/1cIH+yreZ/GjiZt/dZYsE+SMWNtwd3FJkFci+JekHcRSHRvd4iHwrY
         MvmzkXYiXjUDSmCrknAdYxzm4CZUGvdTBbJWYmGNUgXEVuvd4lPNps8cW0EumtpTVo4E
         yM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNb/lz0LdCEBHKr/Jc1jyvfKiZBAglfKd7TOteUI9+s=;
        b=ID225Z/mBcJbOuTbc0kSNLnR/6bXQ+DbVyCMTfbnQUF2YX4oJ/ErOuxabsUja4myxK
         pETBrUIz0GX1xid5xwp3bt1JMsRu/TJ37b3+eHmuCcjsiIAASr9inaPNL6Nwsc/85rAu
         sRtnqXl5uL0W0ZfTZDYJ4t9/7sTvXoY9/fjwHsuj3ilWomzRcCQy9+3geLVSqlkdPT65
         2Zt/RIucmncy10/lfr8DH5ahWbFqDe0lyJ193xLTC+1QMLqN4vUJb4ltiBnWubmv8CTF
         6eW5ZHcnSaaqAkPhBsTTGxoNPYahoXqubYIZzwszF/mU8ZnUsN36bpZL5qkRIWzGc8HR
         bFHQ==
X-Gm-Message-State: AOAM533NeXySPyFxXGQR33EHHMkfPNMUO4QYOzPWhgIyK9a49LQgOLMR
        Op/b9B1Ly1YSZTNQHgKzaP9gcHjsL9gfQw==
X-Google-Smtp-Source: ABdhPJwQ2QNd3piuRXZOIjv2+dTtvhfmFLDGmZRjIX+dWSZGDjEXFB/mxnw2fc/GOzzEjl94o1lFLQ==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr1177044wml.179.1632348485140;
        Wed, 22 Sep 2021 15:08:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j20sm3466336wrb.5.2021.09.22.15.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:08:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work with DEVOPTS=pedantic
Date:   Thu, 23 Sep 2021 00:08:01 +0200
Message-Id: <patch-v2-1.2-31c871e9bf6-20210922T220532Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g9f062250122
In-Reply-To: <cover-v2-0.2-00000000000-20210922T220532Z-avarab@gmail.com>
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20210922T220532Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "COMPUTE_HEADER_DEPENDENCIES" feature added in [1] was extended to
use auto-detection in [2], that "auto" detection has always piped
STDERR to /dev/null, so any failures on compilers that didn't support
these GCC flags would silently fall back to
"COMPUTE_HEADER_DEPENDENCIES=no".

Later when -Wpedantic support was added to DEVOPTS in [3] we started
passing -Wpedantic in combination with -Werror to the compiler
here. Note (to the pedantic): [3] actually passed "-pedantic", but it
and "-Wpedantic" are synonyms.

Turning on -Wpedantic in [3] broke the auto-detection, since this
relies on compiling an empty program. GCC would loudly complain on
STDERR:

    /dev/null:1: error: ISO C forbids an empty translation unit
    [-Werror=pedantic]
    cc1: note: unrecognized command-line option
    ‘-Wno-pedantic-ms-format’ may have been intended to silence
    earlier diagnostics
    cc1: all warnings being treated as errors

But as that ended up in the "$(dep_check)" variable due to the "2>&1"
in [2] we didn't see it.

Then when [4] made DEVOPTS=pedantic the default specifying
"DEVELOPER=1" would effectively set "COMPUTE_HEADER_DEPENDENCIES=no".

To fix these issues let's unconditionally pass -Wno-pedantic after
$(ALL_CFLAGS), we might get a -Wpedantic via config.mak.dev after, or
the builder might specify it via CFLAGS. In either case this will undo
current and future problems with -Wpedantic.

I think it would make sense to simply remove the "2>&1", it would mean
that anyone using a non-GCC-like compiler would get warnings under
COMPUTE_HEADER_DEPENDENCIES=auto, e.g on AIX's xlc would emit:

    /opt/IBM/xlc/13.1.3/bin/.orig/xlc: 1501-208 (S) command option D is missing a subargument
    Non-zero 40 exit with COMPUTE_HEADER_DEPENDENCIES=auto, set it to "yes" or "no" to quiet auto-detect

And on Solaris with SunCC:

    cc: Warning: Option -x passed to ld, if ld is invoked, ignored otherwise
    cc: refused to overwrite input file by output file: /dev/null
    cc: Warning: Option -x passed to ld, if ld is invoked, ignored otherwise
    cc: refused to overwrite input file by output file: /dev/null
    Non-zero 1 exit with COMPUTE_HEADER_DEPENDENCIES=auto, set it to "yes" or "no" to quiet auto-detect

Both could be quieted by setting COMPUTE_HEADER_DEPENDENCIES=no
explicitly, as suggested, but let's see if this'll fix it without
emitting too much noise at those that aren't using "gcc" or "clang".

1. f2fabbf76e4 (Teach Makefile to check header dependencies,
   2010-01-26)
2. 111ee18c31f (Makefile: Use computed header dependencies if the
   compiler supports it, 2011-08-18)
3. 729b3925ed9 (Makefile: add a DEVOPTS flag to get pedantic
   compilation, 2018-07-24)
4. 6a8cbc41bac (developer: enable pedantic by default, 2021-09-03)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9df565f27bb..10ea12aae21 100644
--- a/Makefile
+++ b/Makefile
@@ -1278,6 +1278,7 @@ endif
 
 ifeq ($(COMPUTE_HEADER_DEPENDENCIES),auto)
 dep_check = $(shell $(CC) $(ALL_CFLAGS) \
+	-Wno-pedantic \
 	-c -MF /dev/null -MQ /dev/null -MMD -MP \
 	-x c /dev/null -o /dev/null 2>&1; \
 	echo $$?)
-- 
2.33.0.1225.g9f062250122

