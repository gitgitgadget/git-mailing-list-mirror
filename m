Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84195207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 21:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428464AbdDXVNK (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 17:13:10 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35217 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1174195AbdDXVNE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 17:13:04 -0400
Received: by mail-wr0-f194.google.com with SMTP id g12so4500629wrg.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AQa7tNJeG2MsaE5A5MM/D4FjqykcZXTFxCGSmadPGJ0=;
        b=NpM6zcy/1ZZjWyg4/RIzazLfUnTuG9pb/21OQXhhOOHvu0xMr5TYGGeI2HE9INTHMA
         UMke+3rS7wsm5i4DNmT/aOb8Q2F6F/sDdB455Go6+nxrB9ujM6ddB+Pcpgx2bcOHMMAh
         xDYCV+kXtX7mUcG6YTJKa16zkO+37JhQ+UaCYbhDiM6QZvZFVkGHGe5/bqKpBGNKCJ7v
         6pnOsPnuBUrBMhE6A2e04SpBiXd4DNLT2cV0/cHpaF1VH68gwctncRT+HvV9B6N/ps5h
         6fj3elKOpfYl8wZm3107TXpwSRgJ05JEG0VJ6fI0tf2Lr3x4SBB7ca+Sq7JXbm31+ROA
         WzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AQa7tNJeG2MsaE5A5MM/D4FjqykcZXTFxCGSmadPGJ0=;
        b=dd439ZaEy0hS7ICgiFZxZwbM4OMQGg7ZnPnyhHXooNXszM7qRAXy+9gfOCeyZJCWnC
         w60O2GvRkxyoqzzgcVNgbpXt0/oWjySZeShu1gwJcUNheOL8HQUaEOd49R6tMqnK52ZT
         g3gFO5GsVNS/xfHg385ht+FsEc8DEXksoheRw/oPocB13//v48ezppFrSFPPoM1eE3lK
         jkN7AX+VpfV5hPdMp7k/6sCLo5F1T9cbQmBtBuzBwzQa8DythVizlT/jwnf+AIy3Sd7Z
         0bIxBeHqpfoG82PhYAdNaIsJqmJIxW4hPHrAlyBuBe4j9OHiFgXnI3YeyJNgBChW0L3X
         dWjA==
X-Gm-Message-State: AN3rC/7cq1+BZdGpC7C4VDQqEARahX0cUXe6N12yxJvniSuZBQJWTtSj
        ctBUAf4xQQ9Inw==
X-Received: by 10.223.139.215 with SMTP id w23mr7548105wra.169.1493068383040;
        Mon, 24 Apr 2017 14:13:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p107sm12911027wrb.64.2017.04.24.14.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 14:13:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] perf: add function to setup a fresh test repo
Date:   Mon, 24 Apr 2017 21:12:48 +0000
Message-Id: <20170424211249.28553-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170424211249.28553-1-avarab@gmail.com>
References: <20170424211249.28553-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function to setup a fresh test repo via 'git init' to compliment
the existing functions to copy over a normal & large repo.

Some performance tests don't need any existing repository data at all
to be significant, e.g. tests which stress glob matches against
revisions or files, which I'm about to add in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/README      |  1 +
 t/perf/perf-lib.sh | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/t/perf/README b/t/perf/README
index 49ea4349be..de2fe15696 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -106,6 +106,7 @@ sources perf-lib.sh:
 
 After that you will want to use some of the following:
 
+	test_perf_fresh_repo    # sets up an empty repository
 	test_perf_default_repo  # sets up a "normal" repository
 	test_perf_large_repo    # sets up a "large" repository
 
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index ab4b8b06ae..f51fc773e8 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -78,6 +78,10 @@ if test -z "$GIT_PERF_LARGE_REPO"; then
 	GIT_PERF_LARGE_REPO=$TEST_DIRECTORY/..
 fi
 
+test_perf_do_repo_symlink_config_ () {
+	test_have_prereq SYMLINKS || git config core.symlinks false
+}
+
 test_perf_create_repo_from () {
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 parameters to test-create-repo"
@@ -102,15 +106,20 @@ test_perf_create_repo_from () {
 	) &&
 	(
 		cd "$repo" &&
-		"$MODERN_GIT" init -q && {
-			test_have_prereq SYMLINKS ||
-			git config core.symlinks false
-		} &&
+		"$MODERN_GIT" init -q &&
+		test_perf_do_repo_symlink_config_ &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null
 	) || error "failed to copy repository '$source' to '$repo'"
 }
 
 # call at least one of these to establish an appropriately-sized repository
+test_perf_fresh_repo () {
+	repo="${1:-$TRASH_DIRECTORY}"
+	"$MODERN_GIT" init -q "$repo" &&
+	cd "$repo" &&
+	test_perf_do_repo_symlink_config_
+}
+
 test_perf_default_repo () {
 	test_perf_create_repo_from "${1:-$TRASH_DIRECTORY}" "$GIT_PERF_REPO"
 }
-- 
2.11.0

