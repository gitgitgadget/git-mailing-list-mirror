Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB66C4BA3B
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 04:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB7A24650
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 04:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUcddWkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgB0EfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:35:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37751 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgB0EfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 23:35:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so1641769wrx.4
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 20:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4p+qex8gHnrcPz4yVHHwJuZG+xn/dGCMRtimf3xehJI=;
        b=iUcddWkd38h18qOaI5P+Wk/MQa3lvS+p8+DBknIzj0Z13yJs7KH37k+7m6LLWJgrhO
         ushNJ8PwpdNHnFPazB4SgGi2vnfNSms9dJUOEurJflvQGUlv01IFwHQE+4A4P/5qSNNh
         /gOxk4VNHA3/KmXVS4245Y/pFWGarDWEjFfDRj2asEcx9KIpcF3B6RdJULeUFngS7CuS
         9Q0ciFJLJ3QcSTFmMIiSljhthznzJDIKqWxvTvKwh3vgllph+gyJyMHL+L7ugP9Hz0g2
         iaTH0vExIAR0jftc7LRQe6S0MBXxwKax7J5gTFFuQv1coK+MJzkBRc3oBj5bIIHYrzle
         Fc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4p+qex8gHnrcPz4yVHHwJuZG+xn/dGCMRtimf3xehJI=;
        b=bfayD6t+dei0k6wTZsb0MlTo8qv2kVYnMVtQZ0sBpA4jwBqkXggoeZczByuWka5DHS
         3iPGv6mv5AKqFbBc/woBJxrVX6+ugSeZbVxvDbtvxBbP+MD8bJr8QlsF2es9pzatrfE+
         wo2A94gAWDAhG0XY89ueS0SOZvmM4WbMM2cNxG29+rhTxj8FNXus4h0jyR7Zoffg36kT
         +sZCWH6QLc7g97o4J06SHBjyHQI48AZhy/qZ3tFmT0ucs8RGIxmt6khaWyzGwKS6FRXX
         5NTHyUo/P1mmvprPZTcCYG/XDwg5cbpfOcRy8Fv6DPxrhwOjTDZkBg6ZGEu/OUyJLTMH
         NFew==
X-Gm-Message-State: APjAAAWSIsFyyq0JWH6Fv9PWbyKeLiVMRfcPfpMghw7BxoD3tmM9+ffh
        2AS9o9xS5LFDqhsXd4h9j2wOTE3j
X-Google-Smtp-Source: APXvYqzwXiEImVbe0Pjzkl9HlWAYM7OKyWAY2cSzJ2gcV3O3dQ/2Y52ePIFFvpziNufBdUPjGGQvnA==
X-Received: by 2002:adf:de12:: with SMTP id b18mr2317648wrm.268.1582778115853;
        Wed, 26 Feb 2020 20:35:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a198sm6072194wme.12.2020.02.26.20.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 20:35:15 -0800 (PST)
Message-Id: <176e38a841d1bbb138ae31b6db34fb597f9188b2.1582778112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
References: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 04:35:10 +0000
Subject: [PATCH v6 3/4] advice: revamp advise API
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

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Makefile               |   1 +
 advice.c               | 111 +++++++++++++++++++++++++++++++++++++++--
 advice.h               |  49 ++++++++++++++++++
 t/helper/test-advise.c |  19 +++++++
 t/helper/test-tool.c   |   1 +
 t/helper/test-tool.h   |   1 +
 t/t0018-advice.sh      |  32 ++++++++++++
 7 files changed, 210 insertions(+), 4 deletions(-)
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
index 258cc9ba7af..8d9f2910663 100644
--- a/advice.c
+++ b/advice.c
@@ -32,6 +32,40 @@ int advice_checkout_ambiguous_remote_branch_name = 1;
 int advice_nested_tag = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 
