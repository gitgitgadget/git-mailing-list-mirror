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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55325C48BDF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 10:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C24D613FD
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 10:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhFXKV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 06:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFXKVz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 06:21:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1314C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 03:19:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f15so6010735wro.8
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytO1crUD48AtU1t/Tcg1EhchYBoF9l20KUtI9Rfp0v8=;
        b=TVevtdkiSdwFviVleG5a4eNtqLMIM27TM7AyHY/lEaP4hniwzL/vlmT3hGQ+INutPt
         LffKB6UTAuKtAORd370HuOZFVODwLzFPJLWRLlHp4WC6Y0c9tf3rjW04cQozr1KORCGU
         OKuqttbeQKDRfaHdbXqD4su8cxp0JLS2aDUyH/5dLp8TABhpcbIDI+RdPuE9E9MJ10/8
         S+gNNNeWclOQgh2EqbFSaYsoDK/nMnspcxl2dCrusMpcOPFjbNMV+KGIraq8bvsltQTu
         D8qdLpY6p40jI6qg1DztxghLRUxWXudcyyh/QaWcmLXWFbHA+uK5jkPa/tLeIMN1cur2
         8yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytO1crUD48AtU1t/Tcg1EhchYBoF9l20KUtI9Rfp0v8=;
        b=B4/1He9alOFXqhlzXWa3Fx/cP0FulXqAef8J4VdyiuYDnGtV+TyI3QdxjAeKnWnk8Q
         oslwbmMzmLVw0hvDWbfZvdVZxtqLGqeTYl14Zd8nI4KdzwCSHkFRJ9DdhiqMiN4GxcPx
         ys8pnvNPM/dXudGp1m94LW0KeoXX9U6k2M7RBwsQAJrSw5a2IYqecvV8y8UqPykPiyYd
         iOnv7IfKFYp06MeC4ljBjMPyHswv5/mY+1aG3SHaLXa1dM58eUgx+kJiAL1IXgmb+rU8
         KgG9no4mr5hO7n3eOhCMOO6nga5n3rRF7TEko5N4sGPH0e3iwCUQPOTNka8swGxIchiD
         amGQ==
X-Gm-Message-State: AOAM533amrtcSZ3nyPGCiPsvoKp+TIX0NmEHyglwqk3KeyO+PrcGkn4u
        TF+geOSpGlbulOAkgcUDDJno0RTdOAxAYA==
X-Google-Smtp-Source: ABdhPJyGGD1eCpJ8Cgsku/Mf1tkChI4dhZ56ymzzQm3RDaAZ1jzcXSW7or6NVQ6JNk2wuniT6eRSVQ==
X-Received: by 2002:adf:a1c8:: with SMTP id v8mr3617859wrv.300.1624529974073;
        Thu, 24 Jun 2021 03:19:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm2740030wri.91.2021.06.24.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:19:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-lib.sh: set COLUMNS=80 for --verbose repeatability
Date:   Thu, 24 Jun 2021 12:19:31 +0200
Message-Id: <patch-1.1-765c2793122-20210624T101839Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.605.g06ef811e153
In-Reply-To: <patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com>
References: <patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests will fail under --verbose because while we've unset COLUMNS
since b1d645b58ac (tests: unset COLUMNS inherited from environment,
2012-03-27), we also look for the columns with an ioctl(..,
TIOCGWINSZ, ...) on some platforms. By setting COLUMNS again we
preempt the TIOCGWINSZ lookup in pager.c's term_columns(), it'll take
COLUMNS over TIOCGWINSZ,

This fixes the t0500-progress-display.sh test when run as:

    ./t0500-progress-display.sh --verbose

It broke because of a combination of the this issue and the progress
output reacting to the column width since 545dc345ebd (progress: break
too long progress bar lines, 2019-04-12). The
t5324-split-commit-graph.sh fails in a similar manner due to progress
output, see [1] for details.

A more narrow fix here would be to only do this in the --verbose mode,
but there's no harm in setting this for everything. If we're not
connected to a TTY the COLUMNS setting won't matter.

See ea77e675e56 (Make "git help" react to window size correctly,
2005-12-18) and ad6c3739a33 (pager: find out the terminal width before
spawning the pager, 2012-02-12) for how the TIOCGWINSZ code ended up
in pager.c

1. http://lore.kernel.org/git/20210624051253.GG6312@szeder.dev

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This replaces a more narrow fix in
https://lore.kernel.org/git/patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com/,
which as SZEDER points out was also needed by another test using the
progress.c code.

 t/test-lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 54938c64279..1a6ca772d6c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -406,14 +406,15 @@ LANG=C
 LC_ALL=C
 PAGER=cat
 TZ=UTC
-export LANG LC_ALL PAGER TZ
+COLUMNS=80
+export LANG LC_ALL PAGER TZ COLUMNS
 EDITOR=:
 
 # A call to "unset" with no arguments causes at least Solaris 10
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
 # ones.
-unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
+unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 	my @env = keys %ENV;
 	my $ok = join("|", qw(
 		TRACE
-- 
2.32.0.605.g06ef811e153

