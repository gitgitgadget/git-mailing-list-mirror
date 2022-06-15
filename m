Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6914BC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 20:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbiFOUPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 16:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244127AbiFOUPN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 16:15:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB4C4B86D
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:15:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x5so17803503edi.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zT+0UhVZ19skw5c9ZV9ViZPCRnMxQzPNIakWL/ECr30=;
        b=TtPi+1k8bSwvzTWzmjyJdsz2Lyu73+UADfJGcnQ33D5WtCFmrNLmIaoviv1Kl8pJuO
         /CrLk74l3XD1et6bwM/0LoaTiROKJpmeKPbcbsFC4oHJth6CJSsU9gswuxg3AFwPwCSa
         jX3NkzoMJe3lHlJCULtKNs+/b1jxjs5RWh8TrIhNSQ7qUtARwAsdAGXxGFJQOElHW0a7
         qPP/E2BE6nsX4x1jbMD9FQ4X4JC4+tT+ASlEivlcgyDCEhSfaq44tuuF0SJsJ0oqI0it
         lcyMuC8YnhKGSYb/yDKebvz1MKmszCw4qgImT+FfDfZ/8Cdv9AurNh/nRmWGnJCq6TGM
         Q+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zT+0UhVZ19skw5c9ZV9ViZPCRnMxQzPNIakWL/ECr30=;
        b=1btLRlITZxFacBHWtfaSt5l8IsRHRLzKlQIkPJfnpnyRXcYmvLSSxEiMRweZF2/Fts
         vERJscx88wcCGa+2BSuyfXlMlPTxuo/fEwaAFAtjqcTotS5FmeVQEfTjpYdejXhzUHTs
         rp1GZdv/GQuju/+nHYK6vis5plopZQQvBT9q6FRgm39G+4F6fJyLNoW2PMSOjcMSTUxO
         ZFAjbj9sOMer5UlZUZQF9HYXnv48rPc0ACxmDxlefC9kZ48nh0UzwUDKJdy4N89kUU0P
         ei5PY5cd2qS1H6JpW5eILKPG4hFDTCNKko6x7ytkD3BiT27+ZruM6a1byvlLdAZPmZhl
         T0jQ==
X-Gm-Message-State: AJIora9nGMONFkeqqDydxLjLrXfOtwgQYsCg/leLlY7y0aPcK+GxJOza
        yDLqr5L4IdiiJKhEP15exAlu5Lk63rECgw==
X-Google-Smtp-Source: AGRyM1s4MIPdC5+OZ5jP1JYKvwLnIvkrz/cmzzR1a9jCUpUfMy69EhVYsxOWogWrGJkhR9G9E9gU2Q==
X-Received: by 2002:aa7:c857:0:b0:433:5c62:ddbc with SMTP id g23-20020aa7c857000000b004335c62ddbcmr1911733edt.218.1655324109551;
        Wed, 15 Jun 2022 13:15:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7c40e000000b0042dd85bd23bsm92841edq.55.2022.06.15.13.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:15:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1ZPw-000tCM-6d;
        Wed, 15 Jun 2022 22:15:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 1/2] ls-files: introduce "--format" option
Date:   Wed, 15 Jun 2022 22:07:17 +0200
References: <pull.1262.git.1655300752.gitgitgadget@gmail.com>
 <432d80b8c78355e5f70081c05e9a042a9ffcd033.1655300752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <432d80b8c78355e5f70081c05e9a042a9ffcd033.1655300752.git.gitgitgadget@gmail.com>
Message-ID: <220615.86a6ady983.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 15 2022, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>

Thanks a lot for pursuing this, this looks good & is much smaller than I
thought, just some nits below:

