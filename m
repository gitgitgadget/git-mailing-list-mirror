Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9BB51F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbdHCSUp (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:45 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35687 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdHCSUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:25 -0400
Received: by mail-pf0-f175.google.com with SMTP id t86so9381279pfe.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BJi7QvB2n0YyjP+CTuARCVgFQ+wz31wnYjuVoVGCxgM=;
        b=PvWJ+0+C0d7IDXWbf4Z4yUmmBZozRSpezGpxtCV7oMtMxuYQDp1Bay8w9RoszbEJ1X
         pmsnruMJLaWH2+3Rff1kpYzEka87YnSagowEOxhteKbI4mcn2ncAQvSj17HIBSYbmUZf
         1j4+xRdqetbrkl5AshBGj3ruBxJ5LlMhzRBmYbQBmu80/3pNV+UuuPaSDDoaEhGdXZve
         utrw+iJznq4tfljGUDXCVXEcfYdmlyv0x9qUZX18VIzFIk5XLnhH1BUg96kSNU8xTDiz
         69Z71XBuBIvmIR47RMv5nSRgmb+I+8N008GZ1G5UrmCLCoYmEphcrc7RrHsVojbRPSDw
         VPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BJi7QvB2n0YyjP+CTuARCVgFQ+wz31wnYjuVoVGCxgM=;
        b=uAHkFVH6Zu2pt90aGEfqlPGKayRVKLQzPFqImPSLFeayDCeOcwyNQAyhIS67tWbeY7
         K9SY7lOXLh4hAdTYlkeiDW9umDeZ83w0wZ1RYUGJskuRs2WTAUYmejJgkwoR7FfHjOL3
         L4o7/FaaFDojqRoKYC7LRDhCx6NFPK9CEnwqlW4IhU1yWvyWAg++jSN5rh2Ts1HJvR+y
         vch39NdcTHCwvxrqhqoRhmus6QN08cu85dGa2eUSL4XfRugHP1YqKRxtljvlsRhSclV6
         kLMpLDZayyMBUJYMuMRY7EBTixMme6AnA4V9E7l/9MhKhTVRG6KooBQl7bYeAu92ESnU
         ZQXA==
X-Gm-Message-State: AIVw110/UoNdwZiR7j5f+hE5/HxkZWSDSny+ub/YCqY548VSdpIK1+Iu
        zTK1/9C/6O5EgcY8dCmQzg==
X-Received: by 10.84.241.13 with SMTP id a13mr2795051pll.307.1501784424683;
        Thu, 03 Aug 2017 11:20:24 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:23 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 11/15] submodule-config: remove support for overlaying repository config
Date:   Thu,  3 Aug 2017 11:19:56 -0700
Message-Id: <20170803182000.179328-12-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All callers have been migrated to explicitly read any configuration they
need.  The support for handling it automatically in submodule-config is
no longer needed.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule-config.h               |  1 -
 t/helper/test-submodule-config.c |  6 ----
 t/t7411-submodule-config.sh      | 72 ----------------------------------------
 3 files changed, 79 deletions(-)

diff --git a/submodule-config.h b/submodule-config.h
index cccd34b92..84c2cf515 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -34,7 +34,6 @@ extern int option_fetch_parse_recurse_submodules(const struct option *opt,
 						 const char *arg, int unset);
 extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-extern int parse_submodule_config_option(const char *var, const char *value);
 extern int submodule_config_option(struct repository *repo,
 				   const char *var, const char *value);
 extern const struct submodule *submodule_from_name(
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index e13fbcc1b..f4a7c431c 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -10,11 +10,6 @@ static void die_usage(int argc, const char **argv, const char *msg)
 	exit(1);
 }
 
-static int git_test_config(const char *var, const char *value, void *cb)
-{
-	return parse_submodule_config_option(var, value);
-}
-
 int cmd_main(int argc, const char **argv)
 {
 	const char **arg = argv;
@@ -38,7 +33,6 @@ int cmd_main(int argc, const char **argv)
 
 	setup_git_directory();
 	gitmodules_config();
-	git_config(git_test_config, NULL);
 
 	while (*arg) {
 		struct object_id commit_oid;
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 7d6b25ba2..46c09c776 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -122,78 +122,6 @@ test_expect_success 'using different treeishs works' '
 	)
 '
 
-cat >super/expect_url <<EOF
-Submodule url: 'git@somewhere.else.net:a.git' for path 'b'
-Submodule url: 'git@somewhere.else.net:submodule.git' for path 'submodule'
-EOF
-
-cat >super/expect_local_path <<EOF
-Submodule name: 'a' for path 'c'
-Submodule name: 'submodule' for path 'submodule'
-EOF
-
-test_expect_success 'reading of local configuration' '
-	(cd super &&
-		old_a=$(git config submodule.a.url) &&
-		old_submodule=$(git config submodule.submodule.url) &&
-		git config submodule.a.url git@somewhere.else.net:a.git &&
-		git config submodule.submodule.url git@somewhere.else.net:submodule.git &&
-		test-submodule-config --url \
-			"" b \
-			"" submodule \
-				>actual &&
-		test_cmp expect_url actual &&
-		git config submodule.a.path c &&
-		test-submodule-config \
-			"" c \
-			"" submodule \
-				>actual &&
-		test_cmp expect_local_path actual &&
-		git config submodule.a.url "$old_a" &&
-		git config submodule.submodule.url "$old_submodule" &&
-		git config --unset submodule.a.path c
-	)
-'
-
-cat >super/expect_url <<EOF
-Submodule url: '../submodule' for path 'b'
-Submodule url: 'git@somewhere.else.net:submodule.git' for path 'submodule'
-EOF
-
-test_expect_success 'reading of local configuration for uninitialized submodules' '
-	(
-		cd super &&
-		git submodule deinit -f b &&
-		old_submodule=$(git config submodule.submodule.url) &&
-		git config submodule.submodule.url git@somewhere.else.net:submodule.git &&
-		test-submodule-config --url \
-			"" b \
-			"" submodule \
-				>actual &&
-		test_cmp expect_url actual &&
-		git config submodule.submodule.url "$old_submodule" &&
-		git submodule init b
-	)
-'
-
-cat >super/expect_fetchrecurse_die.err <<EOF
-fatal: bad submodule.submodule.fetchrecursesubmodules argument: blabla
-EOF
-
-test_expect_success 'local error in fetchrecursesubmodule dies early' '
-	(cd super &&
-		git config submodule.submodule.fetchrecursesubmodules blabla &&
-		test_must_fail test-submodule-config \
-			"" b \
-			"" submodule \
-				>actual.out 2>actual.err &&
-		touch expect_fetchrecurse_die.out &&
-		test_cmp expect_fetchrecurse_die.out actual.out  &&
-		test_cmp expect_fetchrecurse_die.err actual.err  &&
-		git config --unset submodule.submodule.fetchrecursesubmodules
-	)
-'
-
 test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 	(cd super &&
 		git config -f .gitmodules \
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

