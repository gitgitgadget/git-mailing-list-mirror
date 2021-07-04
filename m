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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C13CC07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 05:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D7E6138C
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 05:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhGDFtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 01:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDFs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 01:48:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0923CC061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 22:46:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o18so14180115pgu.10
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 22:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bEGdnwjeVLlJ/tSRr2lABfjMOpAu7t+xKvA0X5KL2M=;
        b=jZXgQnXAn5TugcaseLE1uJa+ZBR0YH7+lwUNK0RtEJcPYblZZYVJ8YLesnS68I0sYv
         vQ47cs0XoK9OSYWYwhTFgSLlaC1EbpQ9jj/GobbLZl9PBynz6NMs2AhMacO9P2qI7fsK
         yRsTYvBGf1Hbx+EeUzuNRTPTi7taxgfJW2T9dVqoyVHffBuZTvvPry5cIrf0QRzcjiOz
         wEdCNAL2S2l6xcNd2f6ZC4thkRQ6APzuVPHnzFDI6T81GD4kUN9ikuTgXKrem5sw0261
         D9tKpkTMEps4nhwLYcMDqLfLy0y92I9Er4N/wMCWQG/KtLF8CRuqjDn9la96FRa85XoI
         lkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bEGdnwjeVLlJ/tSRr2lABfjMOpAu7t+xKvA0X5KL2M=;
        b=QwpK1U37c8Hg2dX9n2krY5OngJAl987rf2OIqC9LNUkZ0kqq5FQ7dZNipF709UkXlN
         8QqL8sq5AjGR4ewTDvH1Wp5otSepzFXOXQXIaNyRo9g1gjfPAjh06OASw4vUKGzkbm5m
         Z1roXfm2ooamJ2rx7ObnoPm0shDjBfkNi+8HOJQQkwJbFDIRK+zuLf7TiA/sjxdt75Ly
         qDUzB4PlN1QO7QZNMJiFXxrGDPBTksdoX/qGuPaLazAFaeJVPogM8BbKsB/wKLb3tzQC
         d3PKDm7lfWXDLbXnG1C2vaqpD+fhtDrlF/Uf+WvDS3i03gnIicH+O+yHHMpUg2siLV66
         iMuA==
X-Gm-Message-State: AOAM53105DwSC2HYtEKVtqQcqWdpTW99kvKGFlifFKZwUo7BiilCI7w2
        02e3lSFq/OQlMS5yKtcoiSDbfNo56kA=
X-Google-Smtp-Source: ABdhPJxp9CMK1kioi1KTh6EwoMMFLjs+TExjgjwtvRklCXmaLtslVnuK6UNdn/XFaTz5OirD9oiRgA==
X-Received: by 2002:a63:1f25:: with SMTP id f37mr8730887pgf.61.1625377581346;
        Sat, 03 Jul 2021 22:46:21 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:ac70:88b3:9959:84e3:df13])
        by smtp.gmail.com with ESMTPSA id i8sm8182379pfo.154.2021.07.03.22.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 22:46:21 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 1/3] test-lib-functions: introduce test_stdout_line_count
Date:   Sun,  4 Jul 2021 12:46:10 +0700
Message-Id: <ab542ae9aa35decd2bc55561c5ba8f5653fa07a2.1625362489.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.172.g7674896d58
In-Reply-To: <cover.1625362488.git.congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com> <cover.1625362488.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some tests, we're checking the number of lines in output of some
commands, including but not limited to Git's command.

We're doing the check by running those commands in the left side of
a pipe, thus losing the exit status code of those commands. Meanwhile,
we really want to check the exit status code of Git's command.

Let's write the output of those commands to a temporary file, and use
test_line_count separately in order to check exit status code of
those commands properly.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/test-lib-functions.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f0448daa74..f9505be8fe 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -845,6 +845,32 @@ test_line_count () {
 	fi
 }
 
+# SYNOPSIS:
+# 	test_stdout_line_count <bin-ops> <value> <cmd> [<args>...]
+#
+# test_stdout_line_count checks that the output of a command has the number
+# of lines it ought to. For example:
+# 
+# test_stdout_line_count = 3 git ls-files -u
+# test_stdout_line_count -gt 10 ls
+test_stdout_line_count () {
+	local ops val trashdir &&
+	if test "$#" -le 3
+	then
+		BUG "expect 3 or more arguments"
+	fi &&
+	ops="$1" &&
+	val="$2" &&
+	shift 2 &&
+	if ! trashdir="$(git rev-parse --git-dir)/trash"; then
+		BUG "expect to be run inside a worktree"
+	fi &&
+	mkdir -p "$trashdir" &&
+	"$@" >"$trashdir/output" &&
+	test_line_count "$ops" "$val" "$trashdir/output"
+}
+
+
 test_file_size () {
 	test "$#" -ne 1 && BUG "1 param"
 	test-tool path-utils file-size "$1"
-- 
2.32.0.278.gd42b80f139

