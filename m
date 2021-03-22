Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F32C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 22:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04022619A3
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 22:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCVWUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 18:20:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:45169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230016AbhCVWUh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 18:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616451632;
        bh=bcON7X37i1jhfvPl82DPm2ulDlCIJEyvDqSTj+pZ5Ok=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fxxFQlFTd+3++VbAvt9gbWzCSkIHzsNYEarsAmbIwtrSBO4SNkJiPqSuWd0H3T+4d
         gwupOjd5XjMxCS84NyRN1e0UhcuRPD2LpYjGTHbi557G1F6SHp/NCTixocfoZrFRQG
         e4jEi/3nzWNMGcvGH0o1KWdUncLSqdyQ7xIhH7uA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.144.62] ([213.196.212.127]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0Fxf-1ldEk42lD5-00xKlj; Mon, 22
 Mar 2021 23:20:31 +0100
Date:   Mon, 22 Mar 2021 23:20:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v7 08/15] merge-one-file: rewrite in C
In-Reply-To: <20210317204939.17890-9-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103222303210.50@tvgsbejvaqbjf.bet>
References: <20201124115315.13311-1-alban.gruin@gmail.com> <20210317204939.17890-1-alban.gruin@gmail.com> <20210317204939.17890-9-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gBwreTXexBPsvB7bxFb6rchrW5cPGgKerXEwuaMKTB/vIp3k3kI
 v75sFjIYJ4pmR1Pt0VIIFaNL1mAQbHzQz070fJoW3XLGRNv0ZD2FKbXeuIlk8flSN8P0AHd
 W23aMqA/cHd9a2YrMLcHV1M/VGTQ1nA+RGAeFU0Q95zzIDVppRhY24y3JLUO2yhF8rlEm5p
 lQWhNi9ZztkenUqPp7FgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6KnkqYgtAac=:jyTKLKhzeEohc220oxtr9i
 qmI8mRDXVzefOUg6l0vwl2wpFhL05P1p/dJB9+G1w1B0zJPZ7aNhJcxakGneYX3p+sw2SjO5G
 eZtrS1sBR681WYLR4zVFdJxlyZC7g+ijK9P7AOspnhaEakiejEyCbHvub4Ct/74l8yw5942GY
 3pmaCU93jqxnQWo0v4Gknf9uiltpEUf528unijCSkCrPOGyQI9CIPrR4fVKd4QH+Eqf31j/lc
 ApyGaylJurEFTxWb5VoVmaBKniVgDh6Q1TRcfj6SK+txCIvM3XyPIEPzW6EW3zSXF5kWvgV8F
 NhNzqJ0F52z5UTKwyN/ujtuy92f84J+iVh1ozb85hA8XvDXRwb7VTk1Ck1mn71j/AWCrt9nh7
 FaPtP6qQyCsfn5RJfdd/LP5cnCBwrxB1VYD1FK+YQtwOwWQBse2xvgNe/IKFK8oJJQjGlIO1A
 PCgJJt8Npoi/tAFQ8rrIJ9t1NnAuHF/TmYGYCqptwwqMRo8RDBoCBMp2mQvDlJjAcIB86r5TB
 kSqhW+ogiYKM6iraJ+uqi4D5utFsBurIPfHCO9sk+UiBwZ52tcTP5snYgt/1ghHqGkvpXIkHf
 pDl4Y0ttG8eA37i97bk63aDwiELpckJqZq6cE7ZVkEBkcQtlOqVt2MiZTUBUO0kAr2XB8Pm53
 TqFAqApQT6boM/+sK6B22r+zRuZQGkzgKsferIXHN4Z0O7OmakjO4kJL6v+FvgAe0bhZOiJ72
 77ojhQg99LquCMxPW18YsrT2SlO9Ue8WzshZ/4bYtw2szyMP31VMWGDb8wWDJvo04UxNnSWF4
 lfdGSXwfb0nL+PPI3N/LqDGuZpkzYVlbCqki73lHeuD8nZtk/OyVsRHWO4u/i0mwfEaNSC0lc
 eBXfBghR+2AyIIstUYkvvsvWWlVs6RaD+hJAufA4o=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Wed, 17 Mar 2021, Alban Gruin wrote:

