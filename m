Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5191F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754397AbdLPMyj (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:54:39 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45322 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbdLPMyh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:54:37 -0500
Received: by mail-wr0-f194.google.com with SMTP id h1so10213228wre.12
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 04:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Ex2EM/jrDqt11UViuVne8a5T8zKZcXQUgnRejK7isE=;
        b=PM98cGMXj6JlTRMRf9qbMVL9rKEnQJVHAdK+h/QXTvwmlNCAWNYFE/vFedNIhqB4Yt
         OORTyFu977bY45Ei3apX5E6qk6UptgLLHYXNspAuUQFFXCH8bQ/Ilrde/dp4co7ID/Pg
         snKZWnJVFFNNSE/NIIFEqnatRoNwbHSnKL5oBzBV+4jOW9WEN+eZ7zXv3Av5rn3KsbY5
         5fPgcRDNerEPW2lE73qON9rTX3CNGDM6sBvlcMxuM/PpohJ45wrnITGvAuMYZyQpxBv2
         8hI//UtMXVCdDXEpUfGaVhqJJfJec1iMDBR+A8/u20HwrtcfJi/W63fiCCl2CCQkfUog
         O6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Ex2EM/jrDqt11UViuVne8a5T8zKZcXQUgnRejK7isE=;
        b=BikBhDZwSqE/4HEXP4IFT4srHeO4llImftNc8PDxCn5KMUZWAhx2jxA/3ZWNCwnkqb
         g/ryS2B0tR2guMeuhT6U6SKIOV+esZiObr3liX0V6mGas43KX2G3Sm1eH7IG+3eNcoEh
         JkoiDOiQtBBHo+V5WT41xkzVxOcmu84UELbCexdSq3UpROqZWtQqR53d5Wmw/Y/Zx180
         PNPEti514/hHTbxutdj+JgxuT1ysy6D3/9kg+kJOAUhRy91OFhMVOmd3UcaiWVaLkGy9
         bh1e3KUuJGsqVJIwPhBv9hlIb7AXSL18alqIr8H3Q7YbfkESMzwM+Bw5jweTxocYsuQQ
         Q77g==
X-Gm-Message-State: AKGB3mJWWQU47UHYgrfPrbAYzvh6p8UX8X9hWelEHDHH+jZYeT8yGAiZ
        9M/MbpYpvgAe1dN5UBZNJrI=
X-Google-Smtp-Source: ACJfBot/BbcPsbxGvi4TKD3mYjFiNF8foFwpyHytJ2VfJSPwGGluUXa9G1G41yHAzxBVdew18VpdLQ==
X-Received: by 10.223.167.3 with SMTP id c3mr13044579wrd.127.1513428876592;
        Sat, 16 Dec 2017 04:54:36 -0800 (PST)
Received: from localhost.localdomain (x590e5997.dyn.telefonica.de. [89.14.89.151])
        by smtp.gmail.com with ESMTPSA id u33sm11236485wrb.68.2017.12.16.04.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Dec 2017 04:54:36 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/8] travis-ci: use 'set -x' in select 'ci/*' scripts for extra tracing
Date:   Sat, 16 Dec 2017 13:54:18 +0100
Message-Id: <20171216125418.10743-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.429.ga000dd9c7
In-Reply-To: <20171216125418.10743-1-szeder.dev@gmail.com>
References: <20171211233446.10596-1-szeder.dev@gmail.com>
 <20171216125418.10743-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the build logic was embedded in our '.travis.yml', Travis CI
used to produce a nice trace log including all commands executed in
those embedded scriptlets.  Since 657343a60 (travis-ci: move Travis CI
code into dedicated scripts, 2017-09-10), however, we only see the
name of the dedicated scripts, but not what those scripts are actually
doing, resulting in a less useful trace log about e.g. installing
dependencies.  A patch later in this series will move setting
environment variables from '.travis.yml' to 'ci/lib-travisci.sh', so
not even those will be included in the trace log.  Unrelated to
657343a60, 'ci/test-documentation.sh' runs a bunch of 'test -s <file>'
checks which would fail quietly if something were wrong, leaving no
clue about which one of those checks triggered the failure.

Use 'set -x' in 'ci/lib-travisci.sh' to get more detailed trace log
about the commands executed in the 'ci/*' scripts.  Use it in
'ci/run-linux32-build.sh' as well, which is run in a Docker container
and therefore doesn't source 'ci/lib-travisci.sh'.  The secret token
used for the Windows builds is specified as an encrypted environment
variable in git/git repository settings on Travis CI and it's redacted
in the trace logs even with 'set -x'.  However, disable this tracing
in 'ci/print-test-failures.sh', as it produces far too much noise in
the output of that script.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh        | 6 ++++--
 ci/print-test-failures.sh | 3 +++
 ci/run-linux32-build.sh   | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index ac05f1f46..2d0d1d613 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -22,8 +22,10 @@ skip_branch_tip_with_tag () {
 }
 
 # Set 'exit on error' for all CI scripts to let the caller know that
-# something went wrong
-set -e
+# something went wrong.
+# Set tracing executed commands, primarily setting environment variables
+# and installing dependencies.
+set -ex
 
 skip_branch_tip_with_tag
 
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 8c8973cbf..f757e616c 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -5,6 +5,9 @@
 
 . ${0%/*}/lib-travisci.sh
 
+# Tracing executed commands would produce too much noise in this script.
+set +x
+
 for TEST_EXIT in t/test-results/*.exit
 do
 	if [ "$(cat "$TEST_EXIT")" != "0" ]
diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index e30fb2cdd..a8518eddf 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -6,6 +6,8 @@
 #   run-linux32-build.sh [host-user-id]
 #
 
+set -x
+
 # Update packages to the latest available versions
 linux32 --32bit i386 sh -c '
     apt update >/dev/null &&
-- 
2.15.1.429.ga000dd9c7

