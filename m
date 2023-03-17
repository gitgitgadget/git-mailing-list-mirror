Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058FBC6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 14:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjCQOLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 10:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCQOLv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 10:11:51 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA955FA7A
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 07:11:48 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id nf5so3503046qvb.5
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679062307; x=1681654307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luaaBMulOHpyEXewt2/SQgYaoppOxpQrR1fl4k4m2ww=;
        b=OTF6vksLFKffTjfmplULPZ9Yj4F5TT040YdFRw6WyYcXf8S4b0r7kzocEgF3W9hS5R
         /4tmAsWea7fpwTqKFnDgsO1nexV2IQVWlpmIQw1g0zMr3T+mopl3prIFARIDA2sSfu//
         Y9mnHy+3Zkh13ggkr4Ln1AnkGEVuRSfhYUNfdXNwHxgYwiDZsCcEiHf6czOCNjLiwxyd
         MBx16qzysS8zSSJSrtLWXl4c3FGlQbx9uQmw7qCpakA2AH7XVWQYPdAXTkZfMUM5CAR7
         7Zit/gb4PjRXIkRbr/Az3b3YwL7UtSJD5TQVVm+NuFhpkf6FbHs9YSLshrVeaPBU046/
         z5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679062307; x=1681654307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luaaBMulOHpyEXewt2/SQgYaoppOxpQrR1fl4k4m2ww=;
        b=mwJ/ZjqZs6qwE107oNEwSfgnSsVaMmjMz0+B2xbDXAF6bJdBEmckDDOf2eCxxkz+K5
         l20EVmQi6px4SNEHl5FFyZPNvA65ocDXgTgUijCfm6EbOwSUpIPlr7By5fgzjlFCNWQh
         +xWZzueHnaas6DAjs15wWLFphNWpL/sFcX9zJ/TGfyjtccXH0iE3Ty6j5sFQGF1+aO3B
         qM5BcIK5SbJ4lvMNzwKguov5KDvGPksx5AbOmRdzya7jLukR49en3IUgUDqi/zG65nKZ
         iiEi259F0h9BU3BfFqfTX2EMPajO4SbTBSESxvSP9TU7RWpc7XSCmGDsRcqWmnMsrVEB
         pOuw==
X-Gm-Message-State: AO0yUKWKTRb+EY0Ooc7Osjpx8kfbfswxoAySUvxGDPoYOa+HGa8Ledh2
        W1gcG1G6tGke8LrM4zsx0Jk=
X-Google-Smtp-Source: AK7set+LZeCQJVR14iM8Cf1l2MCYzcfhEgOmzmzgjRsoPmeLO6/WjGC2nae3ywkx8Q+enuC5HnVYLQ==
X-Received: by 2002:a05:6214:762:b0:5ad:cd4b:3765 with SMTP id f2-20020a056214076200b005adcd4b3765mr11081938qvz.1.1679062307095;
        Fri, 17 Mar 2023 07:11:47 -0700 (PDT)
Received: from [192.168.1.211] ([2600:4041:454d:2100:c108:fc00:b8e8:83df])
        by smtp.gmail.com with ESMTPSA id a3-20020ae9e803000000b007425dade624sm1736163qkg.41.2023.03.17.07.11.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2023 07:11:46 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: use HEAD for attributes when using bare repository
Date:   Fri, 17 Mar 2023 10:11:46 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <BE20C11F-135C-4A5B-9148-A88C3B2A6DF5@gmail.com>
In-Reply-To: <xmqqcz58i9ud.fsf@gitster.g>
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
 <0fc704cf1c0724473a61086098d44c3a82938b03.1678758818.git.gitgitgadget@gmail.com>
 <xmqqttynqnnj.fsf@gitster.g> <xmqqa60fqld6.fsf@gitster.g>
 <20230314193839.wevenngf324pijhb@pop-os> <xmqqy1nzoyqr.fsf@gitster.g>
 <9E479AA2-2D54-4CAF-899B-B25894B746AA@gmail.com> <xmqqcz58i9ud.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 16 Mar 2023, at 18:56, Junio C Hamano wrote:

