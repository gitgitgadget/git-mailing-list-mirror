Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EDAC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E13D24670
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPZ2PlVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgANT0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:26:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40190 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgANT0I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:26:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so13378939wrn.7
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PivbsZA5xs7Z4OVdw9SfaB6+yEBdhjFeZxYNnmofdOk=;
        b=tPZ2PlVOBKCbB0Uh5RUTGeESQFTsSINBLrn0vzGFj1aIiS5AVm0b9JTqO4kv4n7ROw
         ViIlPZlmTfzEj/ctHt1p/1FmUWb3TBwLijQHYr90zw9FdXc73yytCNpiwLKNZbc1xas+
         sa9TFYkQs92K6Lq1sCUpAB5vemcyiTsAvjr7icSADJ0ywORjdLgPt0k6K2UYtbQnDymO
         vYSq1cnLN393BGrD4FCL+Ro/HlbYijy1jRK2tANOFQFedYq/DlUhw/EI4UaDbo3aei7D
         Aw6pEube5RQM/h6RmPEa+cgT7M21aWidxjckdG7rin5WDAyZtnmfBsW+S23mx8S8JLqQ
         a4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PivbsZA5xs7Z4OVdw9SfaB6+yEBdhjFeZxYNnmofdOk=;
        b=jlCkNBbqkvaa5palHFaezJbAU/IPmL5hhV3Ms9WXhxb5vRqgfwt3fxDNHJYpL21KF/
         M7aIS883l0MZFXnjCmFcVrPonrjBJUpmgsmZwxUIH2QgowZ70ABp78NlZ+27jjOKPt7H
         XyQM1AQtkJZgvWWc/zL8e6IGJC752fgXbut3QuSiAhYpbWK5LIYGFToyxFzpxouSoxyJ
         Gdfx0BAIVVQ0ydrq2lcHtSwTVSgyXiWWcCW3CR8NQKSF2VSURBPtppqnx3JsxifBNRtX
         SBPFulOm7qPDMepI4AL7aweAWtQNuVoo97N+YkVQ860iUo6mHEoXLKJ+6gn7oGms7dSY
         ok4A==
X-Gm-Message-State: APjAAAWBxNfTi3T5/JDymtRBmPUDGhQ9HEbEgJLRHKjjBCIDO9jx9iaV
        1hZGmQVT20Z9rBb6SNXKw+tOPfvJ
X-Google-Smtp-Source: APXvYqxYoWItYS+oBXsNesv3UYk2OOLvOtgQKnOXo+OSg4YE4r/HAufcHDM2Z85yHlGMaAjU6y6tqg==
X-Received: by 2002:adf:806e:: with SMTP id 101mr28101563wrk.300.1579029967221;
        Tue, 14 Jan 2020 11:26:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm20963400wrr.75.2020.01.14.11.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:26:06 -0800 (PST)
Message-Id: <dfa7e204449c8958d35cc01261d2dc8099d7ce0c.1579029963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.git.1579029962.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 19:25:58 +0000
Subject: [PATCH 4/8] sparse-checkout: cone mode does not recognize "**"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
command creates a restricted set of possible patterns that are used
by a custom algorithm to quickly match those patterns.

If a user manually edits the sparse-checkout file, then they could
create patterns that do not match these expectations. The cone-mode
matching algorithm can return incorrect results. The solution is to
detect these incorrect patterns, warn that we do not recognize them,
and revert to the standard algorithm.

Check each pattern for the "**" substring, and revert to the old
logic if seen. While technically a "/<dir>/**" pattern matches
the meaning of "/<dir>/", it is not one that would be written by
the sparse-checkout builtin in cone mode. Attempting to accept that
pattern change complicates the logic and instead we punt and do
not accept any instance of "**".

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              |  7 ++++++
 t/t1091-sparse-checkout-builtin.sh | 34 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/dir.c b/dir.c
index 22d08e61c2..f8e350dda2 100644
--- a/dir.c
+++ b/dir.c
@@ -651,6 +651,13 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		return;
 	}
 
+	if (strstr(given->pattern, "**")) {
+		/* Not a cone pattern. */
+		pl->use_cone_patterns = 0;
+		warning(_("unrecognized pattern: '%s'"), given->pattern);
+		goto clear_hashmaps;
+	}
+
 	if (given->patternlen > 2 &&
 	    !strcmp(given->pattern + given->patternlen - 2, "/*")) {
 		if (!(given->flags & PATTERN_FLAG_NEGATIVE)) {
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 58d9c69163..e532a52f89 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -305,4 +305,38 @@ test_expect_success 'different sparse-checkouts with worktrees' '
 	check_files worktree "a deep"
 '
 
+check_read_tree_errors () {
+	REPO=$1
+	FILES=$2
+	ERRORS=$3
+	git -C $REPO read-tree -mu HEAD 2>err &&
+	if test -z "$ERRORS"
+	then
+		test_must_be_empty err
+	else
+		test_i18ngrep "$ERRORS" err
+	fi &&
+	check_files $REPO "$FILES"
+}
+
+test_expect_success 'pattern-checks: /A/**' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/folder1/**
+	EOF
+	check_read_tree_errors repo "a folder1" "disabling cone pattern matching"
+'
+
+test_expect_success 'pattern-checks: /A/**/B/' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/deep/**/deepest
+	EOF
+	check_read_tree_errors repo "a deep" "disabling cone pattern matching" &&
+	check_files repo/deep "deeper1" &&
+	check_files repo/deep/deeper1 "deepest"
+'
+
 test_done
-- 
gitgitgadget

