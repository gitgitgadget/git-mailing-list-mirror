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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D3EC43214
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957AB60E96
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhHDXGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbhHDXGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:06:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020BFC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:05:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so2399566wmg.4
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPnk6SJwSrsZeiy9174R4Hp0C+F9a1hHLxpuBvicQmo=;
        b=fgFo9hQCk6igwsCWJbytogmINInzX/IryIBuGz+Yjvj7+PEUVGZvLYVh7AAJccBMa/
         r3zn82pHsCs0wpv/gkpuke3a/6oi/4spbA3NMmgSuxv3l6cwZmFQJo+XmnbEpbwbUTOF
         B9boZZ1N16pvfDu4xnocmJXeBOZABXYGZ2PV+YG90Mp8AmWVLRyHnreF2h+60oOMhEDw
         yQ4XBXKTUjs1Vn9aCF8vO+DaSxgphmrYJjuxsl36iewjuK1Sc9GV5dHCS6mDwEYxDBnA
         v1/NhEja+iLLgC5+xWQCGDO72wmuqoZzVA377dsSIZWx6Vs6s3gDhtk9DIplvvAkE1nc
         M54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPnk6SJwSrsZeiy9174R4Hp0C+F9a1hHLxpuBvicQmo=;
        b=qMI9TzoxOBp3th/4uEbYArixLIdRTLrbiGSVt1oIvY6hmxkalBu+Snt2BmhoqshN7v
         03BvRgMuoCON5k60wuhPV5kVOa4sUtWlsr1BpYobVNN++VafyAiDJfWlKnScJgeMCCaS
         klW2DPnWCWOKgb9xYD9W7UXFkfpP3w12lZL+4rzqeEVXfkW2q5Ujv2Dwc6yoHk2rgbf+
         rjHLaHfjpq0rig316v/cxShbOTWGCcPD45oEORFKeVNu179cxK0ihQZbM+DryPTTzAY8
         zkXhTaQSaJz2RjlJBzfegDktfcXYbG6TdJs2x1JT4u48WaoAl501/HDaYxIJUQy4xw/e
         5W2g==
X-Gm-Message-State: AOAM5304/rNUF2iL6iECLLxI1IRy5MbRt2zDBsO6QQ96rc449OQeoZWQ
        2lx2A2em4GqXJrDvfxNcjY0N92nvDCCVbQ==
X-Google-Smtp-Source: ABdhPJzFYmOh2Y5RzjMHaA8po9HNUYamrKkYDekPIix4ze7dmbB6C376233JLZ0J9tBgrp7aMcAQUg==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr1721099wmj.120.1628118351313;
        Wed, 04 Aug 2021 16:05:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f2sm3994917wrq.69.2021.08.04.16.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:05:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/3] test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
Date:   Thu,  5 Aug 2021 01:05:46 +0200
Message-Id: <patch-v3-3.3-74acba0f9ca-20210804T230335Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v3-0.3-00000000000-20210804T230335Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20210804T230335Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my c49a177beca (test-lib.sh: set COLUMNS=80 for --verbose
repeatability, 2021-06-29) the test suite started breaking on recent
versions of bash.

This is because it sets "shopt -s checkwinsize" starting with version
5.0, furthermore it started setting COLUMNS under "shopt -s
checkwinsize" for non-interactive use around version 4.3.

A narrow fix for that issue would be to add this just above our
setting of COLUMNS in test-lib.sh:

	shopt -u checkwinsize >/dev/null 2>&1

But we'd then be at the mercy of the next shell or terminal that wants
to be clever about COLUMNS.

Let's instead solve this more thoroughly. We'll now take
GIT_TEST_COLUMNS over COLUMNS, and furthermore intentionally spoil the
COLUMNS variable to break any tests that rely on it being set to a
sane value.

If something breaks because we have a codepath that's not
term_columns() checking COLUMNS we'd like to know about it, the narrow
"shopt -u checkwinsize" fix won't give us that.

The "shopt" fix won't future-poof us against other 3rd party software
changes either. If that third-party software e.g. takes TIOCGWINSZ
over columns on some platforms, our tests would be flaky and break
there even without this change.

This approach does mean that any tests of ours that expected to test
term_columns() behavior by setting COLUMNS will need to explicitly
unset GIT_TEST_COLUMNS, or set it to the empty string. Let's do that
in the new test_with_columns() helper, which we previously changed all
the tests that set COLUMNS to use.

Reported-by: Fabian Stelzer <fabian.stelzer@campoint.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pager.c                 |  7 +++++++
 t/test-lib-functions.sh |  1 +
 t/test-lib.sh           | 13 +++++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index 52f27a6765c..cfcc6dc04bd 100644
--- a/pager.c
+++ b/pager.c
@@ -165,6 +165,13 @@ int term_columns(void)
 	term_columns_at_startup = 80;
 	term_columns_guessed = 1;
 
+	col_string = getenv("GIT_TEST_COLUMNS");
+	if (col_string && (n_cols = atoi(col_string)) > 0) {
+		term_columns_at_startup = n_cols;
+		term_columns_guessed = 0;
+		return term_columns_at_startup;
+	}
+
 	col_string = getenv("COLUMNS");
 	if (col_string && (n_cols = atoi(col_string)) > 0) {
 		term_columns_at_startup = n_cols;
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index adc853109e4..0970c1293a8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1730,5 +1730,6 @@ test_with_columns () {
 		return 1
 	fi
 
+	GIT_TEST_COLUMNS= \
 	COLUMNS=$columns "$@" 2>&7
 } 7>&2 2>&4
diff --git a/t/test-lib.sh b/t/test-lib.sh
index db61081d6b8..fc589226189 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -415,10 +415,19 @@ LANG=C
 LC_ALL=C
 PAGER=cat
 TZ=UTC
-COLUMNS=80
-export LANG LC_ALL PAGER TZ COLUMNS
+export LANG LC_ALL PAGER TZ
 EDITOR=:
 
+# For repeatability we need to set term_columns()'s idea of
+# columns. We do this via GIT_TEST_COLUMNS and not COLUMNS because
+# e.g. versions of bash >= 5.0 have "shopt -s checkwinsize" on by
+# default. We could do "shopt -u checkwinsize >/dev/null 2>&1" here to
+# fix that particular issue, but this is not shell specific, and
+# future-proof the tests.
+GIT_TEST_COLUMNS=80
+COLUMNS=10
+export GIT_TEST_COLUMNS COLUMNS
+
 # A call to "unset" with no arguments causes at least Solaris 10
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
-- 
2.33.0.rc0.597.gc569a812f0a

