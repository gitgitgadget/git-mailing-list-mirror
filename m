Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C70EC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 12:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC596136A
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 12:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbhI2M0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245563AbhI2M0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 08:26:17 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8449BC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 05:24:36 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id f73so1044399vkf.6
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESRiwWFcfYnjOf4yFKN9x9mD/2+fiyaP4k6OnoKbUug=;
        b=ACjYfitfZBLuHx9vCjNlp6/STB0W24aI9o51SGWgykEekkLIwEpEb3fgleLPbh7Wqn
         XxNw+z603Nk25os3VrdId8GmBzH//1nvfTslKjV94iwvJkkM23ZnN0yiHPdnGLxaJqmz
         uWJAUkCu9pydxXuvqr3h4RM5qMuI4T8zsGTVEYVQF9kCcfuN9qwj1j56rMXInow6UT38
         1LeNv1yBV/A5c4tSlRnTs2+laxKX9V+urbWciT4uvskDZNZOPPeOD4oo/UeP3t0/JDEI
         /PzAl8KxvM39EPiMBi6TqgRnTuSUyNsvaaPajXsGsnu0SOD4LhnpGOkF0d9ii9HDWRrS
         FSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESRiwWFcfYnjOf4yFKN9x9mD/2+fiyaP4k6OnoKbUug=;
        b=BxAdDqXwURnhEwrcTaE6nv37uN4TG79Ezq+0sR/hw+3crgOL9W0YIS6XdsM0PzJfdc
         ai0dRqw884OsmudjQ+83PibOB1ZMlwUfbxj6z4KLzJlngF9mEV1YhzvHtK/QS2K554a1
         u/RIg5sGt5HFTXQ5KP+NRIddyfJ/JOj0lcm5WnI+CRqhwOHgjUix8ZrjGFwmDazdxUU8
         2aBpMnbvbaBrxeKk7Lqyb+U+Ir4o+T2ZVEDdaTNqbEyNX3xe5cxYcB9A2Tdtj8CKV/bq
         +rboA3rB3Rp8l6vjd8mPE7BQajx4x0YwMvydaRfDyX8cg3/wedlgtDDMdAxBZpgEpW//
         Rgkg==
X-Gm-Message-State: AOAM530X2/MFACPyhVZa7VZOxpV/2xjjOh/+FXEi0XXDtVeGq2M8MqAh
        uDoOb77Hm78D9yL8WCAI/efIK7uhvqZsBg==
X-Google-Smtp-Source: ABdhPJygkzqXNZ1N4vfSiwimNPOzPYWRbIdynbi7nMaTEM/vz9exnvosXwN++rz+DBV9lcLqHWPBKQ==
X-Received: by 2002:a1f:8fc1:: with SMTP id r184mr5576319vkd.9.1632918274713;
        Wed, 29 Sep 2021 05:24:34 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id t3sm573028vka.35.2021.09.29.05.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 05:24:34 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        sunshine@sunshineco.com
Subject: [PATCH v2] grep: demonstrate bug with textconv attributes and submodules
Date:   Wed, 29 Sep 2021 09:24:25 -0300
Message-Id: <8c8932465cd2fb2f0d4d6d9a5b86e51e2a72865b.1632918166.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <8c266e58dede247b2c97ad2870c7c24c3b35ed55.1632848754.git.matheus.bernardino@usp.br>
References: <8c266e58dede247b2c97ad2870c7c24c3b35ed55.1632848754.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some circumstances, "git grep --textconv --recurse-submodules"
ignores the textconv attributes from the submodules and erroneously
applies the attributes defined in the superproject on the submodules'
files. The textconv cache is also saved on the superproject, even for
submodule objects.

A fix for these problems will probably require at least three changes:

- Some textconv and attributes functions (as well as their callees) will
  have to be adjusted to work with arbitrary repositories. Note that
  "fill_textconv()", for example, already receives a "struct repository"
  but it writes the textconv cache using "write_loose_object()", which
  implicitly works on "the_repository".

