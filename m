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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62ADC48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4C3613CB
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhFIRHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhFIRHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 13:07:30 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001A5C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 10:05:24 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u11so25773103oiv.1
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GiZUDjAilGEz6vwubDd+jCtsmXE3d7jzfl/LGz6cg/s=;
        b=Rhd5zdXXD1DCcPJnj1mFRNJH08m4ICVgiKocTpyzxWf1jZ1MV8APpswqhswQl9gVB+
         z2sbrF9kkbvoUvaUSf6PECYON9JkJOV7rCV43rSM/C5pNUQcOzfwovCf49UjLPuSGbcq
         NVz4azyTxtrZgsof2oXJUwurT3Rtbsk9mCplosQo5KJlsdcdv///Su5JdCvWb2bS5bjD
         J3p05AOHaFKHiswmfQv7YQKQOdTWsgFd3J1ls+nqiUaTZAz/d2KI6PpeMyYx3Zy/FyZh
         rjOtDT7ASv7+pnRtUoi/oKC17CDxXcEKy2W2mhSh5w0OnKiuvhberK9XSFCuyBd45dZ/
         Pqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GiZUDjAilGEz6vwubDd+jCtsmXE3d7jzfl/LGz6cg/s=;
        b=Dmlplc3p+igrVPXhdhJQAev74JWIukXxc8Lpk1bEwvgJmehrf4b6DDDcAnh8iQNs1d
         p0SxZvcJ1HlGTeiGlyw3fR2D2hp45VzJ+WzCOJQwt68a181E1sEOwW3/subbRArrmgio
         UGPUR6EFvdTqaIWhLxHotOgkxCvSYVAlXEzA+8VPNVGj5kcCnAKExStZGQAXZ8SmKtbT
         CzZGDxn3DLcW2Nj5Gdxmwsw3WQZRsdl8Amsl6rUEhJDxyyTzuXq65MDoWDLL51UE2avs
         8N3nFzY+ySVo/G4r2JhaE765W66EY61FncApmzaNHJDnCLtB8EIuK5I03NM0BALEHdLN
         Tryw==
X-Gm-Message-State: AOAM530Tc0+VZy3GwwVavOzHkGxGjQO7RH+H/+qOB1xKZscI2nnTMr3P
        plLxWc3lSEzMCfph3a6eag9VWuiATHdWiA==
X-Google-Smtp-Source: ABdhPJwmxvXxYBjRnU4kmWSXE5Dd+cFaF7Td4DPCiakFA5zN0a+FgOnIR9yCRRfnRKs39HCkrejWnQ==
X-Received: by 2002:a05:6808:10d4:: with SMTP id s20mr451937ois.70.1623258324092;
        Wed, 09 Jun 2021 10:05:24 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id e29sm69715oiy.53.2021.06.09.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 10:05:23 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
Date:   Wed,  9 Jun 2021 12:05:20 -0500
Message-Id: <20210609170520.67014-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_atexit unit test relies on the specific location of the
generated files.

When TEST_OUTPUT_DIRECTORY is unset, _run_sub_test_lib_test_common sets
it to pwd, which is two levels under the pwd of the parent unit test,
and the parent can find the generated files just fine.

But when TEST_OUTPUT_DIRECTORY is set, it's stored in GIT-BUILD-OPTIONS,
and even though _run_sub_test_lib_test_common correctly overrides it,
when the child script is run, it sources GIT-BUILD-OPTIONS, and
TEST_OUTPUT_DIRECTORY is overridden.

Effectively both the parent and child scripts output to the same
directory.

  make TEST_OUTPUT_DIRECTORY=/tmp/foobar GIT-BUILD-OPTIONS &&
  make -C t t0000-basic.sh

We could simply revert 2d14e13c56 (test output: respect
$TEST_OUTPUT_DIRECTORY, 2013-04-29), but presumably it was done for some
reason.

On the other hand we could follow the alternate path suggested in
6883047071 (t0000: set TEST_OUTPUT_DIRECTORY for sub-tests, 2013-12-28):
pass the --root parameter to the child scripts.

The alternate solution works, so let's do that instead.

Presumably this was broken since 900721e15c (test-lib: introduce
'test_atexit', 2019-03-13).

Cc: John Keeping <john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t0000-basic.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 705d62cc27..16b70ef940 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -93,14 +93,12 @@ _run_sub_test_lib_test_common () {
 		EOF
 		cat >>"$name.sh" &&
 		export TEST_DIRECTORY &&
-		TEST_OUTPUT_DIRECTORY=$(pwd) &&
-		export TEST_OUTPUT_DIRECTORY &&
 		sane_unset GIT_TEST_FAIL_PREREQS &&
 		if test -z "$neg"
 		then
-			./"$name.sh" "$@" >out 2>err
+			./"$name.sh" --root="$(pwd)" "$@" >out 2>err
 		else
-			! ./"$name.sh" "$@" >out 2>err
+			! ./"$name.sh" --root="$(pwd)" "$@" >out 2>err
 		fi
 	)
 }
-- 
2.32.0.2.g41be0a4e50

