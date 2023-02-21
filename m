Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD637C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 06:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjBUGBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 01:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjBUGBl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 01:01:41 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5910E23661
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 22:01:39 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id i1-20020a17090ad34100b00234463de251so3542434pjx.3
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 22:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUIHjNgf0CuxUWUVOQUbYr+uHCyjUz/G/+g9nP9aGq8=;
        b=GnyqC6zuYSlorYw+lY2k5QDJSaFKMC1WsHRP9CRsKEGQuDXMUVquVvB/UsCxIRLZDn
         3a4SDCFbvFItliK5QMBanXIcP/Gv6tOipvnPKTo7TPoMklEeFxYZ4JxAjgbWoBEbAwE8
         m2JA5CdytKldn3Z9ydfpKuSbGRRGwpE9MTJM8UON4m8AehmJVhhjW4ylgj1ghAlhBkpi
         sMwR01oYRV9Je/pvJOrm0SnUEFPahpFg7pl+KXVB/QeHGrL9BnN9ua3VPSecmUf21pz+
         SlbGXvlNUAXO++p8TRqXdw20Y/fhxuJZvyznVOgkixvWHRUqhKgpgBf42hfCLcxX0Uia
         VBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUIHjNgf0CuxUWUVOQUbYr+uHCyjUz/G/+g9nP9aGq8=;
        b=LJZP3PzD4BTbWuB4DuhP4uQF7lNQY7W4DzEsDhpnDqTyWPyWdJuTciPeW7SNeq3MF2
         k99wqYPrJQw4cqA+X4bFZYEYTebGJyz20UrkdmMcL906th0remr2pW/FsRY2Kd1i6SF9
         lLSq4KuKVtI11JGrleALf77LCSU64qhe7y9CpYECRAGkPXMJhJkihvrcLo4l1oKNOF9r
         /U1c1EbmJ8CThAyjyzPJqD2LNbYZ640ABt7qED8GBHB0huiM0f4tor3217yH4YQbLyHk
         qsMfnr06d84L4qPwNGV6osVmNF535p2bqYAc3h+YqxoXu/JYxgJ6V8CD/6IazCiRiwmL
         Tt4w==
X-Gm-Message-State: AO0yUKUov7ZQl97dfRz/W5pTlcWR9bWHmC91RvtXsAHgsdViPGH7wUOg
        Y3ngDToc2ZB12Uk3yPRQ+0gDc1KeOV8=
X-Google-Smtp-Source: AK7set8daclJQi4a8AuBAfnUZC1S6D/QSSLN8fd+nCvOmVe4WHveR7snlILZWkucwz2khcaixVvqVw==
X-Received: by 2002:a17:90b:33d0:b0:234:8cd:c0e4 with SMTP id lk16-20020a17090b33d000b0023408cdc0e4mr3650340pjb.23.1676959298465;
        Mon, 20 Feb 2023 22:01:38 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id mv14-20020a17090b198e00b002308e6e645bsm993905pjb.49.2023.02.20.22.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 22:01:38 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 4/4] rebase: add a config option for --rebase-merges
Date:   Mon, 20 Feb 2023 22:58:05 -0700
Message-Id: <20230221055805.210951-4-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221055805.210951-1-alexhenrie24@gmail.com>
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of the new option is to accommodate users who would like
--rebase-merges to be on by default and to facilitate possibly turning
on --rebase-merges by default without configuration in a future version
of Git.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/config/rebase.txt |  3 ++
 Documentation/git-rebase.txt    |  3 +-
 builtin/rebase.c                | 11 +++++
 t/t3430-rebase-merges.sh        | 81 +++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index f19bd0e040..d956ec4441 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -67,3 +67,6 @@ rebase.rescheduleFailedExec::
 
 rebase.forkPoint::
 	If set to false set `--no-fork-point` option by default.
