Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49CAC4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A921F60F6B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbhH3Vf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbhH3Vfu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:35:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFC8C06175F
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d22-20020a1c1d16000000b002e7777970f0so424623wmd.3
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nWO4BqwkxUM2dv2oWP3GVacCUlapndg/XgVj8QCbqkQ=;
        b=Z/GTjPkJ9O9DzsMCnOWa/6mP6UKfY1+BQPxrtGgSlIR66Aicgl24nWN6E3WqiFJyQM
         Bm8kvbztNHS6MhM171588oBNTaEjuLjBFIZLufuuoqtAzF6yqKkp5XXPmCYHG7m8fUgQ
         9ReZ2+fbtXq0T3zda4xJZQLvfiGGrFljIE1tvnIXvBFCUodrsK/C2zfKm8X9R3EfBUGC
         9oNaND4OYSMLU8i1o8VVB+WDmVrXzqJZBf8Z0+SWslxoe2gD+ZHopmZGJTdhdrDx4sPw
         QhGb0PmqdX1Piex1AvXlm6ZlFjm1znAl1Sk197g4n7b/uI6KT1R0C6fvo+O3+oGt9fyV
         BdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nWO4BqwkxUM2dv2oWP3GVacCUlapndg/XgVj8QCbqkQ=;
        b=ZHPhnKK37jV/DHwKZqZu20YHJptQoCFQeAYFiMMkCPFGWGsJV+fr0oIPiHsn36la82
         YcfZutL2pN+ofza7BgGUgasbW0xUdh7S8xufdN2GK8z24z9eSg7Vive9Ndse3ZPfBNlS
         Kpvp+8iG/rbSA9NJfE3q3kCZueUI9WPg9f3Tc9RwS+2nxVkav8dJLsijLI1QUE9nSm5n
         PL3d4g00IGZIlvLH9Gvv0Gtxv6iM6luDf4vGtUNNBa9oaD4MseHAfhaPv6OniepgaNkC
         R14U9qJD9UA3aJbQhUOTNws+EviGLOnKUejeLLqVtQTGYlPYTgGvNHlDunC/tW+RwosI
         JJCQ==
X-Gm-Message-State: AOAM533ruinSOV7fMTQHWXK9INiZ3HdJuefqFd3Q23IwHshd00i4tf+Z
        GTYgE/43koTnJ96HpxpRVXTM+Q5eu/k=
X-Google-Smtp-Source: ABdhPJyInqFvD7Xh5pf9uJFJQlsCeu5lssc3JW95KXbH4bif0fkiKYgoyYFMxdjErG95xsx93+EAKg==
X-Received: by 2002:a1c:98d8:: with SMTP id a207mr969739wme.16.1630359294673;
        Mon, 30 Aug 2021 14:34:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r25sm17389900wra.12.2021.08.30.14.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:34:54 -0700 (PDT)
Message-Id: <087fc9be19491c10002eb0fc316bc72ff386d44c.1630359290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 21:34:41 +0000
Subject: [PATCH 06/15] scalar: let 'unregister' handle a deleted enlistment
 directory gracefully
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index ef91a1af38b..14e688f44a9 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -276,6 +276,24 @@ static int cmd_register(int argc, const char **argv)
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
@@ -289,6 +307,34 @@ static int cmd_unregister(int argc, const char **argv)
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

