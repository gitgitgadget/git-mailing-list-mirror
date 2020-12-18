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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF54C3526C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE1E23B8C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgLRVLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgLRVLv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:51 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0918C0611CD
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:48 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s2so4340640oij.2
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNEMEKzSDTCVU2kILL0ju1Yn8sQa1nHeURrNwfpMW/Q=;
        b=BR6pZBq0LSNQ36up+UfLXKtynNGuZN4gmdUmJcQsho/u65jWQ5BWYsGLvozcyrcsek
         0d3arG1lxN9BHfYlA6N/z+XlsaJiIHyqIJs/pDXQ89O/x+H7IwtqTJJgxgxiaPL+zIYq
         AcbjyX48cJrYheZe1cX3rCfE54F0uAGLWTX8K5BxocjtaGnlpuvV0vqsPYiKUl1Wf+hr
         sKOZg5maYVLPX0bhHTDe+b9R6XhlM8vHrHqNQ3swwCFRulMF/9KH3P5FuMQQcW4sTFH3
         uDiaBHBgrHdSyNW2tD51tbeL30ughiYdmMCgwJJEy9qi1qV44ib7NMY+pzmI+KlLvPUH
         lmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNEMEKzSDTCVU2kILL0ju1Yn8sQa1nHeURrNwfpMW/Q=;
        b=icpKUXCQYt+s04lFZBFQKcgAWdgoqQCkRGvt60zCj1rCd0W/u4Qv+moeqZzk9mH7zf
         /It5A/H+whI58ibevyRohlF55x5VeTYGfWthLikG4VvFK1TQ5NkdBOMT+Q4aZrKMPGO7
         ZF1UmJ7YC6GYTUe4lY4cMl+3soyernnYzYuSG91wl0j1UkxesWc+Z2710U3ktk5uzlyV
         J29qUfPxmM53Wdy9sJBi7W5+C9QQEjDENjkB8QXS2/qswuaTq8B4r3Nt+RZDgG32o1lx
         aiABmDFFF3HnF9+MgDftpd8Jhv6qgWqIzumFjy6za6GebC4R+2S7cfF38RRdxVOLnjah
         HEjA==
X-Gm-Message-State: AOAM533q7JUdldEs7FXuhFDx8URCTSa3HTzttdxTYUO/9Pd8S41jaOeQ
        wD9R4y9wwKwhdQuR2mb98C2p+7+yFBzVPw==
X-Google-Smtp-Source: ABdhPJwIj0uL35ZdNRFaVj3zHzj0HyP5kTUfKcjB31e54pyS76HCM2HBgej6d730+SBH8dEzaJEK2Q==
X-Received: by 2002:aca:ba42:: with SMTP id k63mr3995362oif.111.1608325848044;
        Fri, 18 Dec 2020 13:10:48 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g12sm2170354oos.8.2020.12.18.13.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:47 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/13] pull: add pull.mode=fast-forward
Date:   Fri, 18 Dec 2020 15:10:24 -0600
Message-Id: <20201218211026.1937168-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is very typical for Git newcomers to inadvertently create merges and
worse; pushing them. This is one of the reasons many experienced users
prefer to avoid 'git pull', and recommend newcomers to avoid it as well.

To escape these problems--and keep 'git pull' useful--it has been
suggested that 'git pull' barfs by default if the merge is
non-fast-forward, which unfortunately would break backwards
compatibility.

This patch leaves everything in place to enable this new mode, but it
only gets enabled if the user specifically configures it:

  pull.mode = fast-forward

Later on this mode can be enabled by default.

For *some* of the long discussions you can read:

https://lore.kernel.org/git/20130522115042.GA20649@inner.h.apk.li
https://lore.kernel.org/git/1377988690-23460-1-git-send-email-felipe.contreras@gmail.com
https://lore.kernel.org/4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/pull.txt   |  4 +--
 Documentation/config/remote.txt |  4 +--
 builtin/pull.c                  |  6 ++++-
 rebase.c                        |  2 ++
 rebase.h                        |  3 ++-
 t/t5520-pull.sh                 | 44 +++++++++++++++++++++++++++++++++
 6 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index f4385cde33..2b5e813259 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -32,8 +32,8 @@ for details).
 pull.mode::
 	When "git pull" is run, this determines if it would either merge or
 	rebase the fetched branch. The possible values are 'merge',