> John Cai <johncai86@gmail.com> writes:
>
>> Ah I see--in that case, what would be a good object to put this state =
into? Mabe
>> repo_settings?
>
> I personally think a global is good enough for a case like this.  It
> is not like the code in the attribute subsystem is structured to
> work in multiple repositories at the same time in the first place, so
> in repo_settings, the_repository, or elsewhere is just as good as
> having it in a plain old file-scope static, and even after moving it
> into the_repository or something, the access will initially be done
> by referring to the_repository global (which may not even exist by
> the time "git --attr-source=3D<tree>" gets parsed), and not by plumbing=

> a "struct repository *" parameter through the callchain.

Makes sense.

>
> Another thing to note is that there needs a mechanism to convey the
> tree object used to read the attributes from down to subprocesses,
> e.g. exporting the GIT_ATTR_SOURCE environment variable and make Git
> behave as if it saw the "git --attr-source=3D<tree>" option when such
> an environment variable exists, or something.  Otherwise, the custom
> attribute source would only take effect inside built-in commands.
>
> In any case, here is what I have now, stealing some tests from your
> patch.  I do not think I'll be working on it further at least for
> now, so feel free to run with it.  I am not adding the "in a bare
> repository, always read from HEAD unless told otherwise", as I do
> not see a good way to countermand it from a command line.

Thanks for the patch! Looks like you took it most of the way. I'll take a=
 look
and make some additions if necessary.

thanks
John

>
> ----- >8 ----- cut here ----- >8 ----- cut here ----- >8 -----
> Subject: [PATCH] attr: teach "--attr-source=3D<tree>" global option to =
"git"
>
> Earlier, 47cfc9bd (attr: add flag `--source` to work with tree-ish,
> 2023-01-14) taught "git check-attr" the "--source=3D<tree>" option to
> allow it to read attribute files from a tree-ish, but did so only
> for the command.  Just like "check-attr" users wanted a way to use
> attributes from a tree-ish and not from the working tree files,
> users of other commands (like "git diff") would benefit from the
> same.
>
> Undo most of the UI change the commit made, while keeping the
> internal logic to read attributes from a given tree-ish.  Expose the
> internal logic via a new "--attr-source=3D<tree>" command line option
> given to "git", so that it can be used with any git command that
> runs internally.
>
> The tests were stolen and adjusted from John Cai's effort where only
> "git diff" learned the "--attr-source" option to read from a
> tree-ish.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  archive.c                 |  2 +-
>  attr.c                    | 34 ++++++++++++++++++++++++++++++++--
>  attr.h                    | 13 +++++++++----
>  builtin/check-attr.c      | 17 ++++++++---------
>  builtin/pack-objects.c    |  2 +-
>  convert.c                 |  2 +-
>  git.c                     |  3 +++
>  ll-merge.c                |  4 ++--
>  pathspec.c                |  2 +-
>  t/lib-diff-alternative.sh | 31 ++++++++++++++++++++++++++-----
>  t/t0003-attributes.sh     |  7 ++++++-
>  t/t4018-diff-funcname.sh  | 19 +++++++++++++++++++
>  userdiff.c                |  2 +-
>  ws.c                      |  2 +-
>  14 files changed, 111 insertions(+), 29 deletions(-)
>
> diff --git c/archive.c w/archive.c
> index 9aeaf2bd87..385aa5f248 100644
> --- c/archive.c
> +++ w/archive.c
> @@ -120,7 +120,7 @@ static const struct attr_check *get_archive_attrs(s=
truct index_state *istate,
>  	static struct attr_check *check;
>  	if (!check)
>  		check =3D attr_check_initl("export-ignore", "export-subst", NULL);
> -	git_check_attr(istate, NULL, path, check);
> +	git_check_attr(istate, path, check);
>  	return check;
>  }
>
> diff --git c/attr.c w/attr.c
> index 1053dfcd4b..d34c7e9d54 100644
> --- c/attr.c
> +++ w/attr.c
> @@ -1165,11 +1165,40 @@ static void collect_some_attrs(struct index_sta=
te *istate,
>  	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, =
rem);
>  }
>
> +static const char *default_attr_source_tree_object_name;
> +
> +void set_git_attr_source(const char *tree_object_name)
> +{
> +	default_attr_source_tree_object_name =3D xstrdup(tree_object_name);
> +}
> +
> +
> +static void compute_default_attr_source(struct object_id *attr_source)=

