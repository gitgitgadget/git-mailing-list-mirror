Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14949C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77DC60FE9
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhDTMaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhDTMaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:30:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F0C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:29:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v6so56704516ejo.6
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tuZyfnfFbOsgphKmUf0kZdObq4/NeCkXFqCHpTtcZiU=;
        b=VnLapHx99T4nSItrL3QNhv4Ef9eWqQjZ4zScBz7OzU89Ks/NEFi77X++4f4tNS/7h4
         WpKCrZlXwzX7LWEuoL9AztIqEDoUHzNKiCC0kT00jJu2KxNW2wNXmo7TjOQWv0N+cjA0
         sHBUQSkJyaYrP5oO63VooOlEh3chsJzSlusRaTIYPF3fF+Aed4cPUq1h/zciYJ+2HAj0
         DrNzOpEt/5lNdyCpS/QoqV9P/237k2exRE5HueQAqlmxfDtb5mRFPjIyq39xSKLV9z1P
         4fNsoRFXCBe3AWlsigSCAE5aJMc1smCSO0MaHT59j+AyB2ZANp83t7r89dKD4gM4mt+d
         F2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tuZyfnfFbOsgphKmUf0kZdObq4/NeCkXFqCHpTtcZiU=;
        b=EbPcIJrlaj1q/Y2ytybWxtyW3otLxZrdsdXo/glqafscq/gZTVrgNUnMO3gAF2v+B2
         ACH3kJN5QJn/bQ9+uMwqSt4p0h359eiB/VmJ1nJ0NQQ9sPwSlNfRPaDd6bGW8wOLX/S3
         aNO0/RjUcXx0zV6MlqXR6tJs4Milnh7Uxe57iijMNP2DQF1nUR9MEm7of3lySMu/YdN7
         3jjqhFyEKZnmfHqOnRixSgAuxCpf+exxHVvDEg8G6yOq/bVnJ/XOGdJ5YvlRIdJ5rDNL
         ujUmu0tdFkl402a/5TaWOa0OD73SZns67oyzZAjYNDd+DzeAAhcXJVadVrVdJlSb+82X
         CwBA==
X-Gm-Message-State: AOAM5333EIVTwWUuJVKOwWaP5YJPJi25m2UBsj7UbAnUqeZNLcG57ykx
        BGf9sbjulmSdPN02Oa3E0/FsCtoH2Jo5Mg==
X-Google-Smtp-Source: ABdhPJw6JGTMPK8dHQ6N3nkx8H4TgCQqOWyMO1YrLunJa0ATA/pBjAy7VrLV+wBflhcVe5DPEuK5NA==
X-Received: by 2002:a17:907:9116:: with SMTP id p22mr27836164ejq.516.1618921779602;
        Tue, 20 Apr 2021 05:29:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm10898031edz.60.2021.04.20.05.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:29:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] Revert and amend "test-lib-functions: assert correct parameter count"
Date:   Tue, 20 Apr 2021 14:29:29 +0200
Message-Id: <patch-2.3-67ddd821df-20210420T122706Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts and amends my my own e7884b353b7 (test-lib-functions:
assert correct parameter count, 2021-02-12) in order to improve the -x
output.

The goal here is to get rid of the verbosity of having e.g. a "test 2
-ne 2" line for every "test_cmp". We use "$@" as an argument to "test"
to intentionally feed the "test" operator too many arguments if the
functions are called with too many arguments, thus piggy-backing on it
to check the number of arguments we get.

Before this for each test_cmp invocation we'd emit:

    + test_cmp expect actual
    + test 2 -ne 2
    + eval diff -u "$@"
    + diff -u expect actual

That "test 2 -ne 2" line is new in my e7884b353b7. As noted in
45a2686441b (test-lib-functions: remove bug-inducing "diagnostics"
helper param, 2021-02-12) we had buggy invocations of some of these
functions with too many parameters.

Now we'll get just:

    + test_cmp expect actual
    + eval diff -u "$@"
    + diff -u expect actual