+const char ADVICE_ADD_EMBEDDED_REPO[] = "advice.addEmbeddedRepo";
+const char ADVICE_AM_WORK_DIR[] = "advice.amWorkDir";
+const char ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME[] = "advice.checkoutAmbiguousRemoteBranchName";
+const char ADVICE_COMMIT_BEFORE_MERGE[] = "advice.commitBeforeMerge";
+const char ADVICE_DETACHED_HEAD[] = "advice.detachedHead";
+const char ADVICE_FETCH_SHOW_FORCED_UPDATES[] = "advice.fetchShowForcedUpdates";
+const char ADVICE_GRAFT_FILE_DEPRECATED[] = "advice.graftFileDeprecated";
+const char ADVICE_IGNORED_HOOK[] = "advice.ignoredHook";
+const char ADVICE_IMPLICIT_IDENTITY[] = "advice.implicitIdentity";
+const char ADVICE_NESTED_TAG[] = "advice.nestedTag";
+const char ADVICE_OBJECT_NAME_WARNING[] = "advice.objectNameWarning";
+const char ADVICE_PUSH_ALREADY_EXISTS[] = "advice.pushAlreadyExists";
+const char ADVICE_PUSH_FETCH_FIRST[] = "advice.pushFetchFirst";
+const char ADVICE_PUSH_NEEDS_FORCE[] = "advice.pushNeedsForce";
+const char ADVICE_PUSH_NON_FF_CURRENT[] = "advice.pushNonFFCurrent";
+const char ADVICE_PUSH_NON_FF_MATCHING[] = "advice.pushNonFFMatching";
+const char ADVICE_PUSH_UNQUALIFIED_REF_NAME[] = "advice.pushUnqualifiedRefName";
+const char ADVICE_PUSH_UPDATE_REJECTED[] = "advice.pushUpdateRejected";
+
+/* make this an alias for backward compatibility */
+const char ADVICE_PUSH_UPDATE_REJECTED_ALIAS[] = "advice.pushNonFastForward";
+
+const char ADVICE_RESET_QUIET_WARNING[] = "advice.resetQuiet";
+const char ADVICE_RESOLVE_CONFLICT[] = "advice.resolveConflict";
+const char ADVICE_RM_HINTS[] = "advice.rmHints";
+const char ADVICE_SEQUENCER_IN_USE[] = "advice.sequencerInUse";
+const char ADVICE_SET_UPSTREAM_FAILURE[] = "advice.setUpstreamFailure";
+const char ADVICE_STATUS_AHEAD_BEHIND_WARNING[] = "advice.statusAheadBehindWarning";
+const char ADVICE_STATUS_HINTS[] = "advice.statusHints";
+const char ADVICE_STATUS_U_OPTION[] = "advice.statusUoption";
+const char ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE[] = "advice.submoduleAlternateErrorStrategyDie";
+const char ADVICE_WAITING_FOR_EDITOR[] = "advice.waitingForEditor";
+
+
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -96,13 +130,53 @@ static struct {
 	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
-static void vadvise(const char *advice, va_list params)
+static const char *advice_config_keys[] = {
+	ADVICE_ADD_EMBEDDED_REPO,
+	ADVICE_AM_WORK_DIR,
+	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
+	ADVICE_COMMIT_BEFORE_MERGE,
+	ADVICE_DETACHED_HEAD,
+	ADVICE_FETCH_SHOW_FORCED_UPDATES,
+	ADVICE_GRAFT_FILE_DEPRECATED,
+	ADVICE_IGNORED_HOOK,
+	ADVICE_IMPLICIT_IDENTITY,
+	ADVICE_NESTED_TAG,
+	ADVICE_OBJECT_NAME_WARNING,
+	ADVICE_PUSH_ALREADY_EXISTS,
+	ADVICE_PUSH_FETCH_FIRST,
+	ADVICE_PUSH_NEEDS_FORCE,
+	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
+	ADVICE_PUSH_NON_FF_CURRENT,
+	ADVICE_PUSH_NON_FF_MATCHING,
+	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
+	ADVICE_PUSH_UPDATE_REJECTED,
+	ADVICE_RESET_QUIET_WARNING,
+	ADVICE_RESOLVE_CONFLICT,
+	ADVICE_RM_HINTS,
+	ADVICE_SEQUENCER_IN_USE,
+	ADVICE_SET_UPSTREAM_FAILURE,
+	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
+	ADVICE_STATUS_HINTS,
+	ADVICE_STATUS_U_OPTION,
+	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
+	ADVICE_WAITING_FOR_EDITOR,
+};
+
+static const char turn_off_instructions[] =
+N_("\n"
+   "Disable this message with \"git config %s false\"");
+
+static void vadvise(const char *advice, int display_instructions,
+		    const char *key, va_list params)
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
@@ -119,7 +193,36 @@ void advise(const char *advice, ...)
 {
 	va_list params;
 	va_start(params, advice);
-	vadvise(advice, params);
+	vadvise(advice, 0, "", params);
+	va_end(params);
+}
+
+static int get_config_value(const char *advice_key)
+{
+	int value = 1;
+
+	git_config_get_bool(advice_key, &value);
+	return value;
+}
+
+int advice_enabled(const char *advice_key)
+{
+	if (advice_key == ADVICE_PUSH_UPDATE_REJECTED)
+		return get_config_value(ADVICE_PUSH_UPDATE_REJECTED) &&
+		       get_config_value(ADVICE_PUSH_UPDATE_REJECTED_ALIAS);
+	else
+		return get_config_value(advice_key);
+}
+
+void advise_if_enabled(const char *advice_key, const char *advice, ...)
+{
+	va_list params;
+
+	if (!advice_enabled(advice_key))
+		return;
+
+	va_start(params, advice);
+	vadvise(advice, 1, advice_key, params);
 	va_end(params);
 }
 
@@ -159,8 +262,8 @@ void list_config_advices(struct string_list *list, const char *prefix)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(advice_config); i++)
-		list_config_item(list, prefix, advice_config[i].name);
+	for (i = 0; i < ARRAY_SIZE(advice_config_keys); i++)
+		list_config_item(list, prefix, advice_config_keys[i]);
 }
 
 int error_resolve_conflict(const char *me)
