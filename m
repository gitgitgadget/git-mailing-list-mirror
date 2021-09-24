Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB68C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC66861107
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344159AbhIXQx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344084AbhIXQx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 12:53:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B59EC061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 09:51:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t28so15957280wra.7
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfXfhGqrhwjajRcHSAvwweh8bmaxGD0F3ilPpXVbxBo=;
        b=jRUi3kh3NRD5q116q7ArI8cnnPvkdrG4buUzqtfkgrb5uEKwFtTC9+s9tKRjiyFsBh
         FCJ6z748wbWvajBc9IhAVtvtJL84C03k0qoe/nOcyW7zgjSlsLnJRZgAM/Zie6SW5cgg
         XrYyX5CEO+XedINIRyFyU9z362/D+A6mjtJjfqilZAOtgu9NoqIDqfi1pVMc2DHLAskR
         TDZc/sahAJuhj2kfQScquZA/hqkHY51qryk4CgnZZwW7UCtmIvwa/6EDxTEoAYj6cV33
         V2IofkFdfLhHf9kW/8CudrzOV++64Ll1cfqd0tTKwqL/S/bvl2KeEn/JxbvOUBEdVlNi
         DHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfXfhGqrhwjajRcHSAvwweh8bmaxGD0F3ilPpXVbxBo=;
        b=a4PdOCO0k5d3gHxOwCztdWh0UACX/w0tN1J7xKfWQXq5nbyYTCNvUzPBcRAZqS1/Zq
         cf1GPVvozheOEzwoL0k3xCCVITHZs5TmA4faAU0RWDd1u9slyQ9tzzDDZLEaAjJ57LRT
         4CCnJ6kmJvZYXQgAdTytP6HlEX6WD74Shra+W01HMHQqdVsCCV3yF8sUhdqLFgNz7gxm
         83eC/Lm9BXmIz9P4J3Hlos/he3dW97dpGpaHwCg9JjFaE0o4amIrRYkE8wpaXo7hXdpC
         pvFUvJqgPRrzgekESwzkOPS/0D5hZKMrntFT00FGh7m3vlUuH9bXdAVM2/AXzKhJFNZd
         z+Sw==
X-Gm-Message-State: AOAM530CWG8Yh8KRbwvjPOFbYxM+XY6FLsWgIosZ9c6XItDkxKufnZ6J
        Jr0nK7ZGG8EO8KLbe/XqR9HO347NT1p7Gg==
X-Google-Smtp-Source: ABdhPJylSxVeLkwZpsJvWPjLc/yusUDcK8u/ir2AZoJqLdSFM6XYAiMDK+QF0LU1QhC55Z7rIypRqw==
X-Received: by 2002:adf:fb89:: with SMTP id a9mr12698561wrr.164.1632502311947;
        Fri, 24 Sep 2021 09:51:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm8929623wrc.66.2021.09.24.09.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 09:51:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] grep: pass PARSE_OPT_NO_INTERNAL_HELP, fix odd -h handling
Date:   Fri, 24 Sep 2021 18:51:46 +0200
Message-Id: <patch-3.3-996f3dae2a7-20210924T164820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1285.g7aff81f6560
In-Reply-To: <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
References: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net> <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "grep" command supports both "-h" and "-H" options, along with a
mandatory pattern, but this has been partially usurped by the "-h"
handling in parse_options().

The reason it's just been "odd" instead of a bug is that we'll only
print out "-h" usage with parse_options() if there's no further
non-option arguments, so instead of printing this brief blurb on a
stand-alone -h we'd print out the full usage:

    $ git grep -H
    fatal: no pattern given

But for the aforementioned reason a "git grep -h <pattern>" would
work, we wouldn't take the !PARSE_OPT_NO_INTERNAL_HELP branch in
parse_options_step(), would handle our own custom 'h' option, and
builtin/grep.c itself would know what to do at that point.

Reported-by: Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c  | 3 ++-
 t/t0012-help.sh | 4 +++-
 t/t7810-grep.sh | 4 ++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 51278b01fa2..a2d6704aa41 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -981,7 +981,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	 */
 	argc = parse_options(argc, argv, prefix, options, grep_usage,
 			     PARSE_OPT_KEEP_DASHDASH |
-			     PARSE_OPT_STOP_AT_NON_OPTION);
+			     PARSE_OPT_STOP_AT_NON_OPTION |
+			     PARSE_OPT_NO_INTERNAL_HELP);
 	grep_commit_pattern_type(pattern_type_arg, &opt);
 
 	if (use_index && !startup_info->have_repository) {
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 913f34c8e9d..0b623fe794a 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -90,7 +90,9 @@ test_expect_success 'git help succeeds without git.html' '
 '
 
 test_expect_success 'generate builtin list' '
-	git --list-cmds=builtins >builtins
+	git --list-cmds=builtins >builtins &&
+	grep -v "^grep$" builtins >builtins+ &&
+	mv builtins+ builtins
 '
 
 while read builtin
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 6b6423a07c3..4c2777120b0 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -11,6 +11,10 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_expect_success 'usage' '
+	test_expect_code 128 git grep -h
+'
+
 test_invalid_grep_expression() {
 	params="$@" &&
 	test_expect_success "invalid expression: grep $params" '
-- 
2.33.0.1285.g7aff81f6560

