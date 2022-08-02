Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1035C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiHBPeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiHBPdc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:33:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8380019C3A
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:33:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bv3so4452286wrb.5
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=M6XulV7YQUWvl4n5gBDqX27/K2YJgMpwNgNtLmAx6Gw=;
        b=BKhwh+AA2GRqMDC6csnTZcfcKIW95GLProXq21jLSTh4S8mI/9rK+t4oy6252UZxLf
         +/YbLCm0QrKiyFqBDTDMdksDvuK5L7Te5F4qyVdp8x67OQvxpxfEG0NmyoOmnu2apWoR
         Hc/1sdrwtuk7Q8VBc6mcO3lmFUkYeQ6+mGvNeq1fBNi2mTMXf3sFSPa1J1G2if5evQ16
         ZuOQdznZNDqrljiYwGPi//ISVUNQsU20dx+CdqRz6Ribxpu0xIB/mMkiZzwrTpI/rgCQ
         DTUVjlyY2dv5PbGZhz1uo07IwAr/qHB/BsJsVwSSzoPJaH0cQpKYoHT1AruVD/gvRYGR
         K//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=M6XulV7YQUWvl4n5gBDqX27/K2YJgMpwNgNtLmAx6Gw=;
        b=c8Ddpp1fcrLRUKRoubSA1l4Mq/gHjq5KITUFSU2GcO81sP2fDY+GHSoyfSrEccWD30
         axtnet1fopexwA2hExAGMA9Z7PKqHdyW6vAaQLPZEU857EpeNXqt2QVt+oxrPGz0Lui0
         EmphKNBaZq6n5Rm0MXESr8URX79UI1haUBUXe8xyMrAVQshbyxztmmIRxcEcvI2lsaw7
         6z+0Qr3B6aKsH/j2q2iS5NKllexCadUx1VpmyyCYgTjSCjLJjvtrbAS+M46UEy2g3RxU
         hBFQTb7St51kWXc1iZeijEfIPNKSSdIMwL3YQRCdb50myEbJ9YEwXgzZyMHEx5rIMJ5p
         yJpA==
X-Gm-Message-State: ACgBeo1JBxDiOASEql/lrf/60mQWLs027RRQMqLe97ChOOCNXeKtvxn0
        WxW7MnjsKQGXWG1dwz3HLGMUC/wmbVDVFg==
X-Google-Smtp-Source: AA6agR4pRP4vdHemgIhvD7SFNV+R4tYQYfUoxAKOsolYSOBWAIHuUjL5Z7UYkv6zptuATdbcXvSQCQ==
X-Received: by 2002:adf:fbc6:0:b0:21e:3960:45b3 with SMTP id d6-20020adffbc6000000b0021e396045b3mr13207828wrs.92.1659454408603;
        Tue, 02 Aug 2022 08:33:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y7-20020adffa47000000b0021e9396b135sm15332531wrr.37.2022.08.02.08.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:33:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/6] revisions API: don't leak memory on argv elements that need free()-ing
Date:   Tue,  2 Aug 2022 17:33:16 +0200
Message-Id: <patch-v3-6.6-5e637f55ff1-20220802T152925Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "free_removed_argv_elements" member to "struct
setup_revision_opt", and use it to fix several memory leaks.

We have various memory leaks in APIs that take and munge "const
char **argv", e.g. parse_options(). Sometimes these APIs are given the
"argv" we get to the "main" function, in which case we don't leak
memory, but other times we're giving it the "v" member of a "struct
strvec" we created.

There's several potential ways to fix those sort of leaks, we could
add a "nodup" mode to "struct strvec", which would work for the cases
where we push constant strings to it. But that wouldn't work as soon
as we used strvec_pushf(), or otherwise needed to duplicate or create
a string for that "struct strvec".

Let's instead make it the responsibility of the revisions API. If it's
going to clobber elements of argv it can also free() them, which it
will now do if instructed to do so via "free_removed_argv_elements".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c                    | 6 ++++--
 builtin/submodule--helper.c | 5 ++++-
 remote.c                    | 5 ++++-
 revision.c                  | 2 ++
 revision.h                  | 3 ++-
 t/t2020-checkout-detach.sh  | 1 +
 6 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6afb98be7a1..38b3891f3a6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -653,6 +653,9 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 			     const char *bad_format, const char *good_format,
 			     int read_paths)
 {
+	struct setup_revision_opt opt = {
+		.free_removed_argv_elements = 1,
+	};
 	int i;
 
 	repo_init_revisions(r, revs, prefix);
@@ -669,8 +672,7 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	if (read_paths)
 		read_bisect_paths(rev_argv);
 
-	setup_revisions(rev_argv->nr, rev_argv->v, revs, NULL);
-	/* XXX leak rev_argv, as "revs" may still be pointing to it */
+	setup_revisions(rev_argv->nr, rev_argv->v, revs, &opt);
 }
 
 static void bisect_common(struct rev_info *revs)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fac52ade5e1..b63f420ecef 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1104,6 +1104,9 @@ static int compute_summary_module_list(struct object_id *head_oid,
 {
 	struct strvec diff_args = STRVEC_INIT;
 	struct rev_info rev;
+	struct setup_revision_opt opt = {
+		.free_removed_argv_elements = 1,
+	};
 	struct module_cb_list list = MODULE_CB_LIST_INIT;
 	int ret = 0;
 
@@ -1121,7 +1124,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	init_revisions(&rev, info->prefix);
 	rev.abbrev = 0;
 	precompose_argv_prefix(diff_args.nr, diff_args.v, NULL);
-	setup_revisions(diff_args.nr, diff_args.v, &rev, NULL);
+	setup_revisions(diff_args.nr, diff_args.v, &rev, &opt);
 	rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = submodule_summary_callback;
 	rev.diffopt.format_callback_data = &list;
diff --git a/remote.c b/remote.c
index 1ee2b145d07..d66064118cb 100644
--- a/remote.c
+++ b/remote.c
@@ -2169,6 +2169,9 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	struct object_id oid;
 	struct commit *ours, *theirs;
 	struct rev_info revs;
+	struct setup_revision_opt opt = {
+		.free_removed_argv_elements = 1,
+	};
 	struct strvec argv = STRVEC_INIT;
 
 	/* Cannot stat if what we used to build on no longer exists */
@@ -2203,7 +2206,7 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	strvec_push(&argv, "--");
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	setup_revisions(argv.nr, argv.v, &revs, NULL);
+	setup_revisions(argv.nr, argv.v, &revs, &opt);
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
diff --git a/revision.c b/revision.c
index 0c6e26cd9c8..35d24e4fd3e 100644
--- a/revision.c
+++ b/revision.c
@@ -2784,6 +2784,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			const char *arg = argv[i];
 			if (strcmp(arg, "--"))
 				continue;
+			if (opt && opt->free_removed_argv_elements)
+				free((char *)argv[i]);
 			argv[i] = NULL;
 			argc = i;
 			if (argv[i + 1])
diff --git a/revision.h b/revision.h
index e576845cdd1..bb91e7ed914 100644
--- a/revision.h
+++ b/revision.h
@@ -375,7 +375,8 @@ struct setup_revision_opt {
 	const char *def;
 	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
 	unsigned int	assume_dashdash:1,
-			allow_exclude_promisor_objects:1;
+			allow_exclude_promisor_objects:1,
+			free_removed_argv_elements:1;
 	unsigned revarg_opt;
 };
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index bc46713a43e..2eab6474f8d 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -4,6 +4,7 @@ test_description='checkout into detached HEAD state'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_detached () {
-- 
2.37.1.1233.ge8b09efaedc

