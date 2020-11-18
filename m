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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A27C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F17E20B1F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmDb/R8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgKRTEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgKRTEb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 14:04:31 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8EC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:04:31 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c9so4078638wml.5
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwK2lOHer0ivTS7WMTALZhkWdFn5jBdMUCU7hbO2JPE=;
        b=pmDb/R8aJmdo2DCy0umPSGPvAKLF+GDGtft3U/F4h4+aES69ph7aNTrvAfgHCPcxDd
         Utj3/8/gCd8SwhB26SAsAJzVnnFapNvIEyCU6H7XJVBFNUtwQxe06v3sImBefMV65Amv
         Rbiu1nuXZFFEvDMKH3FAhutOkjtf30jIlYRVCtLyem4EW7Xip+W1KcbxpwIGVrCLOH2a
         qVXTNu3CtY02TQFP73FmRGUYRhqad3x32osgk0Ln0QVQFvyhhwyi9C0JNZ85VXK6LOHv
         3aGBmhW70/s06CJKwju8tKZF/WKACrEA0YcpzoKMzBDaWqYQy9O6IooB+x07ATRx+OtD
         7TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwK2lOHer0ivTS7WMTALZhkWdFn5jBdMUCU7hbO2JPE=;
        b=BQ9J9ChGsUO17M+WqXqSW0PjvlhMm2NW4C9YRkR6n4oZ7aHx1/xIpYw90NZUnax3ev
         2xXVApIHeOWrZKVGOzyIgtPNYZJsAhvNf7SJ3k8cCJCDcUGPj0WM2+nivTQmwX5Ctcux
         lkyHG2swaduYCM7Pxx7G2qIjA0G0B3tXmQKlFdmAm2EwFc8arBzaUBlFbnjXICBvNH2r
         GddPq3qek/zPtXCNi5Y/vMScnI85skkblnTPLk9wZIuO/lkpJPUeg7qdShaVIDzOB1jI
         nqAOsMtOzyCYnGleRVMBEbdD0zVc0ZdC5MgAN4pImQD+OgopLNvDCox8YATOG9oeJ6wT
         AlTw==
X-Gm-Message-State: AOAM530Q9Grc9JkMEO7qy1O9Hip7ZOMWqrcohAOVZgtGrSYhK0H/EdQt
        z/oOAR3AoGeJRJpQVD0wkp8sekA/Nbc=
X-Google-Smtp-Source: ABdhPJye703FxNGd3aujxOsctWejnDHBj8OKBeKn1+ErqBD7RMctkhMMQsLLsHYUbVz5NT7T56i4LQ==
X-Received: by 2002:a1c:7d10:: with SMTP id y16mr609153wmc.142.1605726269836;
        Wed, 18 Nov 2020 11:04:29 -0800 (PST)
Received: from localhost.localdomain (78-131-14-45.pool.digikabel.hu. [78.131.14.45])
        by smtp.gmail.com with ESMTPSA id n23sm5313432wmk.24.2020.11.18.11.04.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 11:04:29 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] tests: make sure nested lazy prereqs work reliably
Date:   Wed, 18 Nov 2020 20:04:13 +0100
Message-Id: <20201118190414.32616-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.29.2.612.g41c40d3f73
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some test prereqs depend on other prereqs, so in a couple of cases we
have nested prereqs that look something like this:

  test_lazy_prereq FOO '
      test_have_prereq BAR &&
      check-foo
  '

This can be problematic, because lazy prereqs are evaluated in the
'$TRASH_DIRECTORY/prereq-test-dir' directory, which is the same for
every prereq, and which is automatically removed after the prereq has
been evaluated.  So if the inner prereq (BAR above) is a lazy prereq
that hasn't been evaluated yet, then after its evaluation the
'prereq-test-dir' shared with the outer prereq will be removed.
Consequently, 'check-foo' will find itself in a non-existing
directory, and won't be able to create/access any files in its cwd,
which could result in an unfulfilled outer prereq.

Luckily, this doesn't affect any of our current nested prereqs, either
because the inner prereq is not a lazy prereq (e.g. MINGW, CYGWIN or
PERL), or because the outer prereq happens to be checked without
touching any paths in its cwd (GPGSM and RFC1991 in 'lib-gpg.sh').

So to prevent nested prereqs from interfering with each other let's
evaluate each prereq in its own dedicated directory by appending the
prereq's name to the directory name, e.g. 'prereq-test-dir-SYMLINKS'.
In the test we check not only that the prereq test dir is still there,
but also that the inner prereq can't mess with the outer prereq's
files.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

This came up while looking into:

  https://public-inbox.org/git/nycvar.QRO.7.76.6.2011152252520.18437@tvgsbejvaqbjf.bet/

because this did become an issue when I made the JGIT prereq depend on
SHA1.

 t/t0000-basic.sh        | 21 +++++++++++++++++++++
 t/test-lib-functions.sh |  6 +++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 923281af93..4031a0e3fc 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -831,6 +831,27 @@ then
 	exit 1
 fi
 
+test_lazy_prereq NESTED_INNER '
+	>inner &&
+	rm -f outer
+'
+test_lazy_prereq NESTED_PREREQ '
+	>outer &&
+	test_have_prereq NESTED_INNER &&
+	echo "can create new file in cwd" >file &&
+	test -f outer &&
+	test ! -f inner
+'
+test_expect_success NESTED_PREREQ 'evaluating nested lazy prereqs dont interfere with each other' '
+	nestedworks=yes
+'
+
+if test -z "$GIT_TEST_FAIL_PREREQS_INTERNAL" && test "$nestedworks" != yes
+then
+	say 'bug in test framework: nested lazy prerequisites do not work'
+	exit 1
+fi
+
 test_expect_success 'lazy prereqs do not turn off tracing' "
 	run_sub_test_lib_test lazy-prereq-and-tracing \
 		'lazy prereqs and -x' -v -x <<-\\EOF &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8d59b90348..94395b9807 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -474,15 +474,15 @@ test_lazy_prereq () {
 
 test_run_lazy_prereq_ () {
 	script='
-mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
+mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-'"$1"'" &&
 (
-	cd "$TRASH_DIRECTORY/prereq-test-dir" &&'"$2"'
+	cd "$TRASH_DIRECTORY/prereq-test-dir-'"$1"'" &&'"$2"'
 )'
 	say >&3 "checking prerequisite: $1"
 	say >&3 "$script"
 	test_eval_ "$script"
 	eval_ret=$?
-	rm -rf "$TRASH_DIRECTORY/prereq-test-dir"
+	rm -rf "$TRASH_DIRECTORY/prereq-test-dir-$1"
 	if test "$eval_ret" = 0; then
 		say >&3 "prerequisite $1 ok"
 	else
-- 
2.29.2.612.g41c40d3f73

