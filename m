Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4C7C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 08:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiBOIcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:32:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiBOIcl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 03:32:41 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B69A94EE
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w11so30754057wra.4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s5kIJ+O1UzcsJfrsoFb4Y6UDPypo9HQBG7KiiqSk1GY=;
        b=jjetzlqnhdFI6TFXIXtcN1X35rV1szyfh/G/Fd37C6dSMV20L+cAL9ns1cr9Qv5L4U
         pGfPnUW+3KSoMG9LijxfO9OcD20Ck94mmt0U0UgwHw0eQZU5owBbK9cpbGFeAEWJXvOg
         riPMAiDLofAwWd8cp8nPS72+0qU6J07Yb6eKyOd8qS+j6jhT+AhTcBd2KKEEBVNAdxbB
         ml3Ad15OvYz7LEWxyh7j9lsvbA3RZxm8XxnQULlQx06HNc00WTYGdBBb1EqFtVbtCnm5
         UzZpYjx+D/uczu+Cg4iVxYy5VTizIY5OsyLA8v31Bx6ZgJ0vOAPcvAOFEnRAIuj5WCUZ
         Gnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s5kIJ+O1UzcsJfrsoFb4Y6UDPypo9HQBG7KiiqSk1GY=;
        b=6e3Kn2CDak44TUHn9NVQ1Tn+SPhVq/WfjI3IaV2dFXmJnRTZsTlIll0shotUG7DCOE
         IbYvUdYAFa40b86oxEoGKIcB7xg8e05LHF/OILRo0/bEV7i0kMdYTmwS7J0sGFKTcFRe
         E0EXSTUh/gso8T1ukoreqJvvZedBRKGSUe6kzFkg+GLxT7oG68dw0o2R2+tVzaaB4lZS
         nDJIo6qLFjqjWUgY9J1jlupwzJXHA5HbSrCSTtCGaUCHLCaaBTHyI21Non1JIIFcqLa4
         V98heohmEwPDH79yKUIi8BeESsJCviKAdKNHht6kTqeoBrZI9jLW/QapNbdl9m3r7jPV
         mP+A==
X-Gm-Message-State: AOAM532G2j5sOR5/WBU+uzEZZzrT5Gmk+4p7hkP/2rMCXKwwMgFA/XSh
        9ckGch81krrlr1672bOIlQjEndpJsM4=
X-Google-Smtp-Source: ABdhPJzJhDmukeB0d0gXHT/Xl6nyThsEtgz0DZvFnIxpILfzV024/szkY8irXXL7mcJ6fe6Nn7HOyQ==
X-Received: by 2002:adf:e112:: with SMTP id t18mr2315590wrz.411.1644913948062;
        Tue, 15 Feb 2022 00:32:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm22838560wrt.28.2022.02.15.00.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 00:32:27 -0800 (PST)
Message-Id: <f57820e25d67b6c26958d3dfbd33234dcaf4aee4.1644913943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
        <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 08:32:20 +0000
Subject: [PATCH v2 3/6] sparse-checkout: pay attention to prefix for {set,
 add}
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In cone mode, non-option arguments to set & add are clearly paths, and
as such, we should pay attention to prefix.

In non-cone mode, it is not clear that folks intend to provide paths
since the inputs are gitignore-style patterns.  Paying attention to
prefix would prevent folks from doing things like
   git sparse-checkout add /.gitattributes
   git sparse-checkout add '/toplevel-dir/*'
In fact, the former will result in
   fatal: '/.gitattributes' is outside repository...
while the later will result in
   fatal: Invalid path '/toplevel-dir': No such file or directory
despite the fact that both are valid gitignore-style patterns that would
select real files if added to the sparse-checkout file.  This might lead
people to just use the path without the leading slash, potentially
resulting in them grabbing files with the same name throughout the
directory hierarchy contrary to their expectations.  See also [1] and
[2].  Adding prefix seems to just be fraught with error; so for now
simply throw an error in non-cone mode when sparse-checkout set/add are
run from a subdirectory.

[1] https://lore.kernel.org/git/e1934710-e228-adc4-d37c-f706883bd27c@gmail.com/
[2] https://lore.kernel.org/git/CABPp-BHXZ-XLxY0a3wCATfdq=6-EjW62RzbxKAoFPeXfJswD2w@mail.gmail.com/

Helped-by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 25 ++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 41 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index fb85a1459c3..a2192a69219 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -684,6 +684,27 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	return result;
 }
 
+static void sanitize_paths(int argc, const char **argv, const char *prefix)
+{
+	if (!argc)
+		return;
+
+	if (prefix && *prefix) {
+		/*
+		 * The args are not pathspecs, so unfortunately we
+		 * cannot imitate how cmd_add() uses parse_pathspec().
+		 */
+		int i;
+		int prefix_len = strlen(prefix);
+
+		if (!core_sparse_checkout_cone)
+			die("please run from the toplevel directory in non-cone mode");
+
+		for (i = 0; i < argc; i++)
+			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
+	}
+}
+
 static char const * const builtin_sparse_checkout_add_usage[] = {
 	N_("git sparse-checkout add (--stdin | <patterns>)"),
 	NULL
@@ -711,6 +732,8 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_add_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
+	sanitize_paths(argc, argv, prefix);
+
 	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
 }
 
@@ -762,6 +785,8 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	if (!core_sparse_checkout_cone && argc == 0) {
 		argv = default_patterns;
 		argc = default_patterns_nr;
+	} else {
+		sanitize_paths(argc, argv, prefix);
 	}
 
 	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ce5e7c19efa..c1f86b0e02e 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -798,4 +798,45 @@ test_expect_success 'malformed cone-mode patterns' '
 	grep "warning: disabling cone pattern matching" err
 '
 
+test_expect_success 'set from subdir pays attention to prefix' '
+	git -C repo sparse-checkout disable &&
+	git -C repo/deep sparse-checkout set --cone deeper2 ../folder1 &&
+
+	git -C repo sparse-checkout list >actual &&
+
+	cat >expect <<-\EOF &&
+	deep/deeper2
+	folder1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add from subdir pays attention to prefix' '
+	git -C repo sparse-checkout set --cone deep/deeper2 &&
+	git -C repo/deep sparse-checkout add deeper1/deepest ../folder1 &&
+
+	git -C repo sparse-checkout list >actual &&
+
+	cat >expect <<-\EOF &&
+	deep/deeper1/deepest
+	deep/deeper2
+	folder1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'set from subdir in non-cone mode throws an error' '
+	git -C repo sparse-checkout disable &&
+	test_must_fail git -C repo/deep sparse-checkout set --no-cone deeper2 ../folder1 2>error &&
+
+	grep "run from the toplevel directory in non-cone mode" error
+'
+
+test_expect_success 'set from subdir in non-cone mode throws an error' '
+	git -C repo sparse-checkout set --no-cone deep/deeper2 &&
+	test_must_fail git -C repo/deep sparse-checkout add deeper1/deepest ../folder1 2>error &&
+
+	grep "run from the toplevel directory in non-cone mode" error
+'
+
 test_done
-- 
gitgitgadget

