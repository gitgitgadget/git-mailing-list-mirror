Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CF1C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5B764DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBPL7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhBPL65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:58:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995DC0613D6
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o15so8890364wmq.5
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNppnW+dd7Pob1YdPXTtaoy46LetJDQtQu8PvEwTM2o=;
        b=A4ksALrdwiBaSu2JUQC0oflvjcZ41NGoz47xb/ZhxzkM8GkOR1TxCu1ombiWEZl3Si
         IuibQF0Uj6HoP01yQde0645sU7yyL+od9d1TYRhfoy2VH4cw9wF1Vkzfftc4PJ3NzdvC
         ZYx9uU4wfttfealEX8BxzS71UzJFy1iPFzd/HDSaTuXjBjPakuu19qDTGQOQWPu2zUsz
         /jJmPI0/Wny9G5HcZt5woLP5kAm8l+7uvVTGVHUyJbjAmc0USyVv4M5rx6pFyF4SCJzN
         NXcwF+hXuPrNgKtDjjGR3v8j6HID2w+ZNMnyEx2oaJ2373XFeMHmgH2Je3QQcLbCq2Fg
         xHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNppnW+dd7Pob1YdPXTtaoy46LetJDQtQu8PvEwTM2o=;
        b=eyohtdAAIE3h8op6prPPQfODbS7M8kFwlocI1Layv9jgrkhrnY+NNcuHreD8ti6nHh
         Y4BC3UcGWuoRYzKzC7HTfgd6pAqPW6hibp3inZPC88229150a8SnluFs8b7F96i2n6aW
         upvnkbxbKVJbyRRvwvxo3LDC5HhX+3d3jjijU55Kq+zDK23IuupphIEEmts7YlLoXXeQ
         ejWUFFywjuCqWwVI9seiDwAKrNFGgvaDDLDCS3Q4OxOdwjYWUjjxzEpkrAw/DU7Yg3DI
         U7TroJXRjTPjoBVlvFo3U4+g6Sadms3ZKbHlBXx6wmVpq5xmvdFB7yBzbxqpL5LKLZti
         8G8Q==
X-Gm-Message-State: AOAM532RYw93WVI3ES0/iQUaYnSxJLZXgGqqZpMpx33pAaOqJF5kW1B9
        DWGJSxW5Wv47MRCQRdnsRGVW5NbQJcs+XQ==
X-Google-Smtp-Source: ABdhPJxWBiyEYR0wf47TH7gJ5k3vln6qLONEN0Kx+P3ylbrQ3DOA7KEsJlhOk2sJIzFnrb9ZaRKO8A==
X-Received: by 2002:a1c:2094:: with SMTP id g142mr3115807wmg.101.1613476694906;
        Tue, 16 Feb 2021 03:58:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/22] test-lib-functions: document and test test_commit --no-tag
Date:   Tue, 16 Feb 2021 12:57:41 +0100
Message-Id: <20210216115801.4773-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 76b8b8d05c (test-lib functions: document arguments to test_commit,
2021-01-12) I added missing documentation to test_commit, but in less
than a month later in 3803a3a099 (t: add --no-tag option to
test_commit, 2021-02-09) we got another undocumented option.

Let's fix that, and while we're at it expand on my
e7884b353b (test-lib-functions: assert correct parameter count,
2021-02-12) and assert that you shouldn't be passing the optional
"<tag>" argument under "test_commit --no-tag".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh        | 19 +++++++++++++++++++
 t/test-lib-functions.sh |  8 +++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index a6e570d674a..6ee98fd0695 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1324,4 +1324,23 @@ test_expect_success 'test_must_fail rejects a non-git command with env' '
 	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
 '
 
+test_expect_success 'test_commit --no-tag fails with a <tag> argument' '
+	run_sub_test_lib_test_err \
+		test_commit-bug "test_commit-bug with --no-tag" <<-\EOF &&
+	test_expect_success "setup #1" "test_commit message1 file1 contents1"
+	test_expect_success "setup #2" "test_commit message2 file2 contents2 tag2"
+	test_expect_success "setup #3" "test_commit --no-tag message3 file3 contents3"
+	test_expect_success "setup #4" "test_commit --no-tag message4 file4 contents4 tag4"
+	test_done
+	EOF
+	check_sub_test_lib_test_err test_commit-bug \
+		<<-\EOF_OUT 3<<-\EOF_ERR
+	ok 1 - setup #1
+	ok 2 - setup #2
+	ok 3 - setup #3
+	EOF_OUT
+	error: bug in the test script: expect no <tag> parameter with --no-tag
+	EOF_ERR
+'
+
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d7339..1eb75d0d733 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -178,6 +178,9 @@ debug () {
 #	Invoke "git commit" with --signoff
 #   --author <author>
 #	Invoke "git commit" with --author <author>
+#   --no-tag
+#	Do not tag the resulting commit, if supplied giving the
+#	optional "<tag>" argument is an error.
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
@@ -242,7 +245,10 @@ test_commit () {
 	git ${indir:+ -C "$indir"} commit \
 	    ${author:+ --author "$author"} \
 	    $signoff -m "$1" &&
-	if test -z "$no_tag"
+	if test -n "$no_tag" -a $# -eq 4
+	then
+		BUG "expect no <tag> parameter with --no-tag"
+	elif test -z "$no_tag"
 	then
 		git ${indir:+ -C "$indir"} tag "${4:-$1}"
 	fi
-- 
2.30.0.284.gd98b1dd5eaa7

