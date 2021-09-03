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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D8C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CA660F90
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350344AbhICR4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350309AbhICR4A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:56:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A23AC061796
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:55:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q14so9290108wrp.3
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A7SlMnB//NngTEdJmSpKoCZhHDmYXDx6Ccgj4FWTexY=;
        b=pGFZbmsfKMLT7mlRqZNq68rSArUkjSHzvMF97Z5j7+DNc1sHy1I5SzsM2Cu3rcsBaD
         8/oLb/AtrFI9tIJCUunLiSaJu6V9EHUPu/LKMmKi+k7PbEHo+Y3SsVSsighoxu4Y1dwh
         LvE8r4kDV+dybZUO1ShpK4CVecWdSS7VMSVdILtbrFXg1QG809ZuRujKgDh6x08T87JI
         /30n7n1QqtKURSrGC2kG17pbNmutx3IWZwLa7aXfb28IsKjtQeUhjP0P/jNRAN1mJojM
         11W2Elwe7x450b5gpp8SlMQoqPs2pEwHWN65hnV5wOeNgTcZE3IN39A6hm+35O0hLAMl
         Q0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A7SlMnB//NngTEdJmSpKoCZhHDmYXDx6Ccgj4FWTexY=;
        b=FJ94cu7Dn5yNlzCe4gKtwSUIBkkprQZ7fuOuzCrcTuspMdZBUic3r2RTlyOwX4JO8H
         UuaBLHYXXBT2ybhZaourCPoiC/0d0BBBJAEmiOQ0K2s5NnDbdp9F9ei5MtVpwkmnw4E3
         UOQKl7oGVN/h48dvK2S11Kw5FPrEo5uua1mRYDCR+drJFIdddFdbJX8SLsOg3XrgTTvU
         /qtrLdGc5E8rQVqmqPOJxwimGF7EY0qevvRyXaeZcuL/6dNw4uHqztJ7CZKrsIA1pcil
         pNOSqAPUhMhDcstzVpCT6jfY03g6yZTtdcSWQdmoNW8S2a51eDSfdjxfIZL2BYKO80F5
         6uPg==
X-Gm-Message-State: AOAM530tg8PHFEs5+8NNPG18ddEK9AqHv7yXy7kDVfTEBAsF8KiSzfq1
        DXM6/EgUJlxQ4AKuuV4u2YPR1FHl/Z8=
X-Google-Smtp-Source: ABdhPJzW+7fC9uZY5bJdqpdx698+RNUczQ2bmTUeH47/bCFhhnSuPDlo9fWf94Ab9eaLpNPmdheMGg==
X-Received: by 2002:adf:edc2:: with SMTP id v2mr284250wro.255.1630691698667;
        Fri, 03 Sep 2021 10:54:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm107350wmr.2.2021.09.03.10.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:54:58 -0700 (PDT)
Message-Id: <94a21982652a1e0dea3fed08d56f17159066e965.1630691688.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Sep 2021 17:54:45 +0000
Subject: [PATCH v2 13/15] scalar: implement the `delete` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 7e98a1d6b06..822d7c39903 100644
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
index 8637e207860..b7ace8b9f1f 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -14,6 +14,7 @@ scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
+scalar delete <enlistment>
 
 DESCRIPTION
 -----------
@@ -129,6 +130,13 @@ With the `--all` option, all enlistments currently registered with Scalar
 will be reconfigured. This option is meant to to be run every time after
 Scalar is upgraded.
 
+Delete
+~~~~~~
+
+delete <enlistment>::
+	This subcommand lets you delete an existing Scalar enlistment from your
+	local file system, unregistering the repository.
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

