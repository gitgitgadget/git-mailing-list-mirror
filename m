Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462A7C4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF5360E77
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbhH3VgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbhH3Vf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:35:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D79C0617AD
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g18so16881110wrc.11
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nes43C5JEgz1MZonFU3BxL8mLEThPsfmLZqNaFOAzcI=;
        b=tGXYS3igGTW0UR0OZ4FB+bJD0cf+RuwSBduCmEP/JoQb8whqjGNaH/+zzBxzVklRVM
         uH2Z9wW59BgTyKbmFfLQu4C9Xeom2QVIcta4WQgdkaqVyHyn+FLxwzFJuYQxnp02cZ5Z
         r6vvF1KbA1guVM8oNCIVbY68ixShxOMvEeSZkuyPa+C5mm6LTNse+zbKVkOeQvgo6Bzw
         u9+NrBXz+mKIdeDhvUURbXO02QTRgmFqtlBTDIs7wcNRHtLMNXgLB3YFNRogzvJbcurD
         QjMmnKRhmRVc5n+PiF4DJ1wGAEVSXUSibGTVCrC1SuZBrIFl3mi7nEYTTqZqFOU0Hrvu
         1j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nes43C5JEgz1MZonFU3BxL8mLEThPsfmLZqNaFOAzcI=;
        b=phlS5ZMhz3J0cgFrZuZM+iqysQbN3f1cggUVCy4gYuhSxwKADtzQd8r9FCcDHQ86zY
         +2biKcz4kxASLT39G8hwFVMrpjhY4lPczPVGJeZrYsP1jnghg7E2/rCoN7iWDeS35GMF
         5cN47AISn8GDMKhIh5pShTIn2EcKE/rsMeagTUBXFdqlg7Pg2m/8hJg+/yWXVslwZ426
         nalVRTEYQT1O0QrT6+zNDRlfZlstSyXsvzTzKXd7pUd2/b4vcBuy0zev++XlD2kiduk3
         qxendBN5vsEgsnDGmpXKHab9ag3NEaKcLXJZLHqsQiRrnRCGaZHlar3W82bTx3DL9rfE
         WbOg==
X-Gm-Message-State: AOAM531PXwJY0vRuVfSL43Jtyu24XUU6uJkpSzv0IyZ5zrg9Q930uJqa
        7s1hZNi5+SN905KRQYqs2/R2UDjJsTc=
X-Google-Smtp-Source: ABdhPJxTS1RhgcbmuFvYk016NzhRHwAVwftrf+9m+EbP0ttxuFm3iZS1FvsDg6vaZRVRQZ0mZUp0vA==
X-Received: by 2002:a05:6000:368:: with SMTP id f8mr6312043wrf.128.1630359298578;
        Mon, 30 Aug 2021 14:34:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm636476wmp.1.2021.08.30.14.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:34:58 -0700 (PDT)
Message-Id: <13afbd68812b92b5f51af4377c9b95f1725dd3f0.1630359290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 21:34:48 +0000
Subject: [PATCH 13/15] scalar: implement the `delete` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Delete an enlistment by first unregistering the repository and then
deleting the enlistment directory (usually the directory containing the
worktree `src/` directory).

On Windows, if the current directory is inside the enlistment's
directory, change to the parent of the enlistment directory, to allow us
to delete the enlistment (directories used by processes e.g. as current
working directories cannot be deleted on Windows).

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 55 ++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  8 +++++
 contrib/scalar/t/t9099-scalar.sh |  9 ++++++
 3 files changed, 72 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 1f8778cbb39..c616e91231a 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -8,6 +8,7 @@
 #include "config.h"
 #include "run-command.h"
 #include "refs.h"
+#include "dir.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -334,6 +335,33 @@ static char *remote_default_branch(const char *url)
 	return NULL;
 }
 
+static int delete_enlistment(struct strbuf *enlistment)
+{
+#ifdef WIN32
+	struct strbuf parent = STRBUF_INIT;
+#endif
+
+	if (unregister_dir())
+		die(_("failed to unregister repository"));
+
+#ifdef WIN32
+	/*
+	 * Change the current directory to one outside of the enlistment so
+	 * that we may delete everything underneath it.
+	 */
+	strbuf_addbuf(&parent, enlistment);
+	strbuf_parent_directory(&parent);
+	if (chdir(parent.buf) < 0)
+		die_errno(_("could not switch to '%s'"), parent.buf);
+	strbuf_release(&parent);
+#endif
+
+	if (remove_dir_recursively(enlistment, 0))
+		die(_("failed to delete enlistment directory"));
+
+	return 0;
+}
+
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
@@ -694,6 +722,32 @@ static int cmd_unregister(int argc, const char **argv)
 	return unregister_dir();
 }
 
+static int cmd_delete(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar delete <enlistment>"),
+		NULL
+	};
+	struct strbuf enlistment = STRBUF_INIT;
+	int res = 0;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	if (argc != 1)
+		usage_with_options(usage, options);
+
+	setup_enlistment_directory(argc, argv, usage, options, &enlistment);
+
+	res = delete_enlistment(&enlistment);
+	strbuf_release(&enlistment);
+
+	return res;
+}
+
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
@@ -704,6 +758,7 @@ static struct {
 	{ "unregister", cmd_unregister },
 	{ "run", cmd_run },
 	{ "reconfigure", cmd_reconfigure },
+	{ "delete", cmd_delete },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 2a1a0695b4d..00923023243 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -14,6 +14,7 @@ scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
+scalar delete <enlistment>
 
 DESCRIPTION
 -----------
@@ -125,6 +126,13 @@ With the `--all` option, all enlistments currently registered with Scalar
 will be reconfigured. This option is meant to to be run every time Scalar
 was upgraded.
 
+Delete
+~~~~~~
+
+delete <enlistment>::
+    This subcommand lets you delete an existing Scalar enlistment from your
+    local file system, unregistering the repository.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 5fe7fabd0e5..7e8771d0eff 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -76,4 +76,13 @@ test_expect_success 'scalar reconfigure' '
 	test true = "$(git -C one/src config core.preloadIndex)"
 '
 
+test_expect_success 'scalar delete without enlistment shows a usage' '
+	test_expect_code 129 scalar delete
+'
+
+test_expect_success 'scalar delete with enlistment' '
+	scalar delete cloned &&
+	test_path_is_missing cloned
+'
+
 test_done
-- 
gitgitgadget

