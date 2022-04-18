Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C7C433FE
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346299AbiDRQdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346324AbiDRQcb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458693134E
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u3so19155564wrg.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ATTgcCKKISLPODhqRVDwDNg88Ga8xZLAYUX2gIGqCU=;
        b=LdDZpn//FzLXfkylYG7KJNVQ1CC3OEHWEcXRndoHVOzlNmHQAOgLpPOthveMH0tXC6
         ztp9ba7BytwSTcaeW20C1mtIquY+AhxKlVkdkUQAnQULS9jwAey8i7pRf69siJgm6jMs
         RXD8YW+Q5KAY2BAApsMaXoRQQQVb8PfE0DZyiTS0IQ4/Z1dKSD4I0bCoWvUM64zOszC9
         e+5wRTX73y6Y1CsKDhxFg83LvHrSL9D52IgcMhch2v/5c5+LMcIe5BGZ4mT95Og/0OuY
         J6R8HrRDXYLKd060Qv0Zgs30IByy6SiOfFRRJ21qYyo5fU5jnC6nSJ0m/2KHo9WH4Xqs
         qCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ATTgcCKKISLPODhqRVDwDNg88Ga8xZLAYUX2gIGqCU=;
        b=sL/x5555hlwvgnkM0RPuifoVBFbzB0iUOWR4Y8WNrmXlsI1FJMOaucxzrJh+KqJkhW
         /6QkbHrWi/GWTG8Smg9BwlUOhgq1u5XX/TBtAeZLJ+ryWmCKkHwbXLca98Mk7vwyNzmo
         zqQk6Tjkc6raottpw95qpw5o04EBkM3EVmS8BTEYmU0vuqDgpe+Uj/r0ZqnnQE3yA15c
         7dn4/U4RAaJdUON3nSLvLcL7/RfN+m0MaF8+9437r0EGlZqeivZ1r2Y7ojQeRURV5con
         eYYn4qZHrOaQ2REvncct18fLefY8D3giakaTIC9vq7C+/dYTk1MhJw513e0Ok5s63dWO
         ByKw==
X-Gm-Message-State: AOAM533AlRSEL6NZhuquxsdYJwDYfKz9TE4NfpllfcqywnbzSjyShVRH
        se/cZ8+LCWAWZTIyTDwWPt87zK4a6vdL0w==