- grep.c functions will have to call textconv/userdiff routines passing
  the "repo" field from "struct grep_source" instead of the one from
  "struct grep_opt". The latter always points to "the_repository" on
  "git grep" executions (see its initialization in builtin/grep.c), but
  the former points to the correct repository that each source (an
  object, file, or buffer) comes from.

- "userdiff_find_by_path()" might need to use a different attributes
  stack for each repository it works on or reset its internal static
  stack when the repository is changed throughout the calls.

For now, let's add some tests to demonstrate these problems, and also
update a NEEDSWORK comment in grep.h that mentions this bug to reference
the added tests.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Changed in v2: fixed typos in commit message and test names

 grep.h                             |   6 +-
 t/t7814-grep-recurse-submodules.sh | 103 +++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/grep.h b/grep.h
index 128007db65..3b63bd0253 100644
--- a/grep.h
+++ b/grep.h
@@ -128,9 +128,9 @@ struct grep_opt {
 	 * instead.
 	 *
 	 * This is potentially the cause of at least one bug - "git grep"
-	 * ignoring the textconv attributes from submodules. See [1] for more
-	 * information.
-	 * [1] https://lore.kernel.org/git/CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
+	 * using the textconv attributes from the superproject on the
+	 * submodules. See the failing "git grep --textconv" tests in
+	 * t7814-grep-recurse-submodules.sh for more information.
 	 */
 	struct repository *repo;
 
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 3172f5b936..058e5d0c96 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -441,4 +441,107 @@ test_expect_success 'grep --recurse-submodules with --cached ignores worktree mo
 	test_must_fail git grep --recurse-submodules --cached "A modified line in submodule" >actual 2>&1 &&
 	test_must_be_empty actual
 '
+
+test_expect_failure 'grep --textconv: superproject .gitattributes does not affect submodules' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >.gitattributes &&
+
+	cat >expect <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv: superproject .gitattributes (from index) does not affect submodules' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >.gitattributes &&
+	git add .gitattributes &&
+	rm .gitattributes &&
+
+	cat >expect <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv: superproject .git/info/attributes does not affect submodules' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	super_attr="$(git rev-parse --git-path info/attributes)" &&
+	test_when_finished "rm -f \"$super_attr\"" &&
+	echo "a diff=d2x" >"$super_attr" &&
+
+	cat >expect <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+# Note: what currently prevents this test from passing is not that the
+# .gitattributes file from "./submodule" is being ignored, but that it is being
+# propagated to the nested "./submodule/sub" files.
+#
+test_expect_failure 'grep --textconv correctly reads submodule .gitattributes' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >submodule/.gitattributes &&
+
+	cat >expect <<-\EOF &&
+	submodule/a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv correctly reads submodule .gitattributes (from index)' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >submodule/.gitattributes &&
+	git -C submodule add .gitattributes &&
+	rm submodule/.gitattributes &&
+
+	cat >expect <<-\EOF &&
+	submodule/a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv correctly reads submodule .git/info/attributes' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+
+	submodule_attr="$(git -C submodule rev-parse --path-format=absolute --git-path info/attributes)" &&
+	test_when_finished "rm -f \"$submodule_attr\"" &&
+	echo "a diff=d2x" >"$submodule_attr" &&
+
+	cat >expect <<-\EOF &&
+	submodule/a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep saves textconv cache in the appropriate repository' '
+	reset_and_clean &&
+	test_config_global diff.d2x_cached.textconv "sed -e \"s/d/x/\"" &&
+	test_config_global diff.d2x_cached.cachetextconv true &&
+	echo "a diff=d2x_cached" >submodule/.gitattributes &&
+
+	# We only read/write to the textconv cache when grepping from an OID,
+	# as the working tree file might have modifications.
+	git grep --textconv --cached --recurse-submodules x &&
+
+	super_textconv_cache="$(git rev-parse --git-path refs/notes/textconv/d2x_cached)" &&
+	sub_textconv_cache="$(git -C submodule rev-parse \
+			--path-format=absolute --git-path refs/notes/textconv/d2x_cached)" &&
+	test_path_is_missing "$super_textconv_cache" &&
+	test_path_is_file "$sub_textconv_cache"
+'
+
 test_done
-- 
2.33.0