This does not to the "right" thing in cases like:

    test_path_is_file x -a y

Which will now turn into:

    test -f x -a y

I consider that to be OK given the trade-off that any extra checking
would produce more verbose trace output. As shown in 45a2686441b we
had issues with these functions being invoked with multiple
parameters (e.g. a glob) by accident, we don't need to be paranoid in
guarding against hostile misuse from our own test suite.

While I'm at it change a few functions that relied on a "false" being
the last statement in the function to use an explicit "return 1" like
the other functions in this file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 59 +++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0232cc9f46..f8f5bf9de1 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -756,41 +756,43 @@ test_external_without_stderr () {
 }
 
 # debugging-friendly alternatives to "test [-f|-d|-e]"
-# The commands test the existence or non-existence of $1
+# The commands test the existence or non-existence of
+# a given argument.
+#
+# The pattern of using "$@" to "test" instead of "$1" is not a bug. We
+# are counting on "test" to error on too many arguments if more than
+# one is given. Checking "$#" explicitly would lead to overly verbose
+# -x output.
 test_path_is_file () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -f "$1"
+	if ! test -f "$@"
 	then
-		echo "File $1 doesn't exist"
-		false
+		echo "File $* doesn't exist"
+		return 1
 	fi
 }
 
 test_path_is_dir () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -d "$1"
+	if ! test -d "$@"
 	then
-		echo "Directory $1 doesn't exist"
-		false
+		echo "Directory $* doesn't exist"
+		return 1
 	fi
 }
 
 test_path_exists () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -e "$1"
+	if ! test -e "$@"
 	then
-		echo "Path $1 doesn't exist"
-		false
+		echo "Path $* doesn't exist"
+		return 1
 	fi
 }
 
 # Check if the directory exists and is empty as expected, barf otherwise.
 test_dir_is_empty () {
-	test "$#" -ne 1 && BUG "1 param"
-	test_path_is_dir "$1" &&
-	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
+	test_path_is_dir "$@" &&
+	if test -n "$(ls -a1 "$@" | egrep -v '^\.\.?$')"
 	then
-		echo "Directory '$1' is not empty, it contains:"
+		echo "Directory '$*' is not empty, it contains:"
 		ls -la "$1"
 		return 1
 	fi
@@ -798,19 +800,17 @@ test_dir_is_empty () {
 
 # Check if the file exists and has a size greater than zero
 test_file_not_empty () {
-	test "$#" = 2 && BUG "2 param"
-	if ! test -s "$1"
+	if ! test -s "$@"
 	then
-		echo "'$1' is not a non-empty file."
-		false
+		echo "'$*' is not a non-empty file."
+		return 1
 	fi
 }
 
 test_path_is_missing () {
-	test "$#" -ne 1 && BUG "1 param"
-	if test -e "$1"
+	if test -e "$@"
 	then
-		echo "Path $1 exists!"
+		echo "Path $* exists!"
 		false
 	fi
 }
@@ -1012,7 +1012,6 @@ test_expect_code () {
 # - not all diff versions understand "-u"
 
 test_cmp () {
-	test "$#" -ne 2 && BUG "2 param"
 	eval "$GIT_TEST_CMP" '"$@"'
 }
 
@@ -1042,7 +1041,6 @@ test_cmp_config () {
 # test_cmp_bin - helper to compare binary files
 
 test_cmp_bin () {
-	test "$#" -ne 2 && BUG "2 param"
 	cmp "$@"
 }
 
@@ -1103,12 +1101,11 @@ verbose () {
 # otherwise.
 
 test_must_be_empty () {
-	test "$#" -ne 1 && BUG "1 param"
-	test_path_is_file "$1" &&
-	if test -s "$1"
+	test_path_is_file "$@" &&
+	if test -s "$@"
 	then
-		echo "'$1' is not empty, it contains:"
-		cat "$1"
+		echo "'$*' is not empty, it contains:"
+		cat "$@"
 		return 1
 	fi
 }
-- 
2.31.1.723.gf6bad1b9ba1

