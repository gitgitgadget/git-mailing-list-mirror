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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84189C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECC522CB2
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbhAWNCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAWNCc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 08:02:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8279C0617AB
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:14 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j18so6591011wmi.3
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYlebPiimKWpyZOySik7cVCMHlKoyzQf+oXTupRcTcI=;
        b=NpDH90dYlRExXl0mV5SWlkHas0hecIoGtrkk4myfN/uCl80+qo15U0ucEYXZB3/8Vp
         nViV0HH0m6uq9ujeJVHxv7BuZUP90mhJ2ybSFBJ5GfMGFyKqvyPPfD+ypHZDXoEzGXon
         q2VXizV83BG85SxLQTK+6k+J1kx6Xzu6GdQ0F5cYXytNJwZZpGwuTmeBo4MQc8iwBZxs
         iN0COC9a8LnfaSJja4vFyR3rhCj6/8kD7EV25aMsGn0U6EfIhYE4zV4azAusHLWeZrWP
         ijClWiKnDWJRRtKmtJtGFMo/mUsKZ8KjiFcDe1f5Bc5WjVtbxHSvUP843oUfFp0Zw7q6
         dfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYlebPiimKWpyZOySik7cVCMHlKoyzQf+oXTupRcTcI=;
        b=qSi33WSE9XO17MC+GeCPY58e5kvJVQoYWx4xWtrhMZ+vlSVYICI9AXVE7MyzavaWdQ
         vHC8HpgZTymdP+ty1KLKWqy3kkUhPDKTbyLanHKHfxCRcVk09zmF/F8mERC9r+YObk1t
         Yj63AglAe6xJlmrF0GNMYJ/y4p5S21YaRRpdKhedmVnbLw6kWkWbsGlIaV2oxyT1AQJt
         G2oGNnuTwtiTk9OCqsyVgBwmh1EujKxSYtK0gkefbOiZdjk6tSei1OgHeSklq/vhpppi
         5TCX6+n4kxzWTgyZZYQ1AzCpoUJMnHcrIGlY8FUxjeK/Ep7NVQ4V8xFSJqdIl9y6FMPu
         VLqg==
X-Gm-Message-State: AOAM533pkD5zCZJVoJK2lskjxQaK7XCUhiQ/uJfqrqze0ySK2hrcPAHF
        8G350b4vn1wacWQXVgoJK25wbb5yfYZ1+w==
X-Google-Smtp-Source: ABdhPJxVhV1+j99JpOWvxeLSwlDU7VHmooKFjrdCGMbL3SzQG+xzKF6Q0yK46Jt3wpYyQWRDuVGhAw==
X-Received: by 2002:a1c:18d:: with SMTP id 135mr8128300wmb.33.1611406873394;
        Sat, 23 Jan 2021 05:01:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm16750319wro.16.2021.01.23.05.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 05:01:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/10] rm tests: actually test for SIGPIPE in SIGPIPE test
Date:   Sat, 23 Jan 2021 14:00:46 +0100
Message-Id: <20210123130046.21975-11-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87sg6s6lrs.fsf@evledraar.gmail.com>
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a test initially added in 50cd31c652 (t3600: comment on
inducing SIGPIPE in `git rm`, 2019-11-27) to explicitly test for
SIGPIPE using a pattern initially established in 7559a1be8a (unblock
and unignore SIGPIPE, 2014-09-18).

The problem with using that pattern is that it requires us to skip the
test on MINGW[1]. If we kept the test with its initial semantics[2]
we'd get coverage there, at the cost of not checking whether we
actually had SIGPIPE outside of MinGW.

Arguably we should just remove this test. Between the test added in
7559a1be8a and the change made in 12e0437f23 (common-main: call
restore_sigpipe_to_default(), 2016-07-01) it's a bit arbitrary to only
check this for "git rm".

But in lieu of having wider test coverage for other "git" subcommands
let's refactor this to explicitly test for SIGPIPE outside of MinGW,
and then just that we remove the ".git/index.lock" (as before) on all
platforms.

1. https://lore.kernel.org/git/xmqq1rec5ckf.fsf@gitster.c.googlers.com/
2. 0693f9ddad (Make sure lockfiles are unlocked when dying on SIGPIPE,
   2008-12-18)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3600-rm.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index efec8d13b6..185e39c390 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -240,7 +240,7 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
 	test_path_is_missing frotz/nitfol
 '
 
-test_expect_success 'choking "git rm" should not let it die with cruft' '
+choke_git_rm_setup() {
 	git reset -q --hard &&
 	test_when_finished "rm -f .git/index.lock && git reset -q --hard" &&
 	i=0 &&
@@ -249,12 +249,24 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 	do
 		echo "100644 $hash 0	some-file-$i"
 		i=$(( $i + 1 ))
-	done | git update-index --index-info &&
+	done | git update-index --index-info
+}
+
+test_expect_success 'choking "git rm" should not let it die with cruft (induce SIGPIPE)' '
+	choke_git_rm_setup &&
 	# git command is intentionally placed upstream of pipe to induce SIGPIPE
 	git rm -n "some-file-*" | : &&
 	test_path_is_missing .git/index.lock
 '
 
+
+test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
+	choke_git_rm_setup &&
+	OUT=$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
+	test_match_signal 13 "$OUT" &&
+	test_path_is_missing .git/index.lock
+'
+
 test_expect_success 'Resolving by removal is not a warning-worthy event' '
 	git reset -q --hard &&
 	test_when_finished "rm -f .git/index.lock msg && git reset -q --hard" &&
-- 
2.29.2.222.g5d2a92d10f8

