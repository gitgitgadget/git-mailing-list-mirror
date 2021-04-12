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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9333EC43461
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7326661249
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbhDLLJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbhDLLJl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B488BC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 12so6548168wmf.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfGCBhAgfn+A1wCEWJ9Q6Q2IIWnpaL3kO8sl+AHLD2s=;
        b=c3ACsWFTpYAnuyJl10U7Ts9yUW/DUey9oQF3ih4MfB/bL/mZXJTuQK4zrL5z+JCO8X
         tuIVeXdD7SxyjasbDiPwqaIwUNUZDbBnGQnGkF4qe41HULwgeqZFMMEwSf1aKDzrsQSL
         ZTAZu7976B24Rk+SDmgjp6hMVLaBDjV59LV5GSUEB4SekIaLW1Iw4XsSevmK5ACZTDcC
         aCPPxVGZAQXD8P/pDOnMV4OhaYgnQ98uXW/1u+0byUvk2GXSuw3LUwwgIzegvP9sgU30
         hDcg7OlxcAKt2h23GJ2z57c8thiL2P3JWHXguENhtWiLxdqWN/AY/CBOGFqfwPBr7d5m
         BIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfGCBhAgfn+A1wCEWJ9Q6Q2IIWnpaL3kO8sl+AHLD2s=;
        b=gZHsjVDCrA3/Frr6jfh5VasshX/Z5pVylAKbqW5/BNpg4vVDihjzdCsaBPb/POWTx0
         V+yYavx6sQ/qbWTLvGEESnQjUefTuzynV+MjtQUSL2Ii0+LOVIE5uQJl3WZewMAJPwEw
         UAjqrcmRHytKHp1XuxmC+eimU1mY92RO35k3RW5XNzGJbiWznwOTTN0bTvx5LZ6q78tu
         dQjI4D100QNghkDelnmjMsJx2h3LydnBh4Ibf5aUfPLFHWbYtWDsRlVAYtWEiqUodBvo
         5uocwrdBiyJTeFjwy9kY2bJCf0F+JqFPfZOL9yx/CJjRQkf5C2s6g7LRvZS4cveqaBUb
         jJGw==
X-Gm-Message-State: AOAM531s/i7QY+F3reDNTLETGIzJ+J5PLYB3yuVSUvjxX8yY1XCqbO+G
        jrfcfiNm6KKizo0ptJBRDhoecBwRr9eO2A==
X-Google-Smtp-Source: ABdhPJxBxzWV41KXqQ8GT8aATkPKPMw5CIjTqPK2nWZjLJuxm2G1AzBmO+aiFJfLNvHgXDfoWwtaRg==
X-Received: by 2002:a1c:6489:: with SMTP id y131mr13377807wmb.0.1618225762104;
        Mon, 12 Apr 2021 04:09:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/16] Revert and amend "test-lib-functions: assert correct parameter count"
Date:   Mon, 12 Apr 2021 13:09:04 +0200
Message-Id: <patch-15.16-0cd511206c4-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts and amends my my own e7884b353b7 (test-lib-functions:
assert correct parameter count, 2021-02-12) in order to improve the -x
output.

When I added these BUG assertions in e7884b353b7 I missed that this
made the -x output much more verbose.

E.g. for each test_cmp invocation we'd now emit:

    + test_cmp expect actual
    + test 2 -ne 2
    + eval diff -u "$@"
    + diff -u expect actual

That "test 2 -ne 2" line is new in e7884b353b7. As noted in
45a2686441b (test-lib-functions: remove bug-inducing "diagnostics"
helper param, 2021-02-12) we had buggy invocations of some of these
functions with too many parameters.

Let's instead use "$@" instead of "$1" to achieve the same ends with
no extra -x output verbosity. The "test" operator will die with an
error if given more than one argument in these contexts, so using "$@"
achieves the same goal.

The same goes for "cmp" and "diff -u" (which we typically use for
test_cmp).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c46bf0ff09c..2cf72b56851 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -759,39 +759,35 @@ test_external_without_stderr () {
 # debugging-friendly alternatives to "test [-f|-d|-e]"
 # The commands test the existence or non-existence of $1
 test_path_is_file () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -f "$1"
+	if ! test -f "$@"
 	then
-		echo "File $1 doesn't exist"
+		echo "File $@ doesn't exist"
 		return 1
 	fi
 }
 
 test_path_is_dir () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -d "$1"
+	if ! test -d "$@"
 	then
-		echo "Directory $1 doesn't exist"
+		echo "Directory $@ doesn't exist"
 		return 1
 	fi
 }
 
 test_path_exists () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -e "$1"
+	if ! test -e "$@"
 	then
-		echo "Path $1 doesn't exist"
+		echo "Path $@ doesn't exist"
 		return 1
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
+		echo "Directory '$@' is not empty, it contains:"
 		ls -la "$1"
 		return 1
 	fi
@@ -799,17 +795,15 @@ test_dir_is_empty () {
 
 # Check if the file exists and has a size greater than zero
 test_file_not_empty () {
-	test "$#" = 2 && BUG "2 param"
-	if ! test -s "$1"
+	if ! test -s "$@"
 	then
-		echo "'$1' is not a non-empty file."
+		echo "'$@' is not a non-empty file."
 		return 1
 	fi
 }
 
 test_path_is_missing () {
-	test "$#" -ne 1 && BUG "1 param"
-	if test -e "$1"
+	if test -e "$@"
 	then
 		echo "Path $1 exists!"
 		false
@@ -1013,7 +1007,6 @@ test_expect_code () {
 # - not all diff versions understand "-u"
 
 test_cmp () {
-	test "$#" -ne 2 && BUG "2 param"
 	eval "$GIT_TEST_CMP" '"$@"'
 }
 
@@ -1043,7 +1036,6 @@ test_cmp_config () {
 # test_cmp_bin - helper to compare binary files
 
 test_cmp_bin () {
-	test "$#" -ne 2 && BUG "2 param"
 	cmp "$@"
 }
 
@@ -1104,12 +1096,11 @@ verbose () {
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
+		echo "'$@' is not empty, it contains:"
+		cat "$@"
 		return 1
 	fi
 }
-- 
2.31.1.634.gb41287a30b0