> Add a new option --format that output index enties
> informations with custom format, taking inspiration
> from the option with the same name in the `git ls-tree`
> command.
>
> --format cannot used with -s, -o, -k, --resolve-undo,
> --deduplicate, --debug.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-ls-files.txt |  51 +++++++++++-
>  builtin/ls-files.c             | 126 ++++++++++++++++++++++++++++-
>  t/t3013-ls-files-format.sh     | 142 +++++++++++++++++++++++++++++++++
>  3 files changed, 315 insertions(+), 4 deletions(-)
>  create mode 100755 t/t3013-ls-files-format.sh
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 0dabf3f0ddc..b22860ec8c0 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -20,7 +20,7 @@ SYNOPSIS
>  		[--exclude-standard]
>  		[--error-unmatch] [--with-tree=<tree-ish>]
>  		[--full-name] [--recurse-submodules]
> -		[--abbrev[=<n>]] [--] [<file>...]
> +		[--abbrev[=<n>]] [--format=<format>] [--] [<file>...]
>  
>  DESCRIPTION
>  -----------
> @@ -192,6 +192,13 @@ followed by the  ("attr/<eolattr>").
>  	to the contained files. Sparse directories will be shown with a
>  	trailing slash, such as "x/" for a sparse directory "x".
>  
> +--format=<format>::
> +	A string that interpolates %(fieldname) from the result being shown.

Missing `` for %(fieldname) ?
> +	It also interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
> +	interpolates to character with hex code `xx`; for example `%00`
> +	interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
> +	--format cannot be combined with `-s`, `-o`, `-k`, `--resolve-undo`,

Replace that last "," with " or ".

