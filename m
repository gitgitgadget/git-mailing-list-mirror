Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157EDC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C64613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhGEMfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhGEMff (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:35 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83006C061760
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso18154878otu.10
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9m/vdK0srFXQMGiuPuI2YU3FWSnp1s5FMBfe2gPFgg=;
        b=Rr6ws2Khc5khJ+4BLjIGey5P7fSgz8djNjAIzDhzEudK11uomFnonna/eX5+8FT99O
         jFjQH/mKmd3JS2qui2W8zcuGFxaz6/BFr9+M1BExmK7mCPgd6UXuQAJBRKmFXqyFKKgZ
         v6CdKFtJgn7+euTccp+68LVm5qaicbOwXRELyx9noNqeyvIVCKZCPhr6m/kTUHnsAP5B
         TMGH/LnhXL247bQC2VXs8BoUPQHtHqiRVeM26p3rA2Jtka2S2kFwXAR2VZICfbRlNEXF
         IUbwOeJE0nX6kwtmHNbB0PkI1KCsN71JTIKqpUxC/IQrkj9O2ve3WLrbn4lhPRFsDzAw
         nGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9m/vdK0srFXQMGiuPuI2YU3FWSnp1s5FMBfe2gPFgg=;
        b=NyFMBDkWdceyuDGXekKTjSTOwliKWhLckI0n8uCtt73TR215IpNK2BiCWdRgw7bWUo
         9+gYmGWQYAwbI/Zokcvwr9rUUv5KUlE2jJ3C54M0YU/Js2SJl/cX7pPjzzQ3EiSPKFok
         QhCtTtUBtdg4BnY+fbSaIORbyoDB5v8fh+IBtrWy/Fg4OdxzWKjiM02inM1GxirdeZjk
         pbfhfoWJsG8SDD1tgs+cbgnMWnHhFPGNq7rXxsQUpEjOaopNxRN8uiQMHcANOx4Iu6kB
         IVOIXDwDxSkdADiEKiiP7TTreFtjKzTikjRBNvt89G0PQO3T7q7e3EGAARG1+HaswBPw
         2vIA==
X-Gm-Message-State: AOAM5339TzH/YDH7DVrukwo7YSvzOlVwnlMmOy5EEnKkKrjGX/4z3gz1
        Kc5G7qeJdx6vuT89ZzBLnD4bRDR6hkHMOw==
X-Google-Smtp-Source: ABdhPJyslZXi+MSYYflRHciWrwLS+oyqdGB11+mH5MoKNn6BWdut4b+dDbOtd2Xr/ctswkr1GpxPWw==
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr10724449otl.8.1625488377709;
        Mon, 05 Jul 2021 05:32:57 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id e18sm2631938oiw.27.2021.07.05.05.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 27/35] pull: add per-branch mode configuration
Date:   Mon,  5 Jul 2021 07:32:01 -0500
Message-Id: <20210705123209.1808663-28-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many people have argued that `git pull` should have a per-branch
configuration for its mode of operation (e.g. Linus Torvalds [1] and
Theodore Ts'o [2]).

branch.<name>.pullMode achieves that.

[1] https://lore.kernel.org/git/CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com/
[2] https://lore.kernel.org/git/20130312212027.GE14792@thunk.org/

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/branch.txt |  5 +++++
 Documentation/config/pull.txt   |  3 ++-
 builtin/pull.c                  | 13 +++++++++++++
 t/t5520-pull.sh                 | 11 +++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index ba355f23e0..5f412caf62 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -101,6 +101,11 @@ branch.<name>.updateMode::
 	possible values are 'fast-forward', 'merge', and 'rebase'.
 	See `update.mode` for doing this in a non branch-specific manner.
 
+branch.<name>.pullMode::
+	When `git pull` is run, this determines the mode of operation,
+	possible values are 'merge' and 'rebase'. See `pull.mode` for doing this
+	in a non branch-specific manner.
+
 branch.<name>.description::
 	Branch description, can be edited with
 	`git branch --edit-description`. Branch description is
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index 646431a02d..3fb9bfdfea 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -32,7 +32,8 @@ for details).
 pull.mode::
 	When "git pull" is run, this determines if it would either merge or
 	rebase the fetched branch. The possible values are 'merge',
-	and 'rebase'.
+	and 'rebase'. See "branch.<name>.pullMode" for setting this on a
+	per-branch basis.
 
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
diff --git a/builtin/pull.c b/builtin/pull.c
index 124575c32c..bb3c0b55f9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -374,8 +374,21 @@ static enum rebase_type config_get_rebase(void)
 
 static enum pull_mode_type config_get_pull_mode(const char *repo)
 {
+	struct branch *curr_branch = branch_get("HEAD");
 	const char *value;
 
+	if (curr_branch) {
+		char *key = xstrfmt("branch.%s.pullmode", curr_branch->name);
+
+		if (!git_config_get_value(key, &value)) {
+			enum pull_mode_type ret = parse_config_pull_mode(key, value);
+			free(key);
+			return ret;
+		}
+
+		free(key);
+	}
+
 	if (!git_config_get_value("pull.mode", &value))
 		return parse_config_pull_mode("pull.mode", value);
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 663c15fcd7..59894dd15a 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -493,6 +493,17 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test_cmp expect actual
 '
 
+test_expect_success 'branch..pullmode overrides pull.mode' '
+	git reset --hard before-rebase &&
+	test_config pull.mode rebase &&
+	test_config branch.to-rebase.pullmode merge &&
+	git pull . copy &&
+	test_cmp_rev ! HEAD^ copy &&
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pull --rebase warns on --verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --verify-signatures . copy 2>err &&
-- 
2.32.0.36.g70aac2b1aa

