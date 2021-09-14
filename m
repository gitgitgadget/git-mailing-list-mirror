Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC12C433FE
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85F7610A2
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhINOpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbhINOoh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:44:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8033C0619FB
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x6so20595585wrv.13
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8FE3y0fGxiycG0w1Lwj4WjBo2HVuo6K0aDkta9kvYZ8=;
        b=YnorxewcP9yG84ffWcAr9YFBPRjFXqNGtzoT+Zrk4WKflLzYSWhsgKcHN6JCqofKKG
         n8yR6vhdrj2JQQtMUmaGwTfoMQmewuendjUfT/sxGIlK2YlhwodjuMdMeTG/O8cDwvz1
         2OQ7bje1zdfduMJdPkP1H78blmTrG5lCQ1AjufX9BGST5eWX1yy5TuzKu5g1Hp4ObTc+
         acCB3On7+wpAPYTbTVsSJ19nIu1itxY/Kv7pMZMMwymBAZqmqUynJncINg4ZDyXkOWI/
         Z0d2jF80Up6WjhRZxOyzzq+3WO0zLhyLk9jHL8fYtkL8ETWlQdDbMx5JEWrl4qua6YOx
         maTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8FE3y0fGxiycG0w1Lwj4WjBo2HVuo6K0aDkta9kvYZ8=;
        b=MetRcrTXlI9oUi3uu48Xx2uVq2Yh9+UCcIJxAOT19hV8xoNhdpmxI2DFLUmsupPCZn
         TRSlZFgFuWe39CaMDHnPh7WdHdJTfXl+eNmvCQpUtdulFZQAPD/6B3r7s/S+gErn72A8
         nZbpa0OD8La/oZNExDgXz6NqtmYh/FTP4/dIuzttdq0VdBVbmRAWYxQlfP1hsai8/3bO
         YaYrjPYiqp8FnobJ4Z97Q+lGqu8eCSPqS7bfUjJsn4pmhU+Vj2ybCB4yXob12NKwvTOM
         yd6uSGEHkk7ArfmNod0CY5x0iKjzcLm7iVBhEWAMvQJLvVmM2UfvKR/14FBvBt3jCY29
         kjug==
X-Gm-Message-State: AOAM530HRsQ6/6R3ITJtGuYX4F4WraNDxpqAdYlzFKiyhfRV3/7dm1Ah
        CfTIUa67wMbftQyQoKA5rrGlrky4SFc=
X-Google-Smtp-Source: ABdhPJyYTpIfI37AYHWDo7Vg6cIoh2f9fq+7/Pp1rmyqg1sWwAhs9BjYuED1ZPF8fbzR88En7a7XNg==
X-Received: by 2002:adf:fb8d:: with SMTP id a13mr19212931wrr.164.1631630362349;
        Tue, 14 Sep 2021 07:39:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f20sm1294637wmb.32.2021.09.14.07.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:39:22 -0700 (PDT)
Message-Id: <c3c2f3a497127efaeacb5563ba9ef2c3a2a0b6b1.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 14:39:07 +0000
Subject: [PATCH v4 06/15] scalar: let 'unregister' handle a deleted enlistment
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
index 2b5c52a25f5..d114c038b64 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -275,6 +275,24 @@ static int cmd_register(int argc, const char **argv)
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
@@ -288,6 +306,34 @@ static int cmd_unregister(int argc, const char **argv)
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

