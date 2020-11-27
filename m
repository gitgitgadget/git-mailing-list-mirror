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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31661C2D0E4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC742087C
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgwOVw+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgK0K7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 05:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgK0K7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 05:59:11 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED54C0613D1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:59:11 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id gj5so6990782ejb.8
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=08CEQZNiRMb0Nh84P21vxdGv72PMjiEvT9cy70fiLrg=;
        b=BgwOVw+Xkg2JmnU685DXW60pjc+0Xy8xyHsl0AMle6GBsRd/+TZKZhgD4jUq/7074E
         AsQiLwKeanuSX1OFTJoUFRHg8eNTrMdVEY6lVt6LhZhMwVTFW0qykYpw4jOTG/2/+08e
         ib6WMGI0ErUZo81KzIQmK3w5pEI2BSGSHTH4BNbVnIUk7XiaCmaSa7FwwPJRYGiuWRvr
         ahulZF6IBjMtdTNU5P9VWJ3WUHJhWyPiSeCdzz/l3pGJ9BfXHoOi6p2wETl8V1BKoLQ0
         k1fFGbt01/KLT1acUoF7SEOj53ONG63hJobqVbE/fg6oooR/3flboUZ/MyccTzhrNsWj
         kPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=08CEQZNiRMb0Nh84P21vxdGv72PMjiEvT9cy70fiLrg=;
        b=LFjNGbSMEHiMcYykojSPyZEP+Hefet2Edm6suvDN62BnRhTecW6oonzNnqSGMPHoiy
         PRTQWhX8cXmuL4GtGEds/lbsOdyf+V6et+ei3rs1fdI9k5ydX3LPHZlLOonUW7Jny2Ww
         SGnqlo7feKI3vsC1e+/35a6QmBmlbzAQLmAgyaQzp7WkJriFGWmzKerr+UFCwcxG9JNC
         WjogmfHXJ2zZst8Jb59ery2ZFsmRNeOZuvSy4fF++QRFqwnv2l/LG/A1N6Dw+efi5krb
         ebLG6F9BsH/QjCRcjdgkW6UqwEmN+05kn66V+0CSjdos4Kcikc2oLKk6t8tNzcCvIVqv
         FoHA==
X-Gm-Message-State: AOAM531RDgECTFQbNILeHVlS0Tu46OypMHkQUABN2oJevPB8UNfWLBfL
        mOBoKceUaQBZxwD2FhjKefOQt0WusJK0kw==
X-Google-Smtp-Source: ABdhPJwUmPshN21iGXb3lnP7T779d8ea2NY/0OcSKraHHdYNkY3brNmR09vYJhRNHonHD/aTwXHazw==
X-Received: by 2002:a17:906:f286:: with SMTP id gu6mr7270808ejb.182.1606474749654;
        Fri, 27 Nov 2020 02:59:09 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id h15sm2228305edz.95.2020.11.27.02.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:59:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 14/16] Reftable support for git-core
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <a590865a7008f065b3f4a75deabbf6dc06807623.1606419752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <a590865a7008f065b3f4a75deabbf6dc06807623.1606419752.git.gitgitgadget@gmail.com>
Date:   Fri, 27 Nov 2020 11:59:08 +0100
Message-ID: <87czzznk03.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 26 2020, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> For background, see the previous commit introducing the library.
>
> This introduces the file refs/reftable-backend.c containing a reftable-powered
> ref storage backend.
>
> It can be activated by passing --ref-storage=reftable to "git init", or setting
> GIT_TEST_REFTABLE in the environment.
>
> Example use: see t/t0031-reftable.sh
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Co-authored-by: Jeff King <peff@peff.net>
> ---
>  .../technical/repository-version.txt          |    7 +
>  Makefile                                      |    4 +
>  builtin/clone.c                               |    5 +-
>  builtin/init-db.c                             |   55 +-
>  builtin/worktree.c                            |   27 +-
>  cache.h                                       |    8 +-
>  config.mak.uname                              |    2 +-
>  contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
>  refs.c                                        |   27 +-
>  refs.h                                        |    3 +
>  refs/refs-internal.h                          |    1 +
>  refs/reftable-backend.c                       | 1418 +++++++++++++++++
>  repository.c                                  |    2 +
>  repository.h                                  |    3 +
>  setup.c                                       |    9 +-
>  t/t0031-reftable.sh                           |  199 +++
>  t/t1409-avoid-packing-refs.sh                 |    6 +
>  t/t1450-fsck.sh                               |    6 +
>  t/t3210-pack-refs.sh                          |    6 +
>  t/test-lib.sh                                 |    5 +
>  20 files changed, 1771 insertions(+), 33 deletions(-)
>  create mode 100644 refs/reftable-backend.c
>  create mode 100755 t/t0031-reftable.sh
>
> diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
> index 7844ef30ff..7257623583 100644
> --- a/Documentation/technical/repository-version.txt
> +++ b/Documentation/technical/repository-version.txt
> @@ -100,3 +100,10 @@ If set, by default "git config" reads from both "config" and
>  multiple working directory mode, "config" file is shared while
>  "config.worktree" is per-working directory (i.e., it's in
>  GIT_COMMON_DIR/worktrees/<id>/config.worktree)
> +
> +==== `refStorage`
> +
> +Specifies the file format for the ref database. Values are `files`
> +(for the traditional packed + loose ref format) and `reftable` for the
> +binary reftable format. See https://github.com/google/reftable for
> +more information.

