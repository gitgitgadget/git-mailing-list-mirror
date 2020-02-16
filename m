Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6EAC7619C
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1959A20857
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 21:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hklwUa+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBPVjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 16:39:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56055 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgBPVjP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 16:39:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so15228079wmj.5
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 13:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nhUIzAIqcjc2AQUiDkgZnCMN6Aap+sPKx9ptQQdE0qo=;
        b=hklwUa+qsDYHeR2iOmxbh5BtvT1JoUg4ACyMreaA0dsV8BJgrzQELhz41DnPnEQOI9
         491ZdYw6qFV/cH42AfpMfwK/P+ysdfvx65nTOzTbiuxhvDHPdfGeAvaR0qLjtOXDEqCV
         zD4uGx+tRUr3nRFNBrOZrY8U9ls5kIxtDCo4zw+gp9EqOZEwXALzwPTKsI8UjkD8s+Ae
         tBzwLumdwEISy8XfTU7QeNDd7pzAfSS8t1zISSiBnkohuIgJ3C8/dOa4HmpmtATYHUl/
         mOzWURedhJqzUkk7ilgpphntCJp6tfbTkv1LSKYtBCOFqRLm+bS3nub4Wcx3AmwAU8HG
         uYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nhUIzAIqcjc2AQUiDkgZnCMN6Aap+sPKx9ptQQdE0qo=;
        b=f0Bhdq3yoTxXwOsDg0rBhnzeVyqjbuSpILd5f3hYwXHIuxV5wOSUGCU/kYZ1oIAGAH
         C5jS879+i7i3SSshhbsml0mTLjH91k+MMf9iK2wWzQrXKOvSpSaqKCq7IPSau+F5fu+W
         Dt+4AcjlauLjZED1PtUujU6fVP/1uLxsytBvDHDkenwMC8LT5nB7mur7d2o7kL1DNDQZ
         flTBzFWUoU5oKUDQf0LDK6G5HwkfFXu1PnJGu2nHwtRJbiZeAQyfduTstCmK3hJc9bBU
         8NJJYO9VbUPO0ZQcPpkLIo0iOdk5vti7La8jhFvCtmKBKdqxoyXLo9Q1XNy3s+mWqf2u
         Yr7w==
X-Gm-Message-State: APjAAAVh5+bgYDRydJRkal7h0/6p3DCkaIfYzcmoVkc3H8Tr+U3IYyYq
        NT8SLzQ4jQNjzqCLuU5P8UOmOAm/
X-Google-Smtp-Source: APXvYqwQWM2SLsaSBfKtgGoosPOrLdjSowR+W5LlYR+na6QcekE0gTo8Ay5052t6bZlGh6/OA1MEzg==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr18367880wmg.38.1581889152023;
        Sun, 16 Feb 2020 13:39:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm25879514wmd.1.2020.02.16.13.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 13:39:11 -0800 (PST)
Message-Id: <080d12b5c696d61ac1052d5863f7260a4005346e.1581889150.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
        <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Feb 2020 21:39:08 +0000
Subject: [PATCH v2 1/2] advice: refactor advise API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Currently it's very easy for the advice library's callers to miss
checking the visibility step before printing an advice. Also, it makes
more sense for this step to be handled by the advice library.

Add a new advise_if_enabled function that checks the visibility of
advice messages before printing.

Add a new helper advise_enabled to check the visibility of the advice
if the caller needs to carry out complicated processing based on that
value.

A list of config variables 'advice_config_keys' is added to be used by
list_config_advices() instead of 'advice_config[]' because we'll get
rid of 'advice_config[]' and the global variables once we migrate all
the callers to use the new APIs.

Also change the advise call in tag library from advise() to
advise_if_enabled() to construct an example of the usage of the new
API.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Makefile               |  1 +
 advice.c               | 88 ++++++++++++++++++++++++++++++++++++++++--
 advice.h               | 58 +++++++++++++++++++++++++++-
 builtin/tag.c          |  4 +-
 t/helper/test-advise.c | 16 ++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0018-advice.sh      | 28 ++++++++++++++
 t/t7004-tag.sh         |  1 +
 9 files changed, 191 insertions(+), 7 deletions(-)
 create mode 100644 t/helper/test-advise.c
 create mode 100755 t/t0018-advice.sh

diff --git a/Makefile b/Makefile
index 09f98b777ca..ed923a3e818 100644
--- a/Makefile
+++ b/Makefile
@@ -695,6 +695,7 @@ X =
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
+TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-ctype.o
diff --git a/advice.c b/advice.c
index 249c60dcf32..8cedc649afa 100644
--- a/advice.c
+++ b/advice.c
@@ -29,7 +29,6 @@ int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
-int advice_nested_tag = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 
 static int advice_use_color = -1;
