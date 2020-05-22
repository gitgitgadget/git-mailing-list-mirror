Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E0C433E0
	for <git@archiver.kernel.org>; Fri, 22 May 2020 10:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B29320738
	for <git@archiver.kernel.org>; Fri, 22 May 2020 10:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="RUd0eB1u";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="XKBAxeSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgEVKq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 06:46:26 -0400
Received: from ns3309586.ip-5-135-160.eu ([5.135.160.121]:50106 "EHLO
        mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgEVKqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 06:46:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id C5E1340348;
        Fri, 22 May 2020 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1590144381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/QX3U3fHZyMtBmwhPu2FBW/9wpkS2X/XHdor+HkDzZY=;
        b=RUd0eB1uFu6GPDEH4rE49wgUrPEe5HOHc+hwrYfmTqNsAed6Z9whaRgLFmUgtfqBK1Dw9H
        Q3JoTM+dGaT/O45vISWBHaq6UELKsF4TcjwFGSwIOIDFYWyFWuTkJqfP1H7k2MJgxECXgo
        faSWJPHql5pnHIPuIaFlXiLP+Xk0jn8=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id 421D1400F2;
        Fri, 22 May 2020 10:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1590144380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/QX3U3fHZyMtBmwhPu2FBW/9wpkS2X/XHdor+HkDzZY=;
        b=XKBAxeSm+2ZFRXktRIVG1VzpaeRFq9z7ONBha2PIGjMxyanTflJCxO8Ev+dCMOA7Yhpdkd
        j0jyGdGoCbufiSMxCxEIZIyO7+iszTAIBWYsTcnI2X95AVThDMOVoDq+n45uFOyayPsDux
        gcE8AyJYpWixyA0zTd5nTvwQSqRQXy0=
Date:   Fri, 22 May 2020 12:46:18 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH v8] diff: add config option relative
Message-ID: <20200522104618.GA2050@spk-laptop>
References: <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
 <20200518094021.GA2069@spk-laptop>
 <20200518135656.GB1980@danh.dev>
 <xmqq4ksd5ggq.fsf@gitster.c.googlers.com>
 <20200518191205.GA1999@danh.dev>
 <xmqqo8ql0yjg.fsf@gitster.c.googlers.com>
 <20200519003006.GC1999@danh.dev>
 <xmqqv9krztwp.fsf@gitster.c.googlers.com>
 <20200519193902.GA202573@spk-laptop>
 <20200519230124.GA12509@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519230124.GA12509@danh.dev>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `diff.relative` boolean option set to `true` shows only changes in
the current directory/value specified by the `path` argument of the
`relative` option and shows pathnames relative to the aforementioned
directory.

Teach `--no-relative` to override earlier `--relative`

Add for git-format-patch(1) options documentation `--relative` and
`--no-relative`

Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
---
 Documentation/config/diff.txt  |  4 ++
 Documentation/diff-options.txt |  5 ++-
 diff.c                         | 11 +++--
 t/t4014-format-patch.sh        | 13 ++++++
 t/t4045-diff-relative.sh       | 82 ++++++++++++++++++++++++++++++++--
 5 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index ff09f1cf73..c3ae136eba 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -105,6 +105,10 @@ diff.mnemonicPrefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.

+diff.relative::
+	If set to 'true', 'git diff' does not show changes outside of the directory
+	and show pathnames relative to the current directory.
+
 diff.orderFile::
 	File indicating how to order files within a diff.
 	See the '-O' option to linkgit:git-diff[1] for details.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index bb31f0c42b..7987d72b02 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -643,15 +643,18 @@ ifndef::git-format-patch[]
 -R::
 	Swap two inputs; that is, show differences from index or
 	on-disk file to tree contents.
+endif::git-format-patch[]

 --relative[=<path>]::
+--no-relative::
 	When run from a subdirectory of the project, it can be
 	told to exclude changes outside the directory and show
 	pathnames relative to it with this option.  When you are
 	not in a subdirectory (e.g. in a bare repository), you
 	can name which subdirectory to make the output relative
 	to by giving a <path> as an argument.
-endif::git-format-patch[]
+	`--no-relative` can be used to countermand both `diff.relative` config
+	option and previous `--relative`.

 -a::
 --text::
diff --git a/diff.c b/diff.c
index d1ad6a3c4a..863da896c0 100644
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
@@ -4538,6 +4543,7 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 	options->interhunkcontext = diff_interhunk_context_default;
 	options->ws_error_highlight = ws_error_highlight_default;
 	options->flags.rename_empty = 1;
+	options->flags.relative_name = diff_relative;
 	options->objfind = NULL;

 	/* pathchange left =NULL by default */
