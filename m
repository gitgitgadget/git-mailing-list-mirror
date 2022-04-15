Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FD6C4332F
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 12:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiDOMob (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354300AbiDOMnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 08:43:06 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50938CB016
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 05:39:45 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id d9so6413546qvm.4
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJ7DbHGSxw3vXKUulivPGKaZFtiI/8rtovplUenMawE=;
        b=dUyXQ+MAGy7qUjvX3694jjnY/L6E+GuXUaK7+2+5RK/jg99lisOfC/jmnKX+8r7/3j
         YstGsQapTdGl1n4XnJlt0k6Z+/HOBk0JPqd2HhXaFnfbfCC69WRPlfDhpFp2vUv9/ty3
         ghNY2Q6PWwqGc0BpFkGoh6Z7Q1fOkHehZKOPwvxq5TAw+2/RDs9kv5Vi05F8Kp33dlzL
         tyjMrkiuhzAyZF1YCkSUVYLEen6Zi9rpar/ndibiKOtWyutkPgjG+18Zqw6vOJuy8LTM
         ZFfTMTiF1WDaOnlBZn8NzVjtLPluMu00Yv9ey96s/d7f/NRplXQqxlS0NrMlIaoCZlSR
         o+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJ7DbHGSxw3vXKUulivPGKaZFtiI/8rtovplUenMawE=;
        b=JVkUAe5fa06TO3nyofEplDmzlDE9EFY4kyHr7X30RQ58uE5VWxu2XZEdU4rJFvs5jn
         8WVPvYnzRrJQLHgQ88LVE55dpw7xy+RYbg3W+ipAqH0s60N4oBavpAn4SNc0aHE3m/35
         PstRqHYrgYtoa/vdQgTHQtbat4c1lMsDmZPct4ptcQ7dK20UlEf3n4Y/sy0zOF/bgH5h
         yXsCiX/TJqw3IAls9v4ge0h2TFILATuKGoQJHraLOYlZhn4q4Av4oAgMTfph1xEOYeDa
         JKVWA3amFo1tiOg6qM3BC7BAm+LS25SCogg3zSG8btmjGnxivhXml1+QKARnjmYqwhQU
         wn9w==
X-Gm-Message-State: AOAM532Z8WqlRc2DpNaoLfzboub8usJ11emfK4v6t/HwmtqLxI2lChKD
        qMamH8BfrpqL060S84VB37u+suvlB+0=
X-Google-Smtp-Source: ABdhPJzD+hyC7MGpgfdIjZWjqDjV+sB7bCVaGxn3oEHeCIxGFCeKJgbN/VXdi6eZAYQV6Y/xEMD1wg==
X-Received: by 2002:ad4:456d:0:b0:444:42fa:243c with SMTP id o13-20020ad4456d000000b0044442fa243cmr7371399qvu.78.1650026384289;
        Fri, 15 Apr 2022 05:39:44 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id m4-20020ac85b04000000b002e1dcaed228sm2660368qtw.7.2022.04.15.05.39.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2022 05:39:44 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] ci: lock "pedantic" job into fedora 35 and other cleanup
Date:   Fri, 15 Apr 2022 05:39:22 -0700
Message-Id: <20220415123922.30926-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.283.gbef64175c85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fedora 36 is scheduled to be released in Apr 19th, but it includes
a prerelease of gcc 12 that has known issues[1] with our codebase
and therefore requires extra changes to not break a DEVELOPER=1
build.

Lock the CI job to the current release image, and while at it rename
the job to better reflect what it is currently doing, instead of its
original objective.

Finally add git which was a known[2] issue for a while.

[1] https://lore.kernel.org/git/YZQhLh2BU5Hquhpo@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/xmqqeeb1dumx.fsf@gitster.g/

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
This merges fine to master, maint and next but will need some work to
get into seen.

Alternatively, the fixes to fix the build could be merged instead, but
it will still require at least one temporary change to disable a flag
as the underlying bug[3] is yet to be addressed in gcc (or somewhere
else in Fedora).

[3] https://bugzilla.redhat.com/show_bug.cgi?id=2075786

 .github/workflows/main.yml        | 4 ++--
 ci/install-docker-dependencies.sh | 4 ++--
 ci/run-build-and-tests.sh         | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c35200defb9..48e212f4110 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -282,8 +282,8 @@ jobs:
         - jobname: linux32
           os: ubuntu32
           image: daald/ubuntu32:xenial
-        - jobname: pedantic
-          image: fedora
+        - jobname: fedora
+          image: fedora:35
     env:
       jobname: ${{matrix.vector.jobname}}
     runs-on: ubuntu-latest
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
index 78b7e326da6..660e25d1d26 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -15,8 +15,8 @@ linux-musl)
 	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
 		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
 	;;
-pedantic)
+fedora)
 	dnf -yq update >/dev/null &&
-	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	dnf -yq install make gcc git findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
 esac
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 280dda7d285..de0f8d36d7c 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -37,10 +37,9 @@ linux-clang)
 linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	;;
-pedantic)
+fedora)
 	# Don't run the tests; we only care about whether Git can be
 	# built.
-	export DEVOPTS=pedantic
 	export MAKE_TARGETS=all
 	;;
 esac
-- 
2.36.0.rc2.283.gbef64175c85

