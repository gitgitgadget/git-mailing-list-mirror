Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82A5620D12
	for <e@80x24.org>; Thu,  1 Jun 2017 00:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbdFAAbA (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 20:31:00 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36626 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdFAAa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 20:30:59 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so21556177pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 17:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QEBR04HWtYwj4sY+s1M1IB3d0J6nJO2mFNmH+rrRApI=;
        b=QcLzmx5ckEkS5NS9nhdmhZ/zRyOK6kUrIicpOnaR9a9iM0xfQIhCF90tLd6k1uX1Ll
         X7zyg5oLpul+UktThW9a02KL++HT9j/uXPXfCB4glTaFVzJdsIcNCr27a4aeOyFyhnFt
         7GbUkb/qOgtziplKv6kgn8HkNB0FrHNVb+jX2/kPNshZpjMm9aQMWhOnVaS6mpSxKLgl
         3hlG3juzgneS11HaSM9vhd4Gpi8sqU8YV+ZP9B5QitSvMW+x/3DgGjNJD1Yviy5akeuR
         Bu+JbSrHIvZllaG3EiUn5GI9Bm8p65DkH8Bv27vPPeKxcxn9dWI4RNVfTBT5I9mNkMYQ
         0NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QEBR04HWtYwj4sY+s1M1IB3d0J6nJO2mFNmH+rrRApI=;
        b=i8euL59xPsAVnQET0j8s1v3qWJhR0b6M72TW+4rjMpaMtvcsZpbkf4TNOoFvrn9Nc/
         TUoIaWICYUxV4IZh6bx1mzr+t4HoN3oQLJT+tL6UOXA4uUJEs+z+CSr0D9/m6flitgT/
         0CHo9GXo+3rwisiBkD5hjULs3B+zcaLQP5RKeqM5g8PSQaJwrBJV09WrbHBAq54RnmVV
         WCOobFu9VKcsywik4R7rvI6qoTJxPn49pqo8g8ZmvK1G4ZFHJPvsHYuR0TkYX1wEDc2S
         7VC7s/BPwJH2koPz3KaoBXCXMvaGQXTJwB24cPoKNcD/RC67N3eXgkD6tbYtcwrg83kL
         Umig==
X-Gm-Message-State: AODbwcAIw/sHFOm50nNQFT6CLkQhAvP82YK0Y5OBVSmekDRywYBUKDHk
        iHETEojR9U5B22o7
X-Received: by 10.99.99.193 with SMTP id x184mr35975776pgb.14.1496277057848;
        Wed, 31 May 2017 17:30:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7872:b8ac:87ee:2203])
        by smtp.gmail.com with ESMTPSA id b24sm36782160pfm.17.2017.05.31.17.30.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 17:30:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, sbeller@google.com
Subject: [PATCHv3 1/4] Introduce 'submodule.recurse' option for worktree manipulators
Date:   Wed, 31 May 2017 17:30:47 -0700
Message-Id: <20170601003050.4221-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gab62347cd9
In-Reply-To: <20170601003050.4221-1-sbeller@google.com>
References: <xmqqa85udi92.fsf@gitster.mtv.corp.google.com>
 <20170601003050.4221-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any command that understands '--recurse-submodules' can have its
default changed to true, by setting the new 'submodule.recurse'
option.

This patch includes read-tree/checkout/reset for working tree
manipulating commands. Later patches will cover other commands.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt  |  5 +++++
 builtin/checkout.c        |  2 +-
 builtin/read-tree.c       | 10 +++++++++-
 builtin/reset.c           | 10 +++++++++-
 submodule.c               | 23 +++++++++++++++++++++--
 submodule.h               |  1 +
 t/lib-submodule-update.sh | 12 ++++++++++++
 7 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e0b9fd0bc3..f60c504e86 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3065,6 +3065,11 @@ submodule.active::
 	submodule's path to determine if the submodule is of interest to git
 	commands.
 
+submodule.recurse::
+	Specifies if commands recurse into submodules by default. This
+	applies to all commands that have a `--recurse-submodules` option.
+	Defaults to false.
+
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
 	A positive integer allows up to that number of submodules fetched
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 56ea723b75..e289b7d477 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -855,7 +855,7 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 	}
 
 	if (starts_with(var, "submodule."))
-		return parse_submodule_config_option(var, value);
+		return submodule_config(var, value, NULL);
 
 	return git_xmerge_config(var, value, NULL);
 }
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 8a889ef4c3..7fd55140db 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -98,6 +98,14 @@ static int debug_merge(const struct cache_entry * const *stages,
 	return 0;
 }
 
+static int git_read_tree_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "submodule.recurse"))
+		return git_default_submodule_config(var, value, cb);
+
+	return git_default_config(var, value, cb);
+}
+
 static struct lock_file lock_file;
 
 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
@@ -150,7 +158,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 
-	git_config(git_default_config, NULL);
+	git_config(git_read_tree_config, NULL);
 
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
diff --git a/builtin/reset.c b/builtin/reset.c
index 6f89dc5494..585cfe0745 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -266,6 +266,14 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 	return update_ref_status;
 }
 
+static int git_reset_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "submodule.recurse"))
+		return git_default_submodule_config(var, value, cb);
+
+	return git_default_config(var, value, cb);
+}
+
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
@@ -294,7 +302,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_reset_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
diff --git a/submodule.c b/submodule.c
index 78cccb7563..2b157dc995 100644
--- a/submodule.c
+++ b/submodule.c
@@ -16,6 +16,7 @@
 #include "quote.h"
 #include "remote.h"
 #include "worktree.h"
+#include "parse-options.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
@@ -170,10 +171,28 @@ static int git_modules_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-/* Loads all submodule settings from the config */
+/* Loads all submodule settings from the config. */
 int submodule_config(const char *var, const char *value, void *cb)
 {
-	return git_modules_config(var, value, cb);
+	if (!strcmp(var, "submodule.recurse")) {
+		int v = git_config_bool(var, value) ?
+			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		config_update_recurse_submodules = v;
+		return 0;
+	} else {
+		return git_modules_config(var, value, cb);
+	}
+}
+
+/* Cheap function that only determines if we're interested in submodules at all */
+int git_default_submodule_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "submodule.recurse")) {
+		int v = git_config_bool(var, value) ?
+			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		config_update_recurse_submodules = v;
+	}
+	return 0;
 }
 
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
diff --git a/submodule.h b/submodule.h
index b13f120f76..d920ca1d5a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -39,6 +39,7 @@ extern void stage_updated_gitmodules(void);
 extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
 		const char *path);
 extern int submodule_config(const char *var, const char *value, void *cb);
+extern int git_default_submodule_config(const char *var, const char *value, void *cb);
 
 struct option;
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 0272c4d8ca..52beadad96 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -990,6 +990,18 @@ test_submodule_switch_recursing_with_args () {
 		)
 	'
 
+	test_expect_success "git -c submodule.recurse=true $cmd_args: modified submodule updates submodule work tree" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			git -c submodule.recurse=true $cmd_args modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1
+		)
+	'
+
 	# Updating a submodule to an invalid sha1 doesn't update the
 	# superproject nor the submodule's work tree.
 	test_expect_success "$command: updating to a missing submodule commit fails" '
-- 
2.13.0.17.gab62347cd9

