Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F60C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 22:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCFWe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 17:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFWe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 17:34:26 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBFE2D56
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 14:34:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so14665353pjg.4
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 14:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678142063;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o2sYsmgx8hojUdSl7Xf2bYMztr4jtTBZNmqIcwf9Ds=;
        b=QwVRkhbmOAhP8EfJPdx/Cx81kUJimlhtm+Jqnxp1Pjrbw2IrwiDZu1cY2Aa8goplXA
         mKOIqjwojQT7lNgiTj3nn8qEM9ElzxxXEf5Xwqm7M1yNTxN7zaVbv97bKXnVERa7YD8E
         IujE1xOIw9Xi1SCapnNQusHAd2xQa/bqAzC3jyG/iW9Y1MMzpbZbcoajjryTcthIqmHf
         T5wbYMFB0rjAIB2kUwcYCjEDv3RZBKa3946yzsO2/fHBtY5WGoPxgmCn9AiIFr/PklZD
         ZEL1D3nNn79+39bZ0N1kY2BL+YiBHhIoIJdUatDawNiVivexVuj5GX6G8QQPce1iR4TG
         iOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142063;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1o2sYsmgx8hojUdSl7Xf2bYMztr4jtTBZNmqIcwf9Ds=;
        b=E6jbFIusJhcvK1LBX5ueziXu9RHgRQFiY8O39VZ9dDPN6NwJAsiH0bzHjgWIPjQm9M
         Dg/nl+dZipAjNfR1DAXUvCLSA8ku07vZoEykeNlu2HH3Ce9jVh61HVaTLhxz3NhEWTZP
         sj79xHmgwvILEK8mPp/Zw8/pmwhpaH366gZFU9+jpR9uBCLygrhcqDyHYPC6RFW4i3h+
         VCzI5O9/5Oa880519b66BItOJ0yhcmhx72P+dIB5HUXqemaPewz1TE+065YF+9RcPU4z
         ElyUuFL3jxP4s+6x2XiL4qKyvwkmBpd64JvdxI/v02Ny7oWqyB005zSAoqow7dGw3vjd
         0nRg==
X-Gm-Message-State: AO0yUKXfTI9vEhKwB3r6sgVxg1+/YnpS/NIRq9S49AjqtTQ9nv5owzwK
        ygP/YYThNyc9CFGEMttKHQM=
X-Google-Smtp-Source: AK7set+MnRWPyFwGBKrRjJ8wgRsg3xQCixxx5rhRH0GuBI2IOSfctzW1sPgcyDnMLnvGSy9xA8csFQ==
X-Received: by 2002:a17:90a:4612:b0:23a:66:1d3a with SMTP id w18-20020a17090a461200b0023a00661d3amr13138028pjg.45.1678142062862;
        Mon, 06 Mar 2023 14:34:22 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a3b4f00b00233d6547000sm6218774pjf.54.2023.03.06.14.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 14:34:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org,
        Matthias =?utf-8?Q?G=C3=B6rgens?= <matthias.goergens@gmail.com>
Subject: Re: Bug in git archive + .gitattributes + relative path
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
        <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
        <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
        <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
        <xmqqcz5lbxiq.fsf@gitster.g>
        <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de>
        <xmqqo7p59049.fsf@gitster.g>
        <3da35216-ca42-9759-d4f9-20451a44c231@web.de>
Date:   Mon, 06 Mar 2023 14:34:21 -0800
In-Reply-To: <3da35216-ca42-9759-d4f9-20451a44c231@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 6 Mar 2023 22:32:06 +0100")
Message-ID: <xmqq4jqx8q6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Neither of them resolves "../$PWD/" parts to "" like git ls-tree does,
> but I can accept that difference.  And then we'd need to keep leading
> "../", I suppose.  Still unsure.

I offhand do not know how well it would mix with --strip-components
if we leave the leading "../".

But it certainly would be nice if we somehow:

 * can keep the current behaviour where "git -C sub archive" records
   paths relative to "sub" for backward compatibility.

 * fail loudly when "git -C sub archive <pathspec>" makes us use
   "../" prefix because <pathspec> goes above the $PWD for backward
   compatibility and sanity.

 * with --some-option, make "git -C sub archive --some-option :/"
   act exactly like "git archive :/".