-	and 'rebase'. See "branch.<name>.pullmode" for setting this on a
-	per-branch basis.
+	'rebase', and 'fast-forward'. See "branch.<name>.pullmode" for setting
+	this on a per-branch basis.
 
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index a732c92cf5..e7db1d46c1 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -87,6 +87,6 @@ remote.<name>.partialclonefilter::
 
 remote.<name>.pullmode::
 	When "git pull" is run, this determines if it would either merge or
-	rebase the branches from this remote. The possible values are 'merge', and
-	'rebase'. See "pull.mode" for doing this in a non
+	rebase the branches from this remote. The possible values are 'merge',
+	'rebase', and 'fast-forward'. See "pull.mode" for doing this in a non
 	repository-specific manner.
diff --git a/builtin/pull.c b/builtin/pull.c
index bfadd585c7..ef23d8a52f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -985,7 +985,7 @@ static void show_advice_pull_non_ff(void)
 		 "\n"
 		 "  git config --global pull.mode merge\n"
 		 "  git config --global pull.mode rebase\n"
-		 "  git config --global pull.ff only       # fast-forward only\n"
+		 "  git config --global pull.mode fast-forward\n"
 		 "\n"
 		 "If unsure, run \"git pull --merge\".\n"
 		 "Read \"git pull --help\" for more information."));
@@ -1027,6 +1027,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		switch (mode) {
 		case PULL_MODE_MERGE:
+		case PULL_MODE_FAST_FORWARD:
 			opt_rebase = REBASE_FALSE;
 			break;
 		case PULL_MODE_REBASE:
@@ -1117,6 +1118,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
+	if (mode == PULL_MODE_FAST_FORWARD && !can_ff)
+		die(_("The pull was not fast-forward, please either merge or rebase.\n"));
+
 	if (!opt_rebase && !can_ff) {
 		if (opt_verbosity >= 0)
 			show_advice_pull_non_ff();
diff --git a/rebase.c b/rebase.c
index bdfca49886..9fe99b5b16 100644
--- a/rebase.c
+++ b/rebase.c
@@ -40,6 +40,8 @@ enum pull_mode_type pull_mode_parse_value(const char *value)
 		return PULL_MODE_MERGE;
 	else if (!strcmp(value, "rebase") || !strcmp(value, "r"))
 		return PULL_MODE_REBASE;
+	else if (!strcmp(value, "fast-forward") || !strcmp(value, "f"))
+		return PULL_MODE_FAST_FORWARD;
 
 	return PULL_MODE_INVALID;
 }
diff --git a/rebase.h b/rebase.h
index 5ab8f4ddd5..e66a73feb4 100644
--- a/rebase.h
+++ b/rebase.h
@@ -17,7 +17,8 @@ enum pull_mode_type {
 	PULL_MODE_INVALID = -1,
 	PULL_MODE_DEFAULT = 0,
 	PULL_MODE_MERGE,
-	PULL_MODE_REBASE
+	PULL_MODE_REBASE,
+	PULL_MODE_FAST_FORWARD
 };
 
 enum pull_mode_type pull_mode_parse_value(const char *value);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 59799ac4d5..45d818065f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -873,4 +873,48 @@ test_expect_success 'git pull --rebase against local branch' '
 	test_cmp expect file2
 '
 
+setup_other () {
+	test_when_finished "git checkout master && git branch -D other test" &&
+	git checkout -b other $1 &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master
+}
+
+setup_ff () {
+	setup_other master
+}
+
+setup_non_ff () {
+	setup_other master^
+}
+
+test_expect_success 'fast-forward (pull.mode=fast-forward)' '
+	setup_ff &&
+	git -c pull.mode=fast-forward pull
+'
+
+test_expect_success 'non-fast-forward (pull.mode=fast-forward)' '
+	setup_non_ff &&
+	test_must_fail git -c pull.mode=fast-forward pull
+'
+
+test_expect_success 'non-fast-forward with merge (pull.mode=fast-forward)' '
+	setup_non_ff &&
+	git -c pull.mode=fast-forward pull --merge
+'
+
+test_expect_success 'non-fast-forward with rebase (pull.mode=fast-forward)' '
+	setup_non_ff &&
+	git -c pull.mode=fast-forward pull --rebase
+'
+
+test_expect_success 'non-fast-forward error message (pull.mode=fast-forward)' '
+	setup_non_ff &&
+	test_must_fail git -c pull.mode=fast-forward pull 2> error &&
+	test_i18ngrep "The pull was not fast-forward" error
+'
+
 test_done
-- 
2.30.0.rc0

