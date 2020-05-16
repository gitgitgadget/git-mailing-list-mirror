Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8162AC433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 17:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55040206D8
	for <git@archiver.kernel.org>; Sat, 16 May 2020 17:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="FrYzxxNZ";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="wTTbWac7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgEPRic (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 13:38:32 -0400
Received: from ns3309586.ip-5-135-160.eu ([5.135.160.121]:34660 "EHLO
        mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgEPRic (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 May 2020 13:38:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id 2BCC340372;
        Sat, 16 May 2020 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589650710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ICV6GRe3Cb+14ZOGFtJaScUY5gmArQyjcphFdhqub3c=;
        b=FrYzxxNZToLMkmHKfFJ4wEgyCV66Sg4F6Ej5xo5FG5nOcvJb7MJquQhcmswkwiHph1hXqv
        ECtsHF5WKt1GJCC5X4pbm3wQi+XAI1z18PvS98ycqrzqhzlaaYoGTC+1fuw25Xd3uVlzzV
        JfOK/tgOLDhgkWgzGWQHCmOBo/4J8Zw=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id 699B13FDD6;
        Sat, 16 May 2020 17:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589650708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ICV6GRe3Cb+14ZOGFtJaScUY5gmArQyjcphFdhqub3c=;
        b=wTTbWac7QMXhXvmez3lx0JFDtywgp1r81vHAfjsbwtciyW7kLTYZR3mr1ihbahk5WHVlCE
        cLJmrRIcPGCDg9G+eZoB13KeudPeNOvGzaVDfRRSM4yohdhrIQd2m6e1gdiYThIGWPq8mb
        994CfN+mqdB2AhdTyNA9WglONF6PUUQ=
Date:   Sat, 16 May 2020 19:38:28 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] diff: add config option relative
Message-ID: <20200516173828.GB34961@spk-laptop>
References: <20200515155706.GA1165062@spk-laptop>
 <20200515233130.GC6362@camp.crustytoothpaste.net>
 <xmqq1rnk923o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rnk923o.fsf@gitster.c.googlers.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `diff.relative` boolean option set to `true` show only changes on
the current directory and show relative pathnames to the current
directory.

Teach --no-relative to override earlier --relative

Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
---
 Documentation/config/diff.txt   |  4 ++
 Documentation/diff-options.txt  |  2 +
 diff.c                          | 10 ++++
 t/t9904-diff-relative-config.sh | 93 +++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)
 create mode 100755 t/t9904-diff-relative-config.sh

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index ff09f1cf73..76537c3b0c 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -105,6 +105,10 @@ diff.mnemonicPrefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.

+diff.relative::
+	If set to "true", 'git diff' does not show changes outside of the directory
+	and show pathnames relative to the current directory.
+
 diff.orderFile::
 	File indicating how to order files within a diff.
 	See the '-O' option to linkgit:git-diff[1] for details.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index bb31f0c42b..fdc5aefa37 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -651,6 +651,8 @@ ifndef::git-format-patch[]
 	not in a subdirectory (e.g. in a bare repository), you
 	can name which subdirectory to make the output relative
 	to by giving a <path> as an argument.
+--no-relative::
+	Turn off relative pathnames and include all changes in the repository.
 endif::git-format-patch[]

 -a::
diff --git a/diff.c b/diff.c
index d1ad6a3c4a..c4dcf01ec0 100644
--- a/diff.c
+++ b/diff.c
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

@@ -5494,6 +5501,9 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("when run from subdir, exclude changes outside and show relative paths"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_relative),
+		OPT_SET_INT_F(0, "no-relative", &options->flags.relative_name,
+			      N_("disable diff.relative config option"),
+			      0, PARSE_OPT_NONEG),
 		OPT_BOOL('a', "text", &options->flags.text,
 			 N_("treat all files as text")),
 		OPT_BOOL('R', NULL, &options->flags.reverse_diff,
diff --git a/t/t9904-diff-relative-config.sh b/t/t9904-diff-relative-config.sh
new file mode 100755
index 0000000000..23ab1af5e0
--- /dev/null
+++ b/t/t9904-diff-relative-config.sh
@@ -0,0 +1,93 @@
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
+check_diff_relative () {
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
+	test_expect_success "config.relative $relative_opt -p $*" "
+		test_config -C $dir diff.relative $relative_opt &&
+		git -C '$dir' diff -p $* HEAD^ >actual &&
+		test_cmp expected actual
+	"
+}
+
+check_diff_no_relative () {
+	dir=$1
+	shift
+	expect=$1
+	shift
+	relative_opt=$1
+	shift
+	short_blob_file1=$(git rev-parse --short "$(git hash-object file1)")
+	short_blob_file2=$(git rev-parse --short "$(git hash-object subdir/file2)")
+	cat >expected <<-EOF
+	diff --git a/file1 b/file1
+	new file mode 100644
+	index 0000000..$short_blob_file1
+	--- /dev/null
+	+++ b/file1
+	@@ -0,0 +1 @@
+	+content
+	diff --git a/$expect b/$expect
+	new file mode 100644
+	index 0000000..$short_blob_file2
+	--- /dev/null
+	+++ b/$expect
+	@@ -0,0 +1 @@
+	+other content
+	EOF
+	cat expected
+	test_expect_success "config.relative $relative_opt -p $*" "
+		test_config -C $dir diff.relative $relative_opt &&
+		git -C '$dir' diff -p $* HEAD^ >actual &&
+		git -C '$dir' diff -p $* HEAD^ >/tmp/actual &&
+		test_cmp expected actual
+	"
+}
+
+check_diff_relative . file2 false --relative=subdir/
+check_diff_relative . file2 false --relative=subdir
+check_diff_relative . file2 true --relative=subdir/
+check_diff_relative . file2 true --relative=subdir
+check_diff_relative subdir file2 false --relative
+check_diff_relative subdir file2 true --relative
+check_diff_relative subdir file2 true
+check_diff_relative subdir file2 false --no-relative --relative
+check_diff_relative subdir file2 true --no-relative --relative
+check_diff_relative . file2 false --no-relative --relative=subdir
+check_diff_relative . file2 true --no-relative --relative=subdir
+
+check_diff_no_relative . subdir/file2 false
+check_diff_no_relative . subdir/file2 true --no-relative
+check_diff_no_relative . subdir/file2 false --no-relative
+check_diff_no_relative subdir subdir/file2 false
+check_diff_no_relative subdir subdir/file2 true --no-relative
+check_diff_no_relative subdir subdir/file2 false --no-relative
+
+test_done
--
2.26.2
