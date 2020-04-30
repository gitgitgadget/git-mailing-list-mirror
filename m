Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0709BC83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52412083B
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrtlkSrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD3BYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgD3BYh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 21:24:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA64C035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:24:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j4so5943549ybj.20
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=ZsFmjgDSmq77DURRSuFpttfW12OcJcvyCGmPYKomro4=;
        b=HrtlkSrXjw6/znMVwrUhZjmBFnRlQa9UH0ziIOOl223KoeGFrU3cnEPrI45ufLqm0h
         8mv97H999IfY/1zHNBwMt0V7lNzrlKR3UOXtOid5k7Ia0KfROB+mpU665g1+8PXbhw62
         GUXT3L8WQGjhsv5jfjhL9ihdfVF7iqnUSGAiQNI7s7xFH+RV0iHnlYzouETKG/iRo6VJ
         9x9qBS4ccrRfLa8kKfX+yCVUhp0nV6TSX+ORlIZMUnT2YanVn4Bh1omxabKb0pH7BG5f
         WHkeuZkE+hpzs9xQf4CQx0z3ai4zvpl1dVoMMNYF/AHKiB7GYvZupFWsJXsG1fYAorEC
         3CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=ZsFmjgDSmq77DURRSuFpttfW12OcJcvyCGmPYKomro4=;
        b=J7VgsM7axpIoT09qOBWX5LPB79/QbMs3XszvAJjk9y0NbIQQQ8+Gg6yujCRhliK3EO
         Ck+AwtNrgH43XNYgxnQnYq55voOzZkvAx3gTFzSgWX0eO6O6pm5m8zMeGwoIMaaYDlzq
         3GbB3mM9QwO6xRkJr+PmZFEaV9rSRxcD8s1fRQ0GJN11ltuVjt4AvhoMkwU6np0TxpY1
         umsyZ2tKvGTa3lMG5vPlqycg7VxApjNo/BvDlpH0OFRDfPxy8rwF9l7UyNtXjcFywVP1
         sxnid7XjZ49fDffl/kTwBsMtYzIKDcx1MGKvEsaFgn/m3QhV0guQtRqlzzgn0yL6WWIN
         Ow6Q==
X-Gm-Message-State: AGi0PubWyI7j/kQkMkggEyBVRP1AO+OcS1vg1ULvTKLjVNUIooqSY81I
        D8b3QpUvnzy3SnmO5v5F+WG25vVk3DepE1ThtSWyyruygRUxVox1nRRyFe1aLC3uO8hCr4lSopD
        /B42YanbczSLMRw3Avs3qrfcdp9+jgAX/mhBFYLVvIUTp9BOIjgIvOBJCBsqvzQvbt9AJz0YDcg
        ==
X-Google-Smtp-Source: APiQypJlvnxuw/6EYy6f11VH0s+ICiEZaym28zGdRQxBA61j4BwNipc0qnLFM+eAM5P+84EtZAnmVJelQNXfqu0LEVA=
X-Received: by 2002:a25:3295:: with SMTP id y143mr1858646yby.390.1588209876500;
 Wed, 29 Apr 2020 18:24:36 -0700 (PDT)
Date:   Wed, 29 Apr 2020 18:24:25 -0700
In-Reply-To: <20200427233820.179891-1-emilyshaffer@google.com>
Message-Id: <20200430012425.209122-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3] bugreport: collect list of populated hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
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
Since v2, switched to write_script, and modified the test to check for
uninstalled hooks and sample hooks having correct behavior.

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
index acacca8fef..aa8a489c35 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -3,6 +3,8 @@
 #include "strbuf.h"
 #include "help.h"
 #include "compat/compiler.h"
+#include "run-command.h"
+
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -31,6 +33,53 @@ static void get_system_info(struct strbuf *sys_info)
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
@@ -114,6 +163,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, _("System Info"));
 	get_system_info(&buffer);
 
+	get_header(&buffer, _("Enabled Hooks"));
+	get_populated_hooks(&buffer, nongit_ok);
+
 	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
 	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
 
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 2e73658a5c..612c12a918 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -57,5 +57,15 @@ test_expect_success 'can create leading directories outside of a git dir' '
 	nongit git bugreport -o foo/bar/baz
 '
 
+test_expect_success 'indicates populated hooks' '
+	test_when_finished rm git-bugreport-hooks.txt &&
+	test_when_finished rm -fr .git/hooks &&
+	mkdir .git/hooks &&
+	write_script .git/hooks/applypatch-msg &&
+	write_script .git/hooks/prepare-commit-msg.sample &&
+	git bugreport -s hooks &&
+	grep applypatch-msg git-bugreport-hooks.txt &&
+	! grep prepare-commit-msg git-bugreport-hooks.txt
+'
 
 test_done
-- 
2.26.2.303.gf8c07b1a785-goog