Should also be documented in Documentation/config/extensions.txt,
including maybe that setting this will hard die on older git
versions.

Then if you init with reftable and set it to "files" it'll say "warning:
ignoring broken ref refs/heads. Maybe amend that message to say the
config is wrong/detect it's a reftable file?

> +	/*
> +	 * Check to see if .git/HEAD exists; this must happen before
> +	 * initializing the ref db, because we want to see if there is an
> +	 * existing HEAD.
> +	 */
> +	path = git_path_buf(&buf, "HEAD");
> +	reinit = (!access(path, R_OK) ||
> +		  readlink(path, junk, sizeof(junk) - 1) != -1);
> +
> +	/*
> +	 * refs/heads is a file when using reftable. We can't reinitialize with
> +	 * a reftable because it will overwrite HEAD
> +	 */
> +	if (reinit && (!strcmp(fmt->ref_storage, "reftable")) ==
> +			      is_directory(git_path_buf(&buf, "refs/heads"))) {
> +		die("cannot switch ref storage format.");
> +	}
> +

I found this a bit weird, why would creating .git/refs/heads as a file
have to do with .git/HEAD, but reading on what this comment means is
that part of the initialization is to put "ref: refs/heads/.invalid" in
HEAD

And through further dissecting (nothing in this series documents this
AFAICT) that value is chosen because if you stray much from it git will
die with "not a git repository", i.e. it's invalid content, but not
*too* invalid.

I wonder if to achive that aim this isn't more useful &
self-documenting:

    $ cat .git/HEAD
    ref: refs/heads/[this repository uses a reftable for ref storage!]

Also since older versions of git will do this:

    $ __git_ps1
    ([this repository uses a reftable for ref storage!])

