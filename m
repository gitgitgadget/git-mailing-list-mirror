Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8EDC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 00:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiCJApm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbiCJAph (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 19:45:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1518112558B
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 16:44:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso3063602ybs.20
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 16:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RffSdoI9rGHS3QDkc4PdZt5EMNurSxkFhWtc/dr9MaU=;
        b=svJmfEQeqv1aiDcmYluUCS7oOcdJoGRM8u+d14BNsntIJR060495nMUn4VbLYLxNSM
         wN9RlsdCdXXusCGLdyxA1c86OdlFnlPZ8osLFJwcUFTnyRBdMw77e7jkWVYEUwd8aoLX
         YtcUtHtAqlhHfTdZAXzrY66+dG5OApqtu7WoPJKZ8PC57Qk8Vj28tsM5IjJ+lfQD4Q95
         poqv1y9TcgxSY6F/GdGVtiLOr6ObEkf/T8ANzgFL/+hvOgMjtifuVC6KkkElkf6apcRC
         pR/4ofRhJKeqgrRktMTy92UUGRT5wqiCc8zdnspWU/wFpOWnMjRdnc5yeOkqdzil66Hq
         p1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RffSdoI9rGHS3QDkc4PdZt5EMNurSxkFhWtc/dr9MaU=;
        b=pvEZNdAuGnxDmZcgy0bhJDUT/6qyKSliA+jpWH67XwV9ocbY76uqubBfpEJcte3IR7
         UmeG3b8i5b5EFzc1sfK7yR2Y5Vb5jvdt/p8b9wUAjf34QuhbvoBtcgOA24zDpDA1mVcZ
         bFW4VlWwHSL1kihbwQO/gHfxhO4pVIutltjTdZEhYqCG4yO84y3jW4T3cq+yQfC74XHa
         r4YccW5IwLqEnCdOdC9a5z4G60+E89q1orOwyOmtLZsUcWy4nsuzkYcbdx7aMXk7zZj8
         kvSGanrUvbgfiHJy7fX/vElT9ieGJJJn8+0fAFXtdVvI10WXLA2uBiSZH/UGQigNWnQz
         zSEw==
X-Gm-Message-State: AOAM533D05pylphHR2zQqMRdFqvJd55cjKbAfoGunVFjbwk0pAyP46O/
        PuBcUaxka+PjRgn/N7MmJTksqDE1PIsxddgUVVcjkNp4J1WMdhi/yWEke2dlsACx128qyFDXw5E
        MqSBMWJuYvO2lczSmx4y+KXwW+cf9z0/8+4anIjncflZTXfeZNVwOBIP18baG4sbrrqjw86LMtA
        ==
X-Google-Smtp-Source: ABdhPJz5M9HLcn20f79tJ34cpb4PW8Wi7EnoVjfLV7oR1C1aZ/8NcLfBiU7SVD8JxwFNy5sSdW4LDgN3vngKUp/0avg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:e0ed:468:c28b:9b23])
 (user=emilyshaffer job=sendgmr) by 2002:a25:8a06:0:b0:628:cac2:146e with SMTP
 id g6-20020a258a06000000b00628cac2146emr2037096ybl.248.1646873077179; Wed, 09
 Mar 2022 16:44:37 -0800 (PST)
Date:   Wed,  9 Mar 2022 16:44:23 -0800
In-Reply-To: <20220310004423.2627181-1-emilyshaffer@google.com>
Message-Id: <20220310004423.2627181-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220310004423.2627181-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v9 3/3] rev-parse: short-circuit superproject worktree when
 config unset
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit, submodules learned a config
'submodule.hasSuperproject' to indicate whether or not we should attempt
to traverse the filesystem to find their superproject. To help test that
this config was added everywhere it should have been, begin using it to
decide whether to exit early from 'git rev-parse
--show-superproject-working-dir'. Because that command is fairly old,
only short-circuit if the new config was explicitly set to false.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 submodule.c          | 18 ++++++++++++++++++
 t/t1500-rev-parse.sh | 10 +++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index aafbd628ad..64760f1e3a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2231,6 +2231,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf one_up = STRBUF_INIT;
 	const char *cwd = xgetcwd();
+	int has_superproject_cfg = 0;
 	int ret = 0;
 	const char *subpath;
 	int code;
@@ -2244,6 +2245,23 @@ int get_superproject_working_tree(struct strbuf *buf)
 		 */
 		return 0;
 
+	/*
+	 * Because get_superproject_working_tree() is older than
+	 * submodule.hasSuperproject, don't rely on the default "unset = false"
+	 * - instead, only rely on if submodule.hasSuperproject was explicitly
+	 * set to false.
+	 */
+	if (! git_config_get_bool("submodule.hassuperproject", &has_superproject_cfg)
+	    && !has_superproject_cfg) {
+		/*
+		 * If we don't have a superproject, then we're probably not a
+		 * submodule. If this is failing and shouldn't be, investigate
+		 * why the config was set to false.
+		 */
+		error(_("Asked to find a superproject, but submodule.hasSuperproject == false"));
+		return 0;
+	}
+
 	if (!strbuf_realpath(&one_up, "../", 0))
 		return 0;
 
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 1c2df08333..dd35036bd6 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -244,7 +244,15 @@ test_expect_success 'showing the superproject correctly' '
 	test_must_fail git -C super merge branch1 &&
 
 	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
-	test_cmp expect out
+	test_cmp expect out &&
+
+	# When submodule.hasSuperproject=false, --show-superproject-working-tree
+	# should fail instead of checking the filesystem.
+	test_config -C super/dir/sub submodule.hasSuperproject false &&
+	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
+	# --show-superproject-working-tree should print an error about the
+	# broken config
+	! grep "error:.*hasSuperproject" out
 '
 
 # at least one external project depends on this behavior:
-- 
2.35.1.616.g0bdcbb4464-goog

