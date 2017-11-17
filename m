Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A3F202D7
	for <e@80x24.org>; Fri, 17 Nov 2017 01:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754674AbdKQBZA (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 20:25:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52769 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754665AbdKQBY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 20:24:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE3AA9E78F;
        Thu, 16 Nov 2017 20:24:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/WeXMlBilogj
        qlgIIOsrCs5/tRs=; b=Dxy+Al3uyt5YeQKjxGt7YZobtEqsdLsSO0ekxPKGR8Tb
        eZKh9gvUF0av33oKVcVAFJygGoNwJ7UMBOMFfy+lkTKr0mA0Z4Ql5LExfGnSZlsT
        lIle5uqSkGkpDocX9/S3YE2XaG1J7vC6UxLb4f+UUWO3kjrCABIcGrQC2sLYpvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=i2v52n
        gI1agN1eiizW9Cvnzfec6gxqv3HLpMeeD6swKIPzJ3OuoRLMNqN+Etr+8dZVqLSa
        OzNv3UQGdoKekU3Fvph0jorgPfT2TR+0ulvd5lPVzhwaByKJ46H/Q3NCXnvF5naS
        IKSH94EXr73AHHsE1uuHBDWcXfUjy8HAyvFeM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6BC19E78E;
        Thu, 16 Nov 2017 20:24:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A1FB9E78D;
        Thu, 16 Nov 2017 20:24:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] Introduce git add --renormalize .
References: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com>
        <20171116163828.14937-1-tboegi@web.de>
Date:   Fri, 17 Nov 2017 10:24:53 +0900
In-Reply-To: <20171116163828.14937-1-tboegi@web.de> (tboegi@web.de's message
        of "Thu, 16 Nov 2017 17:38:28 +0100")
Message-ID: <xmqqtvxtu26y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1E1B47F8-CB36-11E7-A563-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

I'll retitle this to

	Subject: add: introduce "--renormalize"

and will queue with s/$old/$new/ that you'll see below.

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Make it safer to normalize the line endings in a repository:

s/:$/./;

> Files that had been commited with CRLF will be commited with LF.
>
> The old way to normalize a repo was like this:
>  # Make sure that there are not untracked files
>  $ echo "* text=3Dauto" >.gitattributes
>  $ git read-tree --empty
>  $ git add .
>  $ git commit -m "Introduce end-of-line normalization"
>
> The user must make sure that there are no untracked files,
> otherwise they would have been added and tracked from now on.
>
> The new "add ..renormalize" does not add untracked files:

s/\.\./--/;

>  $ echo "* text=3Dauto" >.gitattributes
>  $ git add --renormalize .
>  $ git commit -m "Introduce end-of-line normalization"
>
> Note that "git add --renormalize <pathspec>" is the short form for
> "git add -u --renormalize <pathspec>".
>
> While add it, document that the same renormalization may be needed,

s/add it/at it/;

> whenever a clean filter is added or changed.
>
> Helped-By: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Thanks.

>
> Changes since V2:
>   Add line endings in t0025
>   Use the <<-\EOF pattern
>   Improve the documentation for "git add --renormalize"
>  =20
>
> Documentation/git-add.txt       |  9 ++++++++-
>  Documentation/gitattributes.txt |  6 ++++--
>  builtin/add.c                   | 28 ++++++++++++++++++++++++++--
>  cache.h                         |  1 +
>  read-cache.c                    | 30 +++++++++++++++++++-----------
>  sha1_file.c                     | 16 ++++++++++++++--
>  t/t0025-crlf-renormalize.sh     | 30 ++++++++++++++++++++++++++++++
>  7 files changed, 102 insertions(+), 18 deletions(-)
>  create mode 100755 t/t0025-crlf-renormalize.sh
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index b700beaff5..d50fa339dc 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [verse]
>  'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interact=
ive | -i] [--patch | -p]
>  	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]=
]
> -	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-miss=
ing]
> +	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-miss=
ing] [--renormalize]
>  	  [--chmod=3D(+|-)x] [--] [<pathspec>...]
> =20
>  DESCRIPTION
> @@ -175,6 +175,13 @@ for "git add --no-all <pathspec>...", i.e. ignored=
 removed files.