diff --git a/advice.h b/advice.h
index b706780614d..78905c7ad57 100644
--- a/advice.h
+++ b/advice.h
@@ -32,9 +32,58 @@ extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
 
+/*
+ * To add a new advice, you need to:
+ * Define a new const char array.
+ * Add a new entry to advice_config_keys list.
+ * Add the new config variable to Documentation/config/advice.txt.
+ * Call advise_if_enabled to print your advice.
+ */
+extern const char ADVICE_ADD_EMBEDDED_REPO[];
+extern const char ADVICE_AM_WORK_DIR[];
+extern const char ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME[];
+extern const char ADVICE_COMMIT_BEFORE_MERGE[];
+extern const char ADVICE_DETACHED_HEAD[];
+extern const char ADVICE_FETCH_SHOW_FORCED_UPDATES[];
+extern const char ADVICE_GRAFT_FILE_DEPRECATED[];
+extern const char ADVICE_IGNORED_HOOK[];
+extern const char ADVICE_IMPLICIT_IDENTITY[];
+extern const char ADVICE_NESTED_TAG[];
+extern const char ADVICE_OBJECT_NAME_WARNING[];
+extern const char ADVICE_PUSH_ALREADY_EXISTS[];
+extern const char ADVICE_PUSH_FETCH_FIRST[];
+extern const char ADVICE_PUSH_NEEDS_FORCE[];
+extern const char ADVICE_PUSH_NON_FF_CURRENT[];
+extern const char ADVICE_PUSH_NON_FF_MATCHING[];
+extern const char ADVICE_PUSH_UNQUALIFIED_REF_NAME[];
+extern const char ADVICE_PUSH_UPDATE_REJECTED_ALIAS[];
+extern const char ADVICE_PUSH_UPDATE_REJECTED[];
+extern const char ADVICE_RESET_QUIET_WARNING[];
+extern const char ADVICE_RESOLVE_CONFLICT[];
+extern const char ADVICE_RM_HINTS[];
+extern const char ADVICE_SEQUENCER_IN_USE[];
+extern const char ADVICE_SET_UPSTREAM_FAILURE[];
+extern const char ADVICE_STATUS_AHEAD_BEHIND_WARNING[];
+extern const char ADVICE_STATUS_HINTS[];
+extern const char ADVICE_STATUS_U_OPTION[];
+extern const char ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE[];
+extern const char ADVICE_WAITING_FOR_EDITOR[];
+
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
 void advise(const char *advice, ...);
+
+/**
+ * Checks if advice type is enabled (can be printed to the user).
+ * Should be called before advise().
+ */
+int advice_enabled(const char *advice_key);
+
+/**
+ * Checks the visibility of the advice before printing.
+ */
+void advise_if_enabled(const char *advice_key, const char *advice, ...);
+
 int error_resolve_conflict(const char *me);
 void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
new file mode 100644
index 00000000000..73e6edd07c8
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
+	advise_if_enabled(ADVICE_NESTED_TAG, argv[1]);
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

