Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F023C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482602166E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUA2BS3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbgIIRCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgIIPr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 11:47:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4CCC061237
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 07:51:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so3255355wrn.10
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=quj1E1TRUSsVeQ3iETItaLb9trwOItVDBfjEDlgx/38=;
        b=WUA2BS3kMWegShtAoMMtSetff7xbxZ+r1cuZhYgNSuHFW/zh4u5wZubIB1ffGS3EvT
         uRKUvgOARE5k4aMAuTQ+TOFNUtbp0VZ5FtZnHSrqMgs8i2oqQNE5Jd5AUJRyxxeXN+tY
         bYiDAtTlBZJa8kmL8hXZJlhxqTUEAm/OqC8k8xyp7xSb1nycMB0MHR1PNKObG7YweO6a
         6CTBiYtpNUiWjh+0T8I0vv0DyiL+Z/nwqoO8FdwQL8WAgV28zg2MFi2sR6U5POi64kx+
         SzUAilDZbqsQJhuSkZ8i7ANFLm+7022hsWM0ovvFL1Wd3Nq2mBIRGVeO9nYjjZgxwwF9
         gSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=quj1E1TRUSsVeQ3iETItaLb9trwOItVDBfjEDlgx/38=;
        b=EMnuZebYaxetwYMxOMkofiAMZBaioo1UiRvubI9R4lnxUrXDUhFfVZo6gDtI0dlrZc
         ysm6jdTNfUqc94NToTNJh/UjSoljySydrxaJgV7GbhiNKy2NgakTFw0pnDdhX3qmDta8
         neG8S/c5H81lKy/LVA5TGLYD0UdD098SrM9lABRTdSQK/7fuFXg0egUt6E4GU/naAS4w
         fCHTPLyGPO2WqaTJYtM4H6m/OmxxggXaY6DB/N+/4U3nS76SZObQogrKqE7D5FjyMFCI
         natUbIEuoT1AT7DYH8HLSELoIB2nvMaTrq6X1ZXySAKE+Q0K5p3Q31XMBki1BPwvqicM
         M9bw==
X-Gm-Message-State: AOAM530LSsG+qq7984p6TQLG1lCY5r2LtS+Cp3uU9Jz8BKI+MMBxgrbZ
        40ObwT5MaV1anDolevNCAdGuUy5P+tA=
X-Google-Smtp-Source: ABdhPJya6pdS48YBAnJhA+pJX3haqAS+QoO7zjtT71y6NjKRuPGEqtrlddamKzPl78h5Wa6hr7IrUw==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr4149491wrn.93.1599663078177;
        Wed, 09 Sep 2020 07:51:18 -0700 (PDT)
Received: from szeder.dev (94-21-23-168.pool.digikabel.hu. [94.21.23.168])
        by smtp.gmail.com with ESMTPSA id t4sm4410667wrr.26.2020.09.09.07.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:51:17 -0700 (PDT)
Date:   Wed, 9 Sep 2020 16:51:14 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-parse: add option for absolute or relative path
 formatting
Message-ID: <20200909145114.GE6209@szeder.dev>
References: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 08, 2020 at 06:50:17PM +0000, brian m. carlson wrote:
> git rev-parse has several options which print various paths.  Some of
> these paths are printed relative to the current working directory, and
> some are absolute.
> 
> Normally, this is not a problem, but there are times when one wants
> paths entirely in one format or another.  This can be done trivially if
> the paths are canonical, but canonicalizing paths is not possible on
> some shell scripting environments which lack realpath(1) and also in Go,
> which lacks functions that properly canonicalize paths on Windows.
> 
> To help out the scripter, let's provide an option which turns most of
> the paths printed by git rev-parse to be either relative to the current
> working directory or absolute and canonical.  Document which options are
> affected and which are not so that users are not confused.
> 
> This approach is cleaner and tidier than providing duplicates of
> existing options which are either relative or absolute.

Indeed.  I added '--absolute-git-dir' as a one-off, because I didn't
see a use case for other absolute paths, and because I saw some design
issues with a generic solution and I didn't want to go there back
then.  In particular:

> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 19b12b6d43..6b95292559 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -208,6 +208,15 @@ Options for Files
>  	Only the names of the variables are listed, not their value,
>  	even if they are set.
>  
> +--path-format=(absolute|relative)::
> +	Controls the behavior of certain other options following it on the command
> +	line.

Does it affect only one subsequent such option on the command line, or
all such options?  IOW, while standing in the top directory of the
worktree, would the following command

  git rev-parse --path-format=absolute --git-dir --git-path foo --show-toplevel

print three absolute paths, or one absolute paths and two relative
paths?

The wording here is not clear on this, the commit message doesn't
mention it, and the tests added in this patch only check one such
option, but looking at the code and doing some testing of my own I
found that it affects all subsequent such options.

