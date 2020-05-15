Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4839AC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9912070A
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="HT+R3fge";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="udlWxoa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgEOQEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 12:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbgEOQD6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 12:03:58 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 May 2020 09:03:58 PDT
Received: from mail.spkdev.net (unknown [IPv6:2001:41d0:8:e379::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DEDC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 09:03:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id E91F840291
        for <git@vger.kernel.org>; Fri, 15 May 2020 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589558230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=WunLlh70MBJKPI5ttyfDBpO9GcNX+ChW1p3uDCnlStU=;
        b=HT+R3fgeSirKSbpT3ZReYqOCxVZGNzREmWzG1HNey4fk42Y7xLQAqHOu5rhi48/Vo2Bu//
        FFvDvUy2fOPGxfMinhaFv0TKoYuEZ7Kx62j8pTVXi6dpuNs0tYYCJlfc5CRwhNmADYaO6E
        pDtu+vH9hLuEvD+31pSrgMx683IjW80=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id 5D9DF3FDD6
        for <git@vger.kernel.org>; Fri, 15 May 2020 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589558227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=WunLlh70MBJKPI5ttyfDBpO9GcNX+ChW1p3uDCnlStU=;
        b=udlWxoa84uuQ3Qt6YpylEVD0UZniTF4rCTvNsNKD/xN0+lFdIk7jXSCSaJDSKjfWB7QRKI
        0TArLghrw0VCpV9orTtFYEF/eYhqHL3Zp26e0pPCTt9eykiolejh6NRYQUf6n5iUK8Etyl
        vd++sE40V7G/q0nzGMg3BUL2U8+7ewI=
Date:   Fri, 15 May 2020 17:57:06 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     git@vger.kernel.org
Subject: [PATCH] diff: add config option relative
Message-ID: <20200515155706.GA1165062@spk-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `diff.relative` boolean option set to `true` to show only changes on the
current directory and show relative pathnames.

Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
---
 Documentation/config/diff.txt   |  4 +++
 diff.c                          |  7 +++++
 t/t9904-diff-relative-config.sh | 48 +++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100755 t/t9904-diff-relative-config.sh

diff --git Documentation/config/diff.txt Documentation/config/diff.txt
index ff09f1cf73..1d311358d8 100644
--- Documentation/config/diff.txt
+++ Documentation/config/diff.txt
@@ -105,6 +105,10 @@ diff.mnemonicPrefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.
 
+diff.relative::
+	If set to "true", 'git diff' does not show changes outside of the directory
+	and show pathnames relative.
+
 diff.orderFile::
 	File indicating how to order files within a diff.
 	See the '-O' option to linkgit:git-diff[1] for details.
diff --git diff.c diff.c
index d1ad6a3c4a..24b7a0ae08 100644
--- diff.c
+++ diff.c
@@ -48,6 +48,7 @@ static const char *diff_order_file_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
+static int diff_relative;
 static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
@@ -386,6 +387,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_no_prefix = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.relative")) {
+		diff_relative = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.statgraphwidth")) {
 		diff_stat_graph_width = git_config_int(var, value);
 		return 0;
@@ -4558,6 +4563,8 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 		options->b_prefix = "b/";
 	}
 
+	options->flags.relative_name = diff_relative;
+
 	options->color_moved = diff_color_moved_default;
 	options->color_moved_ws_handling = diff_color_moved_ws_default;
 
diff --git t/t9904-diff-relative-config.sh t/t9904-diff-relative-config.sh
new file mode 100755
index 0000000000..a92d53ca25
--- /dev/null
+++ t/t9904-diff-relative-config.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='config diff.relative'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m empty &&
+	echo content >file1 &&
+	mkdir subdir &&
+	echo other content >subdir/file2 &&
+	git add . &&
+	git commit -m one
+'
+
+check_diff () {
+	dir=$1
+	shift
+	expect=$1
+	shift
+	relative_opt=$1
+	shift
+	short_blob=$(git rev-parse --short "$(git hash-object subdir/file2)")
+	cat >expected <<-EOF
+	diff --git a/$expect b/$expect
+	new file mode 100644
+	index 0000000..$short_blob
+	--- /dev/null
+	+++ b/$expect
+	@@ -0,0 +1 @@
+	+other content
+	EOF
+	test_expect_success "-p $*" "
+		test_config -C $dir diff.relative $relative_opt &&
+		git -C '$dir' diff -p $* HEAD^ >actual &&
+		test_cmp expected actual
+	"
+}
+
+check_diff . file2 false --relative=subdir/
+check_diff . file2 false --relative=subdir
+check_diff . file2 true --relative=subdir/
+check_diff . file2 true --relative=subdir
+check_diff subdir file2 false --relative
+check_diff subdir file2 true --relative
+check_diff subdir file2 true
+
+test_done
-- 
2.26.2