>  	warning (e.g., if you are manually performing operations on
>  	submodules).
> =20
> +--renormalize::
> +	Apply the "clean" process freshly to all tracked files to
> +	forcibly add them again to the index.  This is useful after
> +	changing `core.autocrlf` configuration or the `text` attribute
> +	in order to correct files added with wrong CRLF/LF line endings.
> +	This option implies `-u`.
> +
>  --chmod=3D(+|-)x::
>  	Override the executable bit of the added files.  The executable
>  	bit is only changed in the index, the files on disk are left
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
> index 4c68bc19d5..30687de81a 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -232,8 +232,7 @@ From a clean working directory:
> =20
>  -------------------------------------------------
>  $ echo "* text=3Dauto" >.gitattributes
> -$ git read-tree --empty   # Clean index, force re-scan of working dire=
ctory
> -$ git add .
> +$ git add --renormalize .
>  $ git status        # Show files that will be normalized
>  $ git commit -m "Introduce end-of-line normalization"
>  -------------------------------------------------
> @@ -328,6 +327,9 @@ You can declare that a filter turns a content that =
by itself is unusable
>  into a usable content by setting the filter.<driver>.required configur=
ation
>  variable to `true`.
> =20
> +Note: Whenever the clean filter is changed, the repo should be renorma=
lized:
> +$ git add --renormalize .
> +
>  For example, in .gitattributes, you would assign the `filter`
>  attribute for paths.
> =20
> diff --git a/builtin/add.c b/builtin/add.c
> index a648cf4c56..c42b50f857 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -26,6 +26,7 @@ static const char * const builtin_add_usage[] =3D {
>  };
>  static int patch_interactive, add_interactive, edit_interactive;
>  static int take_worktree_changes;
> +static int add_renormalize;
> =20
>  struct update_callback_data {
>  	int flags;
> @@ -123,6 +124,25 @@ int add_files_to_cache(const char *prefix,
>  	return !!data.add_errors;
>  }
> =20
> +static int renormalize_tracked_files(const struct pathspec *pathspec, =
int flags)
> +{
> +	int i, retval =3D 0;
> +
> +	for (i =3D 0; i < active_nr; i++) {
> +		struct cache_entry *ce =3D active_cache[i];
> +
> +		if (ce_stage(ce))
> +			continue; /* do not touch unmerged paths */
> +		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
> +			continue; /* do not touch non blobs */
> +		if (pathspec && !ce_path_match(ce, pathspec, NULL))
> +			continue;
> +		retval |=3D add_file_to_cache(ce->name, flags | HASH_RENORMALIZE);
> +	}
> +
> +	return retval;
> +}
> +
>  static char *prune_directory(struct dir_struct *dir, struct pathspec *=
pathspec, int prefix)
>  {
>  	char *seen;
> @@ -276,6 +296,7 @@ static struct option builtin_add_options[] =3D {
>  	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and ap=
ply")),
>  	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files")),
>  	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked fi=
les")),
> +	OPT_BOOL(0, "renormalize", &add_renormalize, N_("renormalize EOL of t=
racked files (implies -u)")),
>  	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fa=
ct that the path will be added later")),
>  	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tr=
acked and untracked files")),
>  	{ OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
> @@ -406,7 +427,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
>  			  chmod_arg[1] !=3D 'x' || chmod_arg[2]))
>  		die(_("--chmod param '%s' must be either -x or +x"), chmod_arg);
> =20
> -	add_new_files =3D !take_worktree_changes && !refresh_only;
> +	add_new_files =3D !take_worktree_changes && !refresh_only && !add_ren=
ormalize;
>  	require_pathspec =3D !(take_worktree_changes || (0 < addremove_explic=
it));
> =20
>  	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
> @@ -500,7 +521,10 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
> =20
>  	plug_bulk_checkin();
> =20
> -	exit_status |=3D add_files_to_cache(prefix, &pathspec, flags);
> +	if (add_renormalize)
> +		exit_status |=3D renormalize_tracked_files(&pathspec, flags);
> +	else
> +		exit_status |=3D add_files_to_cache(prefix, &pathspec, flags);
> =20
>  	if (add_new_files)
>  		exit_status |=3D add_files(&dir, flags);
> diff --git a/cache.h b/cache.h
> index 6440e2bf21..3e63a74113 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -686,6 +686,7 @@ extern int ie_modified(const struct index_state *, =
const struct cache_entry *, s
> =20
>  #define HASH_WRITE_OBJECT 1
>  #define HASH_FORMAT_CHECK 2
> +#define HASH_RENORMALIZE  4
>  extern int index_fd(struct object_id *oid, int fd, struct stat *st, en=
um object_type type, const char *path, unsigned flags);
>  extern int index_path(struct object_id *oid, const char *path, struct =
stat *st, unsigned flags);
> =20
> diff --git a/read-cache.c b/read-cache.c
> index 65f4fe8375..8acd3fcb93 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -631,13 +631,17 @@ int add_to_index(struct index_state *istate, cons=
t char *path, struct stat *st,
>  {
>  	int size, namelen, was_same;
>  	mode_t st_mode =3D st->st_mode;
> -	struct cache_entry *ce, *alias;
> +	struct cache_entry *ce, *alias =3D NULL;
>  	unsigned ce_option =3D CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WOR=
KTREE|CE_MATCH_RACY_IS_DIRTY;
>  	int verbose =3D flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
>  	int pretend =3D flags & ADD_CACHE_PRETEND;
>  	int intent_only =3D flags & ADD_CACHE_INTENT;
>  	int add_option =3D (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
>  			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
> +	int newflags =3D HASH_WRITE_OBJECT;
> +
> +	if (flags & HASH_RENORMALIZE)
> +		newflags |=3D HASH_RENORMALIZE;
> =20
>  	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
>  		return error("%s: can only add regular files, symbolic links or git-=
directories", path);
> @@ -678,19 +682,23 @@ int add_to_index(struct index_state *istate, cons=
t char *path, struct stat *st,
>  	if (ignore_case) {
>  		adjust_dirname_case(istate, ce->name);
>  	}
> +	if (!(flags & HASH_RENORMALIZE)) {
> +		alias =3D index_file_exists(istate, ce->name,
> +					  ce_namelen(ce), ignore_case);
> +		if (alias &&
> +		    !ce_stage(alias) &&
> +		    !ie_match_stat(istate, alias, st, ce_option)) {
> +			/* Nothing changed, really */
> +			if (!S_ISGITLINK(alias->ce_mode))
> +				ce_mark_uptodate(alias);
> +			alias->ce_flags |=3D CE_ADDED;
> =20
> -	alias =3D index_file_exists(istate, ce->name, ce_namelen(ce), ignore_=
case);
> -	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce=
_option)) {
> -		/* Nothing changed, really */
> -		if (!S_ISGITLINK(alias->ce_mode))
> -			ce_mark_uptodate(alias);
> -		alias->ce_flags |=3D CE_ADDED;
> -
> -		free(ce);
> -		return 0;
> +			free(ce);
> +			return 0;
> +		}
>  	}
>  	if (!intent_only) {
> -		if (index_path(&ce->oid, path, st, HASH_WRITE_OBJECT)) {
> +		if (index_path(&ce->oid, path, st, newflags)) {
>  			free(ce);
>  			return error("unable to index file %s", path);
>  		}
> diff --git a/sha1_file.c b/sha1_file.c
> index 10c3a0083d..15abb184c2 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -74,6 +74,18 @@ static struct cached_object *find_cached_object(cons=
t unsigned char *sha1)
>  	return NULL;
>  }
> =20
> +
> +static enum safe_crlf get_safe_crlf(unsigned flags)
> +{
> +	if (flags & HASH_RENORMALIZE)
> +		return SAFE_CRLF_RENORMALIZE;
> +	else if (flags & HASH_WRITE_OBJECT)
> +		return safe_crlf;
> +	else
> +		return SAFE_CRLF_FALSE;
> +}
> +
> +
>  int mkdir_in_gitdir(const char *path)
>  {
>  	if (mkdir(path, 0777)) {
> @@ -1680,7 +1692,7 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
>  	if ((type =3D=3D OBJ_BLOB) && path) {
>  		struct strbuf nbuf =3D STRBUF_INIT;
>  		if (convert_to_git(&the_index, path, buf, size, &nbuf,
> -				   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
> +				   get_safe_crlf(flags))) {
>  			buf =3D strbuf_detach(&nbuf, &size);
>  			re_allocated =3D 1;
>  		}
> @@ -1714,7 +1726,7 @@ static int index_stream_convert_blob(unsigned cha=
r *sha1, int fd,
>  	assert(would_convert_to_git_filter_fd(path));
> =20
>  	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
> -				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
> +				 get_safe_crlf(flags));
> =20
>  	if (write_object)
>  		ret =3D write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
> diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
> new file mode 100755
> index 0000000000..50d8f3a0f3
> --- /dev/null
> +++ b/t/t0025-crlf-renormalize.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +
> +test_description=3D'CRLF renormalization'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	git config core.autocrlf false &&
> +	printf "LINEONE\nLINETWO\nLINETHREE\n"        >LF.txt &&
> +	printf "LINEONE\r\nLINETWO\r\nLINETHREE\r\n"  >CRLF.txt &&
> +	printf "LINEONE\r\nLINETWO\nLINETHREE\n"      >CRLF_mix_LF.txt &&
> +	git add . &&
> +	git commit -m initial
> +'
> +
> +test_expect_success 'renormalize CRLF in repo' '
> +	echo "*.txt text=3Dauto" >.gitattributes &&
> +	git add --renormalize "*.txt" &&
> +cat >expect <<-\EOF &&
> +	i/lf w/crlf attr/text=3Dauto CRLF.txt
> +	i/lf w/lf attr/text=3Dauto LF.txt
> +	i/lf w/mixed attr/text=3Dauto CRLF_mix_LF.txt
> +EOF
> +	git ls-files --eol |
> +	sed -e "s/	/ /g" -e "s/  */ /g" |
> +	sort >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
