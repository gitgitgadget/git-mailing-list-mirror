Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B9EC433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381115AbhLCNiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352570AbhLCNiG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2162C06175B
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:34:39 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a9so5750957wrr.8
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uF47jrxySOx1RCAW8JfnsQEtxQMXRg+E9VpSAZcKnVw=;
        b=HsCbSU93wiGyN3PRS9Kz4juvCZ6JLWQTbFpFkGleqiX3B4F234vGfwsivlipts8/Pp
         mHsKpj3hYXOC1SzQOdMWz+V5sQfIUdWtpt8RrZtJXcpm52m5gXrAtJvaxjDpPk7UWIyC
         2s0FK0H8Usxdbxc9Eqnb4JOYDAVB2otlTwFfZGE4QT8xgd6xiWwYKbjdWFDbxC1eAl6/
         hZM3mnmO8fL0eLlVC4pSH34mLQ8qaof0fsrCOx7o2nqoQrvkevei3uzUynhCNpVGvoRU
         JG+y2aa5FD5DPstgfekpTGpgWRus7p5z7qN9HJ4cEcgoz8Pj/tCIAks8pNz/6cFZXtJV
         YxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uF47jrxySOx1RCAW8JfnsQEtxQMXRg+E9VpSAZcKnVw=;
        b=sw+kyHTKiwRb/0GwlzWi6F0m3g421LE/VRSC0rBNrNMyxhWAjXEYoZod/oTtquoqhp
         lvb7eKJdh7/zxrx6YhidMTsyrNZ0qeyCbSFTyV93RJer/bBbfwBKn4ZqfbMnpEPOwNFu
         NpLFcNucQtInlZiD20CoCGh6M4hoEjqZgxbOfHM4Qz/3sCn9J6F2W2p7DsbDnTTTkN9k
         ja2iGUU70njHX9EmMB/A6QCKnQGjYMTYZ9AurErl7GeBUKLMHQBBO9QvJAxkHAWjvHvl
         P1s2SFjYF5dOfEUi7ZGn27BMpQqwcqiU0Xf62/7MCzz+N0ACV0cI0vyolnTRw5U+Nmt4
         RTqg==
X-Gm-Message-State: AOAM530cRIph9+QDf+XFMta9saPAk/F+Lq5ovSKQR9RqLF10kvrgH12p
        t9+FsiyGF9y5CHh+cTabnyffh4Xvles=
X-Google-Smtp-Source: ABdhPJx0s+N78CwtZ8ZeS4qegotyMOhB6ApkuL7lVm1mvfDtz+A6EmkF/XLnn9qh6XPMqZKcNpvkig==
X-Received: by 2002:a05:6000:1a8b:: with SMTP id f11mr21262427wry.409.1638538478078;
        Fri, 03 Dec 2021 05:34:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p62sm2666705wmp.10.2021.12.03.05.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:34:37 -0800 (PST)
Message-Id: <c865e89beb31fba6e1fe17be76f2a7bb0098cb6e.1638538470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:34:21 +0000
Subject: [PATCH v10 07/15] scalar: let 'unregister' handle a deleted
 enlistment directory gracefully
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

