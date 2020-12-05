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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CB7C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A7F230FA
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgLETyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgLETyk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:40 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE7FC061A56
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:28 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id x13so1214676oto.8
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIjVNlDxbfW3e5eFM0I2zjl06KHCN+Uny4+Tmva6fqY=;
        b=JqxBKITfyqO23GKyxJsxLH4dFjX53wwKLsztacHDSFbSxYqrNY0jGiVZxYgQDECNZk
         sVa8K5Y3py13XLy0JFcpiy2OKebx8Z0OKEXqrUFGI9zJAyBR4ppy7mTwpahgwoDhRl2f
         ppqGOufyWVqGO3jQ5BdDEUMlcDzdEApGhF0ZDq8ZC7jEtcKH+NigPQDqMt38eCKzsIu1
         H/lt8j+4oAJLi/rCTt1g6VvePkkEZs4pWUrhUGDdPD7vdCwb1mDGS7uZ1NJpldIRkqQi
         yhrxp+fpBdt4JUuwV07znUtJADyXjQPA81NNbVKKI6ri/SCSliX+ghPh14KisHFu58YZ
         cDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIjVNlDxbfW3e5eFM0I2zjl06KHCN+Uny4+Tmva6fqY=;
        b=VKklg6six/xaGndbqmE841jAp1ixSG/IsKvceAXr3EtKfg/Umlze+ohflM5Yk2GYj8
         I4QirGUy5aheNkFwe4EbYWKkItXIHs1u067X8YDhbejDgZEZfzjvLLbID/HUq9Kqu23P
         bC914Xg5fFGYZaiC6YW7DDb6mQeL49cRaVFKSZp9ngwkdWOQIUWVBm5E4fK/HZTPW1El
         JEkdW6oaTuKo8ZutfffLfaKVR807FhOATf7bMqkgQMJrY+7O9Qm19wU8wlkkJ9R4ZnLr
         W24OWXm/gwmm0SlQ5S6MfRlCNuuqTQLBu2wsKg9p3Da8xq2AXhsXAkWCWs8Br6Cm0cI6
         v0wA==
X-Gm-Message-State: AOAM531cIPIsBzMQlAZ7CuuBJHbA+h9V95Z53Gsm3qooUdAYrrWIpHNK
        ayZGkiusPvgOC57eQSjFVj7+vIVBNZgXXA==
X-Google-Smtp-Source: ABdhPJzTQ3XYyXzhKlOV5WjJfrb8J24n8VXBVzQdqg+4OK9O30OFEFZ/SyoomCINliGxchEiArylLA==
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr8323404ots.286.1607198007319;
        Sat, 05 Dec 2020 11:53:27 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t25sm1515401otj.13.2020.12.05.11.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:26 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 07/16] pull: display default warning only when non-ff
Date:   Sat,  5 Dec 2020 13:53:04 -0600
Message-Id: <20201205195313.1557473-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to display the annoying warning on every pull... only
the ones that are not fast-forward.

This requires the tests to pick another base, so the merge is not
fast-forward. And in the cases where --ff-only is specified add
test_must_fail (since now they are non-fast-forward).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   |  3 +++
 builtin/pull.c               |  2 +-
 t/t7601-merge-pull-config.sh | 28 +++++++++++++++++-----------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index dc812139f4..ad33d2472c 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -60,6 +60,9 @@ However, a non-fast-foward case looks very different.
 	origin/master in your repository
 ------------
 
+By default `git pull` will warn about these situations, however, most likely
+you would want to force a merge, which you can do with `git pull --no-rebase`.
+
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
 until its current commit (`C`) on top of `master` and record the
diff --git a/builtin/pull.c b/builtin/pull.c
index 3fd9bd1bd2..300b17b962 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1013,7 +1013,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
+	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
 		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
 			"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
 			"You can squelch this message by running one of the following commands:\n"
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6774e9d86f..6b4adab8b1 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'pull.rebase not set' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git -c color.advice=always pull . c1 2>err &&
 	test_decode_color <err >decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
@@ -36,54 +36,60 @@ test_expect_success 'pull.rebase not set' '
 
 '
 
-test_expect_success 'pull.rebase not set and pull.ff=true' '
+test_expect_success 'pull.rebase not set (fast-forward)' '
 	git reset --hard c0 &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=true' '
+	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	test_config pull.ff only &&
-	git pull . c1 2>err &&
+	test_must_fail git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --no-rebase . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given' '
-	git reset --hard c0 &&
-	git pull --ff-only . c1 2>err &&
+	git reset --hard c2 &&
+	test_must_fail git pull --ff-only . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-- 
2.29.2