+
+rebase.merges::
+	Default value of `--rebase-merges` option.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c98784a0d2..b02f9cbb8c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -537,7 +537,8 @@ See also INCOMPATIBLE OPTIONS below.
 	by recreating the merge commits. Any resolved merge conflicts or
 	manual amendments in these merge commits will have to be
 	resolved/re-applied manually. `--no-rebase-merges` can be used to
-	countermand a previous `--rebase-merges`.
+	countermand both the `rebase.merges` config option and a previous
+	`--rebase-merges`.
 +
 By default, or when `no-rebase-cousins` was specified, commits which do not
 have `<upstream>` as direct ancestor will keep their original branch point,
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0a8366f30f..35f3837f43 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -829,6 +829,17 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.merges")) {
+		const char *rebase_merges;
+		if (!git_config_string(&rebase_merges, var, value) &&
+		    rebase_merges && *rebase_merges) {
+			opts->rebase_merges = git_parse_maybe_bool(rebase_merges);
+			if (opts->rebase_merges < 0)
+				parse_merges_value(opts, rebase_merges);
+		}
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.backend")) {
 		return git_config_string(&opts->default_backend, var, value);
 	}
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index b8ba323dbc..4a7193d501 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -299,6 +299,86 @@ test_expect_success '--rebase-merges="" is invalid syntax' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase.merges="" is equivalent to not passing --rebase-merges' '
+	git config rebase.merges "" &&
+	git checkout -b config-merges-blank E &&
+	git rebase C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
+test_expect_success 'rebase.merges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
+	git config rebase.merges rebase-cousins &&
+	git checkout -b config-rebase-cousins main &&
+	git rebase HEAD^ &&
+	test_cmp_graph HEAD^.. <<-\EOF
+	*   Merge the topic branch '\''onebranch'\''
+	|\
+	| * D
+	| * G
+	|/
+	o H
+	EOF
+'
+
+test_expect_success '--no-rebase-merges overrides rebase.merges=no-rebase-cousins' '
+	git config rebase.merges no-rebase-cousins &&
+	git checkout -b override-config-no-rebase-cousins E &&
+	git rebase --no-rebase-merges C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
+test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.merges=rebase-cousins' '
+	git config rebase.merges rebase-cousins &&
+	git checkout -b override-config-rebase-cousins main &&
+	git rebase --rebase-merges=no-rebase-cousins HEAD^ &&
+	test_cmp_graph HEAD^.. <<-\EOF
+	*   Merge the topic branch '\''onebranch'\''
+	|\
+	| * D
+	| * G
+	o | H
+	|/
+	o A
+	EOF
+'
+
+test_expect_success '--rebase-merges overrides rebase.merges=false' '
+	git config rebase.merges false &&
+	git checkout -b override-config-merges-false main &&
+	git rebase --rebase-merges HEAD^ &&
+	test_cmp_graph HEAD^.. <<-\EOF
+	*   Merge the topic branch '\''onebranch'\''
+	|\
+	| * D
+	| * G
+	o | H
+	|/
+	o A
+	EOF
+'
+
+test_expect_success '--rebase-merges does not override rebase.merges=rebase-cousins' '
+	git config rebase.merges rebase-cousins &&
+	git checkout -b no-override-config-rebase-cousins main &&
+	git rebase --rebase-merges HEAD^ &&
+	test_cmp_graph HEAD^.. <<-\EOF
+	*   Merge the topic branch '\''onebranch'\''
+	|\
+	| * D
+	| * G
+	|/
+	o H
+	EOF
+'
+
 test_expect_success 'refs/rewritten/* is worktree-local' '
 	git worktree add wt &&
 	cat >wt/script-from-scratch <<-\EOF &&
@@ -409,6 +489,7 @@ test_expect_success 'a "merge" into a root commit is a fast-forward' '
 '
 
 test_expect_success 'A root commit can be a cousin, treat it that way' '
+	git config --unset rebase.merges &&
 	git checkout --orphan khnum &&
 	test_commit yama &&
 	git checkout -b asherah main &&
-- 
2.39.2