@@ -89,13 +88,46 @@ static struct {
 	{ "waitingForEditor", &advice_waiting_for_editor },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
-	{ "nestedTag", &advice_nested_tag },
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
+static const char *advice_config_keys[] = {
+	[FETCH_SHOW_FORCED_UPDATES]		 = "fetchShowForcedUpdates",
+	[PUSH_UPDATE_REJECTED]			 = "pushUpdateRejected",
+	/* make this an alias for backward compatibility */
+	[PUSH_UPDATE_REJECTED_ALIAS]		 = "pushNonFastForward",
+	
+	[PUSH_NON_FF_CURRENT]			 = "pushNonFFCurrent",
+	[PUSH_NON_FF_MATCHING]			 = "pushNonFFMatching",
+	[PUSH_ALREADY_EXISTS]			 = "pushAlreadyExists",
+	[PUSH_FETCH_FIRST]			 = "pushFetchFirst",
+	[PUSH_NEEDS_FORCE]			 = "pushNeedsForce",
+	[PUSH_UNQUALIFIED_REF_NAME]		 = "pushUnqualifiedRefName",
+	[STATUS_HINTS]				 = "statusHints",
+	[STATUS_U_OPTION]			 = "statusUoption",
+	[STATUS_AHEAD_BEHIND_WARNING]		 = "statusAheadBehindWarning",
+	[COMMIT_BEFORE_MERGE]			 = "commitBeforeMerge",
+	[RESET_QUIET_WARNING]			 = "resetQuiet",
+	[RESOLVE_CONFLICT]			 = "resolveConflict",
+	[SEQUENCER_IN_USE]			 = "sequencerInUse",
+	[IMPLICIT_IDENTITY]			 = "implicitIdentity",
+	[DETACHED_HEAD]				 = "detachedHead",
+	[SET_UPSTREAM_FAILURE]			 = "setupStreamFailure",
+	[OBJECT_NAME_WARNING]			 = "objectNameWarning",
+	[AMWORKDIR]				 = "amWorkDir",
+	[RM_HINTS]				 = "rmHints",
+	[ADD_EMBEDDED_REPO]			 = "addEmbeddedRepo",
+	[IGNORED_HOOK]				 = "ignoredHook",
+	[WAITING_FOR_EDITOR] 			 = "waitingForEditor",
+	[GRAFT_FILE_DEPRECATED]			 = "graftFileDeprecated",
+	[CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]	 = "checkoutAmbiguousRemoteBranchName",
+	[NESTED_TAG]				 = "nestedTag",
+	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie"
+};
+
 void advise(const char *advice, ...)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -118,6 +150,54 @@ void advise(const char *advice, ...)
 	strbuf_release(&buf);
 }
 
+int advice_enabled(enum advice_type type)
+{
+	int value = 1;
+	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
+	git_config_get_bool(key, &value);
+	return value;
+}
+
+int advice_push_update_rejected_enabled(void)
+{
+	return advice_enabled(PUSH_UPDATE_REJECTED) ||
+	       advice_enabled(PUSH_UPDATE_REJECTED_ALIAS);
+	
+}
+
+static const char turn_off_instructions[] =
+N_("\n"
+   "Disable this message with \"git config %s false\"");
+
+void advise_if_enabled(enum advice_type type, const char *advice, ...)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
+	va_list params;
+	const char *cp, *np;
+	
+	if(!advice_enabled(type))
+		return;
+
+	va_start(params, advice);
+	strbuf_vaddf(&buf, advice, params);
+	va_end(params);
+
+	strbuf_addf(&buf, turn_off_instructions, key);
+	
+	for (cp = buf.buf; *cp; cp = np) {
+		np = strchrnul(cp, '\n');
+		fprintf(stderr,	_("%shint: %.*s%s\n"),
+			advise_get_color(ADVICE_COLOR_HINT),
+			(int)(np - cp), cp,
+			advise_get_color(ADVICE_COLOR_RESET));
+		if (*np)
+			np++;
+	}
+	strbuf_release(&buf);
+
+}
+
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k, *slot_name;
@@ -154,8 +234,8 @@ void list_config_advices(struct string_list *list, const char *prefix)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(advice_config); i++)
-		list_config_item(list, prefix, advice_config[i].name);
+	for (i = 0; i < ARRAY_SIZE(advice_config_keys); i++)
+		list_config_item(list, prefix, advice_config_keys[i]);
 }
 
 int error_resolve_conflict(const char *me)
diff --git a/advice.h b/advice.h
index b706780614d..d2ac3084067 100644
--- a/advice.h
+++ b/advice.h
@@ -29,12 +29,68 @@ extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
 extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
-extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
 
