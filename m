Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00458C35DFB
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 10:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE4A21556
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 10:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2XxW4U8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgBYKzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:55:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45534 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgBYKzq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 05:55:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so14116970wrs.12
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 02:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KItkg3ZtIU+uZwxU8FyvK8Pt+sJCV98QvBjZseUvis4=;
        b=D2XxW4U8hu9gETvEvhn1GqDPNITBLSxSxczJ+33BwM2KCaxyjamDb8mwU+RjBbiXZW
         PcMtk/LZhPkz5npApSzkKN7BsW8cVMb9VLElBW8j7H7ZpexBhCt8zOZqEPj4PBDeqUZt
         4CLFPFjZ4qYP7Hlo9lBLxh+FrNsIXER1pNj7qdAwvgtXgNfi1sbFJll3wt4qydWOrjfZ
         hBMP+G6LE7vmVEFKLGsGKe28RGINfO+KiH9ORVjmEfAYiR2Fb7YRHG0chx3tfwRUEd/P
         u8J0RR6rnonVcglyijoNua8DUpDNF7AOaak2zPxzmkPWBqA6KLeZD3qjgZC7QFFjut3R
         VNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KItkg3ZtIU+uZwxU8FyvK8Pt+sJCV98QvBjZseUvis4=;
        b=KIKSpCaa79KlCmEzE4bZ2z4ydGCqKlldWFwvk24/Oh5kc67GoMA8pm3PVz25HdyzKa
         DcwGvTL+UQcv89sKTF8Cz+GQR2FsF/Y4dHSlJKAbt0wV4k+wORVi0n4aAvZv8Pp9Eytm
         XRI3+p68aRHJH++Q4iD+83Vk2JVkIEtZrWccXL86VOh/wq02OGg/ymZAmWbUfH34PPNN
         Vc97kwM6lNzynkdVYFNXTpDTel75ezq02u4Ip3dJ9cMyBl0v3N9Ta+e+Na9mfj2RDO/Y
         1VdVCkB5HajNsLdj8HcWV6Pbwry/0T3CEhJkVGfQd7u78wgx9hPk9VdImcV85LiOsW2C
         vxgg==
X-Gm-Message-State: APjAAAUJsaCECSiGiDFxI0Rup/IHd9jWdsgPBtuZsohGPZoMBuMeoEDj
        d3lu1mMFfK6LmtK5GGiqQlzkcXHN
X-Google-Smtp-Source: APXvYqyi7vPDpUpt9k326L5AOaui6GgkvPN+a06gl/999iQ6Y6KvLTzYcWNAX4JpZS3EbX8GHQAYVw==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr71496387wrx.218.1582628144445;
        Tue, 25 Feb 2020 02:55:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm1710827wme.41.2020.02.25.02.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 02:55:43 -0800 (PST)
Message-Id: <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Feb 2020 10:55:39 +0000
Subject: [PATCH v5 2/3] advice: revamp advise API
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
 advice.c               | 86 ++++++++++++++++++++++++++++++++++++++++--
 advice.h               | 52 +++++++++++++++++++++++++
 t/helper/test-advise.c | 19 ++++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0018-advice.sh      | 32 ++++++++++++++++
 7 files changed, 188 insertions(+), 4 deletions(-)
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
index fd836332dad..5c2068b8f8a 100644
--- a/advice.c
+++ b/advice.c
@@ -96,13 +96,56 @@ static struct {
 	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
-static void vadvise(const char *advice, va_list params)
+static const char *advice_config_keys[] = {
+	[ADD_EMBEDDED_REPO]			 = "addEmbeddedRepo",
+	[AMWORKDIR]				 = "amWorkDir",
+	[CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]	 = "checkoutAmbiguousRemoteBranchName",
+	[COMMIT_BEFORE_MERGE]			 = "commitBeforeMerge",
+	[DETACHED_HEAD]				 = "detachedHead",
+	[FETCH_SHOW_FORCED_UPDATES]		 = "fetchShowForcedUpdates",
+	[GRAFT_FILE_DEPRECATED]			 = "graftFileDeprecated",
+	[IGNORED_HOOK]				 = "ignoredHook",
+	[IMPLICIT_IDENTITY]			 = "implicitIdentity",
+	[NESTED_TAG]				 = "nestedTag",
+	[OBJECT_NAME_WARNING]			 = "objectNameWarning",
+	[PUSH_ALREADY_EXISTS]			 = "pushAlreadyExists",
+	[PUSH_FETCH_FIRST]			 = "pushFetchFirst",
+	[PUSH_NEEDS_FORCE]			 = "pushNeedsForce",
+
+	/* make this an alias for backward compatibility */
+	[PUSH_UPDATE_REJECTED_ALIAS]		 = "pushNonFastForward",
+
+	[PUSH_NON_FF_CURRENT]			 = "pushNonFFCurrent",
+	[PUSH_NON_FF_MATCHING]			 = "pushNonFFMatching",
+	[PUSH_UNQUALIFIED_REF_NAME]		 = "pushUnqualifiedRefName",
+	[PUSH_UPDATE_REJECTED]			 = "pushUpdateRejected",
+	[RESET_QUIET_WARNING]			 = "resetQuiet",
+	[RESOLVE_CONFLICT]			 = "resolveConflict",
+	[RM_HINTS]				 = "rmHints",
+	[SEQUENCER_IN_USE]			 = "sequencerInUse",
+	[SET_UPSTREAM_FAILURE]			 = "setupStreamFailure",
+	[STATUS_AHEAD_BEHIND_WARNING]		 = "statusAheadBehindWarning",
+	[STATUS_HINTS]				 = "statusHints",
+	[STATUS_U_OPTION]			 = "statusUoption",
+	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie",
+	[WAITING_FOR_EDITOR] 			 = "waitingForEditor",
+};
+
+static const char turn_off_instructions[] =
+N_("\n"
+   "Disable this message with \"git config %s false\"");
+
+static void vadvise(const char *advice, int display_instructions,
+		    char *key, va_list params)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *cp, *np;
 
 	strbuf_vaddf(&buf, advice, params);
 
+	if (display_instructions)
+		strbuf_addf(&buf, turn_off_instructions, key);
+
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
 		fprintf(stderr,	_("%shint: %.*s%s\n"),
@@ -119,8 +162,43 @@ void advise(const char *advice, ...)
 {
 	va_list params;
 	va_start(params, advice);
-	vadvise(advice, params);
+	vadvise(advice, 0, "", params);
+	va_end(params);
+}
+
+static int get_config_value(enum advice_type type)
+{
+	int value = 1;
+	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
+
+	git_config_get_bool(key, &value);
+	free(key);
+	return value;
+}
+
+int advice_enabled(enum advice_type type)
+{
+	switch (type) {
+	case PUSH_UPDATE_REJECTED:
+		return get_config_value(PUSH_UPDATE_REJECTED) &&
+		       get_config_value(PUSH_UPDATE_REJECTED_ALIAS);
+	default:
+		return get_config_value(type);
+	}
+}
+
+void advise_if_enabled(enum advice_type type, const char *advice, ...)
+{
+	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
+	va_list params;
+
+	if (!advice_enabled(type))
+		return;
+
+	va_start(params, advice);
+	vadvise(advice, 1, key, params);
 	va_end(params);
+	free(key);
 }
 
 int git_default_advice_config(const char *var, const char *value)
@@ -159,8 +237,8 @@ void list_config_advices(struct string_list *list, const char *prefix)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(advice_config); i++)
-		list_config_item(list, prefix, advice_config[i].name);
+	for (i = 0; i < ARRAY_SIZE(advice_config_keys); i++)
+		list_config_item(list, prefix, advice_config_keys[i]);
 }
 
 int error_resolve_conflict(const char *me)
