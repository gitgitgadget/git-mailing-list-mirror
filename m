Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DF541F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeBUSwD (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:52:03 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35620 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753752AbeBUSv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:51:56 -0500
Received: by mail-wr0-f194.google.com with SMTP id l43so7392879wrc.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 10:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ifx0TRo/nsfZS5wNyl46GCxrhhBG6UcJCGQpRxGmso=;
        b=sj0U4+A3SHeFmLn5EqMuH+Lbb084DTR3bkpBZ2O6hqFLPuOiIRVwmSuNWaS2lJ9hmL
         9023X/HRjLjFLXlnxX26s9D3EynYtak/FBdLka6b0XKcen16ZH6q7sK1AMXRDzAgKEGj
         vZqAIguPrRNr2MBkrxKSG3KxnrMmW2RCeRuioAKfAzR16+qM094SisgXVjTFSpVHQ/zV
         DObOccHNvQ/hgF6Zq6qvG7bMMCPbmk7b26cIGY2MFjevJ5R+YvImlIre22Lrb16DO6Dy
         YPcDU2IYht91Zkfpy/PGEb0AppeeSZdPgn6a6QegxcAmdlc23Z4A8fIOn9Y5URvhCyqu
         dlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ifx0TRo/nsfZS5wNyl46GCxrhhBG6UcJCGQpRxGmso=;
        b=f4CumgP2Dxs0Xg8fnm6wniBOAjPdE+uEJuhOYAkh43kDwAB53vc8T6oLvfeFFVwhQF
         u8nA+5MfVHBnF+Pv2xVMxS196hXXXKdR+PQG3rJnUhAJ77TbWyxibJlCbvzU55EAeuKf
         jo1v+PjuW4ZefOX/xpMXyMoM8MEOngY7RjQNmle9op5srZUh/OrWI/b0+zAJTUjNitMk
         +xpwIVLr9ON+Sg3IaOpA+1Cgcn35n254vYrDPh8OSQ6lJlHBpSjUgmAL+HmwIFJgfM73
         7L26b5KL4S0EnxfiVEMbj4JetbJOtVWN81f0rFV4rHTWip8hsfNm09uHZFWw/rgHn5ia
         6rBA==
X-Gm-Message-State: APf1xPAVQpD8BsYyrO8kKruwz0FESk6hLFLed8FLM35Fh+gQrNcj3AGP
        /+KL+A23s5ydWX3vn/aKklOFxhFS
X-Google-Smtp-Source: AH8x224Y8TqJ+qUyhQzNFYDnZ+yF0ciDlf6l84muSJqOh798fygT0HJuALjcSpku2l2cdZkoSEjmig==
X-Received: by 10.28.234.8 with SMTP id i8mr3149162wmh.44.1519239114640;
        Wed, 21 Feb 2018 10:51:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 128sm5224964wmi.20.2018.02.21.10.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Feb 2018 10:51:53 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] t7006: add tests for how git config paginates
Date:   Wed, 21 Feb 2018 19:51:42 +0100
Message-Id: <e16c55763bb667d0d332f0110a8e31dbc9286b30.1519238410.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519238410.git.martin.agren@gmail.com>
References: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com> <cover.1519238410.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next couple of commits will change how `git config` handles
`pager.config`, similar to how de121ffe5 (tag: respect `pager.tag` in
list-mode only, 2017-08-02) and ff1e72483 (tag: change default of
`pager.tag` to "on", 2017-08-02) changed `git tag`. Similar work has
also been done to `git branch`.

Add tests in this area to make sure that we don't regress and so that
the upcoming commits can be made clearer by adapting the tests. Add
tests for simple config-setting, `--edit`, `--get`, `--get-urlmatch`,
`get-all`, and `--list`. Those represent a fair portion of the various
options that will be affected by the next two commits.

Use `test_expect_failure` to document that we currently respect the
pager-configuration with `--edit`. The current behavior is buggy since
the pager interferes with the editor and makes the end result completely
broken. See also b3ee740c8 (t7006: add tests for how git tag paginates,
2017-08-02).

The next commit will teach simple config-setting and `--get` to ignore
`pager.config`. Test the current behavior as "success", not "failure",
since the currently expected behavior according to documentation would
be to page. The next commit will change that expectation by updating the
documentation on `git config` and will redefine those successful tests.

Remove the test added in commit 3ba7e6e29a (config: run
setup_git_directory_gently() sooner, 2010-08-05) since it has some
overlap with these. We could leave it or tweak it, or place new tests
like these next to it, but let's instead make the tests for `git config`
as similar as possible to the ones for `git tag` and `git branch`, and
place them after those.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t7006-pager.sh | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index f5f46a95b4..a46a079339 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -110,13 +110,6 @@ test_expect_success TTY 'configuration can disable pager' '
 	! test -e paginated.out
 '
 
-test_expect_success TTY 'git config uses a pager if configured to' '
-	rm -f paginated.out &&
-	test_config pager.config true &&
-	test_terminal git config --list &&
-	test -e paginated.out
-'
-
 test_expect_success TTY 'configuration can enable pager (from subdir)' '
 	rm -f paginated.out &&
 	mkdir -p subdir &&
@@ -252,6 +245,48 @@ test_expect_success TTY 'git branch --set-upstream-to ignores pager.branch' '
 	! test -e paginated.out
 '
 
+test_expect_success TTY 'git config respects pager.config when setting' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.config config foo.bar bar &&
+	test -e paginated.out
+'
+
+test_expect_failure TTY 'git config --edit ignores pager.config' '
+	rm -f paginated.out editor.used &&
+	write_script editor <<-\EOF &&
+		touch editor.used
+	EOF
+	EDITOR=./editor test_terminal git -c pager.config config --edit &&
+	! test -e paginated.out &&
+	test -e editor.used
+'
+
+test_expect_success TTY 'git config --get respects pager.config' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.config config --get foo.bar &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git config --get-urlmatch defaults to not paging' '
+	rm -f paginated.out &&
+	test_terminal git -c http."https://foo.com/".bar=foo \
+			  config --get-urlmatch http https://foo.com &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git config --get-all respects pager.config' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.config config --get-all foo.bar &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git config --list defaults to not paging' '
+	rm -f paginated.out &&
+	test_terminal git config --list &&
+	! test -e paginated.out
+'
+
+
 # A colored commit log will begin with an appropriate ANSI escape
 # for the first color; the text "commit" comes later.
 colorful() {
-- 
2.16.2.246.ga4ee44448f