> This rewrites `git merge-one-file' from shell to C.  This port is not
> completely straightforward: to save precious cycles by avoiding reading
> and flushing the index repeatedly, write temporary files when an
> operation can be performed in-memory, or allow other function to use the
> rewrite without forking nor worrying about the index, the calls to
> external processes are replaced by calls to functions in libgit.a:
>
>  - calls to `update-index --add --cacheinfo' are replaced by calls to
>    add_to_index_cacheinfo();
>
>  - calls to `update-index --remove' are replaced by calls to
>    remove_file_from_index();
>
>  - calls to `checkout-index -u -f' are replaced by calls to
>    checkout_entry();
>
>  - calls to `unpack-file' and `merge-files' are replaced by calls to
>    read_mmblob() and xdl_merge(), respectively, to merge files
>    in-memory;
>
>  - calls to `checkout-index -f --stage=3D2' are removed, as this is need=
ed
>    to have the correct permission bits on the merged file from the
>    script, but not in the C version;
>
>  - calls to `update-index' are replaced by calls to add_file_to_index().
>
> The bulk of the rewrite is done in a new file in libgit.a,
> merge-strategies.c.  This will enable the resolve and octopus strategies
> to directly call it instead of forking.
>
> This also fixes a bug present in the original script: instead of
> checking if a _regular_ file exists when a file exists in the branch to
> merge, but not in our branch, the rewritten version checks if a file of
> any kind (ie. a directory, ...) exists.  This fixes the tests t6035.14,
> where the branch to merge had a new file, `a/b', but our branch had a
> directory there; it should have failed because a directory exists, but
> it did not because there was no regular file called `a/b'.  This test is
> now marked as successful.
>
> This also teaches `merge-index' to call merge_three_way() (when invoked
> with `--use=3Dmerge-one-file') without forking using a new callback,
> merge_one_file_func().
>
> To avoid any issue with a shrinking index because of the merge function
> used (directly in the process or by forking), as described earlier, the
> iterator of the loop of merge_all_index() is increased by the number of
> entries with the same name, minus the difference between the number of
> entries in the index before and after the merge.
>
> This should handle a shrinking index correctly, but could lead to issues
> with a growing index.  However, this case is not treated, as there is no
> callback that can produce such a case.

Nice!

