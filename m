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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EDC432BE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9023360FC4
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhHBNqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbhHBNqo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 09:46:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE7C0617A3
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 06:46:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so21571289wrr.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2LddSbP6/7/DhuI3wNTrsf9bWZLAr0sNOiVvcAWFYLM=;
        b=d2bryfO0im31NeaGyl6bQ74lcbjrHhgHimaaC0VWI2b1By3rL3UbNSicBwTnIJfXxx
         1kaeXvVeud031ef/x3nnGIxYBEjQejNoHUDVBgT4WG0RfC4hpfZ+j/FsEjY+U0cDyvfG
         3A1aiD4fyP5JPMp0YR+p7P2cjyz1y0pyStwBwcprE3+me2wtY6m1t1I3geIdLkSLvvh3
         sBLC3pT9MsDZ39vfc35Q66Wff0zV4Agwwp6dKsfQEEus5WXakuMljycL/vVny92c4b6w
         40TtAUvfTBQbjSSD93OoSGkneVoGDrtIxn58YI3BKe6O5zKfy8UbbwmbULkK3sQGTMHU
         Y2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LddSbP6/7/DhuI3wNTrsf9bWZLAr0sNOiVvcAWFYLM=;
        b=ixlosAMNuK8KyRvWcaUjNCr6GtMea+mK91G02Y2eIXgr1lcje6pXZ653Qiht0g2wE7
         aLLOXdyNGWfqZAsQax528QvH7EGhU5a68UM46lSVJtHQuIrOTWrjHGZLJKFbegwPd/1h
         MsbtYdpxMUIxRNsXYSM64NCOHin77XbRUl31QUzeeSQ2x2M/WdZ95dLzK7U08+mwzGrm
         YhbYR1HNti+48X34a5pfIlBhd1HE2KG6QS+V/7t0WJJaXuz8tMfnMaa8U3av/haBKFVF
         iw5zROgu9JbWRcE0EVg6C6w/9xs6ICp08EQqKDMM8LAbR1ywGwcnmcqKkMdhZ0mo7zmG
         6tMQ==
X-Gm-Message-State: AOAM533RVBjOJ7YVRuT3TYFtnsaBVWITpsL+YvydAQ9/vEkfem6Be/hP
        0jRzAX6BR/CbLRAodQWgUj6Ru2NspQ580Q==
X-Google-Smtp-Source: ABdhPJwp+nuYKBr04XZptTGfo/sHxfUe7dYMYnBKQMpdTFRoqvU3PYd8cuIFiWc2WUEu8rDtnWCrxA==
X-Received: by 2002:adf:cd0d:: with SMTP id w13mr17955595wrm.25.1627911993140;
        Mon, 02 Aug 2021 06:46:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14sm11549003wrm.43.2021.08.02.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 06:46:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
Date:   Mon,  2 Aug 2021 15:46:28 +0200
Message-Id: <patch-v2-3.3-6cbbb955e9a-20210802T134610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1070.gec115ccd780
In-Reply-To: <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com>
References: <patch-1.1-f81f3911d5-20210726T235452Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com>
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
 t/test-lib-functions.sh |  7 +++++++
 t/test-lib.sh           | 13 +++++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

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
index 536339faaa2..959354e0c6e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1724,5 +1724,12 @@ test_with_columns () {
 	local columns=$1
 	shift
 
+	if ! is_git_command_name "$@"
+	then
+		echo >&7 "test_with_columns: only 'git' is allowed: $*"
+		return 1
+	fi
+
+	GIT_TEST_COLUMNS= \
 	COLUMNS=$columns "$@"
 }
diff --git a/t/test-lib.sh b/t/test-lib.sh
index da13190970f..4bb231e5729 100644
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
2.32.0.1070.gec115ccd780

