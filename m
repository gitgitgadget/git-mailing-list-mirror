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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3E2C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABA16146E
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhFNKxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:53:30 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35645 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhFNKv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:51:29 -0400
Received: by mail-wr1-f52.google.com with SMTP id m18so14030167wrv.2
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BS0ULjgZdgeRfiDjOjmJCMuxP6qf3m+5a2iu1mhKxrY=;
        b=JvfqZ2D8dte/gPuJP8836Ijckiu0XkAr/p9lFF/gljfctOXz/14641W+9Lgd22vFSe
         UV8RrVT02QNx5Twspeh+jDh7by6s52maP1pihyCCAZFusPBF0oItTzZyz8VMa5gmBES/
         De4U1/Ui3VhrBuT8ITYT7FbjcZKY0rkYD/331w2aQAlTHMuLjoDsrSiSMt+dbZPa9tI5
         Cnb9Iojk6uNEOWbkdvlNmNWKLC/kg/VKJ1KsL/3w1U9k6dDzv9XvvPc37BRyaejqNSFk
         b3uk6xMxNpHSDX6q73cpuaJwLxw36Enxyha7B6AFpim9N8FFleWDWhg434h8GnaTRlM0
         H4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BS0ULjgZdgeRfiDjOjmJCMuxP6qf3m+5a2iu1mhKxrY=;
        b=BRIbK9dD3GDp2VGZxOd40bT1m7/816TFDxUmDZzTr8fKkGMS73/xiHPti3RTw2+Vl3
         sogogr4oAC8g8xUdEpJyjZ5C0XBro8hAazBWwlEb8+UBt0hgV91lxHuZwxQqnnVXbJcF
         Mln/mBY5pUDlQxZdJbdeMbQ0b1ws3Rgf9YB/N3TE7WzPC0DzHnHHgqstQpie0I+YFjp8
         tfa+VoouRVX53u3+m3/7xjYU4drBZtPvicQYCfJWtNfM6nwI2+CYQcQ15BmRzh9I2y69
         +VoDZPt4Y8Kfs3uxzbQXRDbaNVhqa5KPvMYfsKNC4NBs6Zi31+kzyMWVga9yAHlxw+jd
         MX9w==
X-Gm-Message-State: AOAM531PGAoIM1tUcSsdi49r9clJVCACG935h8rPCMP996kcbWDeMOLz
        JffCWJDbD6OjdidmVebW0ksYrPnNG7Y7fQ==
X-Google-Smtp-Source: ABdhPJy5+2Cz6xfbXDeuTgIE/s6uHtN/MfnyNGcYTNwzUn7Ko5PYA06LMUAt8kti57gBx8LJVoJXvQ==
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr17800141wrz.350.1623667705982;
        Mon, 14 Jun 2021 03:48:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m23sm15153732wms.2.2021.06.14.03.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:48:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/8] test-lib tests: assert 1 exit code, not non-zero
Date:   Mon, 14 Jun 2021 12:48:14 +0200
Message-Id: <patch-8.8-ddbc8db2802-20210614T104351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the testing for test-lib.sh itself to assert that we have a
exit code of 1, not any non-zero. Improves code added in
0445e6f0a12 (test-lib: '--run' to run only specific tests,
2014-04-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 02864c9d0e0..bb7153ac9e5 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -43,8 +43,8 @@ write_sub_test_lib_test () {
 }
 
 _run_sub_test_lib_test_common () {
-	neg="$1" name="$2" # stdin is the body of the test code
-	shift 2
+	cmp_op="$1" want_code="$2" name="$3" # stdin is the body of the test code
+	shift 3
 	(
 		cd "$name" &&
 
@@ -58,33 +58,30 @@ _run_sub_test_lib_test_common () {
 		TEST_OUTPUT_DIRECTORY=$(pwd) &&
 		export TEST_OUTPUT_DIRECTORY &&
 		sane_unset GIT_TEST_FAIL_PREREQS &&
-		if test -z "$neg"
-		then
-			./"$name.sh" "$@" >out 2>err
-		else
-			! ./"$name.sh" "$@" >out 2>err
-		fi
+		./"$name.sh" "$@" >out 2>err;
+		ret=$? &&
+		test "$ret" "$cmp_op" "$want_code"
 	)
 }
 
 write_and_run_sub_test_lib_test () {
 	name="$1" descr="$2" # stdin is the body of the test code
 	write_sub_test_lib_test "$@" || return 1
-	_run_sub_test_lib_test_common '' "$@"
+	_run_sub_test_lib_test_common -eq 0 "$@"
 }
 
 write_and_run_sub_test_lib_test_err () {
 	name="$1" descr="$2" # stdin is the body of the test code
 	write_sub_test_lib_test "$@" || return 1
-	_run_sub_test_lib_test_common '!' "$@"
+	_run_sub_test_lib_test_common -eq 1 "$@"
 }
 
 run_sub_test_lib_test () {
-	_run_sub_test_lib_test_common '' "$@"
+	_run_sub_test_lib_test_common -eq 0 "$@"
 }
 
 run_sub_test_lib_test_err () {
-	_run_sub_test_lib_test_common '!' "$@"
+	_run_sub_test_lib_test_common -eq 1 "$@"
 }
 
 _check_sub_test_lib_test_common () {
-- 
2.32.0.rc3.434.gd8aed1f08a7