> diff --git a/builtin/merge-index.c b/builtin/merge-index.c
> index fd5b1a5a92..04d38aa130 100644
> --- a/builtin/merge-index.c
> +++ b/builtin/merge-index.c
> @@ -38,7 +38,7 @@ static int merge_one_file_spawn(struct index_state *is=
tate,
>  int cmd_merge_index(int argc, const char **argv, const char *prefix)
>  {
>  	int i, force_file =3D 0, err =3D 0, one_shot =3D 0, quiet =3D 0;
> -	merge_fn merge_action =3D merge_one_file_spawn;
> +	merge_fn merge_action;
>  	struct lock_file lock =3D LOCK_INIT;
>  	struct repository *r =3D the_repository;
>  	const char *use_internal =3D NULL;
> @@ -69,10 +69,13 @@ int cmd_merge_index(int argc, const char **argv, con=
st char *prefix)
>
>  	if (skip_prefix(pgm, "--use=3D", &use_internal)) {
>  		if (!strcmp(use_internal, "merge-one-file"))
> -			pgm =3D "git-merge-one-file";
> +			merge_action =3D merge_one_file_func;
>  		else
>  			die(_("git merge-index: unknown internal program %s"), use_internal)=
;
> -	}
> +
> +		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
> +	} else
> +		merge_action =3D merge_one_file_spawn;

I would have a slight preference to keep the default initializer, because
that makes it easer to reason about. But if you _want_ to keep this patch
as-is, I won't object.

It is a bit sad that the conversion cannot be done more incrementally, as
there is a lot to unpack in the many different cases that are handled. It
looks correct, though.

Just one thing:

>
>  	for (; i < argc; i++) {
>  		const char *arg =3D argv[i];
> diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
> new file mode 100644
> index 0000000000..ad99c6dbd4
> --- /dev/null
> +++ b/builtin/merge-one-file.c
> @@ -0,0 +1,94 @@
> +/*
> + * Builtin "git merge-one-file"
> + *
> + * Copyright (c) 2020 Alban Gruin
> + *
> + * Based on git-merge-one-file.sh, written by Linus Torvalds.
> + *
> + * This is the git per-file merge utility, called with
> + *
> + *   argv[1] - original file object name (or empty)
> + *   argv[2] - file in branch1 object name (or empty)
> + *   argv[3] - file in branch2 object name (or empty)
> + *   argv[4] - pathname in repository
> + *   argv[5] - original file mode (or empty)
> + *   argv[6] - file in branch1 mode (or empty)
> + *   argv[7] - file in branch2 mode (or empty)
> + *
> + * Handle some trivial cases. The _really_ trivial cases have been
> + * handled already by git read-tree, but that one doesn't do any merges
> + * that might change the tree layout.
> + */
> +
> +#include "cache.h"
> +#include "builtin.h"
> +#include "lockfile.h"
> +#include "merge-strategies.h"
> +
> +static const char builtin_merge_one_file_usage[] =3D
> +	"git merge-one-file <orig blob> <our blob> <their blob> <path> "
> +	"<orig mode> <our mode> <their mode>\n\n"
> +	"Blob ids and modes should be empty for missing files.";
> +
> +static int read_mode(const char *name, const char *arg, unsigned int *m=
ode)
> +{
> +	char *last;
> +	int ret =3D 0;
> +
> +	*mode =3D strtol(arg, &last, 8);
> +
> +	if (*last)
> +		ret =3D error(_("invalid '%s' mode: expected nothing, got '%c'"), nam=
e, *last);
> +	else if (!(S_ISREG(*mode) || S_ISDIR(*mode) || S_ISLNK(*mode)))
> +		ret =3D error(_("invalid '%s' mode: %o"), name, *mode);
> +
> +	return ret;
> +}
> +
> +int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
> +{
> +	struct object_id orig_blob, our_blob, their_blob,
> +		*p_orig_blob =3D NULL, *p_our_blob =3D NULL, *p_their_blob =3D NULL;
> +	unsigned int orig_mode =3D 0, our_mode =3D 0, their_mode =3D 0, ret =
=3D 0;
> +	struct lock_file lock =3D LOCK_INIT;
> +	struct repository *r =3D the_repository;
> +
> +	if (argc !=3D 8)
> +		usage(builtin_merge_one_file_usage);
> +
> +	if (repo_read_index(r) < 0)
> +		die("invalid index");
> +
> +	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
> +
> +	if (!get_oid_hex(argv[1], &orig_blob)) {
> +		p_orig_blob =3D &orig_blob;
> +		ret =3D read_mode("orig", argv[5], &orig_mode);
> +	} else if (!*argv[1] && *argv[5])
> +		ret =3D error(_("no 'orig' object id given, but a mode was still give=
n."));

Here, it looks as if the case of an empty `argv[1]` is not handled
_explicitly_, but we rely on `get_oid_hex()` to return non-zero, and then
we rely on the second arm _also_ not re-assigning `orig_blob`.

I wonder whether this could be checked, and whether it would make sense to
fold this, along with most of these 5 lines, into the `read_mode()` helper
function (DRYing up the code even further).

As for the rest of the patch, it is totally possible that I missed a bug,
but it looks correct to me, and the added regression tests give me a good
feeling about the patch, too.

Thanks,
Dscho

> +
> +	if (!get_oid_hex(argv[2], &our_blob)) {
> +		p_our_blob =3D &our_blob;
> +		ret =3D read_mode("our", argv[6], &our_mode);
> +	} else if (!*argv[2] && *argv[6])
> +		ret =3D error(_("no 'our' object id given, but a mode was still given=
."));
> +
> +	if (!get_oid_hex(argv[3], &their_blob)) {
> +		p_their_blob =3D &their_blob;
> +		ret =3D read_mode("their", argv[7], &their_mode);
> +	} else if (!*argv[3] && *argv[7])
> +		ret =3D error(_("no 'their' object id given, but a mode was still giv=
en."));
> +
> +	if (ret)
> +		return ret;
> +
> +	ret =3D merge_three_way(r->index, p_orig_blob, p_our_blob, p_their_blo=
b,
> +			      argv[4], orig_mode, our_mode, their_mode);
> +
> +	if (ret) {
> +		rollback_lock_file(&lock);
> +		return !!ret;
> +	}
> +
> +	return write_locked_index(r->index, &lock, COMMIT_LOCK);
> +}
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> deleted file mode 100755
> index f6d9852d2f..0000000000
> --- a/git-merge-one-file.sh
> +++ /dev/null
> @@ -1,167 +0,0 @@
> -#!/bin/sh
> -#
> -# Copyright (c) Linus Torvalds, 2005
> -#
> -# This is the git per-file merge script, called with
> -#
> -#   $1 - original file SHA1 (or empty)
> -#   $2 - file in branch1 SHA1 (or empty)
> -#   $3 - file in branch2 SHA1 (or empty)
> -#   $4 - pathname in repository
> -#   $5 - original file mode (or empty)
> -#   $6 - file in branch1 mode (or empty)
> -#   $7 - file in branch2 mode (or empty)
> -#
> -# Handle some trivial cases.. The _really_ trivial cases have
> -# been handled already by git read-tree, but that one doesn't
> -# do any merges that might change the tree layout.
> -
> -USAGE=3D'<orig blob> <our blob> <their blob> <path>'
> -USAGE=3D"$USAGE <orig mode> <our mode> <their mode>"
> -LONG_USAGE=3D"usage: git merge-one-file $USAGE
> -
> -Blob ids and modes should be empty for missing files."
> -
> -SUBDIRECTORY_OK=3DYes
> -. git-sh-setup
> -cd_to_toplevel
> -require_work_tree
> -
> -if test $# !=3D 7
> -then
> -	echo "$LONG_USAGE"
> -	exit 1
> -fi
> -
> -case "${1:-.}${2:-.}${3:-.}" in
> -#
> -# Deleted in both or deleted in one and unchanged in the other
> -#
> -"$1.." | "$1.$1" | "$1$1.")
> -	if { test -z "$6" && test "$5" !=3D "$7"; } ||
> -	   { test -z "$7" && test "$5" !=3D "$6"; }
> -	then
> -		echo "ERROR: File $4 deleted on one branch but had its" >&2
> -		echo "ERROR: permissions changed on the other." >&2
> -		exit 1
> -	fi
> -
> -	if test -n "$2"
> -	then
> -		echo "Removing $4"
> -	else
> -		# read-tree checked that index matches HEAD already,
> -		# so we know we do not have this path tracked.
> -		# there may be an unrelated working tree file here,
> -		# which we should just leave unmolested.  Make sure
> -		# we do not have it in the index, though.
> -		exec git update-index --remove -- "$4"
> -	fi
> -	if test -f "$4"
> -	then
> -		rm -f -- "$4" &&
> -		rmdir -p "$(expr "z$4" : 'z\(.*\)/')" 2>/dev/null || :
> -	fi &&
> -		exec git update-index --remove -- "$4"
> -	;;
> -
> -#
> -# Added in one.
> -#
> -".$2.")
> -	# the other side did not add and we added so there is nothing
> -	# to be done, except making the path merged.
> -	exec git update-index --add --cacheinfo "$6" "$2" "$4"
> -	;;
> -"..$3")
> -	echo "Adding $4"
> -	if test -f "$4"
> -	then
> -		echo "ERROR: untracked $4 is overwritten by the merge." >&2
> -		exit 1
> -	fi
> -	git update-index --add --cacheinfo "$7" "$3" "$4" &&
> -		exec git checkout-index -u -f -- "$4"
> -	;;
> -
> -#
> -# Added in both, identically (check for same permissions).
> -#
> -".$3$2")
> -	if test "$6" !=3D "$7"
> -	then
> -		echo "ERROR: File $4 added identically in both branches," >&2
> -		echo "ERROR: but permissions conflict $6->$7." >&2
> -		exit 1
> -	fi
> -	echo "Adding $4"
> -	git update-index --add --cacheinfo "$6" "$2" "$4" &&
> -		exec git checkout-index -u -f -- "$4"
> -	;;
> -
> -#
> -# Modified in both, but differently.
> -#
> -"$1$2$3" | ".$2$3")
> -
> -	case ",$6,$7," in
> -	*,120000,*)
> -		echo "ERROR: $4: Not merging symbolic link changes." >&2
> -		exit 1
> -		;;
> -	*,160000,*)
> -		echo "ERROR: $4: Not merging conflicting submodule changes." >&2
> -		exit 1
> -		;;
> -	esac
> -
> -	src1=3D$(git unpack-file $2)
> -	src2=3D$(git unpack-file $3)
> -	case "$1" in
> -	'')
> -		echo "Added $4 in both, but differently."
> -		orig=3D$(git unpack-file $(git hash-object /dev/null))
> -		;;
> -	*)
> -		echo "Auto-merging $4"
> -		orig=3D$(git unpack-file $1)
> -		;;
> -	esac
> -
> -	git merge-file "$src1" "$orig" "$src2"
> -	ret=3D$?
> -	msg=3D
> -	if test $ret !=3D 0 || test -z "$1"
> -	then
> -		msg=3D'content conflict'
> -		ret=3D1
> -	fi
> -
> -	# Create the working tree file, using "our tree" version from the
> -	# index, and then store the result of the merge.
> -	git checkout-index -f --stage=3D2 -- "$4" && cat "$src1" >"$4" || exit=
 1
