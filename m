Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07894C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 06:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C241120748
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 06:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDUbEgRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgCaGpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 02:45:00 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36698 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCaGpA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 02:45:00 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so665800pjb.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 23:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+RsEZz7jojn9pSOmhbVh5W+SmyWkJ70L2q6lysKSDfU=;
        b=TDUbEgRAM1SochY0IGS7j3bWYWr0Sj5gJST9R/CImJoLdkdm72RQDIRz0YR34egfj6
         xGztrXfr8yj+EeEUjybg4z8WBtbGrrurQzOJiSKPGvtbUNgAchwH9LR/9685koypfkZW
         ODrwfgcC0q7mW9qGLnkdcAURNUcRpqv99sy4xargsft6qAWGhbVeBcm5n9nHr8RFtQ1r
         JcuLm5/vgpybVvROjExCPJ0rGzmrme2boFib6zi0vG635M9IKtLYLnKjK40dnXneXGpi
         d56Ij+P/Y5uww7Jgl2dTPsW9q0/o28rGC82bGbePrUoe4PAvixdsbbT+VzuvueeJKidn
         Q/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+RsEZz7jojn9pSOmhbVh5W+SmyWkJ70L2q6lysKSDfU=;
        b=ApzSWdmDViqwtZjcpzd97U91EtaVAg/qu6i7tr71CA08WK2QjjGICGfeaGyd4/Sxhr
         UQvLMpvMqGOk33XpuEOKI391A20TC6YT40FGFLXLDnvhHk0Z1jAGrRGDRzuw2stjEeOm
         p6iXA9SQMxF6c8ghkCl3QNxIUtkq/YIiXhdwzjnz/LPlnmYT6YEKMragZNuBZ+zImf45
         3JHFnY87keSbPWD3wSTZx6dc/CvJPvUa9nrdIaePmjXZCUUw95go/6jg/JZRDU8RrciI
         TE44CUuP48QTyypLML9bfh512tIeMJdn0/UcFeHK33bu3c4YkVjcbyf2kydYiujuwEoJ
         nk/g==
X-Gm-Message-State: ANhLgQ2YtEeJ9v/aW7DY5ApLZcaAQbWs0laRA6ucEdeVovcMVilXejX0
        QWnlE9G9beWQgjSqeuH6fQbq8+r+
X-Google-Smtp-Source: ADFU+vs3NW6FTURHB2a4yYJA/TMl807+Z6SR3WgQmcALQznH8xNkVanL0hUDs1dD8nqBt6DRVyEebQ==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr16960037plq.59.1585637099006;
        Mon, 30 Mar 2020 23:44:59 -0700 (PDT)
Received: from localhost ([2402:800:6375:f121:1d2a:e7e0:840f:1f18])
        by smtp.gmail.com with ESMTPSA id g9sm4287602pgj.89.2020.03.30.23.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 23:44:58 -0700 (PDT)
Date:   Tue, 31 Mar 2020 13:44:56 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Dominic Chen <d.c.ddcc@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] rebase.c: teach --no-gpg-sign to git-rebase
Message-ID: <20200331064456.GA15850@danh.dev>
References: <81aea443-6978-93d7-c5d3-98dd731a1fd8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81aea443-6978-93d7-c5d3-98dd731a1fd8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-30 16:03:55-0400, Dominic Chen <d.c.ddcc@gmail.com> wrote:
> The subcommand `git commit` supports a `--no-gpg-sign` argument, which I
> find useful for cases where e.g. a GPG key is specified in `.gitconfig`,
> but is located on a hardware key that may not currently be attached to
> the system. However, other commands like `git rebase`, `git
> cherry-pick`, etc, which internally invoke `git commit`, don't support

cherry-pick (in git 2.25.1) understands --no-gpg-sign

I've encountered this in the past, but I stopped signing my commit.

Anyways, here is the patch