> And I don't know why PATHSPEC_PREFER_CWD is necessary.
>
> So no sign-off, yet.
>
>
>  archive.c | 60 +++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 9aeaf2bd87..c7e9f58b02 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -139,6 +139,7 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
>  		void *context)
>  {
>  	static struct strbuf path = STRBUF_INIT;
> +	static struct strbuf scratch = STRBUF_INIT;
>  	struct archiver_context *c = context;
>  	struct archiver_args *args = c->args;
>  	write_archive_entry_fn_t write_entry = c->write_entry;
> @@ -148,6 +149,14 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
>  	void *buffer;
>  	enum object_type type;
>
> +	/*
> +	 * NEEDSWORK: variable names could be clearer:
> +	 * - args->prefix is the current working directory,
> +	 * - args->base with args->baselen is the --prefix value,
> +	 * - base with baselen is the path of the current tree,
> +	 * - args->base + base + filename is the path in the archive,
> +	 * - path_without_prefix is base + filename.
> +	 */
>  	args->convert = 0;
>  	strbuf_reset(&path);
>  	strbuf_grow(&path, PATH_MAX);
> @@ -166,6 +175,15 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
>  		args->convert = check_attr_export_subst(check);
>  	}
>
> +	if (args->prefix) {
> +		const char *rel = relative_path(path_without_prefix,
> +						args->prefix, &scratch);
> +		if (!strcmp(rel, "./"))
> +			return S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0;
> +		strbuf_setlen(&path, args->baselen);
> +		strbuf_addstr(&path, rel);
> +	}
> +
>  	if (args->verbose)
>  		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
>
> @@ -401,14 +419,15 @@ static int reject_entry(const struct object_id *oid UNUSED,
>  	return ret;
>  }
>
> -static int path_exists(struct archiver_args *args, const char *path)
> +static int path_exists(struct archiver_args *args, const char *prefix,
> +		       const char *path)
>  {
>  	const char *paths[] = { path, NULL };
>  	struct path_exists_context ctx;
>  	int ret;
>
>  	ctx.args = args;
> -	parse_pathspec(&ctx.pathspec, 0, 0, "", paths);
> +	parse_pathspec(&ctx.pathspec, 0, 0, prefix, paths);
>  	ctx.pathspec.recursive = 1;
>  	ret = read_tree(args->repo, args->tree,
>  			&ctx.pathspec,
> @@ -417,30 +436,35 @@ static int path_exists(struct archiver_args *args, const char *path)
>  	return ret != 0;
>  }
>
> -static void parse_pathspec_arg(const char **pathspec,
> +static void parse_pathspec_arg(const char **pathspec, const char *prefix,
>  		struct archiver_args *ar_args)
>  {
> +	const char *match_all[] = { ".", NULL };
> +
> +	if (prefix && !*pathspec)
> +		pathspec = match_all;
> +
>  	/*
>  	 * must be consistent with parse_pathspec in path_exists()
>  	 * Also if pathspec patterns are dependent, we're in big
>  	 * trouble as we test each one separately
>  	 */
>  	parse_pathspec(&ar_args->pathspec, 0,
> -		       PATHSPEC_PREFER_FULL,
> -		       "", pathspec);
> +		       PATHSPEC_PREFER_CWD,
> +		       prefix, pathspec);
>  	ar_args->pathspec.recursive = 1;
>  	if (pathspec) {
>  		while (*pathspec) {
> -			if (**pathspec && !path_exists(ar_args, *pathspec))
> +			if (**pathspec &&
> +			    !path_exists(ar_args, prefix, *pathspec))
>  				die(_("pathspec '%s' did not match any files"), *pathspec);
>  			pathspec++;
>  		}
>  	}
>  }
>
> -static void parse_treeish_arg(const char **argv,
> -		struct archiver_args *ar_args, const char *prefix,
> -		int remote)
> +static void parse_treeish_arg(const char **argv, struct archiver_args *ar_args,
> +			      int remote)
>  {
>  	const char *name = argv[0];
>  	const struct object_id *commit_oid;
> @@ -479,20 +503,6 @@ static void parse_treeish_arg(const char **argv,
>  	if (!tree)
>  		die(_("not a tree object: %s"), oid_to_hex(&oid));
>
> -	if (prefix) {
> -		struct object_id tree_oid;
> -		unsigned short mode;
> -		int err;
> -
> -		err = get_tree_entry(ar_args->repo,
> -				     &tree->object.oid,
> -				     prefix, &tree_oid,
> -				     &mode);
> -		if (err || !S_ISDIR(mode))
> -			die(_("current working directory is untracked"));
> -
> -		tree = parse_tree_indirect(&tree_oid);
> -	}
>  	ar_args->refname = ref;
>  	ar_args->tree = tree;
>  	ar_args->commit_oid = commit_oid;
> @@ -710,8 +720,8 @@ int write_archive(int argc, const char **argv, const char *prefix,
>  		setup_git_directory();
>  	}
>
> -	parse_treeish_arg(argv, &args, prefix, remote);
> -	parse_pathspec_arg(argv + 1, &args);
> +	parse_treeish_arg(argv, &args, remote);
> +	parse_pathspec_arg(argv + 1, prefix, &args);
>
>  	rc = ar->write_archive(ar, &args);
