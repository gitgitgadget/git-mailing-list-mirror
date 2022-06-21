Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D233C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354684AbiFUWey (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354549AbiFUWep (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5974D3191D
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so7966084wms.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+y64IDAFKqKJmjhRU6m/ZMh6o5iKfBKsykj2H+GEVg=;
        b=dpqd+OXPHERo7uZ6GK3AsLXWAC52FayXoHnjqHqzo5jI5BQXxvga+UsoTRKQysz0j0
         OM4vZhwkAq/DOWQb9MgIjDKTaC1hKLU12+JzJhKy9eixZivJazOT8QQ4+pOaCerVTwUL
         lihbd6Oc6YHOEughiYi4FZacdyGUHwjrc0y+GWXVFfxPnTo8filNmjVM5J19RjFXR03H
         6C7a+mXmytwecijxrvcSU6TOVy/AwPnrX/WD3bBVsVOHoEGtszkOW7PftVofgX9GE75o
         GgY59xrT+oTup2ZzmffAm/NDX8LEK5PDJqprJqfpAEmkmoQ12fEsz1ywXt1/v0FHawhE
         BtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+y64IDAFKqKJmjhRU6m/ZMh6o5iKfBKsykj2H+GEVg=;
        b=bicMxXTSRYNsLBNcPO06CR/yegiaDD+Y4ZgEd1IQiXG8o0V9CM/dVeDFd4m4J7sgsH
         xKoLq9Uh2Ry+ypRr2p/hf7k2Ba3bJZ9IL1LsT7KCesWzliy6gTw/aEPIkyAU48lQDTjS
         kH/G86d0DSjt840HlMarQnflWjQgIOvJcTrCA5JOZX5eE73a46yx6A0MUfUz1hvhHm7J
         B4ZXjsxFT5rDVVDAQ0D7Ya99HzadUruvNLTMqUWOdu8jHpoBFwTz4RfGZj3GYnDBG/Df
         m9+GH9xryfx+UvG4lNoO/CBBpAhdMYNB1tNBin0vDLKPW7Fp/2Eol7pZIG+EhxlKPHLX
         nmbQ==
X-Gm-Message-State: AOAM531D5vNx3F3IjDoX8Or88dRdrilBBeiJNbv08gBAjSdkZmVDe590
        ubhC2+t/lB/V6w4pejOJCHM/Rf/2O9bXBA==
X-Google-Smtp-Source: ABdhPJytkADJzKi9FaIKHN6WX6oDXRlIL6kvQ4FL/ySDp+hw4N7rfRzAyZqk+zQX5NIjvJUVdYk9lQ==
X-Received: by 2002:a05:600c:354c:b0:39c:7e86:6ff5 with SMTP id i12-20020a05600c354c00b0039c7e866ff5mr43063353wmq.145.1655850875534;
        Tue, 21 Jun 2022 15:34:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b0039c7c4a542csm19000299wmj.47.2022.06.21.15.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:34:34 -0700 (PDT)
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
Subject: [PATCH 10/10] fetch tests: fix needless and buggy re-quoting
Date:   Wed, 22 Jun 2022 00:34:22 +0200
Message-Id: <patch-10.10-54129b94a77-20220621T222854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
References: <xmqqa6a5g0m3.fsf@gitster.g> <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test_configured_prune_type() function to take full
advantage of its arguments being passed in as a list, rather than
needing hacks to work around its quoting issues.

When the test_configured_prune() function was implemented in
737c5a9cde7 (fetch: make --prune configurable, 2013-07-13) it passed
in its arguments to "git fetch" as one argument (although at the time
only one argument was passed)..

Then in preparation for passing more arguments the first quoting hack
was added in 82f34e03e91 (fetch tests: double quote a variable for
interpolation, 2018-02-09), with e1790f9245f (fetch tests: fetch <url>
<spec> as well as fetch [<remote>], 2018-02-09) following after
that. This was all to implement the "git fetch --prune-tags" feature
in 97716d217c1 (fetch: add a --prune-tags option and fetch.pruneTags
config, 2018-02-09).

At the time the edge cases introduced by this quoting were a known
issue, but the alternative was a larger refactoring of this test
file. In preceding commits we've done that refactoring, so let's
finally take advantage of it. As reported in [1] the existing
workaround(s) weren't enough.

We can now drop the "perl" (or "sed" or whatever, see [2]), this will
also handle other cases, such as those mentioned in [3].

1. https://lore.kernel.org/git/00a401d884d0$32885890$979909b0$@nexbridge.com/
2. https://lore.kernel.org/git/495bd957-43dc-f252-657d-2969bb7ad5f3@github.com/
3. https://lore.kernel.org/git/YrFwcL2dRS%2Fv7xAw@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 79 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 17 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 73964bebced..730968d4cd7 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -837,6 +837,7 @@ test_configured_prune_type () {
 		shift
 	done &&
 
+	local refspec_tags='refs/tags/*:refs/tags/*' &&
 	local refspec_heads='+refs/heads/*:refs/remotes/origin/*' &&
 
 	local fetch_prune="$1" &&
@@ -846,23 +847,59 @@ test_configured_prune_type () {
 	local expected_branch="$5" &&
 	local expected_tag="$6" &&
 	shift 6 &&
-	local cmdline="$@" &&
+	local cmdline="" &&
+	local arg_fetch_prune="" &&
+	local arg_fetch_no_prune="" &&
+	local arg_fetch_prune_tags="" &&
+	local arg_fetch_origin="" &&
+	local arg_fetch_url="" &&
+	local arg_fetch_refspec_tags="" &&
+	local arg_fetch_refspec_heads="" &&
+	while test $# != 0
+	do
+		cmdline="${cmdline:+$cmdline }$1" &&
+		case "$1" in
+		--prune)
+			arg_fetch_prune=t
+			;;
+		--no-prune)
+			arg_fetch_no_prune=t
+			;;
+		--prune-tags)
+			arg_fetch_prune_tags=t
+			;;
+		origin)
+			arg_fetch_origin=t
+			;;
+		REMOTE_URL)
+			arg_fetch_url=t
+			;;
+		$refspec_tags)
+			arg_fetch_refspec_tags=t
+			;;
+		$refspec_heads)
+			arg_fetch_refspec_heads=t
+			;;
+		*)
+			BUG "unknown argument: '$1'"
+			;;
+		esac &&
+		shift
+	done &&
 
