Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55401C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 10:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379840AbhLCKXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379807AbhLCKXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 05:23:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EA2C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 02:20:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j3so4704447wrp.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gvKMxbh5Ykh3AQGwQMKjt2JaD1jiPJKU+L1UbV4sYhk=;
        b=kjT5KrlbO0tuONQHUC0+lDxSmb3IBuXBkBHL+azXFH5D51JVM3sU51gwjC1Rl7XpuN
         caEiP2dlxuu0acFTgNkXi8RUQtK6hqGZ88CDYOkX4jUx3zc0sPwNrdeFSZpOI+eV2UJh
         vtp5oMyECbsikjj25JGH76bRGkYa8BAbO28rd1615Noo/1ZSWwQ3uOihucBVxkUBkZm8
         CpJDDbjfoPL/bY6hCdUJkRDA04lQU8cR7ygUSeSWpaKpHu3oh5l8gndeEqeBk9qEtl4S
         g/KP7CVlgiz/EOHsVJ7uGmlPHzCJIcIRwSDpluZ6hI6Ero+dHQTgfGhGcvPEUcFxZdPK
         Rx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gvKMxbh5Ykh3AQGwQMKjt2JaD1jiPJKU+L1UbV4sYhk=;
        b=YbG6oOnlxLYljQtyH+LyA3B9YmnGP1RXhonyd1DEYM53ZJeQxu9dhbsibO+cVJs1qs
         kUdQSR7EeyWHWiqZ8Nga6HUou9rV6G0cRolCeDHuwe4qu8Lz7/8MYDG1pAHAecX8NQow
         EksB6eKSGzdAJB5gh3IIjbO3xZ0/sOKeX6Tglsb6BNy1+LQEsO7kk9xR3L+c5lBxUDCX
         CfTa8gXuGW2SRQtGSA/wPqaLmjPWrKU7jSJA23H9avudOHy7WkG4hI1ErdwjzpO0VPmM
         7/9gXKCKAnuskxTRyBV9Ksa2x8aAsQWSlIF4K7hLPn2VaMOkRfnWTH1VkopcQh7oo8Dd
         SGmw==
X-Gm-Message-State: AOAM532rxNxl+rzj74+fi+B5att8b8EYCK1HnKz8a8DGbOMe8rkz8SaP
        1WCD5EHHWUpRDV8nhw/ru0AqzjXMkHJrHw==
X-Google-Smtp-Source: ABdhPJzAnfOSWgxEuWMM0LfkYdqM3EYDyzafNccnXTqwHF9i6274WJur3wZ2eSHepbaZFQ+zjCgN3g==
X-Received: by 2002:adf:ed52:: with SMTP id u18mr20618117wro.609.1638526808374;
        Fri, 03 Dec 2021 02:20:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r8sm2798448wrz.43.2021.12.03.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:20:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/7] log tests: check if grep_config() is called by "log"-like cmds
Date:   Fri,  3 Dec 2021 11:19:49 +0100
Message-Id: <patch-v4-2.7-f853d669682-20211203T101348Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.875.gb925cffed1e
In-Reply-To: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests added in my 9df46763ef1 (log: add exhaustive tests
for pattern style options & config, 2017-05-20) to check not only
whether "git log" handles "grep.patternType", but also "git show"
etc.

It's sufficient to check whether we match a "fixed" or a "basic" regex
here to see if these codepaths correctly invoked grep_config(). We
don't need to check the details of their regular expression matching
as the "log" test does.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7884e3d46b3..11bb25440b0 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -449,6 +449,30 @@ test_expect_success !FAIL_PREREQS 'log with various grep.patternType configurati
 	)
 '
 
+for cmd in show whatchanged reflog format-patch
+do
+	case "$cmd" in
+	format-patch) myarg="HEAD~.." ;;
+	*) myarg= ;;
+	esac
+
+	test_expect_success "$cmd: understands grep.patternType, like 'log'" '
+		git init "pattern-type-$cmd" &&
+		(
+			cd "pattern-type-$cmd" &&
+			test_commit 1 file A &&
+			test_commit "(1|2)" file B 2 &&
+
+			git -c grep.patternType=fixed $cmd --grep="..." $myarg >actual &&
+			test_must_be_empty actual &&
+
+			git -c grep.patternType=basic $cmd --grep="..." $myarg >actual &&
+			test_file_not_empty actual
+		)
+	'
+done
+test_done
+
 test_expect_success 'log --author' '
 	cat >expect <<-\EOF &&
 	Author: <BOLD;RED>A U<RESET> Thor <author@example.com>
-- 
2.34.1.875.gb925cffed1e

