Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DE6C4332F
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhKSXHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhKSXGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:06:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC36C061757
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so11659748wme.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uLWWlghNT753Rcq+QFeAaezw69rdNihpNbSkEQ0YgSo=;
        b=UwTtNFOcBzcrprRCpgsil6Nca8R5uwrOR0IVs/tL5w9Zo/HdiTQBXDePtJBTY+rw+J
         ev9hQvZOD5PHDHKu/nncMcYVapip2p9PXg4o1I4CQGN4RNpqQ7eGRa9kqsVnbQzee9nw
         IMy2CrnnD8nc7s5d1mDaOtWZgCLB1/zQnSAzPCipu7vivQsKiewqb7cE9vtGPhzgc0qK
         Ac9HwKEGnWgoksTlWOnckqVrqMMbYf4CC97qlSkig1S+DesE1yocnjqGQmU4wKoTbShn
         mI3NnYYP8MiCAovRT9JsBS1rkcv/iG2v7SMauAy0QUlnXuRZq3iASkEF2NH054t1yNOq
         /EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uLWWlghNT753Rcq+QFeAaezw69rdNihpNbSkEQ0YgSo=;
        b=bB1odGPzRI2W/HpKw+pwLJy+w2LBAvY/TI2AYF6BTSY9N8n+o4YeQpIQ1Tb2zNVLdS
         Sn6mzJ0lwRIeCuhFz67Jcv6fBGewRWeSXBNGx/8rRDLCMj2UM1xZQuDsNJeAjr6Z7Ycj
         R3vV7vNyT33cDjdvBkXpPSsD927QuHavzzBR3yvWeJiLlusmSdZ21dN7MJ+fHiNropec
         07uNTqkOxjg32AZ8tjY/TNcx/DVpI6QCV2qXlzrU/i84+gZ33H3bkO4/JAbSfm1wZ4vX
         XIyJYNOf1gc2+yM0/h7lP53dQHbz9O1Lk2ER85DgM8ek5Y+Pn20E8e9plzCpuKr0eFBn
         pwiA==
X-Gm-Message-State: AOAM533BfGGG+KY/GDorA6sNYIUU2vpQD4toBLrMAOywgExjHPaFvarB
        qmDuPvpdqvymIaonJ9/YlLlaCO1W07I=
X-Google-Smtp-Source: ABdhPJyj/kC818DSmzSzek43ib7v9C/pSXzYjYe0WsXtkzqtnNmw0wCiZXQ5LOW4SK/P+kAQhEyP/g==
X-Received: by 2002:a05:600c:1f19:: with SMTP id bd25mr4213309wmb.75.1637363031800;
        Fri, 19 Nov 2021 15:03:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay21sm13762542wmb.7.2021.11.19.15.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:51 -0800 (PST)
Message-Id: <f7fc1958b9e5224268077064e49b4f7337a12861.1637363025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:36 +0000
Subject: [PATCH v8 09/17] scalar: let 'unregister' handle a deleted enlistment
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
index bab0271c37d..097d3bd478b 100644
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