-	remote_url="file://$TRASH_DIRECTORY/." && # NOT local yet!
-	local cmdline_setup="\"$remote_url\" \"$refspec_heads\""
+	local remote_url="file://$TRASH_DIRECTORY/." &&
 
 	if test "$mode" = 'link'
 	then
-		new_cmdline="" &&
-
 		if test -z "$cmdline"
 		then
-			new_cmdline=$cmdline_setup
-		else
-			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
-		fi &&
-
-		cmdline="$new_cmdline"
+			arg_fetch_refspec_heads=t
+			arg_fetch_url=t
+		elif test -n "$arg_fetch_origin"
+		then
+			arg_fetch_origin=
+			arg_fetch_url=t
+		fi
 	fi &&
 
 	test_expect_success "$mode prune fetch.prune=$fetch_prune remote.origin.prune=$remote_origin_prune fetch.pruneTags=$fetch_prune_tags remote.origin.pruneTags=$remote_origin_prune_tags${cmdline:+ $cmdline}; branch:$expected_branch tag:$expected_tag" '
@@ -871,7 +908,7 @@ test_configured_prune_type () {
 		git tag -f newtag &&
 		(
 			cd one &&
-			git fetch '"$cmdline_setup"' &&
+			git fetch "$remote_url" "$refspec_heads" &&
 			git rev-parse --verify refs/remotes/origin/newbranch &&
 			git rev-parse --verify refs/tags/newtag
 		) &&
@@ -893,7 +930,15 @@ test_configured_prune_type () {
 			then
 				git_fetch_c=""
 			fi &&
-			git$git_fetch_c fetch '"$cmdline"' &&
+			git$git_fetch_c fetch \
+				${arg_fetch_prune:+--prune} \
+				${arg_fetch_no_prune:+--no-prune} \
+				${arg_fetch_prune_tags:+--prune-tags} \
+				${arg_fetch_origin:+origin} \
+				${arg_fetch_url:+"$remote_url"} \
+				${arg_fetch_refspec_tags:+"refs/tags/*:refs/tags/*"} \
+				${arg_fetch_refspec_heads:+"+refs/heads/*:refs/remotes/origin/*"} &&
+
 			case "$expected_branch" in
 			pruned)
 				test_must_fail git rev-parse --verify refs/remotes/origin/newbranch
@@ -993,22 +1038,22 @@ test_configured_prune unset unset unset unset pruned pruned --prune --prune-tags
 
 test_configured_prune_type --mode name true  unset true  unset pruned pruned
 test_configured_prune_type --mode link true  unset true  unset pruned pruned \
-	"\"$remote_url\"" \
+	REMOTE_URL \
 	"refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
 test_configured_prune_type --mode name unset true  unset true  pruned pruned
 test_configured_prune_type --mode link unset true  unset true  pruned pruned \
-	"\"$remote_url\"" \
+	REMOTE_URL \
 	"refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
 
 # remote.<name>.pruneTags overrides fetch.pruneTags, just like
 # remote.<name>.prune overrides fetch.prune if set.
 test_configured_prune_type --mode name true  unset true unset pruned pruned
 test_configured_prune_type --mode link true  unset true unset pruned pruned \
-	"\"$remote_url\"" \
+	REMOTE_URL \
 	"refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
 test_configured_prune_type --mode name false true  false true pruned pruned
 test_configured_prune_type --mode link false true  false true pruned pruned \
-	"\"$remote_url\"" \
+	REMOTE_URL \
 	"refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
 test_configured_prune true  false true false kept kept
 
-- 
2.36.1.1239.gfba91521d90