diff --git a/advice.h b/advice.h
index b706780614d..a8461a362a3 100644
--- a/advice.h
+++ b/advice.h
@@ -32,9 +32,61 @@ extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
 
+/*
+ * To add a new advice, you need to:
+ * Define an advice_type.
+ * Add a new entry to advice_config_keys list.
+ * Add the new config variable to Documentation/config/advice.txt.
+ * Call advise_if_enabled to print your advice.
+ */
+enum advice_type {
+	ADD_EMBEDDED_REPO,
+	AMWORKDIR,
+	CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
+	COMMIT_BEFORE_MERGE,
+	DETACHED_HEAD,
+	FETCH_SHOW_FORCED_UPDATES,
+	GRAFT_FILE_DEPRECATED,
+	IGNORED_HOOK,
+	IMPLICIT_IDENTITY,
+	NESTED_TAG,
+	OBJECT_NAME_WARNING,
+	PUSH_ALREADY_EXISTS,
+	PUSH_FETCH_FIRST,
+	PUSH_NEEDS_FORCE,
+	PUSH_NON_FF_CURRENT,
+	PUSH_NON_FF_MATCHING,
+	PUSH_UNQUALIFIED_REF_NAME,
+	PUSH_UPDATE_REJECTED_ALIAS,
+	PUSH_UPDATE_REJECTED,
+	RESET_QUIET_WARNING,
+	RESOLVE_CONFLICT,
+	RM_HINTS,
+	SEQUENCER_IN_USE,
+	SET_UPSTREAM_FAILURE,
+	STATUS_AHEAD_BEHIND_WARNING,
+	STATUS_HINTS,
+	STATUS_U_OPTION,
+	SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
+	WAITING_FOR_EDITOR,
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
+ Checks the visibility of the advice before printing.
+ */
+void advise_if_enabled(enum advice_type type, const char *advice, ...);
+
 int error_resolve_conflict(const char *me);
 void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
new file mode 100644
index 00000000000..279cad6460e
--- /dev/null
+++ b/t/helper/test-advise.c
@@ -0,0 +1,19 @@
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
+	/*
+	  Any advice type can be used for testing, but NESTED_TAG was selected
+	  here and in t0018 where this command is being executed.
+	 */
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
index 00000000000..e03554d2f34
--- /dev/null
+++ b/t/t0018-advice.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='Test advise_if_enabled functionality'
+
+. ./test-lib.sh
+
+test_expect_success 'advice should be printed when config variable is unset' '
+	cat >expect <<-\EOF &&
+	hint: This is a piece of advice
+	hint: Disable this message with "git config advice.nestedTag false"
+	EOF
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'advice should be printed when config variable is set to true' '
+	cat >expect <<-\EOF &&
+	hint: This is a piece of advice
+	hint: Disable this message with "git config advice.nestedTag false"
+	EOF
+	test_config advice.nestedTag true &&
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'advice should not be printed when config variable is set to false' '
+	test_config advice.nestedTag false &&
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_must_be_empty actual
+'
+
+test_done
-- 
gitgitgadget

