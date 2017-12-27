Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747161F404
	for <e@80x24.org>; Wed, 27 Dec 2017 16:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbdL0Qg0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 11:36:26 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:45352 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdL0QgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 11:36:25 -0500
Received: by mail-wm0-f43.google.com with SMTP id 9so40211319wme.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 08:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VI1iiOz+Hd/qsV0wCiDqWI7/3r0j6etwJT9zmyLg4Y=;
        b=t2tjmbfYyGGK0QnOTow/eXcRQZyxojJMbukU/bD/yMdXOMPhbLiRQ5CatL2ORqOFzy
         T9yKwKDP/TGBBLZTTZP9RQkgGovtBqRsQbYIuYmdDMlI2oH6/13wrQsYF0JWwgVuazaR
         bL3KfR9Xi2kA2EUN+5AnpKn+FGpgu0cnjfvVMvotudoRk5/cgYt5APMKtQsSfUTeOczp
         0aDeyDbf1LhvTayHblMaOeN2BAgp+xBMo6isfsSBhSK/78+IwNzfBMPhROhiWP9OSROl
         T+9heSARh5VaEqVxGeKhJaiJeOS0BPnUR455KSTkq8mF36raN0Q3jo+4M2LAap1Z4gUd
         6mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VI1iiOz+Hd/qsV0wCiDqWI7/3r0j6etwJT9zmyLg4Y=;
        b=e8pHRKwxkvR5Vvx0wmwgRCwcEU/hH5mAyB7xsdh0wts4lomoU6O7+mHhkNTntp9xaB
         aCuDVdtZsEi3hNPliK0NJ7KTH0C+ywxFj0Tk4adt3F/yyDJ9t92H1rAkyXF8Ve7+xEVB
         g6ooYfGwmfDv7N9ViQjnFoCCRRWw1ICtDfsyrdKax95Bhee/jGBGjoBDRSOfLgDQ+2Xq
         4B/4geQZmAfGLYU5hc9SYgB3t4QnLBvJOSznXGq0si2YeWRGYNpZU+gIi1yGyBjOggq9
         HVpA4YeMBxARtS+9GgEgBBNR/vxk+20oHnuqUQb2mU54GRzjqUd1VG3dOP7vP/yfgehF
         +puQ==
X-Gm-Message-State: AKGB3mIN8/Awi+MsmLkg2YZ4tZr3wIC3W0r5wKPkAxnzVo5P3at1hBqj
        rW/mDF+FmHU8wqCwlItEdYY=
X-Google-Smtp-Source: ACJfBosaW4SpnuagL1Aj6Ej7+pOA5/so23k8Yq9PJMHopqXOnOhgvgBim+CM5q9gBI4obiGfkgZLCg==
X-Received: by 10.28.45.151 with SMTP id t145mr21946519wmt.108.1514392584352;
        Wed, 27 Dec 2017 08:36:24 -0800 (PST)
Received: from localhost.localdomain (62-165-236-58.pool.digikabel.hu. [62.165.236.58])
        by smtp.gmail.com with ESMTPSA id l1sm8400557wmh.13.2017.12.27.08.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 08:36:23 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/4] travis-ci: fine tune the use of 'set -x' in 'ci/*' scripts
Date:   Wed, 27 Dec 2017 17:36:00 +0100
Message-Id: <20171227163603.13313-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.500.g54ea76cc4
In-Reply-To: <20171227163603.13313-1-szeder.dev@gmail.com>
References: <20171216125418.10743-1-szeder.dev@gmail.com>
 <20171227163603.13313-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The change in commit 4f2636667 (travis-ci: use 'set -x' in 'ci/*'
scripts for extra tracing output, 2017-12-12) left a couple of rough
edges:

  - 'ci/run-linux32-build.sh' is executed in a Docker container and
    therefore doesn't source 'ci/lib-travisci.sh', which would enable
    tracing executed commands.  Enable 'set -x' in this script, too.

  - 'ci/print-test-failures.sh' iterates over all the files containing
    the exit codes of all the execued test scripts.  Since there are
    over 800 such files, the loop produces way too much noise with
    tracing executed commands enabled, so disable 'set -x' for this
    script.

  - 'ci/run-windows-build.sh' busily waits in a loop for the result of
    the Windows build, producing too much noise with tracing executed
    commands enabled as well.  Disable 'set -x' for the duration of
    that loop.

igned-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh        | 4 +++-
 ci/print-test-failures.sh | 3 +++
 ci/run-linux32-build.sh   | 2 ++
 ci/run-windows-build.sh   | 5 +++++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 331d3eb3a..348fe3c3c 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -22,7 +22,9 @@ skip_branch_tip_with_tag () {
 }
 
 # Set 'exit on error' for all CI scripts to let the caller know that
-# something went wrong
+# something went wrong.
+# Set tracing executed commands, primarily setting environment variables
+# and installing dependencies.
 set -ex
 
 skip_branch_tip_with_tag
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 8c8973cbf..97cc05901 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -5,6 +5,9 @@
 
 . ${0%/*}/lib-travisci.sh
 
+# Tracing executed commands would produce too much noise in the loop below.
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
diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
index 8757b3a97..86999268a 100755
--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -69,6 +69,10 @@ esac
 
 echo "Visual Studio Team Services Build #${BUILD_ID}"
 
+# Tracing execued commands would produce too much noise in the waiting
+# loop below.
+set +x
+
 # Wait until build job finished
 STATUS=
 RESULT=
@@ -90,6 +94,7 @@ done
 # Print log
 echo ""
 echo ""
+set -x
 gfwci "action=log&buildId=$BUILD_ID" | cut -c 30-
 
 # Set exit code for TravisCI
-- 
2.15.1.500.g54ea76cc4

