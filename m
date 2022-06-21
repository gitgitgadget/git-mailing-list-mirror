Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD7C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354597AbiFUWeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354486AbiFUWed (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC4412AAF
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so88687wms.1
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJCHk6aWHo9U+yB8NT4lrI+LcdWFYKaN3lde/I6cJyk=;
        b=A7y3I12bact5YS2MBY+UWPvqeb5zFCUcvn9LcgWjC4+e4jyIz4D+1QWoxo+3WlK+lL
         wsN0471I8w6jH4YeWSQPuiMFmgbQERVbMyXuasN6UPPD/0ooSWenb8jhdkoOg+mFdKkJ
         WqiUIqBhtsfIJEwSkWR879Q6gOfxZQF3W7RxMLZ3cR3UBkDxCN8/oKD68iSkxt6AFUA9
         kPzvkM7B7M1duVPFMnYQHG0iWpWuYhwibMX6zzm7Y8P2mY02Y7PMrOslFLEAT0NPyKZ+
         F5OLyXYt/96mWIgDtVnQqoadUO92HEOaZjB7PN81XB9J8X/1haVLYA4HJ0trdXc3SfNj
         m98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJCHk6aWHo9U+yB8NT4lrI+LcdWFYKaN3lde/I6cJyk=;
        b=gv60dYdWQt/PWp1phTQIrUUKic2uFKAc95gi8VG/nTFF60WLe4MgGQ5SOleGp9wgqI
         X1wT4vnk00b2dIL7MZklo7JSEjiWpVzrWGji3Xjq/hcSTcLiDsJOzD5Tae97+L5Lpgdb
         ujv/f6YbQjW4jLX0vVqiKs3SksPS8yOt0BSO8wwVykA+a37SbHX6qiJDDJX0RKqtylOK
         +iUqD5wjLwse7M03BpOsQCzBv0D1fl7nUscb5Dzi/QAImIP8PpaPgfHB8PLFqrqLEOzR
         xOeA6GnW0pl22fyeiL7+Rl3YbY3JX2/tEznNqjWcZFV9mVPTSi23R4P2ZEU6rVvdft+P
         TvGg==
X-Gm-Message-State: AJIora+1oGnPJF7wIV8OBBqx1U43fne/s49TdEpAuUjF8YWcCO6SHBu9
        pqmWOCStG//HoaIne/XvVyIbv8H1XbUq7w==
X-Google-Smtp-Source: AGRyM1tNrDpBgCEU55wqVel50Job+0zfhXYJOq373ueNhjTuU0bsXvWRYs5hviEBmzwOFUvDaM1mJg==
X-Received: by 2002:a05:600c:a18a:b0:3a0:2978:30d2 with SMTP id id10-20020a05600ca18a00b003a0297830d2mr126713wmb.173.1655850870277;
        Tue, 21 Jun 2022 15:34:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b0039c7c4a542csm19000299wmj.47.2022.06.21.15.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:34:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] fetch tests: pass "mode" parameter first, pave way for "$@"
Date:   Wed, 22 Jun 2022 00:34:17 +0200
Message-Id: <patch-05.10-a3fb3174bde-20220621T222854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
References: <xmqqa6a5g0m3.fsf@gitster.g> <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "$mode" parameter to be passed first, and setup a
command-line parser we'll be able to use for getting rid of many of
the boilerplate parameters.

This will allow us to unquote the command-line argument, and process
fetch arguments as a list of "$@". For now we need to do more work to
unpack these, but in a subsequent commit we'll be able to make the
shell quote handling here much simpler.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5d118a6a806..477b6dd4953 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -822,14 +822,29 @@ set_config_tristate () {
 }
 
 test_configured_prune_type () {
+	mode= &&
+	while test $# != 0
+	do
+		case "$1" in
+		--mode)
+			mode="$2" &&
+			shift
+			;;
+		*)
+			break
+			;;
+		esac &&
+		shift
+	done &&
+
 	local fetch_prune="$1" &&
 	local remote_origin_prune="$2" &&
 	local fetch_prune_tags="$3" &&
 	local remote_origin_prune_tags="$4" &&
 	local expected_branch="$5" &&
 	local expected_tag="$6" &&
-	local cmdline="$7" &&
-	local mode="$8" &&
+	shift 6 &&
+	local cmdline="$@" &&
 
 	if test -z "$cmdline_setup"
 	then
@@ -915,8 +930,8 @@ test_configured_prune_type () {
 }
 
 test_configured_prune () {
-	test_configured_prune_type "$@" "name" &&
-	test_configured_prune_type "$@" "link"
+	test_configured_prune_type --mode name "$@" &&
+	test_configured_prune_type --mode link "$@"
 }
 
 # $1 config: fetch.prune
@@ -1007,11 +1022,19 @@ test_configured_prune unset unset unset true pruned  kept \
 # +refs/heads/*:refs/remotes/origin/* refspec and supplying it on the
 # command-line negates --prune-tags, the branches will not be pruned.
 test_configured_prune_type_branch () {
-	test_configured_prune_type "$1" "$2" "$3" "$4" pruned "$6" "$7" "name"
-	test_configured_prune_type "$1" "$2" "$3" "$4" kept   "$6" "$7" "link"
+	local cfg_fp="$1" &&
+	local cfg_rnp="$2" &&
+	local cfg_fpt="$3" &&
+	local cfg_rnpt="$4" &&
+	local arg_branch="$5" &&
+	local arg_tag="$6" &&
+	shift 6 &&
+
+	test_configured_prune_type --mode name "$cfg_fp" "$cfg_rnp" "$cfg_fpt" "$cfg_rnpt" pruned "$arg_tag" "$@"
+	test_configured_prune_type --mode link "$cfg_fp" "$cfg_rnp" "$cfg_fpt" "$cfg_rnpt" kept   "$arg_tag" "$@"
 }
-test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "name"
-test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "link"
+test_configured_prune_type --mode name unset unset unset unset kept   kept   "origin --prune-tags"
+test_configured_prune_type --mode link unset unset unset unset kept   kept   "origin --prune-tags"
 test_configured_prune_type_branch unset unset unset unset - pruned "origin --prune --prune-tags"
 test_configured_prune_type_branch unset unset unset unset - pruned "--prune --prune-tags origin"
 test_configured_prune_type_branch unset unset true  unset - pruned "--prune origin"
@@ -1029,8 +1052,8 @@ test_expect_success 'remove remote.origin.fetch "one"' '
 		git config --unset-all remote.origin.fetch
 	)
 '
-test_configured_prune_type unset unset unset unset kept pruned "origin --prune --prune-tags" "name"
-test_configured_prune_type unset unset unset unset kept pruned "origin --prune --prune-tags" "link"
+test_configured_prune_type --mode name unset unset unset unset kept pruned "origin --prune --prune-tags"
+test_configured_prune_type --mode link unset unset unset unset kept pruned "origin --prune --prune-tags"
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.36.1.1239.gfba91521d90

