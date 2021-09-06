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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29901C433FE
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C78361004
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbhIFHGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 03:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhIFHG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 03:06:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5FDC061757
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 00:05:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u9so8206660wrg.8
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 00:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gv0MrRvKKm19V0OiQaRrFOIJc5k/QdkOxkmFwBADi9Q=;
        b=Kyn7aE3gAuBNNLc/80cuIEyxxBCWUi1DBkBU+CAcLXxWULwrS8vy1AsxCv4EOWSqda
         j0s5SUvvxTlpGbKmG6/SqIhJT+W3CeL9AVgS9io1YHiS/JEKxtM6f/H8i5TGioHdm9eg
         TQwfbqlUrE0iYDAOU61KYMe3eKA1AqxTLshw9IPL2MSXApUR3ynZawThAUBok1FDKoVh
         yrn4r1PV7JRQTFS/jFGDmm99MoZ5mPhK1oS+fEbUTRh4ufpIzfuAQY1q4kkdU631WYHm
         n63C78IB9WaRCNl4NhT9xgeB3qg7wICyf+uXBKl2qBBzxz2TFDJG5noodJ8ofsiBNK4B
         2log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gv0MrRvKKm19V0OiQaRrFOIJc5k/QdkOxkmFwBADi9Q=;
        b=Ei+3ZgUh9Vba2hi076lTaSuNrOdM/UREclabGY9jydGdbsgd1lt9DRNYMORrsf1woO
         PjJOu+N4DllflZfCgVIjP0L1meFaRC9YE2L839qowcCNy1rqO3mlvc1+QP7ZN2xmovO+
         BjJJ84hy08OvG12px+UF//4HuVsvAy4RD8l66vtWPFJTd4j0Ob1ywjJWX9VAUNkXuMsh
         FB1SzyB4+8SnFmrNPIPx5DCHNtidUiuS6JH7SlZrZZCIfo6drgKtHubeWbObzuPWh4ub
         OdhabkFUjQ6L1K0aaO2ZAgdJeVWBzPQUbBCqCHyfT0i/6ih+JW+qn7iHhEHqpAtToNyi
         xAXg==
X-Gm-Message-State: AOAM533Y54gCSR2RbeWtgd1AXBNng4QYzc4tAaA9WMcJSu/oSedb6wiQ
        8Adjd2v3h/FideBtJZ0T524JipnQtq6bpA==
X-Google-Smtp-Source: ABdhPJzRFbaCU/8plO6qz6DOGNmObTgSSqIfTcf4qR3tUuPn78GckgpY7gvp94ANyJ6niEvub02fdg==
X-Received: by 2002:a05:6000:160d:: with SMTP id u13mr11818689wrb.17.1630911921871;
        Mon, 06 Sep 2021 00:05:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm8076684wrt.63.2021.09.06.00.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:05:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/7] git-sh-setup: remove unused git_pager() function
Date:   Mon,  6 Sep 2021 09:05:12 +0200
Message-Id: <patch-v2-1.7-8eb1dfbff5d-20210906T070201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.821.gfd4106eadbd
In-Reply-To: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the git_pager() function last referenced by non-test code in
49eb8d39c78 (Remove contrib/examples/*, 2018-03-25).

We can also remove the test for this added in 995bc22d7f8 (pager: move
pager-specific setup into the build, 2016-08-04), the test that
actually matters is the one added in e54c1f2d253 (pager: set LV=-c
alongside LESS=FRSX, 2014-01-06) just above the removed test.

I.e. we don't care if the "LESS" and "LV" variables are set by
git-sh-setup anymore, no built-in uses them, we do care that pager.c
sets them, which we still test for.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-sh-setup.sh  | 16 ----------------
 t/t7006-pager.sh | 13 -------------
 2 files changed, 29 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 10d97641856..7ee4b0edff5 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -157,22 +157,6 @@ git_editor() {
 	eval "$GIT_EDITOR" '"$@"'
 }
 
-git_pager() {
-	if test -t 1
-	then
-		GIT_PAGER=$(git var GIT_PAGER)
-	else
-		GIT_PAGER=cat
-	fi
-	for vardef in @@PAGER_ENV@@
-	do
-		var=${vardef%%=*}
-		eval ": \"\${$vardef}\" && export $var"
-	done
-
-	eval "$GIT_PAGER" '"$@"'
-}
-
 sane_grep () {
 	GREP_OPTIONS= LC_ALL=C grep @@SANE_TEXT_GREP@@ "$@"
 }
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435e..08f712a4497 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -49,19 +49,6 @@ test_expect_success TTY 'LESS and LV envvars are set for pagination' '
 	grep ^LV= pager-env.out
 '
 
-test_expect_success !MINGW,TTY 'LESS and LV envvars set by git-sh-setup' '
-	(
-		sane_unset LESS LV &&
-		PAGER="env >pager-env.out; wc" &&
-		export PAGER &&
-		PATH="$(git --exec-path):$PATH" &&
-		export PATH &&
-		test_terminal sh -c ". git-sh-setup && git_pager"
-	) &&
-	grep ^LESS= pager-env.out &&
-	grep ^LV= pager-env.out
-'
-
 test_expect_success TTY 'some commands do not use a pager' '
 	rm -f paginated.out &&
 	test_terminal git rev-list HEAD &&
-- 
2.33.0.821.gfd4106eadbd