+/**
+ To add a new advice, you need to:
+ - Define an advice_type.
+ - Add a new entry to advice_config_keys list.
+ - Add the new config variable to Documentation/config/advice.txt.
+ - Call advise_if_enabled to print your advice.
+ */
+enum advice_type {
+	FETCH_SHOW_FORCED_UPDATES = 0,
+	PUSH_UPDATE_REJECTED = 1,
+	PUSH_UPDATE_REJECTED_ALIAS = 2,
+	PUSH_NON_FF_CURRENT = 3,
+	PUSH_NON_FF_MATCHING = 4,
+	PUSH_ALREADY_EXISTS = 5,
+	PUSH_FETCH_FIRST = 6,
+	PUSH_NEEDS_FORCE = 7,
+	PUSH_UNQUALIFIED_REF_NAME = 8,
+	STATUS_HINTS = 9,
+	STATUS_U_OPTION = 10,
+	STATUS_AHEAD_BEHIND_WARNING = 11,
+	COMMIT_BEFORE_MERGE = 12,
+	RESET_QUIET_WARNING = 13,
+	RESOLVE_CONFLICT = 14,
+	SEQUENCER_IN_USE = 15,
+	IMPLICIT_IDENTITY = 16,
+	DETACHED_HEAD = 17,
+	SET_UPSTREAM_FAILURE = 18,
+	OBJECT_NAME_WARNING = 19,
+	AMWORKDIR = 20,
+	RM_HINTS = 21,
+	ADD_EMBEDDED_REPO = 22,
+	IGNORED_HOOK = 23,
+	WAITING_FOR_EDITOR = 24,
+	GRAFT_FILE_DEPRECATED = 25,
+	CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME = 26,
+	NESTED_TAG = 27,
+	SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE = 28,
+};
+
+
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
 void advise(const char *advice, ...);
+
+/**
+ Checks if advice type is enabled (can be printed to the user).
+ Should be called before advise().
+ */
+int advice_enabled(enum advice_type type);
+
+/**
+ Checks if PUSH_UPDATE_REJECTED advice type is enabled.
+ */
+int advice_push_update_rejected_enabled(void);
+
+/**
+ Checks the visibility of the advice before priniting.
+ */
+void advise_if_enabled(enum advice_type type, const char *advice, ...);
+
 int error_resolve_conflict(const char *me);
 void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
diff --git a/builtin/tag.c b/builtin/tag.c
index e0a4c253828..247d9075e19 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -231,8 +231,8 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 	if (type <= OBJ_NONE)
 		die(_("bad object type."));
 
-	if (type == OBJ_TAG && advice_nested_tag)
-		advise(_(message_advice_nested_tag), tag, object_ref);
+	if (type == OBJ_TAG)
+		advise_if_enabled(NESTED_TAG, _(message_advice_nested_tag), tag, object_ref);
 
 	strbuf_addf(&header,
 		    "object %s\n"
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
new file mode 100644
index 00000000000..c49be89f970
--- /dev/null
+++ b/t/helper/test-advise.c
@@ -0,0 +1,16 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "advice.h"
+
+int cmd__advise_if_enabled(int argc, const char **argv)
+{
+	if (!argv[1])
+	die("usage: %s <advice>", argv[0]);
+
+	setup_git_directory();
+	
+	//use any advice type for testing
+	advise_if_enabled(NESTED_TAG, argv[1]);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f20989d4497..6977badc690 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -14,6 +14,7 @@ struct test_cmd {
 };
 
 static struct test_cmd cmds[] = {
+	{ "advise", cmd__advise_if_enabled },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
 	{ "ctype", cmd__ctype },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 8ed2af71d1b..ca5e33b842f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -4,6 +4,7 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "git-compat-util.h"
 
+int cmd__advise_if_enabled(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
new file mode 100755
index 00000000000..f4cdb649d51
--- /dev/null
+++ b/t/t0018-advice.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='Test advise_if_enabled functionality'
+
+. ./test-lib.sh
+
+cat > expected <<EOF
+hint: This is a piece of advice
+hint: Disable this message with "git config advice.nestedTag false"
+EOF
+test_expect_success 'advise should be printed when config variable is unset' '
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'advise should be printed when config variable is set to true' '
+	test_config advice.nestedTag true &&
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'advise should not be printed when config variable is set to false' '
+	test_config advice.nestedTag false &&
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_must_be_empty actual
+'
+
+test_done
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 6db92bd3ba6..74b637deb25 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1726,6 +1726,7 @@ test_expect_success 'recursive tagging should give advice' '
 	hint: already a tag. If you meant to tag the object that it points to, use:
 	hint: |
 	hint: 	git tag -f nested annotated-v4.0^{}
+	hint: Disable this message with "git config advice.nestedTag false"
 	EOF
 	git tag -m nested nested annotated-v4.0 2>actual &&
 	test_i18ncmp expect actual
-- 
gitgitgadget