@@ -5195,8 +5201,7 @@ static int diff_opt_relative(const struct option *opt,
 {
 	struct diff_options *options = opt->value;

-	BUG_ON_OPT_NEG(unset);
-	options->flags.relative_name = 1;
+	options->flags.relative_name = !unset;
 	if (arg)
 		options->prefix = arg;
 	return 0;
@@ -5492,7 +5497,7 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_GROUP(N_("Other diff options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
 			       N_("when run from subdir, exclude changes outside and show relative paths"),
-			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       PARSE_OPT_OPTARG,
 			       diff_opt_relative),
 		OPT_BOOL('a', "text", &options->flags.text,
 			 N_("treat all files as text")),
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index db7e733af9..575e079cc2 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1602,6 +1602,19 @@ test_expect_success 'format patch ignores color.ui' '
 	test_cmp expect actual
 '

+test_expect_success 'format patch respects diff.relative' '
+	rm -rf subdir &&
+	mkdir subdir &&
+	echo other content >subdir/file2 &&
+	git add subdir/file2 &&
+	git commit -F msg &&
+	test_unconfig diff.relative &&
+	git format-patch --relative=subdir --stdout -1 >expect &&
+	test_config diff.relative true &&
+	git -C subdir format-patch --stdout -1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cover letter with invalid --cover-from-description and config' '
 	test_config branch.rebuild-1.description "config subject

diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 258808708e..7be1de736d 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -8,7 +8,8 @@ test_expect_success 'setup' '
 	echo content >file1 &&
 	mkdir subdir &&
 	echo other content >subdir/file2 &&
-	blob=$(git hash-object subdir/file2) &&
+	blob_file1=$(git hash-object file1) &&
+	blob_file2=$(git hash-object subdir/file2) &&
 	git add . &&
 	git commit -m one
 '
@@ -18,7 +19,7 @@ check_diff () {
 	shift
 	expect=$1
 	shift
-	short_blob=$(git rev-parse --short $blob)
+	short_blob=$(git rev-parse --short $blob_file2)
 	cat >expected <<-EOF
 	diff --git a/$expect b/$expect
 	new file mode 100644
@@ -70,7 +71,7 @@ check_raw () {
 	expect=$1
 	shift
 	cat >expected <<-EOF
-	:000000 100644 $ZERO_OID $blob A	$expect
+	:000000 100644 $ZERO_OID $blob_file2 A	$expect
 	EOF
 	test_expect_success "--raw $*" "
 		git -C '$dir' diff --no-abbrev --raw $* HEAD^ >actual &&
@@ -86,4 +87,79 @@ do
 	check_$type . dir/file2 --relative=sub
 done

+check_diff_relative_option () {
+	dir=$1
+	shift
+	expect=$1
+	shift
+	relative_opt=$1
+	shift
+	test_expect_success "config diff.relative $relative_opt -p $*" "
+		short_blob=\$(git rev-parse --short $blob_file2) &&
+		cat >expected <<-EOF &&
+		diff --git a/$expect b/$expect
+		new file mode 100644
+		index 0000000..\$short_blob
+		--- /dev/null
+		+++ b/$expect
+		@@ -0,0 +1 @@
+		+other content
+		EOF
+		test_config -C $dir diff.relative $relative_opt &&
+		git -C '$dir' diff -p $* HEAD^ >actual &&
+		test_cmp expected actual
+	"
+}
+
+check_diff_no_relative_option () {
+	dir=$1
+	shift
+	expect=$1
+	shift
+	relative_opt=$1
+	shift
+	test_expect_success "config diff.relative $relative_opt -p $*" "
+		short_blob_file1=\$(git rev-parse --short $blob_file1) &&
+		short_blob_file2=\$(git rev-parse --short $blob_file2) &&
+		cat >expected <<-EOF &&
+		diff --git a/file1 b/file1
+		new file mode 100644
+		index 0000000..\$short_blob_file1
+		--- /dev/null
+		+++ b/file1
+		@@ -0,0 +1 @@
+		+content
+		diff --git a/$expect b/$expect
+		new file mode 100644
+		index 0000000..\$short_blob_file2
+		--- /dev/null
+		+++ b/$expect
+		@@ -0,0 +1 @@
+		+other content
+		EOF
+		test_config -C $dir diff.relative $relative_opt &&
+		git -C '$dir' diff -p $* HEAD^ >actual &&
+		test_cmp expected actual
+	"
+}
+
+check_diff_no_relative_option . subdir/file2 false
+check_diff_no_relative_option . subdir/file2 true --no-relative
+check_diff_no_relative_option . subdir/file2 false --no-relative
+check_diff_no_relative_option subdir subdir/file2 false
+check_diff_no_relative_option subdir subdir/file2 true --no-relative
+check_diff_no_relative_option subdir subdir/file2 false --no-relative
+
+check_diff_relative_option . file2 false --relative=subdir/
+check_diff_relative_option . file2 false --relative=subdir
+check_diff_relative_option . file2 true --relative=subdir/
+check_diff_relative_option . file2 true --relative=subdir
+check_diff_relative_option subdir file2 false --relative
+check_diff_relative_option subdir file2 true --relative
+check_diff_relative_option subdir file2 true
+check_diff_relative_option subdir file2 false --no-relative --relative
+check_diff_relative_option subdir file2 true --no-relative --relative
+check_diff_relative_option . file2 false --no-relative --relative=subdir
+check_diff_relative_option . file2 true --no-relative --relative=subdir
+
 test_done
--
2.26.2
