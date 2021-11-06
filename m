Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91657C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D7F611AE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhKFVNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhKFVNo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:13:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7688BC061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:11:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so8916380wmz.2
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nz8W20G88nXrWXfCcK1qYo75Dt00ppW9/+jAxD6BVcU=;
        b=hz5gNjvutz88LAbXYjAuCcXPlcHnZ3mgPx3Z4oJVtoGwThd3A0AnWPZRmr9oebGhnO
         5UTe2ztITHh2LlMhMw1HPg2s9PDmY6vkSV1sGhw+JThONorEgVkCqBvZU9slEIVX+9uZ
         Uo7bHnO7ZyOFovmtFg3f3pfs3Pl+jd+yPgNk5/sXhWmELVyJ6HqFj7CXgy9CG82QXeFG
         YzaAItkKNP8nUJdppJdby0Wz5lAhNNSpsqfCUnPFJFjhBtPzXQigLE19P9v8KpDE+bPh
         xzy0ehSUpNBbE4P7IEZk53JeY0QDDMpEzqq+tcz2J9a0yqw20AF5FQ7gUcW//s+z2Vu8
         2rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nz8W20G88nXrWXfCcK1qYo75Dt00ppW9/+jAxD6BVcU=;
        b=HQ4S2+iq5Thx9pCVtBa0L6y6masn6OrcXQe/bRDqMFGGk2SPVOwP2Hz4bVZ8qhSOqr
         NHfpMDRdbTHd+cwQ3cQDqHU+OX9KEJc9FKSWwpbsk4K/3ZEMOqGoFsJXCrOU4LVGBmib
         c/Xs3JaAHwufoVANpmF32sQ4dssjs8VCMFJVyloc0T8J5kaN8USbzUu213Lz3PER6lyD
         KCn6FfZ2flMV+11RKllXOe0xiRMZy9O/PGkRKXS8eUl6+P0ZDOJcUHMxOSiReGrDxWRe
         kHXKZPYC2pXetvtN3z/eE7ae345NfIINz+UeidkYX3YFH3A87qtNn/RDfMI6L9uOEaEf
         jlRQ==
X-Gm-Message-State: AOAM532yHZexzS/2gwFkTNHXjrCEEiOfUXN2P1EuZLfjDFWG0QEk0ttM
        gR+fOCJw7Syf2GELXcITSVc5EYrKDJPUMg==
X-Google-Smtp-Source: ABdhPJye7ufOv23HVRdkTz6EbY+/0Wd6LrWGFtrkQeWXKe7u4T4QYDxnO+CFwxGcgbshjPJ+H9m9iA==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr41125302wmi.134.1636233060758;
        Sat, 06 Nov 2021 14:11:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4sm9123051wmq.31.2021.11.06.14.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:11:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] git.c & grep.c: assert that "prefix" is NULL or non-zero string
Date:   Sat,  6 Nov 2021 22:10:48 +0100
Message-Id: <patch-2.8-244715e3497-20211106T210711Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "prefix" we get from setup.c is either going to be NULL or a
string of length >0, never "". So let's drop the "prefix && *prefix"
check in grep.c added in 0d042fecf2f (git-grep: show pathnames
relative to the current directory, 2006-08-11).

As seen in code in revision.c that was added in cd676a51367 (diff
--relative: output paths as relative to the current subdirectory,
2008-02-12) we have existing code that does away with this assertion.

This makes it easier to reason about a subsequent change to the
"prefix_length" code in grep.c in a subsequent commit, and since we're
going to the trouble of doing that let's leave behind an assert() to
promise this to any future callers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git.c  | 4 ++--
 grep.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 5ff21be21f3..aa4f0d77c4b 100644
--- a/git.c
+++ b/git.c
@@ -420,9 +420,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status, help;
 	struct stat st;
-	const char *prefix;
+	const char *prefix = NULL;
 
-	prefix = NULL;
 	help = argc == 2 && !strcmp(argv[1], "-h");
 	if (!help) {
 		if (p->option & RUN_SETUP)
@@ -431,6 +430,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 			int nongit_ok;
 			prefix = setup_git_directory_gently(&nongit_ok);
 		}
+		assert(!prefix || (prefix && *prefix));
 		precompose_argv_prefix(argc, argv, NULL);
 		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
 		    !(p->option & DELAY_PAGER_CONFIG))
diff --git a/grep.c b/grep.c
index f6e113e9f0f..88ebc504630 100644
--- a/grep.c
+++ b/grep.c
@@ -145,7 +145,7 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 
 	opt->repo = repo;
 	opt->prefix = prefix;
-	opt->prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
+	opt->prefix_length = prefix ? strlen(prefix) : 0;
 	opt->pattern_tail = &opt->pattern_list;
 	opt->header_tail = &opt->header_list;
 }
-- 
2.34.0.rc1.741.gab7bfd97031