>       If specified as absolute, the paths printed by those options will be
> +	absolute and canonical. If specified as relative, the paths will be relative
> +	to the current working directory if that is possible.  The default is option
> +	specific.
> +
> +The following options are modified by `--path-format`:
> +
>  --git-dir::
>  	Show `$GIT_DIR` if defined. Otherwise show the path to
>  	the .git directory. The path shown, when relative, is


> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 669dd2fd6f..311a56ba01 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -583,6 +583,55 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
>  	clear_ref_exclusion(&ref_excludes);
>  }
>  
> +enum format_type {
> +	/* We would like a relative path. */
> +	FORMAT_RELATIVE,
> +	/* We would like a canonical absolute path. */
> +	FORMAT_CANONICAL,
> +	/* We would like the default behavior. */
> +	FORMAT_DEFAULT,
> +};
> +
> +enum default_type {
> +	/* Our default is a relative path. */
> +	DEFAULT_RELATIVE,
> +	/* Our default is a relative path if there's a shared root. */
> +	DEFAULT_RELATIVE_IF_SHARED,
> +	/* Our default is a canonical absolute path. */
> +	DEFAULT_CANONICAL,
> +	/* Our default is not to modify the item. */
> +	DEFAULT_UNMODIFIED,
> +};
> +
> +static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
> +{
> +	char *cwd = NULL;
> +	/*
> +	 * We don't ever produce a relative path if prefix is NULL, so set the
> +	 * prefix to the current directory so that we can produce a relative
> +	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
> +	 * we want an absolute path unless the two share a common prefix, so don't
> +	 * set it in that case, since doing so causes a relative path to always
> +	 * be produced if possible.
> +	 */
> +	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
> +		prefix = cwd = xgetcwd();
> +	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
> +		puts(path);
> +	} else if (format == FORMAT_RELATIVE ||
> +		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE) ||
> +		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED)) {
> +		struct strbuf buf = STRBUF_INIT;
> +		puts(relative_path(path, prefix, &buf));
> +		strbuf_reset(&buf);
> +	} else {
> +		char *real = real_pathdup(path, 1);
> +		puts(real);
> +		free(real);
> +	}
> +	free(cwd);
> +}
> +
>  int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  {
>  	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
> @@ -595,6 +644,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  	struct object_context unused;
>  	struct strbuf buf = STRBUF_INIT;
>  	const int hexsz = the_hash_algo->hexsz;
> +	enum format_type format = FORMAT_DEFAULT;
>  
>  	if (argc > 1 && !strcmp("--parseopt", argv[1]))
>  		return cmd_parseopt(argc - 1, argv + 1, prefix);
> @@ -650,8 +700,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  			if (!argv[i + 1])
>  				die("--git-path requires an argument");
>  			strbuf_reset(&buf);
> -			puts(relative_path(git_path("%s", argv[i + 1]),
> -					   prefix, &buf));
> +			print_path(git_path("%s", argv[i + 1]), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
>  			i++;
>  			continue;
>  		}
> @@ -683,6 +732,16 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  					show_file(arg, 0);
>  				continue;
>  			}
> +			if (opt_with_value(arg, "--path-format", &arg)) {
> +				if (!strcmp(arg, "absolute")) {
> +					format = FORMAT_CANONICAL;
> +				} else if (!strcmp(arg, "relative")) {
> +					format = FORMAT_RELATIVE;
> +				} else {
> +					die("unknown argument to --path-format: %s", arg);
> +				}
> +				continue;
> +			}
>  			if (!strcmp(arg, "--default")) {
>  				def = argv[++i];
>  				if (!def)
> @@ -803,7 +862,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  			if (!strcmp(arg, "--show-toplevel")) {
>  				const char *work_tree = get_git_work_tree();
>  				if (work_tree)
> -					puts(work_tree);
> +					print_path(work_tree, prefix, format, DEFAULT_CANONICAL);
>  				else
>  					die("this operation must be run in a work tree");
>  				continue;
> @@ -811,7 +870,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  			if (!strcmp(arg, "--show-superproject-working-tree")) {
>  				struct strbuf superproject = STRBUF_INIT;
>  				if (get_superproject_working_tree(&superproject))
> -					puts(superproject.buf);
> +					print_path(superproject.buf, prefix, format, DEFAULT_CANONICAL);
>  				strbuf_release(&superproject);
>  				continue;
>  			}
> @@ -846,16 +905,18 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
>  				char *cwd;
>  				int len;
> +				enum format_type wanted = format;
>  				if (arg[2] == 'g') {	/* --git-dir */
>  					if (gitdir) {
> -						puts(gitdir);
> +						print_path(gitdir, prefix, format, DEFAULT_UNMODIFIED);
>  						continue;
>  					}
>  					if (!prefix) {
> -						puts(".git");
> +						print_path(".git", prefix, format, DEFAULT_UNMODIFIED);
>  						continue;
>  					}
>  				} else {		/* --absolute-git-dir */
> +					wanted = FORMAT_CANONICAL;
>  					if (!gitdir && !prefix)
>  						gitdir = ".git";
>  					if (gitdir) {
> @@ -868,14 +929,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				}
>  				cwd = xgetcwd();
>  				len = strlen(cwd);
> -				printf("%s%s.git\n", cwd, len && cwd[len-1] != '/' ? "/" : "");
> +				strbuf_reset(&buf);
> +				strbuf_addf(&buf, "%s%s.git", cwd, len && cwd[len-1] != '/' ? "/" : "");
>  				free(cwd);
> +				print_path(buf.buf, prefix, wanted, DEFAULT_CANONICAL);
>  				continue;
>  			}
>  			if (!strcmp(arg, "--git-common-dir")) {
> -				strbuf_reset(&buf);
> -				puts(relative_path(get_git_common_dir(),
> -						   prefix, &buf));
> +				print_path(get_git_common_dir(), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
>  				continue;
>  			}
>  			if (!strcmp(arg, "--is-inside-git-dir")) {
> @@ -905,8 +966,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				if (the_index.split_index) {
>  					const struct object_id *oid = &the_index.split_index->base_oid;
>  					const char *path = git_path("sharedindex.%s", oid_to_hex(oid));
> -					strbuf_reset(&buf);
> -					puts(relative_path(path, prefix, &buf));
> +					print_path(path, prefix, format, DEFAULT_RELATIVE);
>  				}
>  				continue;
>  			}
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 408b97d5af..6f3811d189 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -3,6 +3,16 @@
>  test_description='test git rev-parse'
>  . ./test-lib.sh
>  
> +test_one () {
> +	dir="$1" &&
> +	expect="$2" &&
> +	shift &&
> +	shift &&
> +	echo "$expect" >expect &&
> +	git -C "$dir" rev-parse "$@" >actual

Broken && chain.

> +	test_cmp expect actual
> +}
> +
>  # usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir absolute-git-dir
>  test_rev_parse () {
>  	d=
> @@ -60,7 +70,13 @@ ROOT=$(pwd)
>  
>  test_expect_success 'setup' '
>  	mkdir -p sub/dir work &&
> -	cp -R .git repo.git
> +	cp -R .git repo.git &&
> +	git checkout -b main &&
> +	test_commit abc &&
> +	git checkout -b side &&
> +	test_commit def &&
> +	git checkout main &&
> +	git worktree add worktree side
>  '
>  
>  test_rev_parse toplevel false false true '' .git "$ROOT/.git"
> @@ -88,6 +104,24 @@ test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=../repo.git, core.bare = tru
>  
>  test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
>  
> +test_expect_success 'rev-parse --path-format=absolute' '
> +	test_one "." "$ROOT/.git" --path-format=absolute --git-dir &&
> +	test_one "." "$ROOT/.git" --path-format=absolute --git-common-dir &&
> +	test_one "worktree" "$ROOT/.git/worktrees/worktree" --path-format=absolute --git-dir &&
> +	test_one "worktree" "$ROOT/.git" --path-format=absolute --git-common-dir &&
> +	test_one "." "$ROOT" --path-format=absolute --show-toplevel &&
> +	test_one "." "$ROOT/.git/objects" --path-format=absolute --git-path objects
> +'
> +
> +test_expect_success 'rev-parse --path-format=relative' '
> +	test_one "." ".git" --path-format=relative --git-dir &&
> +	test_one "." ".git" --path-format=relative --git-common-dir &&
> +	test_one "worktree" "../.git/worktrees/worktree" --path-format=relative --git-dir &&
> +	test_one "worktree" "../.git" --path-format=relative --git-common-dir &&
> +	test_one "." "./" --path-format=relative --show-toplevel &&
> +	test_one "." ".git/objects" --path-format=relative --git-path objects
> +'

I would like to see a test that demonstrates that '--absolute-git-dir'
is unaffected by '--path-format=relative', just to be sure.

There are some cases where this new option doesn't do what I would
expect:

  $ ./git -C Documentation/ rev-parse --git-dir --show-toplevel
  /home/szeder/src/git/.git
  /home/szeder/src/git
  $ ./git -C Documentation/ rev-parse --path-format=absolute --git-dir --show-toplevel
  /home/szeder/src/git/.git
  /home/szeder/src/git
  # So far so good, but:
  $ ./git -C Documentation/ rev-parse --path-format=relative --git-dir --show-toplevel
  /home/szeder/src/git/.git
  /home/szeder/src/git


  $ ls -l .git/foo
  ls: cannot access '.git/foo': No such file or directory
  $ ./git rev-parse --git-path foo
  .git/foo
  $ ./git rev-parse --path-format=relative --git-path foo
  .git/foo
  $ ./git rev-parse --path-format=absolute --git-path foo
  /home/szeder/src/git/.git/foo
  $ ./git rev-parse --git-path foo/bar
  .git/foo/bar
  $ ./git rev-parse --path-format=relative --git-path foo/bar
  .git/foo/bar
  # So far so good, but:
  $ ./git rev-parse --path-format=absolute --git-path foo/bar
  fatal: Invalid path '/home/szeder/src/git/.git/foo': No such file or directory