> -	rm -f -- "$orig" "$src1" "$src2"
> -
> -	if test "$6" !=3D "$7"
> -	then
> -		if test -n "$msg"
> -		then
> -			msg=3D"$msg, "
> -		fi
> -		msg=3D"${msg}permissions conflict: $5->$6,$7"
> -		ret=3D1
> -	fi
> -
> -	if test $ret !=3D 0
> -	then
> -		echo "ERROR: $msg in $4" >&2
> -		exit 1
> -	fi
> -	exec git update-index -- "$4"
> -	;;
> -
> -*)
> -	echo "ERROR: $4: Not handling case $1 -> $2 -> $3" >&2
> -	;;
> -esac
> -exit 1
> diff --git a/git.c b/git.c
> index 9bc077a025..95eb74efe1 100644
> --- a/git.c
> +++ b/git.c
> @@ -544,6 +544,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
>  	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
>  	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
> +	{ "merge-one-file", cmd_merge_one_file, RUN_SETUP | NEED_WORK_TREE | N=
O_PARSEOPT },
>  	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE |=
 NO_PARSEOPT },
>  	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_T=
REE | NO_PARSEOPT },
>  	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK=
_TREE | NO_PARSEOPT },
> diff --git a/merge-strategies.c b/merge-strategies.c
> index c80f964612..2717af51fd 100644
> --- a/merge-strategies.c
> +++ b/merge-strategies.c
> @@ -1,5 +1,197 @@
>  #include "cache.h"
> +#include "dir.h"
>  #include "merge-strategies.h"
> +#include "xdiff-interface.h"
> +
> +static int add_merge_result_to_index(struct index_state *istate, unsign=
ed int mode,
> +				     const struct object_id *oid, const char *path,
> +				     int checkout)
> +{
> +	struct cache_entry *ce;
> +	int res;
> +
> +	res =3D add_to_index_cacheinfo(istate, mode, oid, path, 0, 1, 1, &ce);
> +	if (res =3D=3D -1)
> +		return error(_("Invalid path '%s'"), path);
> +	else if (res =3D=3D -2)
> +		return -1;
> +
> +	if (checkout) {
> +		struct checkout state =3D CHECKOUT_INIT;
> +
> +		state.istate =3D istate;
> +		state.force =3D 1;
> +		state.base_dir =3D "";
> +		state.base_dir_len =3D 0;
> +
> +		if (checkout_entry(ce, &state, NULL, NULL) < 0)
> +			return error(_("%s: cannot checkout file"), path);
> +	}
> +
> +	return 0;
> +}
> +
> +static int merge_one_file_deleted(struct index_state *istate,
> +				  const struct object_id *our_blob,
> +				  const struct object_id *their_blob, const char *path,
> +				  unsigned int orig_mode, unsigned int our_mode, unsigned int their=
_mode)
> +{
> +	if ((!our_blob && orig_mode !=3D their_mode) ||
> +	    (!their_blob && orig_mode !=3D our_mode))
> +		return error(_("File %s deleted on one branch but had its "
> +			       "permissions changed on the other."), path);
> +
> +	if (our_blob) {
> +		printf(_("Removing %s\n"), path);
> +
> +		if (file_exists(path))
> +			remove_path(path);
> +	}
> +
> +	if (remove_file_from_index(istate, path))
> +		return error("%s: cannot remove from the index", path);
> +	return 0;
> +}
> +
> +static int do_merge_one_file(struct index_state *istate,
> +			     const struct object_id *orig_blob,
> +			     const struct object_id *our_blob,
> +			     const struct object_id *their_blob, const char *path,
> +			     unsigned int orig_mode, unsigned int our_mode, unsigned int the=
ir_mode)
> +{
> +	int ret, i, dest;
> +	ssize_t written;
> +	mmbuffer_t result =3D {NULL, 0};
> +	mmfile_t mmfs[3];
> +	xmparam_t xmp =3D {{0}};
> +
> +	if (our_mode =3D=3D S_IFLNK || their_mode =3D=3D S_IFLNK)
> +		return error(_("%s: Not merging symbolic link changes."), path);
> +	else if (our_mode =3D=3D S_IFGITLINK || their_mode =3D=3D S_IFGITLINK)
> +		return error(_("%s: Not merging conflicting submodule changes."), pat=
h);
> +
> +	if (orig_blob) {
> +		printf(_("Auto-merging %s\n"), path);
> +		read_mmblob(mmfs + 0, orig_blob);
> +	} else {
> +		printf(_("Added %s in both, but differently.\n"), path);
> +		read_mmblob(mmfs + 0, &null_oid);
> +	}
> +
> +	read_mmblob(mmfs + 1, our_blob);
> +	read_mmblob(mmfs + 2, their_blob);
> +
> +	xmp.level =3D XDL_MERGE_ZEALOUS_ALNUM;
> +	xmp.style =3D 0;
> +	xmp.favor =3D 0;
> +
> +	ret =3D xdl_merge(mmfs + 0, mmfs + 1, mmfs + 2, &xmp, &result);
> +
> +	for (i =3D 0; i < 3; i++)
> +		free(mmfs[i].ptr);
> +
> +	if (ret < 0) {
> +		free(result.ptr);
> +		return error(_("Failed to execute internal merge"));
> +	}
> +
> +	if (ret > 0 || !orig_blob)
> +		ret =3D error(_("content conflict in %s"), path);
> +	if (our_mode !=3D their_mode)
> +		ret =3D error(_("permission conflict: %o->%o,%o in %s"),
> +			    orig_mode, our_mode, their_mode, path);
> +
> +	unlink(path);
> +	if ((dest =3D open(path, O_WRONLY | O_CREAT, our_mode)) < 0) {
> +		free(result.ptr);
> +		return error_errno(_("failed to open file '%s'"), path);
> +	}
> +
> +	written =3D write_in_full(dest, result.ptr, result.size);
> +	close(dest);
> +
> +	free(result.ptr);
> +
> +	if (written < 0)
> +		return error_errno(_("failed to write to '%s'"), path);
> +	if (ret)
> +		return ret;
> +
> +	return add_file_to_index(istate, path, 0);
> +}
> +
> +int merge_three_way(struct index_state *istate,
> +		    const struct object_id *orig_blob,
> +		    const struct object_id *our_blob,
> +		    const struct object_id *their_blob, const char *path,
> +		    unsigned int orig_mode, unsigned int our_mode, unsigned int their=
_mode)
> +{
> +	if (orig_blob &&
> +	    ((!our_blob && !their_blob) ||
> +	     (!their_blob && our_blob && oideq(orig_blob, our_blob)) ||
> +	     (!our_blob && their_blob && oideq(orig_blob, their_blob)))) {
> +		/* Deleted in both or deleted in one and unchanged in the other. */
> +		return merge_one_file_deleted(istate, our_blob, their_blob, path,
> +					      orig_mode, our_mode, their_mode);
> +	} else if (!orig_blob && our_blob && !their_blob) {
> +		/*
> +		 * Added in ours.  The other side did not add and we
> +		 * added so there is nothing to be done, except making
> +		 * the path merged.
> +		 */
> +		return add_merge_result_to_index(istate, our_mode, our_blob, path, 0)=
;
> +	} else if (!orig_blob && !our_blob && their_blob) {
> +		printf(_("Adding %s\n"), path);
> +
> +		if (file_exists(path))
> +			return error(_("untracked %s is overwritten by the merge."), path);
> +
> +		return add_merge_result_to_index(istate, their_mode, their_blob, path=
, 1);
> +	} else if (!orig_blob && our_blob && their_blob &&
> +		   oideq(our_blob, their_blob)) {
> +		/* Added in both, identically (check for same permissions). */
> +		if (our_mode !=3D their_mode)
> +			return error(_("File %s added identically in both branches, "
> +				       "but permissions conflict %o->%o."),
> +				     path, our_mode, their_mode);
> +
> +		printf(_("Adding %s\n"), path);
> +
> +		return add_merge_result_to_index(istate, our_mode, our_blob, path, 1)=
;
> +	} else if (our_blob && their_blob) {
> +		/* Modified in both, but differently. */
> +		return do_merge_one_file(istate,
> +					 orig_blob, our_blob, their_blob, path,
> +					 orig_mode, our_mode, their_mode);
> +	} else {
> +		char orig_hex[GIT_MAX_HEXSZ] =3D {0}, our_hex[GIT_MAX_HEXSZ] =3D {0},
> +			their_hex[GIT_MAX_HEXSZ] =3D {0};
> +
> +		if (orig_blob)
> +			oid_to_hex_r(orig_hex, orig_blob);
> +		if (our_blob)
> +			oid_to_hex_r(our_hex, our_blob);
> +		if (their_blob)
> +			oid_to_hex_r(their_hex, their_blob);
> +
> +		return error(_("%s: Not handling case %s -> %s -> %s"),
> +			     path, orig_hex, our_hex, their_hex);
> +	}
> +
> +	return 0;
> +}
> +
> +int merge_one_file_func(struct index_state *istate,
> +			const struct object_id *orig_blob,
> +			const struct object_id *our_blob,
> +			const struct object_id *their_blob, const char *path,
> +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mo=
de,
> +			void *data)
> +{
> +	return merge_three_way(istate,
> +			       orig_blob, our_blob, their_blob, path,
> +			       orig_mode, our_mode, their_mode);
> +}
>
>  static int merge_entry(struct index_state *istate, int quiet, unsigned =
int pos,
>  		       const char *path, int *err, merge_fn fn, void *data)
> @@ -54,17 +246,24 @@ int merge_all_index(struct index_state *istate, int=
 oneshot, int quiet,
>  		    merge_fn fn, void *data)
>  {
>  	int err =3D 0, ret;
> -	unsigned int i;
> +	unsigned int i, prev_nr;
>
>  	for (i =3D 0; i < istate->cache_nr; i++) {
>  		const struct cache_entry *ce =3D istate->cache[i];
>  		if (!ce_stage(ce))
>  			continue;
>
> +		prev_nr =3D istate->cache_nr;
>  		ret =3D merge_entry(istate, quiet || oneshot, i, ce->name, &err, fn, =
data);
> -		if (ret > 0)
> -			i +=3D ret - 1;
> -		else if (ret =3D=3D -1)
> +		if (ret > 0) {
> +			/*
> +			 * Don't bother handling an index that has
> +			 * grown, since merge_one_file_func() can't grow
> +			 * it, and merge_one_file_spawn() can't change
> +			 * it.
> +			 */
> +			i +=3D ret - (prev_nr - istate->cache_nr) - 1;
> +		} else if (ret =3D=3D -1)
>  			return -1;
>
>  		if (err && !oneshot)
> diff --git a/merge-strategies.h b/merge-strategies.h
> index 88f476f170..8705a550ca 100644
> --- a/merge-strategies.h
> +++ b/merge-strategies.h
> @@ -3,6 +3,12 @@
>
>  #include "object.h"
>
> +int merge_three_way(struct index_state *istate,
> +		    const struct object_id *orig_blob,
> +		    const struct object_id *our_blob,
> +		    const struct object_id *their_blob, const char *path,
> +		    unsigned int orig_mode, unsigned int our_mode, unsigned int their=
_mode);
> +
>  typedef int (*merge_fn)(struct index_state *istate,
>  			const struct object_id *orig_blob,
>  			const struct object_id *our_blob,
> @@ -10,6 +16,13 @@ typedef int (*merge_fn)(struct index_state *istate,
>  			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mo=
de,
>  			void *data);
>
> +int merge_one_file_func(struct index_state *istate,
> +			const struct object_id *orig_blob,
> +			const struct object_id *our_blob,
> +			const struct object_id *their_blob, const char *path,
> +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mo=
de,
> +			void *data);
> +
>  int merge_index_path(struct index_state *istate, int oneshot, int quiet=
,
>  		     const char *path, merge_fn fn, void *data);
>  int merge_all_index(struct index_state *istate, int oneshot, int quiet,
> diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
> index d0cdfeddc1..d9c07965dc 100755
> --- a/t/t6060-merge-index.sh
> +++ b/t/t6060-merge-index.sh
> @@ -72,7 +72,7 @@ test_expect_success 'merge-one-file fails without a wo=
rk tree' '
>  	(cd bare.git &&
>  	 GIT_INDEX_FILE=3D$PWD/merge.index &&
>  	 export GIT_INDEX_FILE &&
> -	 test_must_fail git merge-index git-merge-one-file -a
> +	 test_must_fail git merge-index --use=3Dmerge-one-file -a
>  	)
>  '
>
> diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-syml=
ink.sh
> index 2ce104aca7..075da1f55f 100755
> --- a/t/t6415-merge-dir-to-symlink.sh
> +++ b/t/t6415-merge-dir-to-symlink.sh
> @@ -97,7 +97,7 @@ test_expect_success SYMLINKS 'a/b was resolved as syml=
ink' '
>  	test -h a/b
>  '
>
> -test_expect_failure 'do not lose untracked in merge (resolve)' '
> +test_expect_success 'do not lose untracked in merge (resolve)' '
>  	git reset --hard &&
>  	git checkout baseline^0 &&
>  	>a/b/c/e &&
> --
> 2.31.0
>
>