> +	`--debug`.
>  \--::
>  	Do not interpret any more arguments as options.
>  
> @@ -223,6 +230,48 @@ quoted as explained for the configuration variable `core.quotePath`
>  (see linkgit:git-config[1]).  Using `-z` the filename is output
>  verbatim and the line is terminated by a NUL byte.
>  
> +It is possible to print in a custom format by using the `--format`
> +option, which is able to interpolate different fields using
> +a `%(fieldname)` notation. For example, if you only care about the
> +"objectname" and "path" fields, you can execute with a specific
> +"--format" like
> +
> +	git ls-files --format='%(objectname) %(path)'
> +
> +FIELD NAMES
> +-----------
> +Various values from structured fields can be used to interpolate
> +into the resulting output. For each outputting line, the following
> +names can be used:
> +
> +tag::
> +	The tag of file status.
> +objectmode::
> +	The mode of the object.
> +objectname::
> +	The name of the object.
> +stage::
> +	The stage of the file.
> +eol::
> +	The line endings of files.
> +path::
> +	The pathname of the object.
> +ctime::
> +	The create time of file.
> +mtime::
> +	The modify time of file.
> +dev::
> +	The ID of device containing file.
> +ino::
> +	The inode number of file.
> +uid::
> +	The user id of file owner.
> +gid::
> +	The group id of file owner.
> +size::
> +	The size of the file.
> +flags::
> +	The flags of the file.
>  
>  EXCLUDE PATTERNS
>  ----------------
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index e791b65e7e9..9dd6c55eeb9 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -11,6 +11,7 @@
>  #include "quote.h"
>  #include "dir.h"
>  #include "builtin.h"
> +#include "strbuf.h"
>  #include "tree.h"
>  #include "cache-tree.h"
>  #include "parse-options.h"
> @@ -48,6 +49,7 @@ static char *ps_matched;
>  static const char *with_tree;
>  static int exc_given;
>  static int exclude_args;
> +static const char *format;
>  
>  static const char *tag_cached = "";
>  static const char *tag_unmerged = "";
> @@ -58,8 +60,8 @@ static const char *tag_modified = "";
>  static const char *tag_skip_worktree = "";
>  static const char *tag_resolve_undo = "";
>  
> -static void write_eolinfo(struct index_state *istate,
> -			  const struct cache_entry *ce, const char *path)
> +static void write_eolinfo_internal(struct strbuf *sb, struct index_state *istate,
> +				   const struct cache_entry *ce, const char *path)
>  {
>  	if (show_eol) {
>  		struct stat st;
> @@ -71,10 +73,25 @@ static void write_eolinfo(struct index_state *istate,
>  							       ce->name);
>  		if (!lstat(path, &st) && S_ISREG(st.st_mode))
>  			w_txt = get_wt_convert_stats_ascii(path);
> -		printf("i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
> +		if (sb)
> +			strbuf_addf(sb, "i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
> +		else
> +			printf("i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
>  	}
>  }
>  
> +static void write_eolinfo(struct index_state *istate,
> +			  const struct cache_entry *ce, const char *path)
> +{
> +	write_eolinfo_internal(NULL, istate, ce, path);
> +}
> +
> +static void write_eolinfo_to_buf(struct strbuf *sb, struct index_state *istate,
> +				 const struct cache_entry *ce, const char *path)
> +{
> +	write_eolinfo_internal(sb, istate, ce, path);
> +}
> +
>  static void write_name(const char *name)
>  {
>  	/*
> @@ -85,6 +102,16 @@ static void write_name(const char *name)
>  				   stdout, line_terminator);
>  }
>  
> +static void write_name_to_buf(struct strbuf *sb, const char *name)
> +{
> +	name = relative_path(name, prefix_len ? prefix : NULL, sb);
FWIW I'd find this a bit less "huh?" if we declared another variable
here, so just:

	const char *rel = relative_path(name, ...).

> +	if (line_terminator) {
> +		quote_c_style(name, sb, NULL, 0);
> +	} else {
> +		strbuf_add(sb, name, strlen(name));
> +	}

Can drop the {} braces here for if/else, see CodingGuidelines.

> +}
> +
>  static const char *get_tag(const struct cache_entry *ce, const char *tag)
>  {
>  	static char alttag[4];
> @@ -222,6 +249,86 @@ static void show_submodule(struct repository *superproject,
>  	repo_clear(&subrepo);
>  }
>  
> +struct show_index_data {
> +	const char *tag;
> +	const char *pathname;
> +	struct index_state *istate;
> +	const struct cache_entry *ce;
> +};
> +
> +static size_t expand_show_index(struct strbuf *sb, const char *start,
> +			       void *context)
> +{
> +	struct show_index_data *data = context;
> +	const char *end;
> +	const char *p;
> +	unsigned int errlen;
> +	const struct stat_data *sd = &data->ce->ce_stat_data;
> +	size_t len = strbuf_expand_literal_cb(sb, start, NULL);
> +	if (len)
> +		return len;
> +	if (*start != '(')
> +		die(_("bad ls-files format: element '%s' does not start with '('"), start);
> +
> +	end = strchr(start + 1, ')');
> +	if (!end)
> +		die(_("bad ls-files format: element '%s' does not end in ')'"), start);
> +
> +	len = end - start + 1;
> +	if (skip_prefix(start, "(tag)", &p)) {

Style nit, I'd much rather see us drop the {} on the whole if/else if
chain here, which we can do if...

> +		strbuf_addstr(sb, get_tag(data->ce, data->tag));
> +	} else if (skip_prefix(start, "(objectmode)", &p)) {
> +		strbuf_addf(sb, "%06o", data->ce->ce_mode);
> +	} else if (skip_prefix(start, "(objectname)", &p)) {
> +		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
> +	} else if (skip_prefix(start, "(stage)", &p)) {
> +		strbuf_addf(sb, "%d", ce_stage(data->ce));
> +	} else if (skip_prefix(start, "(eol)", &p)) {
> +		write_eolinfo_to_buf(sb, data->istate, data->ce, data->pathname);
> +	} else if (skip_prefix(start, "(path)", &p)) {
> +		write_name_to_buf(sb, data->pathname);
> +	} else if (skip_prefix(start, "(ctime)", &p)) {
> +		strbuf_addf(sb, "ctime: %u:%u", sd->sd_ctime.sec, sd->sd_ctime.nsec);
> +	} else if (skip_prefix(start, "(mtime)", &p)) {
> +		strbuf_addf(sb, "mtime: %u:%u", sd->sd_mtime.sec, sd->sd_mtime.nsec);

(too long lines, keep within 79 chars?)

> +	} else if (skip_prefix(start, "(dev)", &p)) {
> +		strbuf_addf(sb, "dev: %u", sd->sd_dev);
> +	} else if (skip_prefix(start, "(ino)", &p)) {
> +		strbuf_addf(sb, "ino: %u", sd->sd_ino);
> +	} else if (skip_prefix(start, "(uid)", &p)) {
> +		strbuf_addf(sb, "uid: %u", sd->sd_uid);
> +	} else if (skip_prefix(start, "(gid)", &p)) {
> +		strbuf_addf(sb, "gid: %u", sd->sd_gid);
> +	} else if (skip_prefix(start, "(size)", &p)) {
> +		strbuf_addf(sb, "size: %u", sd->sd_size);
> +	} else if (skip_prefix(start, "(flags)", &p)) {
> +		strbuf_addf(sb, "flags: %x", data->ce->ce_flags);
> +	} else {
> +		errlen = (unsigned long)len;
> +		die(_("bad ls-files format: %%%.*s"), errlen, start);

We just line-wrap the "(unsigned long)len" here, which seems worth it
for less line noise :)

> +	}
> +
> +	return len;
> +}
> +
> +static void show_ce_fmt(struct repository *repo, const struct cache_entry *ce,
> +			const char *format, const char *fullname, const char *tag) {
> +
> +	struct show_index_data data = {
> +		.tag = tag,
> +		.pathname = fullname,
> +		.istate = repo->index,
> +		.ce = ce,
> +	};
> +
> +	struct strbuf sb = STRBUF_INIT;
> +	strbuf_expand(&sb, format, expand_show_index, &data);
> +	strbuf_addch(&sb, line_terminator);
> +	fwrite(sb.buf, sb.len, 1, stdout);
> +	strbuf_release(&sb);
> +	return;
> +}
> +
>  static void show_ce(struct repository *repo, struct dir_struct *dir,
>  		    const struct cache_entry *ce, const char *fullname,
>  		    const char *tag)
> @@ -236,6 +343,11 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
>  				  max_prefix_len, ps_matched,
>  				  S_ISDIR(ce->ce_mode) ||
>  				  S_ISGITLINK(ce->ce_mode))) {
> +		if (format) {
> +			show_ce_fmt(repo, ce, format, fullname, tag);
> +			return;
> +		}
> +
>  		tag = get_tag(ce, tag);
>  
>  		if (!show_stage) {
> @@ -675,6 +787,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  			 N_("suppress duplicate entries")),
>  		OPT_BOOL(0, "sparse", &show_sparse_dirs,
>  			 N_("show sparse directories in the presence of a sparse index")),
> +		OPT_STRING_F(0, "format", &format, N_("format"),
> +					 N_("format to use for the output"),
> +					 PARSE_OPT_NONEG),

Odd indentation?

>  		OPT_END()
>  	};
>  	int ret = 0;
> @@ -699,6 +814,11 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  	for (i = 0; i < exclude_list.nr; i++) {
>  		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
>  	}
> +
> +	if (format && (show_stage || show_others || show_killed ||
> +		show_resolve_undo || skipping_duplicates || debug_mode))
> +			die(_("ls-files --format cannot used with -s, -o, -k, --resolve-undo, --deduplicate, --debug"));

Good to check this.

> +
>  	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
>  		tag_cached = "H ";
>  		tag_unmerged = "M ";
> diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
> new file mode 100755
> index 00000000000..61a2e68713a
> --- /dev/null
> +++ b/t/t3013-ls-files-format.sh
> @@ -0,0 +1,142 @@
> +#!/bin/sh
> +
> +test_description='git ls-files --format test'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	echo o1 >o1 &&
> +	echo o2 >o2 &&
> +	git add o1 o2 &&
> +	git add --chmod +x o1 &&
> +	git commit -m base
> +'
> +
> +test_expect_success 'git ls-files --format tag' '
> +	printf "H \nH \n" >expect &&
> +	git ls-files --format="%(tag)" -t >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format objectmode' '
> +	cat >expect <<-EOF &&
> +	100755
> +	100644
> +	EOF
> +	git ls-files --format="%(objectmode)" -t >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format objectname' '
> +	oid1=$(git hash-object o1) &&
> +	oid2=$(git hash-object o2) &&
> +	cat >expect <<-EOF &&
> +	$oid1
> +	$oid2
> +	EOF
> +	git ls-files --format="%(objectname)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format eol' '
> +	printf "i/lf    w/lf    attr/                 \t\n" >expect &&
> +	printf "i/lf    w/lf    attr/                 \t\n" >>expect &&
> +	git ls-files --format="%(eol)" --eol >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format path' '
> +	cat >expect <<-EOF &&
> +	o1
> +	o2
> +	EOF
> +	git ls-files --format="%(path)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format ctime' '
> +	git ls-files --debug | grep ctime >expect &&

For this and the rest: don't put git on the left-hand-side of a "|", it
hides its exit code (and potential segfaults)>.

Instead e.g.:

    git ... >out &&
    grep ctime out >expect &&
    ...

> +	git ls-files --format="  %(ctime)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format mtime' '
> +	git ls-files --debug | grep mtime >expect &&

ditto here & below.

> +	git ls-files --format="  %(mtime)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format dev and ino' '
> +	git ls-files --debug | grep dev >expect &&
> +	git ls-files --format="  %(dev)%x09%(ino)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format uid and gid' '
> +	git ls-files --debug | grep uid >expect &&
> +	git ls-files --format="  %(uid)%x09%(gid)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format with -m' '
> +	echo change >o1 &&
> +	cat >expect <<-EOF &&

When not using varibales use <<-\EOF, applies for the rest.

> +	o1
> +	EOF
> +	git ls-files --format="%(path)" -m >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format with -d' '
> +	rm o1 &&

Don't "rm o1" here, rather have the test that creates it do:

    test_when_finished "rm o1" &&
    [the command that creates o1]

> +	test_when_finished "git restore o1" &&
> +	cat >expect <<-EOF &&
> +	o1
> +	EOF
> +	git ls-files --format="%(path)" -d >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format size and flags' '
> +	git ls-files --debug | grep size >expect &&
> +	git ls-files --format="  %(size)%x09%(flags)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format imitate --stage' '
> +	git ls-files --stage >expect &&
> +	git ls-files --format="%(objectmode) %(objectname) %(stage)%x09%(path)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format imitate --debug' '
> +	git ls-files --debug >expect &&
> +	git ls-files --format="%(path)%x0a  %(ctime)%x0a  %(mtime)%x0a  %(dev)%x09%(ino)%x0a  %(uid)%x09%(gid)%x0a  %(size)%x09%(flags)" >actual &&
> +	test_cmp expect actual
> +'

These tests...:

> +test_expect_success 'git ls-files --format with -s must fail' '
> +	test_must_fail git ls-files --format="%(objectname)" -s
> +'
> +
> +test_expect_success 'git ls-files --format with -o must fail' '
> +	test_must_fail git ls-files --format="%(objectname)" -o
> +'
> +
> +test_expect_success 'git ls-files --format with -k must fail' '
> +	test_must_fail git ls-files --format="%(objectname)" -k
> +'
> +
> +test_expect_success 'git ls-files --format with --resolve-undo must fail' '
> +	test_must_fail git ls-files --format="%(objectname)" --resolve-undo
> +'
> +
> +test_expect_success 'git ls-files --format with --deduplicate must fail' '
> +	test_must_fail git ls-files --format="%(objectname)" --deduplicate
> +'
> +
> +test_expect_success 'git ls-files --format with --debug must fail' '
> +	test_must_fail git ls-files --format="%(objectname)" --debug
> +'

...would be better done with a for-loop, so:

	for flag in -s -o -k --resolve-undo [...]
	do
		test_expect_success "git ls-files --format is incompatible with $flag" '
			test_must_fail git ls-files --format="%(objectname)" $flag
		'
	done

Note the '' on the second argument, that's intentional, as we eval it
you don't need "".

> +test_done

