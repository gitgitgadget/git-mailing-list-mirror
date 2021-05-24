Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C055C47084
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9D361414
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhEXXQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 19:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXXQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 19:16:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52034C061756
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:14:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u133so15670653wmg.1
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8gwIVnahlE/Z6nkMdFpXlLHCfhTjQ+ZrixUofY1K+4A=;
        b=UFDbkHdp3VCvBrOm9QBshML/gE2+qRKhWSCR40hxepnsZF4IkJTFH3eOZx+Rot8Lpq
         U0CIQgxa5u2vQI9wm75Y0zQRQy4kGRnn5hdadt/Smiqh3Qu23tDnWnlDcH+ntzCowIG/
         YFBFa3r+4eMlXE0PV+MH0h5leV5p0mxsvoJe4FdGVmFQ33SztX2Ri+sGX9hizgkKIWMi
         1UyjvZ2Pd1u8gDt1vO0WuHYSQuhL97Se9F7dF9uN1u/wwEzQfX9m1vbqSExPiza09hxk
         sRTEcAbAdSaP054mOelx9cL5qqAp1E1nfpJtTvDAsWJvRCFXbGt95vSnkNvxzZTvBOYt
         cvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gwIVnahlE/Z6nkMdFpXlLHCfhTjQ+ZrixUofY1K+4A=;
        b=fkR/BNsxRpy0tQ3Cb+jM/p0tKcfeLgXNweun9Ep2u3nm3cdJkDQCohSubtbXIEIqJc
         6/6B6+A85KPsg+gMymf8YaoGpAlVVVEMvL2zLsRCXBvI5KExAC+/TEOGG8W0lTe/+9po
         ZN0NfLYkExbGUZOdfrMACryICmimem2pLLl+YYDLPQV1SQbPF572/5MP/D4GUBw4TbFb
         RGvZgHnZ/6VA1RCswOSiIcd9uKYoIyXuptv/BghSnOknkJYvvI2qK+MLAWIqXfCHb7BE
         6PhWtm4HjWUGzmuxqa6c+4Vp84iDVtqDltuPNhQiKoXu464yPQ2znvk0AJjgNqPI+WQ0
         gqiQ==
X-Gm-Message-State: AOAM533z3qjln8oO/ems+3ptU9tA7l6t+jMi5z1li/c10kbo8wScedvJ
        nhBPMoW6fwl2ERNk77pWSbhG8X4Nq6pvcA==
X-Google-Smtp-Source: ABdhPJzU+wzqA3qPZ2moCH+8Y5VwX+mQnDfC5BupAvZQCGrA/wRQsrlFLkrD55W5AOQCao5NGlF5Fg==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr21457839wmd.116.1621898071644;
        Mon, 24 May 2021 16:14:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v12sm14067264wrv.76.2021.05.24.16.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 16:14:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] send-email: fix missing error message regression
Date:   Tue, 25 May 2021 01:14:24 +0200
Message-Id: <patch-1.2-df3a2b8562d-20210524T231047Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.388.g81c17cd8439
In-Reply-To: <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org> <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression with the "the editor exited uncleanly, aborting
everything" error message going missing after my
d21616c0394 (git-send-email: refactor duplicate $? checks into a
function, 2021-04-06).

I introduced a $msg variable, but did not actually use it. This caused
us to miss the optional error message supplied by the "do_edit"
codepath. Fix that, and add tests to check that this works.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl   | 12 +++++++++++-
 t/t9001-send-email.sh | 23 +++++++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 175da07d946..170f42fe210 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -219,8 +219,18 @@ sub system_or_msg {
 	my $exit_code = $? >> 8;
 	return unless $signalled or $exit_code;
 
+	my @sprintf_args = ($args->[0], $exit_code);
+	if (defined $msg) {
+		# Quiet the 'redundant' warning category, except we
+		# need to support down to Perl 5.8, so we can't do a
+		# "no warnings 'redundant'", since that category was
+		# introduced in perl 5.22, and asking for it will die
+		# on older perls.
+		no warnings;
+		return sprintf($msg, @sprintf_args);
+	}
 	return sprintf(__("fatal: command '%s' died with exit code %d"),
-		       $args->[0], $exit_code);
+		       @sprintf_args);
 }
 
 sub system_or_die {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 65b30353719..2acf389837c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -644,14 +644,33 @@ test_expect_success $PREREQ 'In-Reply-To with --chain-reply-to' '
 	test_cmp expect actual
 '
 
+test_set_editor "$(pwd)/fake-editor"
+
+test_expect_success $PREREQ 'setup erroring fake editor' '
+	write_script fake-editor <<-\EOF
+	echo >&2 "I am about to error"
+	exit 1
+	EOF
+'
+
+test_expect_success $PREREQ 'fake editor dies with error' '
+	clean_fake_sendmail &&
+	test_must_fail git send-email \
+		--compose --subject foo \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches 2>err &&
+	grep "I am about to error" err &&
+	grep "the editor exited uncleanly, aborting everything" err
+'
+
 test_expect_success $PREREQ 'setup fake editor' '
 	write_script fake-editor <<-\EOF
 	echo fake edit >>"$1"
 	EOF
 '
 
-test_set_editor "$(pwd)/fake-editor"
-
 test_expect_success $PREREQ '--compose works' '
 	clean_fake_sendmail &&
 	git send-email \
-- 
2.32.0.rc1.385.g9db524b96f7

