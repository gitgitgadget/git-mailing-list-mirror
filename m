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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660A2C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6E610F8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351979AbhIHT0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350638AbhIHT0B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:26:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1655EC0613D9
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:24:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q11so4849349wrr.9
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8FE3y0fGxiycG0w1Lwj4WjBo2HVuo6K0aDkta9kvYZ8=;
        b=gGr21GH8UWfThEiwUSMuewfBZhHx/rehGClI6nveRa3CniWuS7JfWqsemqWBNLECnF
         IXQg08dv60ZomYOIkcRLwIJpF4BLq0wr5zqw9Onr0nMjBmD0llLq+e5jD/59qQ67wzcx
         p2rVi4LE3K8vgDHVbAAjQWkZX9gg5n5Yg3RIooaG5PEq8108bwDQnuCYrywFIhiQ/1gg
         LWWSQeVd951BVue5+b5WjKNdQphd6MrZUYy5YNx3E/xZemt8SE3vHY7CoIh3x8nYC6Iu
         KUBzOspnoU3LqGizjJxBDVIZ5K4S6hC6QvF2ViRsjMGVpNFsmkXyuw+YuoCpLzWMgCMa
         8xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8FE3y0fGxiycG0w1Lwj4WjBo2HVuo6K0aDkta9kvYZ8=;
        b=fbphgWw2IlR0FK+dFUyDg3p/9An7Sen32D3DQf7KCMJ7fAJg+5V+jgeNxdRvXWlDfc
         cs88fczTbIOo6K3q7H3VfuX4zZv5veUViU8XME8cHW9KxuIsan66eO3i21y6ExgnZqLQ
         h3LZNaRY2z3LoMz+iixUKiDhz9Y4AidgXnHtkRaQ9eG/Y4fpfoI1okgBTEpcQHJJP+pf
         304ArLWFymfmSqJnugLTWbH6ONl12mETQwAiDZ0sNiOXOw93LdgoI0HXel5oBr/2J2Uz
         qd5FtFsphoSDEB9lZjwlu8IoNrYfNXdQLdPtGBbeJ0dcmSBT62eQ4Hc6mUBmRV27Yya0
         hsBw==
X-Gm-Message-State: AOAM532Otag79fapJIMJOy2slUtuDUNdOBn9qGzG8scyu2oeegmG3oWQ
        63xOaCPHBWwnsRksJCtaejDmON5rTlE=
X-Google-Smtp-Source: ABdhPJx40ThqMQlbiyYUu4aP7J3pFpAeYIVhPWdpyBvn084O+TkZMOVgi+2uu5heH2RKcPxUKul/Jw==
X-Received: by 2002:a05:6000:1627:: with SMTP id v7mr5653233wrb.195.1631129090770;
        Wed, 08 Sep 2021 12:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm11327wrz.61.2021.09.08.12.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:24:50 -0700 (PDT)
Message-Id: <82dd253154fb8dabd6f344df2196d8e6261d09a5.1631129086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 19:24:36 +0000
Subject: [PATCH v3 06/15] scalar: let 'unregister' handle a deleted enlistment
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