X-Google-Smtp-Source: ABdhPJz/HmFGXxQwVOwraTigmSoRpadlcf8Tam9HzAWJW2QprWnZ/OzDkqtN90iNSy4QRw6jD/ab8A==
X-Received: by 2002:adf:f746:0:b0:207:9bc7:68ba with SMTP id z6-20020adff746000000b002079bc768bamr8467263wrp.600.1650299382345;
        Mon, 18 Apr 2022 09:29:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 31/31] CI: make it easy to use ci/*.sh outside of CI
Date:   Mon, 18 Apr 2022 18:29:08 +0200
Message-Id: <patch-v4-31.31-4fc67e668da-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the ci/.sh scripts have lost most of their
CI-specific assumptions. Let's go even further and explicitly support
running ci/lib.sh outside of CI.

This was possible before by faking up enough CI-specific variables,
but as shown in the new "help" output being added here using the
ci/lib.sh to provide "CI-like" has now become trivial.

The ci/print-test-failures.sh scripts can now be used outside of CI as
well, the only GitHub CI-specific part is now guarded by a check that
we'll pass if outside of GitHub CI.

There's also a special-case here to not clobber $MAKEFLAGS in the
environment if we're outside of CI, in case the user has e.g. "jN" or
other flags to "make" that they'd prefer configured already.

Using "ci/lib.sh" as a stand-alone script is much more useful if it
doesn't hardcode NPROC=10, let's provide a poor shellscript
replacement for the online_cpus() we have in thread-utils.c to cover
the most common OS's. It was suggested to use "2>&1" to invoke
"command -v", but per my reading of [2] and my own testing that
doesn't seem to be needed. Perhaps it's only needed for "which(1)"?

1. https://lore.kernel.org/git/214f8670-91d5-f4b6-efa1-76966c3ab1ee@sunshineco.com/
2. https://pubs.opengroup.org/onlinepubs/009604499/utilities/command.html

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib-ci-type.sh         |  3 ---
 ci/lib-online_cpus.sh     | 26 ++++++++++++++++++
 ci/lib.sh                 | 57 ++++++++++++++++++++++++++++++++++++---
 ci/print-test-failures.sh |  4 ---
 4 files changed, 79 insertions(+), 11 deletions(-)
 create mode 100644 ci/lib-online_cpus.sh

diff --git a/ci/lib-ci-type.sh b/ci/lib-ci-type.sh
index 6f01fd9e5d9..09acab7aaec 100644
--- a/ci/lib-ci-type.sh
+++ b/ci/lib-ci-type.sh
@@ -3,7 +3,4 @@
 if test "$GITHUB_ACTIONS" = "true"
 then
 	CI_TYPE=github-actions
-else
-	echo "Could not identify CI type" >&2
-	exit 1
 fi
diff --git a/ci/lib-online_cpus.sh b/ci/lib-online_cpus.sh
new file mode 100644
index 00000000000..6ce7ec5692d
--- /dev/null
+++ b/ci/lib-online_cpus.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+# TODO: Ideally we'd compile t/helper/test-online-cpus.c early, but
+# that presents a chicken & egg problem. But if we move it to a
+# stand-oline command...
+online_cpus() {
+	NPROC=
+
+	if command -v nproc >/dev/null
+	then
+		# GNU coreutils
+		NPROC=$(nproc)
+	elif command -v sysctl >/dev/null
+	then
+		# BSD & Mac OS X
+		NPROC=$(sysctl -n hw.ncpu)
+	elif test -n "$NUMBER_OF_PROCESSORS"
+	then
+		# Windows
+		NPROC="$NUMBER_OF_PROCESSORS"
+	else
+		NPROC=1
+	fi
+
+	echo $NPROC
+}
diff --git a/ci/lib.sh b/ci/lib.sh
index 8f80be4c3df..362bd031df0 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,6 +1,30 @@
 #!/bin/sh
 set -e
 
+#  Usage
+CI_TYPE_HELP_COMMANDS='
+	# run "make all test" like the "linux-leaks" job
+	(eval $(jobname=linux-leaks ci/lib.sh --all) && make test)
+
+	# run "make all test" like the "linux-musl" job
+	(eval $(jobname=linux-musl ci/lib.sh --all) && make test)
+
+	# run "make test" like the "linux-TEST-vars" job (uses various GIT_TEST_* modes)
+	make && (eval $(jobname=linux-TEST-vars ci/lib.sh --test) && make test)
+
+	# run "make test" like the "linux-sha256" job
+	make && (eval $(jobname=linux-sha256 ci/lib.sh --test) && make test)
+'
+
+CI_TYPE_HELP="
+running $0 outside of CI? You can use ci/lib.sh to set up your
+environment like a given CI job. E.g.:
+$CI_TYPE_HELP_COMMANDS
+
+note that some of these (e.g. the linux-musl one) may not work as
+expected due to the CI job configuring a platform that may not match
+yours."
+
 # Helper libraries
 . ${0%/*}/lib-ci-type.sh
 
@@ -9,6 +33,10 @@ mode=$1
 if test -z "$mode"
 then
 	echo "need a $0 mode, e.g. --build or --test" >&2
+	if test -z "$CI_TYPE"
+	then
+		echo "$CI_TYPE_HELP" >&2
+	fi
 	exit 1
 fi
 
@@ -35,7 +63,7 @@ setenv () {
 	do
 		case "$1" in
 		--build | --test)
-			if test "$1" != "$mode"
+			if test "$1" != "$mode" && test "$mode" != "--all"
 			then
 				skip=t
 			fi
@@ -65,6 +93,10 @@ setenv () {
 	if test -n "$GITHUB_ENV"
 	then
 		echo "$key=$val" >>"$GITHUB_ENV"
+	elif test -z "$CI_TYPE"
+	then
+		echo "$key=\"$val\""
+		echo "export $key"
 	fi
 
 	echo "SET: '$key=$val'" >&2
@@ -75,10 +107,25 @@ CC=
 
 # How many jobs to run in parallel?
 NPROC=10
+case "$CI_TYPE" in
+'')
+	. ${0%/*}/lib-online_cpus.sh
+	NPROC=$(online_cpus)
+
+	if test -n "$MAKEFLAGS"
+	then
+		COMMON_MAKEFLAGS="$MAKEFLAGS"
+	else
+		COMMON_MAKEFLAGS=--jobs=$NPROC
+	fi
+	;;
+*)
+	# For "--test" we carry the MAKEFLAGS over from earlier steps, except
+	# in stand-alone jobs which will use $COMMON_MAKEFLAGS.
+	COMMON_MAKEFLAGS=--jobs=$NPROC
+	;;
+esac
 
-# For "--test" we carry the MAKEFLAGS over from earlier steps, except
-# in stand-alone jobs which will use $COMMON_MAKEFLAGS.
-COMMON_MAKEFLAGS=--jobs=$NPROC
 
 # Clear MAKEFLAGS that may come from the outside world.
 MAKEFLAGS=$COMMON_MAKEFLAGS
@@ -98,6 +145,8 @@ github-actions)
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
 	;;
+'')
+	;;
 *)
 	echo "Unhandled CI type: $CI_TYPE" >&2
 	exit 1
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 29f8c332eca..ec395c79ccd 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -36,10 +36,6 @@ do
 			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
 			;;
-		*)
-			echo "Unhandled CI type: $CI_TYPE" >&2
-			exit 1
-			;;
 		esac
 	fi
 done
-- 
2.36.0.rc2.898.gdf6bbac50ff