>  	/*
>  	 * We need to create a "refs" dir in any case so that older
>  	 * versions of git can tell that this is a repository.
> @@ -260,9 +281,6 @@ static int create_default_files(const char *template_path,
>  	 * Point the HEAD symref to the initial branch with if HEAD does
>  	 * not yet exist.
>  	 */
> -	path = git_path_buf(&buf, "HEAD");
> -	reinit = (!access(path, R_OK)
> -		  || readlink(path, junk, sizeof(junk)-1) != -1);
>  	if (!reinit) {
>  		char *ref;
>  
> @@ -279,7 +297,7 @@ static int create_default_files(const char *template_path,
>  		free(ref);
>  	}
>  
> -	initialize_repository_version(fmt->hash_algo, 0);
> +	initialize_repository_version(fmt->hash_algo, 0, fmt->ref_storage);
>  
>  	/* Check filemode trustability */
>  	path = git_path_buf(&buf, "config");
> @@ -396,7 +414,7 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
>  
>  int init_db(const char *git_dir, const char *real_git_dir,
>  	    const char *template_dir, int hash, const char *initial_branch,
> -	    unsigned int flags)
> +	    const char *ref_storage_format, unsigned int flags)
>  {
>  	int reinit;
>  	int exist_ok = flags & INIT_DB_EXIST_OK;
> @@ -435,6 +453,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  	 * is an attempt to reinitialize new repository with an old tool.
>  	 */
>  	check_repository_format(&repo_fmt);
> +	repo_fmt.ref_storage = xstrdup(ref_storage_format);
>  
>  	validate_hash_algorithm(&repo_fmt, hash);
>  
> @@ -467,6 +486,9 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  		git_config_set("receive.denyNonFastforwards", "true");
>  	}
>  
> +	if (!strcmp(ref_storage_format, "reftable"))
> +		git_config_set("extensions.refStorage", ref_storage_format);
> +
>  	if (!(flags & INIT_DB_QUIET)) {
>  		int len = strlen(git_dir);
>  
> @@ -540,6 +562,7 @@ static const char *const init_db_usage[] = {
>  int cmd_init_db(int argc, const char **argv, const char *prefix)
>  {
>  	const char *git_dir;
> +	const char *ref_storage_format = default_ref_storage();
>  	const char *real_git_dir = NULL;
>  	const char *work_tree;
>  	const char *template_dir = NULL;
> @@ -548,15 +571,18 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  	const char *initial_branch = NULL;
>  	int hash_algo = GIT_HASH_UNKNOWN;
>  	const struct option init_db_options[] = {
> -		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
> -				N_("directory from which templates will be used")),
> +		OPT_STRING(0, "template", &template_dir,
> +			   N_("template-directory"),
> +			   N_("directory from which templates will be used")),
>  		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
> -				N_("create a bare repository"), 1),
> +			    N_("create a bare repository"), 1),
>  		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
> -			N_("permissions"),
> -			N_("specify that the git repository is to be shared amongst several users"),
> -			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
> +		  N_("permissions"),
> +		  N_("specify that the git repository is to be shared amongst several users"),
> +		  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0 },
>  		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
> +		OPT_STRING(0, "ref-storage", &ref_storage_format, N_("backend"),
> +			   N_("the ref storage format to use")),
>  		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
>  			   N_("separate git dir from working tree")),
>  		OPT_STRING('b', "initial-branch", &initial_branch, N_("name"),
> @@ -697,10 +723,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	UNLEAK(real_git_dir);
> +	UNLEAK(ref_storage_format);
>  	UNLEAK(git_dir);
>  	UNLEAK(work_tree);
>  
>  	flags |= INIT_DB_EXIST_OK;
>  	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
> -		       initial_branch, flags);
> +		       initial_branch, ref_storage_format, flags);
>  }
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index ce56fdaaa9..7931620788 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -12,6 +12,7 @@
>  #include "submodule.h"
>  #include "utf8.h"
>  #include "worktree.h"
> +#include "../refs/refs-internal.h"
>  
>  static const char * const worktree_usage[] = {
>  	N_("git worktree add [<options>] <path> [<commit-ish>]"),
> @@ -402,9 +403,29 @@ static int add_worktree(const char *path, const char *refname,
>  	 * worktree.
>  	 */
>  	strbuf_reset(&sb);
> -	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
> -	write_file(sb.buf, "%s", oid_to_hex(&null_oid));
> -	strbuf_reset(&sb);
> +	if (get_main_ref_store(the_repository)->be == &refs_be_reftable) {
> +		/* XXX this is cut & paste from reftable_init_db. */
> +		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
> +		write_file(sb.buf, "%s", "ref: refs/heads/.invalid\n");
> +		strbuf_reset(&sb);
> +
> +		strbuf_addf(&sb, "%s/refs", sb_repo.buf);
> +		safe_create_dir(sb.buf, 1);
> +		strbuf_reset(&sb);
> +
> +		strbuf_addf(&sb, "%s/refs/heads", sb_repo.buf);
> +		write_file(sb.buf, "this repository uses the reftable format");
> +		strbuf_reset(&sb);
> +
> +		strbuf_addf(&sb, "%s/reftable", sb_repo.buf);
> +		safe_create_dir(sb.buf, 1);
> +		strbuf_reset(&sb);
> +	} else {
> +		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
> +		write_file(sb.buf, "%s", oid_to_hex(&null_oid));
> +		strbuf_reset(&sb);
> +	}
> +
>  	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>  	write_file(sb.buf, "../..");
>  
> diff --git a/cache.h b/cache.h
> index e986cf4ea9..545d2b7260 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -627,9 +627,10 @@ int path_inside_repo(const char *prefix, const char *path);
>  #define INIT_DB_EXIST_OK 0x0002
>  
>  int init_db(const char *git_dir, const char *real_git_dir,
> -	    const char *template_dir, int hash_algo,
> -	    const char *initial_branch, unsigned int flags);
> -void initialize_repository_version(int hash_algo, int reinit);
> +	    const char *template_dir, int hash_algo, const char *initial_branch,
> +	    const char *ref_storage_format, unsigned int flags);
> +void initialize_repository_version(int hash_algo, int reinit,
> +				   const char *ref_storage_format);
>  
>  void sanitize_stdfds(void);
>  int daemonize(void);
> @@ -1043,6 +1044,7 @@ struct repository_format {
>  	int is_bare;
>  	int hash_algo;
>  	char *work_tree;
> +	char *ref_storage;
>  	struct string_list unknown_extensions;
>  	struct string_list v1_only_extensions;
>  };
> diff --git a/config.mak.uname b/config.mak.uname
> index c7eba69e54..ae4e25a1a4 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -709,7 +709,7 @@ vcxproj:
>  	# Make .vcxproj files and add them
>  	unset QUIET_GEN QUIET_BUILT_IN; \
>  	perl contrib/buildsystems/generate -g Vcxproj
> -	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
> +	git add -f git.sln {*,*/lib,*/libreftable,t/helper/*}/*.vcxproj
>  
>  	# Generate the LinkOrCopyBuiltins.targets and LinkOrCopyRemoteHttp.targets file
>  	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
> diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
> index d2584450ba..1a25789d28 100644
> --- a/contrib/buildsystems/Generators/Vcxproj.pm
> +++ b/contrib/buildsystems/Generators/Vcxproj.pm
> @@ -77,7 +77,7 @@ sub createProject {
>      my $libs_release = "\n    ";
>      my $libs_debug = "\n    ";
>      if (!$static_library) {
> -      $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
> +      $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib|reftable\/libreftable\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
>        $libs_debug = $libs_release;
>        $libs_debug =~ s/zlib\.lib/zlibd\.lib/g;
>        $libs_debug =~ s/libexpat\.lib/libexpatd\.lib/g;
> @@ -232,6 +232,7 @@ sub createProject {
>  EOM
>      if (!$static_library || $target =~ 'vcs-svn' || $target =~ 'xdiff') {
>        my $uuid_libgit = $$build_structure{"LIBS_libgit_GUID"};
> +      my $uuid_libreftable = $$build_structure{"LIBS_reftable/libreftable_GUID"};
>        my $uuid_xdiff_lib = $$build_structure{"LIBS_xdiff/lib_GUID"};
>  
>        print F << "EOM";
> @@ -241,6 +242,14 @@ sub createProject {
>        <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
>      </ProjectReference>
>  EOM
> +      if (!($name =~ /xdiff|libreftable/)) {
> +        print F << "EOM";
> +    <ProjectReference Include="$cdup\\reftable\\libreftable\\libreftable.vcxproj">
> +      <Project>$uuid_libreftable</Project>
> +      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
> +    </ProjectReference>
> +EOM
> +      }
>        if (!($name =~ 'xdiff')) {
>          print F << "EOM";
>      <ProjectReference Include="$cdup\\xdiff\\lib\\xdiff_lib.vcxproj">
> diff --git a/refs.c b/refs.c
> index 392f0bbf68..1b874db334 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -19,10 +19,16 @@
>  #include "repository.h"
>  #include "sigchain.h"
>  
> +const char *default_ref_storage(void)
> +{
> +	const char *test = getenv("GIT_TEST_REFTABLE");
> +	return test ? "reftable" : "files";
> +}
> +
>  /*
>   * List of all available backends
>   */
> -static struct ref_storage_be *refs_backends = &refs_be_files;
> +static struct ref_storage_be *refs_backends = &refs_be_reftable;
>  
>  static struct ref_storage_be *find_ref_storage_backend(const char *name)
>  {
> @@ -1754,13 +1760,13 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
>   * Create, record, and return a ref_store instance for the specified
>   * gitdir.
>   */
> -static struct ref_store *ref_store_init(const char *gitdir,
> +static struct ref_store *ref_store_init(const char *gitdir, const char *be_name,
>  					unsigned int flags)
>  {
> -	const char *be_name = "files";
> -	struct ref_storage_be *be = find_ref_storage_backend(be_name);
> +	struct ref_storage_be *be;
>  	struct ref_store *refs;
>  
> +	be = find_ref_storage_backend(be_name);
>  	if (!be)
>  		BUG("reference backend %s is unknown", be_name);
>  
> @@ -1776,7 +1782,11 @@ struct ref_store *get_main_ref_store(struct repository *r)
>  	if (!r->gitdir)
>  		BUG("attempting to get main_ref_store outside of repository");
>  
> -	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
> +	r->refs_private = ref_store_init(r->gitdir,
> +					 r->ref_storage_format ?
> +						       r->ref_storage_format :
> +						       default_ref_storage(),
> +					 REF_STORE_ALL_CAPS);
>  	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
>  	return r->refs_private;
>  }
> @@ -1832,7 +1842,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  		goto done;
>  
>  	/* assume that add_submodule_odb() has been called */
> -	refs = ref_store_init(submodule_sb.buf,
> +	refs = ref_store_init(submodule_sb.buf, default_ref_storage(),
>  			      REF_STORE_READ | REF_STORE_ODB);
>  	register_ref_store_map(&submodule_ref_stores, "submodule",
>  			       refs, submodule);
> @@ -1846,6 +1856,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  
>  struct ref_store *get_worktree_ref_store(const struct worktree *wt)
>  {
> +	const char *format = default_ref_storage();
>  	struct ref_store *refs;
>  	const char *id;
>  
> @@ -1859,9 +1870,9 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
>  
>  	if (wt->id)
>  		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
> -				      REF_STORE_ALL_CAPS);
> +				      format, REF_STORE_ALL_CAPS);
>  	else
> -		refs = ref_store_init(get_git_common_dir(),
> +		refs = ref_store_init(get_git_common_dir(), format,
>  				      REF_STORE_ALL_CAPS);
>  
>  	if (refs)
> diff --git a/refs.h b/refs.h
> index 6695518156..7dc60472c9 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -11,6 +11,9 @@ struct string_list;
>  struct string_list_item;
>  struct worktree;
>  
> +/* Returns the ref storage backend to use by default. */
> +const char *default_ref_storage(void);
> +
>  /*
>   * Resolve a reference, recursively following symbolic refererences.
>   *
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 467f4b3c93..28166bf1f8 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -669,6 +669,7 @@ struct ref_storage_be {
>  };
>  
>  extern struct ref_storage_be refs_be_files;
> +extern struct ref_storage_be refs_be_reftable;
>  extern struct ref_storage_be refs_be_packed;
>  
>  /*
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> new file mode 100644
> index 0000000000..894c72ddc4
> --- /dev/null
> +++ b/refs/reftable-backend.c
> @@ -0,0 +1,1418 @@
> +#include "../cache.h"
> +#include "../chdir-notify.h"
> +#include "../config.h"
> +#include "../iterator.h"
> +#include "../lockfile.h"
> +#include "../refs.h"
> +#include "../reftable/reftable-stack.h"
> +#include "../reftable/reftable-record.h"
> +#include "../reftable/reftable-error.h"
> +#include "../reftable/reftable-blocksource.h"
> +#include "../reftable/reftable-reader.h"
> +#include "../reftable/reftable-iterator.h"
> +#include "../reftable/reftable-merged.h"
> +#include "../reftable/reftable-generic.h"
> +#include "../worktree.h"
> +#include "refs-internal.h"
> +
> +extern struct ref_storage_be refs_be_reftable;
> +
> +struct git_reftable_ref_store {
> +	struct ref_store base;
> +	unsigned int store_flags;
> +
> +	int err;
> +	char *repo_dir;
> +
> +	char *reftable_dir;
> +	char *worktree_reftable_dir;
> +
> +	struct reftable_stack *main_stack;
> +	struct reftable_stack *worktree_stack;
> +};
> +
> +static struct reftable_stack *stack_for(struct git_reftable_ref_store *store,
> +					const char *refname)
> +{
> +	if (store->worktree_stack == NULL)
> +		return store->main_stack;
> +
> +	switch (ref_type(refname)) {
> +	case REF_TYPE_PER_WORKTREE:
> +	case REF_TYPE_PSEUDOREF:
> +	case REF_TYPE_OTHER_PSEUDOREF:
> +		return store->worktree_stack;
> +	default:
> +	case REF_TYPE_MAIN_PSEUDOREF:
> +	case REF_TYPE_NORMAL:
> +		return store->main_stack;
> +	}
> +}
> +
> +static int git_reftable_read_raw_ref(struct ref_store *ref_store,
> +				     const char *refname, struct object_id *oid,
> +				     struct strbuf *referent,
> +				     unsigned int *type);
> +
> +static void clear_reftable_log_record(struct reftable_log_record *log)
> +{
> +	log->old_hash = NULL;
> +	log->new_hash = NULL;
> +	log->message = NULL;
> +	log->refname = NULL;
> +	reftable_log_record_release(log);
> +}
> +
> +static void fill_reftable_log_record(struct reftable_log_record *log)
> +{
> +	const char *info = git_committer_info(0);
> +	struct ident_split split = { NULL };
> +	int result = split_ident_line(&split, info, strlen(info));
> +	int sign = 1;
> +	assert(0 == result);
> +
> +	reftable_log_record_release(log);
> +	log->name =
> +		xstrndup(split.name_begin, split.name_end - split.name_begin);
> +	log->email =
> +		xstrndup(split.mail_begin, split.mail_end - split.mail_begin);