> +{
> +	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source=
))
> +		return;
> +
> +	if (get_oid_treeish(default_attr_source_tree_object_name, attr_source=
))
> +		die(_("bad --attr-source object"));
> +}
> +
> +static struct object_id *default_attr_source(void)
> +{
> +	static struct object_id attr_source;
> +
> +	if (is_null_oid(&attr_source))
> +		compute_default_attr_source(&attr_source);
> +	if (is_null_oid(&attr_source))
> +		return NULL;
> +	return &attr_source;
> +}
> +
>  void git_check_attr(struct index_state *istate,
> -		    const struct object_id *tree_oid, const char *path,
> +		    const char *path,
>  		    struct attr_check *check)
>  {
>  	int i;
> +	const struct object_id *tree_oid =3D default_attr_source();
>
>  	collect_some_attrs(istate, tree_oid, path, check);
>
> @@ -1182,10 +1211,11 @@ void git_check_attr(struct index_state *istate,=

>  	}
>  }
>
> -void git_all_attrs(struct index_state *istate, const struct object_id =
*tree_oid,
> +void git_all_attrs(struct index_state *istate,
>  		   const char *path, struct attr_check *check)
>  {
>  	int i;
> +	const struct object_id *tree_oid =3D default_attr_source();
>
>  	attr_check_reset(check);
>  	collect_some_attrs(istate, tree_oid, path, check);
> diff --git c/attr.h w/attr.h
> index 9884ea2bc6..676bd17ce2 100644
> --- c/attr.h
> +++ w/attr.h
> @@ -45,7 +45,7 @@
>   * const char *path;
>   *
>   * setup_check();
> - * git_check_attr(&the_index, tree_oid, path, check);
> + * git_check_attr(&the_index, path, check);
>   * ------------
>   *
>   * - Act on `.value` member of the result, left in `check->items[]`:
> @@ -120,7 +120,6 @@
>  #define ATTR_MAX_FILE_SIZE (100 * 1024 * 1024)
>
>  struct index_state;
> -struct object_id;
>
>  /**
>   * An attribute is an opaque object that is identified by its name. Pa=
ss the
> @@ -135,6 +134,12 @@ struct git_attr;
>  struct all_attrs_item;
>  struct attr_stack;
>
> +/*
> + * The textual object name for the tree-ish used by git_check_attr()
> + * to read attributes from (instead of from the working tree).
> + */
> +void set_git_attr_source(const char *);
> +
>  /*
>   * Given a string, return the gitattribute object that
>   * corresponds to it.
> @@ -203,14 +208,14 @@ void attr_check_free(struct attr_check *check);
>  const char *git_attr_name(const struct git_attr *);
>
>  void git_check_attr(struct index_state *istate,
> -		    const struct object_id *tree_oid, const char *path,
> +		    const char *path,
>  		    struct attr_check *check);
>
>  /*
>   * Retrieve all attributes that apply to the specified path.
>   * check holds the attributes and their values.
>   */
> -void git_all_attrs(struct index_state *istate, const struct object_id =
*tree_oid,
> +void git_all_attrs(struct index_state *istate,
>  		   const char *path, struct attr_check *check);
>
>  enum git_attr_direction {
> diff --git c/builtin/check-attr.c w/builtin/check-attr.c
> index d7a40e674c..1a7929c980 100644
> --- c/builtin/check-attr.c
> +++ w/builtin/check-attr.c
> @@ -58,7 +58,7 @@ static void output_attr(struct attr_check *check, con=
st char *file)
>  }
>
>  static void check_attr(const char *prefix, struct attr_check *check,
> -		       const struct object_id *tree_oid, int collect_all,
> +		       int collect_all,
>  		       const char *file)
>
>  {
> @@ -66,9 +66,9 @@ static void check_attr(const char *prefix, struct att=
r_check *check,
>  		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
>
>  	if (collect_all) {
> -		git_all_attrs(&the_index, tree_oid, full_path, check);
> +		git_all_attrs(&the_index, full_path, check);
>  	} else {
> -		git_check_attr(&the_index, tree_oid, full_path, check);
> +		git_check_attr(&the_index, full_path, check);
>  	}
>  	output_attr(check, file);
>
> @@ -76,7 +76,7 @@ static void check_attr(const char *prefix, struct att=
r_check *check,
>  }
>
>  static void check_attr_stdin_paths(const char *prefix, struct attr_che=
ck *check,
> -				   const struct object_id *tree_oid, int collect_all)
> +				   int collect_all)
>  {
>  	struct strbuf buf =3D STRBUF_INIT;
>  	struct strbuf unquoted =3D STRBUF_INIT;
> @@ -90,7 +90,7 @@ static void check_attr_stdin_paths(const char *prefix=
, struct attr_check *check,
>  				die("line is badly quoted");
>  			strbuf_swap(&buf, &unquoted);
>  		}
> -		check_attr(prefix, check, tree_oid, collect_all, buf.buf);
> +		check_attr(prefix, check, collect_all, buf.buf);
>  		maybe_flush_or_die(stdout, "attribute to stdout");
>  	}
>  	strbuf_release(&buf);
> @@ -106,7 +106,6 @@ static NORETURN void error_with_usage(const char *m=
sg)
>  int cmd_check_attr(int argc, const char **argv, const char *prefix)
>  {
>  	struct attr_check *check;
> -	struct object_id *tree_oid =3D NULL;
>  	struct object_id initialized_oid;
>  	int cnt, i, doubledash, filei;
>
> @@ -182,14 +181,14 @@ int cmd_check_attr(int argc, const char **argv, c=
onst char *prefix)
>  	if (source) {
>  		if (repo_get_oid_tree(the_repository, source, &initialized_oid))
>  			die("%s: not a valid tree-ish source", source);
> -		tree_oid =3D &initialized_oid;
> +		set_git_attr_source(source);
>  	}
>
>  	if (stdin_paths)
> -		check_attr_stdin_paths(prefix, check, tree_oid, all_attrs);
> +		check_attr_stdin_paths(prefix, check, all_attrs);
>  	else {
>  		for (i =3D filei; i < argc; i++)
> -			check_attr(prefix, check, tree_oid, all_attrs, argv[i]);
> +			check_attr(prefix, check, all_attrs, argv[i]);
>  		maybe_flush_or_die(stdout, "attribute to stdout");
>  	}
>
> diff --git c/builtin/pack-objects.c w/builtin/pack-objects.c
> index 74a167a180..d561541b8c 100644
> --- c/builtin/pack-objects.c
> +++ w/builtin/pack-objects.c
> @@ -1320,7 +1320,7 @@ static int no_try_delta(const char *path)
>
>  	if (!check)
>  		check =3D attr_check_initl("delta", NULL);
> -	git_check_attr(the_repository->index, NULL, path, check);
> +	git_check_attr(the_repository->index, path, check);
>  	if (ATTR_FALSE(check->items[0].value))
>  		return 1;
>  	return 0;
> diff --git c/convert.c w/convert.c
> index a54d1690c0..9b67649032 100644
> --- c/convert.c
> +++ w/convert.c
> @@ -1308,7 +1308,7 @@ void convert_attrs(struct index_state *istate,
>  		git_config(read_convert_config, NULL);
>  	}
>
> -	git_check_attr(istate, NULL, path, check);
> +	git_check_attr(istate, path, check);
>  	ccheck =3D check->items;
>  	ca->crlf_action =3D git_path_check_crlf(ccheck + 4);
>  	if (ca->crlf_action =3D=3D CRLF_UNDEFINED)
> diff --git c/git.c w/git.c
> index 6171fd6769..21bddc5718 100644
> --- c/git.c
> +++ w/git.c
> @@ -4,6 +4,7 @@
>  #include "help.h"
>  #include "run-command.h"
>  #include "alias.h"
> +#include "attr.h"
>  #include "shallow.h"
>
>  #define RUN_SETUP		(1<<0)
> @@ -307,6 +308,8 @@ static int handle_options(const char ***argv, int *=
argc, int *envchanged)
>  			} else {
>  				exit(list_cmds(cmd));
>  			}
> +		} else if (skip_prefix(cmd, "--attr-source=3D", &cmd)) {
> +			set_git_attr_source(cmd);
>  		} else {
>  			fprintf(stderr, _("unknown option: %s\n"), cmd);
>  			usage(git_usage_string);
> diff --git c/ll-merge.c w/ll-merge.c
> index 130d26501c..22a603e8af 100644
> --- c/ll-merge.c
> +++ w/ll-merge.c
> @@ -391,7 +391,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_bu=
f,
>  		normalize_file(theirs, path, istate);
>  	}
>
> -	git_check_attr(istate, NULL, path, check);
> +	git_check_attr(istate, path, check);
>  	ll_driver_name =3D check->items[0].value;
>  	if (check->items[1].value) {
>  		marker_size =3D atoi(check->items[1].value);
> @@ -419,7 +419,7 @@ int ll_merge_marker_size(struct index_state *istate=
, const char *path)
>
>  	if (!check)
>  		check =3D attr_check_initl("conflict-marker-size", NULL);
> -	git_check_attr(istate, NULL, path, check);
> +	git_check_attr(istate, path, check);
>  	if (check->items[0].value) {
>  		marker_size =3D atoi(check->items[0].value);
>  		if (marker_size <=3D 0)
> diff --git c/pathspec.c w/pathspec.c
> index ab70fcbe61..74e02c75fc 100644
> --- c/pathspec.c
> +++ w/pathspec.c
> @@ -730,7 +730,7 @@ int match_pathspec_attrs(struct index_state *istate=
,
>  	if (name[namelen])
>  		name =3D to_free =3D xmemdupz(name, namelen);
>
> -	git_check_attr(istate, NULL, name, item->attr_check);
> +	git_check_attr(istate, name, item->attr_check);
>
>  	free(to_free);
>
> diff --git c/t/lib-diff-alternative.sh w/t/lib-diff-alternative.sh
> index a8f5d3274a..02381eb7f1 100644
> --- c/t/lib-diff-alternative.sh
> +++ w/t/lib-diff-alternative.sh
> @@ -112,15 +112,36 @@ EOF
>
>  	STRATEGY=3D$1
>
> -	test_expect_success "$STRATEGY diff from attributes" '
> +	test_expect_success "setup attributes files for tests with $STRATEGY"=
 '
> +		git checkout -b master &&
>  		echo "file* diff=3Ddriver" >.gitattributes &&
> -		git config diff.driver.algorithm "$STRATEGY" &&
> -		test_must_fail git diff --no-index file1 file2 > output &&
> -		cat expect &&
> -		cat output &&
> +		git add file1 file2 .gitattributes &&
> +		git commit -m "adding files" &&
> +		git checkout -b branchA &&
> +		echo "file* diff=3DdriverA" >.gitattributes &&
> +		git add .gitattributes &&
> +		git commit -m "adding driverA as diff driver" &&
> +		git checkout master &&
> +		git clone --bare --no-local . bare.git
> +	'
> +
> +	test_expect_success "$STRATEGY diff from attributes" '
> +		test_must_fail git -c diff.driver.algorithm=3D$STRATEGY diff --no-in=
dex file1 file2 > output &&
>  		test_cmp expect output
>  	'
>
> +	test_expect_success "diff from attributes with bare repo when branch =
different than HEAD" '
> +		git -C bare.git --attr-source=3DbranchA -c diff.driver.algorithm=3Dm=
yers \
> +			-c diff.driverA.algorithm=3D$STRATEGY \
> +			diff HEAD:file1 HEAD:file2 >output &&
> +		test_cmp expect output
> +	'
> +
> +	test_expect_success "diff from attributes with bare repo with invalid=
 source" '
> +		test_must_fail git -C bare.git --attr-source=3Dinvalid-branch diff \=

> +			HEAD:file1 HEAD:file2
> +	'
> +
>  	test_expect_success "$STRATEGY diff from attributes has valid diffsta=
t" '
>  		echo "file* diff=3Ddriver" >.gitattributes &&
>  		git config diff.driver.algorithm "$STRATEGY" &&
> diff --git c/t/t0003-attributes.sh w/t/t0003-attributes.sh
> index 89b306cb11..73db37a7f3 100755
> --- c/t/t0003-attributes.sh
> +++ w/t/t0003-attributes.sh
> @@ -30,8 +30,13 @@ attr_check_quote () {
>  attr_check_source () {
>  	path=3D"$1" expect=3D"$2" source=3D"$3" git_opts=3D"$4" &&
>
> -	git $git_opts check-attr --source $source test -- "$path" >actual 2>e=
rr &&
>  	echo "$path: test: $expect" >expect &&
> +
> +	git $git_opts check-attr --source $source test -- "$path" >actual 2>e=
rr &&
> +	test_cmp expect actual &&
> +	test_must_be_empty err &&
> +
> +	git $git_opts --attr-source=3D"$source" check-attr test -- "$path" >a=
ctual 2>err &&
>  	test_cmp expect actual &&
>  	test_must_be_empty err
>  }
> diff --git c/t/t4018-diff-funcname.sh w/t/t4018-diff-funcname.sh
> index 42a2b9a13b..c8d555771d 100755
> --- c/t/t4018-diff-funcname.sh
> +++ w/t/t4018-diff-funcname.sh
> @@ -63,6 +63,25 @@ do
>  		test_i18ngrep ! fatal msg &&
>  		test_i18ngrep ! error msg
>  	'
> +
> +	test_expect_success "builtin $p pattern compiles on bare repo with --=
attr-source" '
> +		test_when_finished "rm -rf bare.git" &&
> +		git checkout -B master &&
> +		git add . &&
> +		echo "*.java diff=3Dnotexist" >.gitattributes &&
> +		git add .gitattributes &&
> +		git commit -am "changing gitattributes" &&
> +		git checkout -B branchA &&
> +		echo "*.java diff=3D$p" >.gitattributes &&
> +		git add .gitattributes &&
> +		git commit -am "changing gitattributes" &&
> +		git clone --bare --no-local . bare.git &&
> +		git -C bare.git symbolic-ref HEAD refs/heads/master &&
> +		test_expect_code 1 git -C bare.git --attr-source=3DbranchA \
> +			diff --exit-code HEAD:A.java HEAD:B.java 2>msg &&
> +		test_i18ngrep ! fatal msg &&
> +		test_i18ngrep ! error msg
> +	'
>  done
>
>  test_expect_success 'last regexp must not be negated' '
> diff --git c/userdiff.c w/userdiff.c
> index 58a3d59ef8..156660eaca 100644
> --- c/userdiff.c
> +++ w/userdiff.c
> @@ -415,7 +415,7 @@ struct userdiff_driver *userdiff_find_by_path(struc=
t index_state *istate,
>  		check =3D attr_check_initl("diff", NULL);
>  	if (!path)
>  		return NULL;
> -	git_check_attr(istate, NULL, path, check);
> +	git_check_attr(istate, path, check);
>
>  	if (ATTR_TRUE(check->items[0].value))
>  		return &driver_true;
> diff --git c/ws.c w/ws.c
> index da3d0e28cb..903bfcd53e 100644
> --- c/ws.c
> +++ w/ws.c
> @@ -79,7 +79,7 @@ unsigned whitespace_rule(struct index_state *istate, =
const char *pathname)
>  	if (!attr_whitespace_rule)
>  		attr_whitespace_rule =3D attr_check_initl("whitespace", NULL);
>
> -	git_check_attr(istate, NULL, pathname, attr_whitespace_rule);
> +	git_check_attr(istate, pathname, attr_whitespace_rule);
>  	value =3D attr_whitespace_rule->items[0].value;
>  	if (ATTR_TRUE(value)) {
>  		/* true (whitespace) */