-----------------8<-----------------
From: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Subject: [PATCH] rebase.c: teach --no-gpg-sign to git-rebase

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-rebase.txt |  5 +++
 builtin/rebase.c             | 10 +++--
 t/t3435-rebase-gpg-sign.sh   | 72 ++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 3 deletions(-)
 create mode 100755 t/t3435-rebase-gpg-sign.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607..54023cf3bb 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -358,6 +358,11 @@ See also INCOMPATIBLE OPTIONS below.
 	defaults to the committer identity; if specified, it must be
 	stuck to the option without a space.
 
+--no-gpg-sign::
+	Countermand `commit.gpgSign` configuration variable that is
+	set to force each and every commit to be signed.
+
+
 -q::
 --quiet::
 	Be quiet. Implies --no-stat.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 27a07d4e78..a8cc5cfe0c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1593,6 +1593,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	options.allow_empty_message = 1;
 	git_config(rebase_config, &options);
+	// options.gpg_sign_opt will be either "-S" or NULL
+	// It'll be freed later, hence, no skip-prefix
+	gpg_sign = options.gpg_sign_opt ? "" : NULL;
 
 	if (options.use_legacy_rebase ||
 	    !git_env_bool("GIT_TEST_REBASE_USE_BUILTIN", -1))
@@ -1823,10 +1826,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.empty != EMPTY_UNSPECIFIED)
 		imply_merge(&options, "--empty");
 
-	if (gpg_sign) {
-		free(options.gpg_sign_opt);
+	free(options.gpg_sign_opt);
+	if (gpg_sign)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
-	}
+	else
+		options.gpg_sign_opt = NULL;
 
 	if (exec.nr) {
 		int i;
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
new file mode 100755
index 0000000000..d12b30b033
--- /dev/null
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Doan Tran Cong Danh
+#
+
+test_description='test rebase --[no-]gpg-sign'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+if ! test_have_prereq GPG
+then
+	skip_all='skip all test rebase --[no-]gpg-sign, gpg not available'
+	test_done
+fi
+
+test_expect_success 'setup: not-signed commit' '
+	test_commit one &&
+	test_commit two &&
+	test_must_fail git verify-commit HEAD &&
+	test_must_fail git verify-commit HEAD^ &&
+	git tag unsigned
+'
+
+test_expect_success 'setup: rebase --gpg-sign to sign all commit' '
+	git rebase --gpg-sign --force-rebase --root &&
+	git verify-commit HEAD &&
+	git verify-commit HEAD^ &&
+	git tag signed
+'
+
+test_expect_success 'rebase without commit.gpgsign config' '
+	git reset --hard signed &&
+	test_might_fail git config --unset commit.gpgsign &&
+	git rebase --force-rebase --root &&
+	test_must_fail git verify-commit HEAD &&
+	test_must_fail git verify-commit HEAD^
+'
+
+test_expect_success 'rebase respects commit.gpgsign=true config' '
+	git reset --hard unsigned &&
+	git config commit.gpgsign true &&
+	git rebase --force-rebase --root &&
+	git verify-commit HEAD &&
+	git verify-commit HEAD^
+'
+
+test_expect_success 'rebase --no-gpg-sign overrides commit.gpgsign' '
+	git reset --hard unsigned &&
+	git config commit.gpgsign true &&
+	git rebase --no-gpg-sign --force-rebase --root &&
+	test_must_fail git verify-commit HEAD &&
+	test_must_fail git verify-commit HEAD^
+'
+
+test_expect_success 'rebase --no-gpg-sign clear signed commit' '
+	git reset --hard signed &&
+	git config commit.gpgsign true &&
+	git rebase --no-gpg-sign --force-rebase --root &&
+	test_must_fail git verify-commit HEAD &&
+	test_must_fail git verify-commit HEAD^
+'
+
+test_expect_success 'rebase -i --no-gpg-sign override commit.gpgsign' '
+	git reset --hard signed &&
+	git config commit.gpgsign true &&
+	GIT_EDITOR=true git rebase -i --no-gpg-sign --force-rebase --root &&
+	test_must_fail git verify-commit HEAD &&
+	test_must_fail git verify-commit HEAD^
+'
+
+test_done
-- 
2.26.0.334.g6536db25bb

