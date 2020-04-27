Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AD6C83001
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAE42072A
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWqVDQ5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgD0Xij (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725968AbgD0Xii (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 19:38:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB9BC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:38:37 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i2so21362169qkl.5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=F64upI//DBOEQJSoY0iXb7BnCLkABIuUDcH/v5kXB9U=;
        b=oWqVDQ5Rh3qPjQD5PBF/1hB45FXLXqyce1Y6nQE5T1EQNui1L86FaoVnnweUNHKPJN
         W17YPBiYtFihwyGyviOYW+QeLDKEyZZhfH+fJ9oSXeDzD4SZuLPvExrjoW6EF8NbDlt5
         j3P3fd0yWTi4jnBk+Ufojq46nqDJWDPJnYQy6Cdb9OtHKEhE5KeICuEbQRFsvx169MOg
         cRF5jalzQ7mK9IqDcpmKBNGkSLpivlpD0uQDny3LG9X/T/zAVpafyo4koolMsjZCgRmG
         DE91GZ22CLMVQ7rpI7HgFB5wb5jSj4EOga8QLSKgTYr8BR5oj2RAdr4PEEArLMgpqOwp
         rLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=F64upI//DBOEQJSoY0iXb7BnCLkABIuUDcH/v5kXB9U=;
        b=E6VRgBFGkrwPSp13lwh95dW7iwjGnztsHasrAJD/sY/u7e0OzkcV0BdspzwDvz3YZ2
         sfQMGSLLs/dJxHyO4mtyR1CWdnBa+LEwzDudOAj1QTFnvwmw0b9CShJjOO8V/lbiFUWe
         vmz4/qGMxx8ZEcru4+lQSx1aiOtrIaaDO61f/bdppFLlpZsMewv5QfKwNgvKCIOj+LyD
         TNyY+n3nSUkYBLphm3TwWGKgRAs91SowiiHqGDI/H/qoTH3NW5F2BfSoUF5/b5RcJsqS
         RR0UapKXOLgVtvyJRE7gSOi3mNUUQL7iqQaD36fT0NMpWFQUIeYDTtR/U5N/0SmNIYeD
         8ZUg==
X-Gm-Message-State: AGi0Pub3DMb2dyYjFMwyU6L6ouP/9dKDywZq7Vz+2RC9CpAptT5Ot9Eu
        nIOyU9v6Lbiw5zhOtRXHqE4ecMnXexRdHilcTHtHf8Yik1en4SS9COr9IOPZkZRweNoERKZ2H2j
        /0W4Y+Rqvq2h3wgCKcOpJScC80Zyjk49i2R48Aqkd04SuinoQ5oSB3JLZd/bT2ALNwVj8u+NQzg
        ==
X-Google-Smtp-Source: APiQypKY1qearA6+elRBqG98oXU976itRZn/B9SlY/nD5kc6oYL6fK6AR1PdolHyhIQAVRvf9OatpjpraOhxjK0ekBM=
X-Received: by 2002:a0c:ea28:: with SMTP id t8mr23950898qvp.174.1588030716115;
 Mon, 27 Apr 2020 16:38:36 -0700 (PDT)
Date:   Mon, 27 Apr 2020 16:38:20 -0700
In-Reply-To: <20200424233800.200439-1-emilyshaffer@google.com>
Message-Id: <20200427233820.179891-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2] bugreport: collect list of populated hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Occasionally a failure a user is seeing may be related to a specific
hook which is being run, perhaps without the user realizing. While the
contents of hooks can be sensitive - containing user data or process
information specific to the user's organization - simply knowing that a
hook is being run at a certain stage can help us to understand whether
something is going wrong.

Without a definitive list of hook names within the code, we compile our
own list from the documentation. This is likely prone to bitrot, but
designing a single source of truth for acceptable hooks is too much
overhead for this small change to the bugreport tool.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Since v1:

 - turned array of hooknames into a static const
 - added a test
 - i18n-ified the outputs added in this section
 - style changes

Thanks, all.
 - Emily

 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 52 +++++++++++++++++++++++++++++++++
 t/t0091-bugreport.sh            | 10 +++++++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 643d1b2884..7fe9aef34e 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -28,6 +28,7 @@ The following information is captured automatically:
  - 'git version --build-options'
  - uname sysname, release, version, and machine strings
  - Compiler-specific info string
+ - A list of enabled hooks
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index 089b939a87..81904b508e 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -5,6 +5,8 @@
 #include "time.h"
 #include "help.h"
 #include "compat/compiler.h"
+#include "run-command.h"
+
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -33,6 +35,53 @@ static void get_system_info(struct strbuf *sys_info)
 	get_libc_info(sys_info);
 }
 
+static void get_populated_hooks(struct strbuf *hook_info, int nongit)
+{
+	/*
+	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
+	 * so below is a transcription of `git help hooks`. Later, this should
+	 * be replaced with some programmatically generated list (generated from
+	 * doc or else taken from some library which tells us about all the
+	 * hooks)
+	 */
+	static const char *hook[] = {
+		"applypatch-msg",
+		"pre-applypatch",
+		"post-applypatch",
+		"pre-commit",
+		"pre-merge-commit",
+		"prepare-commit-msg",
+		"commit-msg",
+		"post-commit",
+		"pre-rebase",
+		"post-checkout",
+		"post-merge",
+		"pre-push",
+		"pre-receive",
+		"update",
+		"post-receive",
+		"post-update",
+		"push-to-checkout",
+		"pre-auto-gc",
+		"post-rewrite",
+		"sendemail-validate",
+		"fsmonitor-watchman",
+		"p4-pre-submit",
+		"post-index-change",
+	};
+	int i;
+
+	if (nongit) {
+		strbuf_addstr(hook_info,
+			_("not run from a git repository - no hooks to show\n"));
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(hook); i++)
+		if (find_hook(hook[i]))
+			strbuf_addf(hook_info, "%s\n", hook[i]);
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
 	NULL
@@ -116,6 +165,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, _("System Info"));
 	get_system_info(&buffer);
 
+	get_header(&buffer, _("Enabled Hooks"));
+	get_populated_hooks(&buffer, nongit_ok);
+
 	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
 	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
 
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 2e73658a5c..387fa46c3f 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -57,5 +57,15 @@ test_expect_success 'can create leading directories outside of a git dir' '
 	nongit git bugreport -o foo/bar/baz
 '
 
+test_expect_success 'indicates populated hooks' '
+	test_when_finished rm git-bugreport-hooks.txt &&
+	test_when_finished rm -fr .git/hooks &&
+	mkdir .git/hooks &&
+	touch .git/hooks/applypatch-msg &&
+	chmod +x .git/hooks/applypatch-msg &&
+	git bugreport -s hooks &&
+	test_i18ngrep applypatch-msg git-bugreport-hooks.txt
+'
+
 
 test_done
-- 
2.26.2.303.gf8c07b1a785-goog

