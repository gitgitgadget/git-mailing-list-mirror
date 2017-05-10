Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD73420188
	for <e@80x24.org>; Wed, 10 May 2017 22:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbdEJWxc (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 18:53:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36616 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753180AbdEJWxb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 18:53:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so2944991wmu.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AQa7tNJeG2MsaE5A5MM/D4FjqykcZXTFxCGSmadPGJ0=;
        b=sO5l6bJ7LwpO6owIYg4eFOmOiXAr/jbO0fXmnNgmFXj+kpW9CbpIT2fgLJ38cT9Q1U
         5JpLIbq3qT9cCZkbpqOiNYt3PTCm3NRXts8fHaq3H8w6Ultf7j2mQ/pcY7DphR09sxBa
         ojJ2LPT+/KIieSKC3csHtimuASRk79Xl5Tc78EsZDRlEFk/YFFf1rY/cyQoTRFqojn3m
         An8pvCOYpTzYC1yVNGniuc9lBYC9WteQ3YQAswwWS+imyD75+8fhlTN3zTXJ2B1370gR
         srj5AV9mYdyYK3EqFzL/bpY1oeZCn1FPJLI6qVdoWsax1bVnRNKWrlROB8AyIjHr+rho
         MORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AQa7tNJeG2MsaE5A5MM/D4FjqykcZXTFxCGSmadPGJ0=;
        b=bEZxhiaHrwH8kXHyyxpBIncksMtm9NfEIzHnqPe70podAV/tL3Oswl7aQmERF4zopR
         L/tbfd6SBAiCHGfB8zs2JIkYfC15WpvJvo0P1C4F3TyQb/kO9+ABjVePPNvUiRRnepkz
         q1vvjn32d99UQxja+Y0cycJ7/hpi8GcrTRyqUL37b3nEHZ/J+57ueqGCoPTdJg7AmGl6
         pogZTPGYDkPyMuBgdveyiZS1Q3Se6pR9oZDV0yNICmBeMdQG5fDNSRxE1L7zHJeMlHCs
         XEYgiFb+c9kdj8GTIHiCvDSwFfdspitcR3a5qf2HkIAt8PaWryma4FesNodJBsXfyY2d
         eGRA==
X-Gm-Message-State: AODbwcC7J2rjwws689TkfM6cjUZ1e+XDBjtEgVefUb1EXqNlRdoJ8z1m
        MkgZPZ4XhUCSlw==
X-Received: by 10.80.164.178 with SMTP id w47mr5953550edb.19.1494456810403;
        Wed, 10 May 2017 15:53:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x26sm86722edx.60.2017.05.10.15.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 May 2017 15:53:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] perf: add function to setup a fresh test repo
Date:   Wed, 10 May 2017 22:53:15 +0000
Message-Id: <20170510225316.31680-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170510225316.31680-1-avarab@gmail.com>
References: <20170510225316.31680-1-avarab@gmail.com>
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

