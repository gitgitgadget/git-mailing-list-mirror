Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E7C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbhK3L7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbhK3L6S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:58:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B55C061748
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j3so43852813wrp.1
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uF47jrxySOx1RCAW8JfnsQEtxQMXRg+E9VpSAZcKnVw=;
        b=Er/g55Br2Ht4anzggGHzmDdxWE7hwWmUpF4tUR/OO0vYO1N0GATf7CJvcrhJATXXlv
         I475kA309xELD9ik8QEA+3Rklgr7QhB4OeQpLfpdHEcPgGZUJ2I/hkwdTUOvTpbu0IHo
         IsTuIUgLX3y3sEoeOd8ob+H3ZbGiMYzGriBZX6fvsUSwGMbx8FVaHjxm5YYSvy9thpMB
         Oz2nJZvJpNQEGPC7rfnRRrgfJnM7lTqgYX4xXM3QMfLx6qcubz4MXTDtXhM2LR3gmCb6
         4jUjaNwZQR8SJSy6rkm+UC7WpR81jzFlj8OUTI5MADHndCEprZpMv+LBHncxS2hiszDD
         YpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uF47jrxySOx1RCAW8JfnsQEtxQMXRg+E9VpSAZcKnVw=;
        b=OWc2l20nWa6v7LV4wsMVJ46rnQfqt8/hw5ktwJYOezpjBEPfa8y++T/QqJIsu04xIQ
         lSYGOHckbiDBfpjc3R+J86T4giFZrKfw/LYCUOXajOh3iCbE3vOiMrwVp3vpTBmBZ4Ez
         Ck7NSc1kXN0KeAXPHo3hBi11HM9J5oyy28woFtEUBcGML/hotVEJ1nFDCQaNUSXPDA/c
         +CzwMlNkU0Xa+QtHFJVn5e3R8yMqXJRmFM4T8r7R1/fejkuJcTWMjyTqvsldtftQGdpc
         N9o+q6kyeFNOZmzouLgxqJvsR9kGO6TrXZNj4xc07mp2sdYvqTiuL8Zs/QfGMtyVPnyp
         hDIg==
X-Gm-Message-State: AOAM530u2WreaVMt6XjLm0QhfciX+d5HlbW/Yvwflx7GVgP9YyE2VWPl
        b+AMb3qX8Rf2jRyknXHsX0yODHnOR80=
X-Google-Smtp-Source: ABdhPJyJZgKWi+9oj231ftppYzgjakryGdzShlnBOARwh813wMB2wvSPdOBXXzerHEN5FuZ51kisJQ==
X-Received: by 2002:a5d:6d41:: with SMTP id k1mr40508586wri.134.1638273297384;
        Tue, 30 Nov 2021 03:54:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm16427570wrx.25.2021.11.30.03.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:54:57 -0800 (PST)
Message-Id: <42121a5764d509e1bf87f6883f436a9bc7f010c6.1638273289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 11:54:41 +0000
Subject: [PATCH v9 09/17] scalar: let 'unregister' handle a deleted enlistment
 directory gracefully
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a user deleted an enlistment manually, let's be generous and
_still_ unregister it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 46 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh | 15 +++++++++++
 2 files changed, 61 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 9ab9dffe3ac..ec783e72ef3 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -269,6 +269,24 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int remove_deleted_enlistment(struct strbuf *path)
+{
+	int res = 0;
+	strbuf_realpath_forgiving(path, path->buf, 1);
+
+	if (run_git("config", "--global",
+		    "--unset", "--fixed-value",
+		    "scalar.repo", path->buf, NULL) < 0)
+		res = -1;
+
+	if (run_git("config", "--global",
+		    "--unset", "--fixed-value",
+		    "maintenance.repo", path->buf, NULL) < 0)
+		res = -1;
+
+	return res;
+}
+
 static int cmd_unregister(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -282,6 +300,34 @@ static int cmd_unregister(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL, options,
 			     usage, 0);
 
+	/*
+	 * Be forgiving when the enlistment or worktree does not even exist any
+	 * longer; This can be the case if a user deleted the worktree by
+	 * mistake and _still_ wants to unregister the thing.
+	 */
+	if (argc == 1) {
+		struct strbuf src_path = STRBUF_INIT, workdir_path = STRBUF_INIT;
+
+		strbuf_addf(&src_path, "%s/src/.git", argv[0]);
+		strbuf_addf(&workdir_path, "%s/.git", argv[0]);
+		if (!is_directory(src_path.buf) && !is_directory(workdir_path.buf)) {
+			/* remove possible matching registrations */
+			int res = -1;
+
+			strbuf_strip_suffix(&src_path, "/.git");
+			res = remove_deleted_enlistment(&src_path) && res;
+
+			strbuf_strip_suffix(&workdir_path, "/.git");
+			res = remove_deleted_enlistment(&workdir_path) && res;
+
+			strbuf_release(&src_path);
+			strbuf_release(&workdir_path);
+			return res;
+		}
+		strbuf_release(&src_path);
+		strbuf_release(&workdir_path);
+	}
+
 	setup_enlistment_directory(argc, argv, usage, options, NULL);
 
 	return unregister_dir();
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 16f2b72b126..ef0e8d680d5 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -14,4 +14,19 @@ test_expect_success 'scalar shows a usage' '
 	test_expect_code 129 scalar -h
 '
 
+test_expect_success 'scalar unregister' '
+	git init vanish/src &&
+	scalar register vanish/src &&
+	git config --get --global --fixed-value \
+		maintenance.repo "$(pwd)/vanish/src" &&
+	scalar list >scalar.repos &&
+	grep -F "$(pwd)/vanish/src" scalar.repos &&
+	rm -rf vanish/src/.git &&
+	scalar unregister vanish &&
+	test_must_fail git config --get --global --fixed-value \
+		maintenance.repo "$(pwd)/vanish/src" &&
+	scalar list >scalar.repos &&
+	! grep -F "$(pwd)/vanish/src" scalar.repos
+'
+
 test_done
-- 
gitgitgadget

