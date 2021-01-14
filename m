Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219D8C433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F3023AA7
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbhANXgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbhANXgm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:36:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC89C0613D6
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so4037690wrt.5
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tCtmgHtGnsWOu/Viqd5pWB2uBYsKnxNIFZPQRcr9rQ=;
        b=ZeIfr2Dkct+QWjyEXd6402l3Bke9vz5Hm85+9ossFfVi3qGeEYP5FPL2/Voiz2Ttii
         OPNEir+A20rQ6kDjFm1X8DDxaCFJzS3mkrQTt65U5OAAIcB8zL4ab1N8ezsZqtww3xl0
         Yp3RJkPN3w8aH3EYHJVRefpkYTIPUECCh9pDhU1MInz/LhKXY6FZlWPadMCh0b3Fmvxz
         c+REQrWhSqqATleb9zNeHhe1dPtQ14s7x2tyDAcVPxnRwLkRCNfj+uP5v3MyvQMWKUbR
         C1j+44PzxdX/dstdiqtv3atunRo9evjJJMXma0vhyoapR4qR0j8TGACKuaXB0GHbN+hj
         jIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tCtmgHtGnsWOu/Viqd5pWB2uBYsKnxNIFZPQRcr9rQ=;
        b=pm/W+wZGpFv+IG8FBGRaklLvYW1leg9qXvpCm7eJSgYDgBUtRjCPg1fBRTZiI89RvK
         UWRRVSmxt3CUf+jTh/ZJnVPh3i/DbRnOyCb9HZLgI8bqRNArKZsezTO4OEDhNb4TNv8u
         uOdLodibfZK5NOf5xUtdys/IhWCqv/cniGQCGXq1WoOysE4Vd3E2QlFlZBsE+HS8ggFw
         IP4DlY9HwD+qJDKlhryHPCn2si4b1h80BwmGadH904M/EDPNq4JdTN8MwZ0tvK72Ot41
         BBmqXFzKIuyPqZf1joF5cmdxBuhIofJFTSeJPT0ha8+KEl37sMGATAzIjsANs+YEq+oo
         i1vQ==
X-Gm-Message-State: AOAM531dI7jvc5h7rZjNqmEmBWCRwU7Jl0QQA1YD34506oJ110mM2g/2
        j/Fi/olWJRccLY4PwkdnyXPcUD/b9ecz9Q==
X-Google-Smtp-Source: ABdhPJwAwVpRUKoqdJwahMr8YpmSCeP02EgmuII64NyzB9cT368/vDYJyDHzCT8AXu3WsNSdqjAubQ==
X-Received: by 2002:a5d:6206:: with SMTP id y6mr10511745wru.413.1610667328040;
        Thu, 14 Jan 2021 15:35:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d13sm12352118wrx.93.2021.01.14.15.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:35:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] tests: split up bash detection library
Date:   Fri, 15 Jan 2021 00:35:14 +0100
Message-Id: <20210114233515.31298-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20191115040909.GA21654@sigill.intra.peff.net>
References: <20191115040909.GA21654@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the detection for whether we're running under bash, and
whether it's the /bin/sh POSIX-y mode or the /bin/bash bash-y mode
into its own library.

This will soon be used very early in test-lib.sh itself to check for
the /bin/bash, so let's make this new file as small as possible.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-bash-detection.sh | 8 ++++++++
 t/lib-bash.sh           | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 t/lib-bash-detection.sh

diff --git a/t/lib-bash-detection.sh b/t/lib-bash-detection.sh
new file mode 100644
index 0000000000..8fbdae1d52
--- /dev/null
+++ b/t/lib-bash-detection.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+TEST_SH_IS_BIN_BASH=
+if test -n "$BASH" && test -z "$POSIXLY_CORRECT"
+then
+	TEST_SH_IS_BIN_BASH=true
+	export TEST_SH_IS_BIN_BASH
+fi
diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index b0b6060929..8fd06d2e58 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -2,7 +2,9 @@
 # to run under Bash; primarily intended for tests of the completion
 # script.
 
-if test -n "$BASH" && test -z "$POSIXLY_CORRECT"
+. ./lib-bash-detection.sh
+
+if test -n "$TEST_SH_IS_BIN_BASH"
 then
 	# we are in full-on bash mode
 	true
-- 
2.29.2.222.g5d2a92d10f8

