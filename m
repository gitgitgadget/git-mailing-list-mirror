Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDF0C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 18:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59D7610E6
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 18:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbhHYSx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 14:53:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:49729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235732AbhHYSx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 14:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629917548;
        bh=1AMnEj6gij4pUz4/EGKoECAWwixi2QIQHZ7ciZAjGcw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MdP7pkisjY4fz1dVXsh3tb6ovBfxYNEEYhW4/L81SyiMo501+znEyAhj4YY7RMwTk
         aC0nxsUUKpfR9EClxUekcwGAvq1QbEkwwvosSRBZR1BzptIJWmfOt0GCHFAAD1XxDX
         zjy6iX9S83innPjf9Ix8j3Rpqfh0If4tK7TDIPME=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1nFjpm19eE-00yAAO; Wed, 25
 Aug 2021 20:52:28 +0200
Date:   Wed, 25 Aug 2021 20:52:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
In-Reply-To: <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108251551100.55@tvgsbejvaqbjf.bet>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IdytPi21GLEpTgbz2q+W0ps7FkV7LtXgAQfLjRdPaW+o3WkHG+2
 5Rc2ohOGAKuv55P3xTwpnKmnzYEP2IyDSb8LuNlKg0tyIBq6ANUNF0/V4vEw6nz2VRDQCKy
 hbHCH12YwBKDa2QmuSVQRWGqAkagL8laI21CWsV3whBEusiup8sIb9aXHWIVqPAjSOCw4gR
 2kBR9JODxqmaPW3uB9Hng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+fV/Cy5ZYxU=:n9zHvVP05axX2JnO3igoJ2
 M1/OZFtQbghhH60OB4VUdf58R81K7y/0scNThewnDfDq2ECiijJkOPSUW1zjjCKdTL5XEKl4e
 2dpC/ufG4MD+TS1GMyFboG4UPC2zKqD8ADm/VqcPU29hG/afNJ6YtRKCg3h6dv8TlUTz50WP1
 TTPRtDsAfiu0IALMwdc3pX6AxvvjE8QRH6MB6l8vaVFymooZLVPSjQhFKqb8WnBkBnU/QR++t
 Mb9ZEfuirxqB0vrkZsEXX0p8Q6MAwFdq5sWuHmt3fTHGrniOiGd69bBYBfg3PR0erTVFKtY6s
 r4pb8YmcWKGQkVqWhAE+f8c3GYePbL6Z8R5uHf2h0n4+tP9Bzu8KqqYNzzcK2SDFhtDfdYOKi
 dVhHg2tV1cfqX9Pp+CclH48oWbstzu5udwVIdywhP0TIv8NnSVIOK9m4RWr9N7VaS4rz5BDSE
 /K1aiP4OXYP+GuoGcXgn8YxwsMAxA2L9Bpl2aw4EHwkdM18bfso84XLnx8hHrmKQyfyMxLmji
 lwpoVecRDE6L4qTtuZqsw2UtIs82ooDRcfKaQQXr7bQeKuoX+K+6Pn7y8/8yVM6WWvUHGhpmu
 5vj0JM/dVDbgovicmfez4e5vPMPNjUPYJZ7y7Yr/9i1zrjRBYk3ik7cC06LqDsRsPx5DNbYwr
 s1eenFII8ZuopAOzoA0GveFH1Eh1BdsLRm6N6a41JvHOo1nIQJjeQXr0SJnjicBjRKN/YrlJa
 okw1tiJEiQj+3vgy8CaAxRMvmkDBZLxkx8TU6YyBfO6O3gb7+dptLu3cQY01h8PeHKJuM8HAz
 zSsLL7aaVP4lRXFEOmpw3ZFLlmQ+lUdI/nmwaT5XhGGEnELs91KNViVxDLpkTSTfbKCas6X6I
 3cxC5kUrhbMxxLt8fwQIl0pKYaKeTdCDV7tsES/JdGhNKBgiBNzYv28SwQwjEtuKWNSyfHMjR
 9jAeKVnyROdaUfJor2UekPfx0as9l/G5wqHAJnglsRbvvcLBUSI4jcNGBflU+pdXbe43naERe
 foCVfH92kVJ279/dzTaQ6U+xMB4bsJY/5k8uM08cZPxaJqBd0X3CmV1nIfHcSYOESIydX50tv
 c7+nsxqqKGjNmmyEYZBNjE9oh3QkSLEXGWNn/V8EimjzSn7S3kPXNTpfg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Neeraj,

continuing my review here, inlined.

On Wed, 25 Aug 2021, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> When adding many objects to a repo with core.fsyncObjectFiles set to
> true, the cost of fsync'ing each object file can become prohibitive.
>
> One major source of the cost of fsync is the implied flush of the
> hardware writeback cache within the disk drive. Fortunately, Windows,
> MacOS, and Linux each offer mechanisms to write data from the filesystem
> page cache without initiating a hardware flush.
>
> This patch introduces a new 'core.fsyncObjectFiles =3D 2' option that
> takes advantage of the bulk-checkin infrastructure to batch up hardware
> flushes.

It makes sense, but I would recommend using a more easily explained value
than `2`. Maybe `delayed`? Or `bulk` or `batched`?

The way this would be implemented would look somewhat like the
implementation for `core.abbrev`, which also accepts a string ("auto") or
a Boolean (or even an integral number), see
https://github.com/git/git/blob/v2.33.0/config.c#L1367-L1381:

	if (!strcmp(var, "core.abbrev")) {
		if (!value)
			return config_error_nonbool(var);
		if (!strcasecmp(value, "auto"))
			default_abbrev =3D -1;
		else if (!git_parse_maybe_bool_text(value))
			default_abbrev =3D the_hash_algo->hexsz;
		else {
			int abbrev =3D git_config_int(var, value);
			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
				return error(_("abbrev length out of range: %d"), abbrev);
			default_abbrev =3D abbrev;
		}
		return 0;
	}

> When the new mode is enabled we do the following for new objects:
>
> 1. Create a tmp_obj_XXXX file and write the object data to it.
> 2. Issue a pagecache writeback request and wait for it to complete.
> 3. Record the tmp name and the final name in the bulk-checkin state for
>    later name.
>
> At the end of the entire transaction we:
> 1. Issue a fsync against the lock file to flush the hardware writeback
>    cache, which should by now have processed the tmp file writes.
> 2. Rename all of the temp files to their final names.
> 3. When updating the index and/or refs, we will issue another fsync
>    internal to that operation.
>
> On a filesystem with a singular journal that is updated during name
> operations (e.g. create, link, rename, etc), such as NTFS and HFS+, we
> would expect the fsync to trigger a journal writeout so that this
> sequence is enough to ensure that the user's data is durable by the time
> the git command returns.
>
> This change also updates the MacOS code to trigger a real hardware flush
> via fnctl(fd, F_FULLFSYNC) when fsync_or_die is called. Previously, on
> MacOS there was no guarantee of durability since a simple fsync(2) call
> does not flush any hardware caches.

You included a very nice table with performance numbers in the cover
letter. Maybe include that here, in the commit message?

> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  Documentation/config/core.txt |  17 ++++--
>  Makefile                      |   4 ++
>  builtin/add.c                 |   3 +-
>  builtin/update-index.c        |   3 +
>  bulk-checkin.c                | 105 +++++++++++++++++++++++++++++++---
>  bulk-checkin.h                |   4 +-
>  config.c                      |   4 +-
>  config.mak.uname              |   2 +
>  configure.ac                  |   8 +++
>  git-compat-util.h             |   7 +++
>  object-file.c                 |  12 +---
>  wrapper.c                     |  36 ++++++++++++
>  write-or-die.c                |   2 +-
>  13 files changed, 177 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.t=
xt
> index c04f62a54a1..3b672c2db67 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -548,12 +548,17 @@ core.whitespace::
>    errors. The default tab width is 8. Allowed values are 1 to 63.
>
>  core.fsyncObjectFiles::
> -	This boolean will enable 'fsync()' when writing object files.
> -+
> -This is a total waste of time and effort on a filesystem that orders
> -data writes properly, but can be useful for filesystems that do not use
> -journalling (traditional UNIX filesystems) or that only journal metadat=
a
> -and not file contents (OS X's HFS+, or Linux ext3 with "data=3Dwritebac=
k").
> +	A boolean value or the number '2', indicating the level of durability
> +	applied to object files.
> ++
> +This setting controls how much effort Git makes to ensure that data add=
ed to
> +the object store are durable in the case of an unclean system shutdown.=
 If

In addition to the content, I also like a lot that this tempers down the
language to be a lot more agreeable to read.

> +'false', Git allows data to remain in file system caches according to o=
perating
> +system policy, whence they may be lost if the system loses power or cra=
shes. A
> +value of 'true' instructs Git to force objects to stable storage immedi=
ately
> +when they are added to the object store. The number '2' is an experimen=
tal
> +value that also preserves durability but tries to perform hardware flus=
hes in a
> +batch.
>
>  core.preloadIndex::
>  	Enable parallel index preload for operations like 'git diff'
> diff --git a/Makefile b/Makefile
> index 9573190f1d7..cb950ee43d3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1896,6 +1896,10 @@ ifdef HAVE_CLOCK_MONOTONIC
>  	BASIC_CFLAGS +=3D -DHAVE_CLOCK_MONOTONIC
>  endif
>
> +ifdef HAVE_SYNC_FILE_RANGE
> +	BASIC_CFLAGS +=3D -DHAVE_SYNC_FILE_RANGE
> +endif
> +
>  ifdef NEEDS_LIBRT
>  	EXTLIBS +=3D -lrt
>  endif
> diff --git a/builtin/add.c b/builtin/add.c
> index 09e684585d9..c58dfcd4bc3 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -670,7 +670,8 @@ int cmd_add(int argc, const char **argv, const char =
*prefix)
>
>  	if (chmod_arg && pathspec.nr)
>  		exit_status |=3D chmod_pathspec(&pathspec, chmod_arg[0], show_only);
> -	unplug_bulk_checkin();
> +
> +	unplug_bulk_checkin(&lock_file);
>
>  finish:
>  	if (write_locked_index(&the_index, &lock_file,
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index f1f16f2de52..64d025cf49e 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -5,6 +5,7 @@
>   */
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
> +#include "bulk-checkin.h"
>  #include "config.h"
>  #include "lockfile.h"
>  #include "quote.h"
> @@ -1152,6 +1153,7 @@ int cmd_update_index(int argc, const char **argv, =
const char *prefix)
>  		struct strbuf unquoted =3D STRBUF_INIT;
>
>  		setup_work_tree();
> +		plug_bulk_checkin();
>  		while (getline_fn(&buf, stdin) !=3D EOF) {
>  			char *p;
>  			if (!nul_term_line && buf.buf[0] =3D=3D '"') {
> @@ -1166,6 +1168,7 @@ int cmd_update_index(int argc, const char **argv, =
const char *prefix)
>  				chmod_path(set_executable_bit, p);
>  			free(p);
>  		}
> +		unplug_bulk_checkin(&lock_file);
>  		strbuf_release(&unquoted);
>  		strbuf_release(&buf);
>  	}

This change to `cmd_update_index()`, would it make sense to separate it
out into its own commit? I think it would, as it is a slight change of
behavior of the `--stdin` mode, no?

> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index b023d9959aa..71004db863e 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -3,6 +3,7 @@
>   */
>  #include "cache.h"
>  #include "bulk-checkin.h"
> +#include "lockfile.h"
>  #include "repository.h"
>  #include "csum-file.h"
>  #include "pack.h"
> @@ -10,6 +11,17 @@
>  #include "packfile.h"
>  #include "object-store.h"
>
> +struct object_rename {
> +	char *src;
> +	char *dst;
> +};
> +
> +static struct bulk_rename_state {
> +	struct object_rename *renames;
> +	uint32_t alloc_renames;
> +	uint32_t nr_renames;
> +} bulk_rename_state;
> +
>  static struct bulk_checkin_state {
>  	unsigned plugged:1;
>
> @@ -21,13 +33,15 @@ static struct bulk_checkin_state {
>  	struct pack_idx_entry **written;
>  	uint32_t alloc_written;
>  	uint32_t nr_written;
> -} state;
> +
> +} bulk_checkin_state;

While it definitely looks better after this patch, having the new code
_and_ the rename in the same set of changes makes it a bit harder to
review and to spot bugs.

Could I ask you to split this rename out into its own, preparatory patch
("preparatory" meaning that it should be ordered before the patch that
adds support for the new fsync mode)?

>
>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  {
>  	struct object_id oid;
>  	struct strbuf packname =3D STRBUF_INIT;
>  	int i;
> +	unsigned old_plugged;

Since this variable is designed to hold the value of the `plugged` field
of the `bulk_checkin_state`, which is declared as `unsigned plugged:1;`,
we probably want a `:1` here, too.

Also: is it really "old", rather than "orig"? I would have expected the
name `orig_plugged` or `save_plugged`.

>
>  	if (!state->f)
>  		return;
> @@ -55,13 +69,42 @@ static void finish_bulk_checkin(struct bulk_checkin_=
state *state)
>
>  clear_exit:
>  	free(state->written);
> +	old_plugged =3D state->plugged;
>  	memset(state, 0, sizeof(*state));
> +	state->plugged =3D old_plugged;

Unfortunately, I lack the context to understand the purpose of this. Is
the idea that `plugged` gives an indication whether we're still within
that batch that should be fsync'ed all at once?

I only see one caller where this would make a difference, and that caller
is `deflate_to_pack()`. Maybe we should just start that function with
`unsigned save_plugged:1 =3D state->plugged;` and restore it after the
`while (1)` loop?

>
>  	strbuf_release(&packname);
>  	/* Make objects we just wrote available to ourselves */
>  	reprepare_packed_git(the_repository);
>  }
>
> +static void do_sync_and_rename(struct bulk_rename_state *state, struct =
lock_file *lock_file)
> +{
> +	if (state->nr_renames) {
> +		int i;
> +
> +		/*
> +		 * Issue a full hardware flush against the lock file to ensure
> +		 * that all objects are durable before any renames occur.
> +		 * The code in fsync_and_close_loose_object_bulk_checkin has
> +		 * already ensured that writeout has occurred, but it has not
> +		 * flushed any writeback cache in the storage hardware.
> +		 */
> +		fsync_or_die(get_lock_file_fd(lock_file), get_lock_file_path(lock_fil=
e));
> +
> +		for (i =3D 0; i < state->nr_renames; i++) {
> +			if (finalize_object_file(state->renames[i].src, state->renames[i].ds=
t))
> +				die_errno(_("could not rename '%s'"), state->renames[i].src);
> +
> +			free(state->renames[i].src);
> +			free(state->renames[i].dst);
> +		}
> +
> +		free(state->renames);
> +		memset(state, 0, sizeof(*state));

Hmm. There is a lot of `memset()`ing going on, and I am not quite sure
that I like what I am seeing. It does not help that there are now two very
easily-confused structs: `bulk_rename_state` and `bulk_checkin_state`.
Which made me worried at first that we might be resetting the `renames`
field inadvertently in `finish_bulk_checkin()`.

Maybe we can do this instead?

		FREE_AND_NULL(state->renames);
		state->nr_renames =3D state->alloc_renames =3D 0;

> +	}
> +}
> +
>  static int already_written(struct bulk_checkin_state *state, struct obj=
ect_id *oid)
>  {
>  	int i;
> @@ -256,25 +299,69 @@ static int deflate_to_pack(struct bulk_checkin_sta=
te *state,
>  	return 0;
>  }
>
> +static void add_rename_bulk_checkin(struct bulk_rename_state *state,
> +				    const char *src, const char *dst)
> +{
> +	struct object_rename *rename;
> +
> +	ALLOC_GROW(state->renames, state->nr_renames + 1, state->alloc_renames=
);
> +
> +	rename =3D &state->renames[state->nr_renames++];
> +	rename->src =3D xstrdup(src);
> +	rename->dst =3D xstrdup(dst);
> +}
> +
> +int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfi=
le,
> +					      const char *filename)
> +{
> +	if (fsync_object_files) {
> +		/*
> +		 * If we have a plugged bulk checkin, we issue a call that
> +		 * cleans the filesystem page cache but avoids a hardware flush
> +		 * command. Later on we will issue a single hardware flush
> +		 * before renaming files as part of do_sync_and_rename.
> +		 */
> +		if (bulk_checkin_state.plugged &&
> +		    fsync_object_files =3D=3D 2 &&
> +		    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >=3D 0) {
> +			add_rename_bulk_checkin(&bulk_rename_state, tmpfile, filename);
> +			if (close(fd))
> +				die_errno(_("error when closing loose object file"));
> +
> +			return 0;
> +
> +		} else {
> +			fsync_or_die(fd, "loose object file");
> +		}
> +	}
> +
> +	if (close(fd))
> +		die_errno(_("error when closing loose object file"));
> +
> +	return finalize_object_file(tmpfile, filename);
> +}
> +
>  int index_bulk_checkin(struct object_id *oid,
>  		       int fd, size_t size, enum object_type type,
>  		       const char *path, unsigned flags)
>  {
> -	int status =3D deflate_to_pack(&state, oid, fd, size, type,
> +	int status =3D deflate_to_pack(&bulk_checkin_state, oid, fd, size, typ=
e,
>  				     path, flags);
> -	if (!state.plugged)
> -		finish_bulk_checkin(&state);
> +	if (!bulk_checkin_state.plugged)
> +		finish_bulk_checkin(&bulk_checkin_state);
>  	return status;
>  }
>
>  void plug_bulk_checkin(void)
>  {
> -	state.plugged =3D 1;
> +	bulk_checkin_state.plugged =3D 1;
>  }
>
> -void unplug_bulk_checkin(void)
> +void unplug_bulk_checkin(struct lock_file *lock_file)
>  {
> -	state.plugged =3D 0;
> -	if (state.f)
> -		finish_bulk_checkin(&state);
> +	bulk_checkin_state.plugged =3D 0;
> +	if (bulk_checkin_state.f)
> +		finish_bulk_checkin(&bulk_checkin_state);
> +
> +	do_sync_and_rename(&bulk_rename_state, lock_file);
>  }
> diff --git a/bulk-checkin.h b/bulk-checkin.h
> index b26f3dc3b74..8efb01ed669 100644
> --- a/bulk-checkin.h
> +++ b/bulk-checkin.h
> @@ -6,11 +6,13 @@
>
>  #include "cache.h"
>
> +int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfi=
le, const char *filename);
> +
>  int index_bulk_checkin(struct object_id *oid,
>  		       int fd, size_t size, enum object_type type,
>  		       const char *path, unsigned flags);
>
>  void plug_bulk_checkin(void);
> -void unplug_bulk_checkin(void);
> +void unplug_bulk_checkin(struct lock_file *);
>
>  #endif
> diff --git a/config.c b/config.c
> index f33abeab851..375bdb24b0a 100644
> --- a/config.c
> +++ b/config.c
> @@ -1509,7 +1509,9 @@ static int git_default_core_config(const char *var=
, const char *value, void *cb)
>  	}
>
>  	if (!strcmp(var, "core.fsyncobjectfiles")) {
> -		fsync_object_files =3D git_config_bool(var, value);
> +		int is_bool;
> +
> +		fsync_object_files =3D git_config_bool_or_int(var, value, &is_bool);
>  		return 0;
>  	}
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 69413fb3dc0..8c07f2265a8 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -53,6 +53,7 @@ ifeq ($(uname_S),Linux)
>  	HAVE_CLOCK_MONOTONIC =3D YesPlease
>  	# -lrt is needed for clock_gettime on glibc <=3D 2.16
>  	NEEDS_LIBRT =3D YesPlease
> +	HAVE_SYNC_FILE_RANGE =3D YesPlease
>  	HAVE_GETDELIM =3D YesPlease
>  	SANE_TEXT_GREP=3D-a
>  	FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
> @@ -133,6 +134,7 @@ ifeq ($(uname_S),Darwin)
>  	COMPAT_OBJS +=3D compat/precompose_utf8.o
>  	BASIC_CFLAGS +=3D -DPRECOMPOSE_UNICODE
>  	BASIC_CFLAGS +=3D -DPROTECT_HFS_DEFAULT=3D1
> +	BASIC_CFLAGS +=3D -DFSYNC_DOESNT_FLUSH=3D1
>  	HAVE_BSD_SYSCTL =3D YesPlease
>  	FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
>  	HAVE_NS_GET_EXECUTABLE_PATH =3D YesPlease
> diff --git a/configure.ac b/configure.ac
> index 031e8d3fee8..c711037d625 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1090,6 +1090,14 @@ AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
>  	[AC_MSG_RESULT([no])
>  	HAVE_CLOCK_MONOTONIC=3D])
>  GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])
> +
> +#
> +# Define HAVE_SYNC_FILE_RANGE=3DYesPlease if sync_file_range is availab=
le.
> +GIT_CHECK_FUNC(sync_file_range,
> +	[HAVE_SYNC_FILE_RANGE=3DYesPlease],
> +	[HAVE_SYNC_FILE_RANGE])
> +GIT_CONF_SUBST([HAVE_SYNC_FILE_RANGE])
> +
>  #
>  # Define NO_SETITIMER if you don't have setitimer.
>  GIT_CHECK_FUNC(setitimer,
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b46605300ab..d14e2436276 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1210,6 +1210,13 @@ __attribute__((format (printf, 1, 2))) NORETURN
>  void BUG(const char *fmt, ...);
>  #endif
>
> +enum fsync_action {
> +    FSYNC_WRITEOUT_ONLY,
> +    FSYNC_HARDWARE_FLUSH
> +};
> +
> +int git_fsync(int fd, enum fsync_action action);
> +
>  /*
>   * Preserves errno, prints a message, but gives no warning for ENOENT.
>   * Returns 0 on success, which includes trying to unlink an object that=
 does
> diff --git a/object-file.c b/object-file.c
> index 607e9e2f80b..5f04143dde0 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1859,16 +1859,6 @@ int hash_object_file(const struct git_hash_algo *=
algo, const void *buf,
>  	return 0;
>  }
>
> -/* Finalize a file on disk, and close it. */
> -static int close_loose_object(int fd, const char *tmpfile, const char *=
filename)
> -{
> -	if (fsync_object_files)
> -		fsync_or_die(fd, "loose object file");
> -	if (close(fd) !=3D 0)
> -		die_errno(_("error when closing loose object file"));
> -	return finalize_object_file(tmpfile, filename);
> -}
> -
>  /* Size of directory component, including the ending '/' */
>  static inline int directory_size(const char *filename)
>  {
> @@ -1982,7 +1972,7 @@ static int write_loose_object(const struct object_=
id *oid, char *hdr,
>  			warning_errno(_("failed futimes() on %s"), tmp_file.buf);
>  	}
>
> -	return close_loose_object(fd, tmp_file.buf, filename.buf);
> +	return fsync_and_close_loose_object_bulk_checkin(fd, tmp_file.buf, fil=
ename.buf);
>  }
>
>  static int freshen_loose_object(const struct object_id *oid)
> diff --git a/wrapper.c b/wrapper.c
> index 563ad590df1..37a8b61a7df 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -538,6 +538,42 @@ int xmkstemp_mode(char *filename_template, int mode=
)
>  	return fd;
>  }
>
> +int git_fsync(int fd, enum fsync_action action)
> +{
> +	if (action =3D=3D FSYNC_WRITEOUT_ONLY) {
> +#ifdef __APPLE__
> +		/*
> +		 * on Mac OS X, fsync just causes filesystem cache writeback but does=
 not
> +		 * flush hardware caches.
> +		 */
> +		return fsync(fd);
> +#endif
> +
> +#ifdef HAVE_SYNC_FILE_RANGE
> +		/*
> +		 * On linux 2.6.17 and above, sync_file_range is the way to issue
> +		 * a writeback without a hardware flush. An offset of 0 and size of 0
> +		 * indicates writeout of the entire file and the wait flags ensure th=
at all
> +		 * dirty data is written to the disk (potentially in a disk-side cach=
e)
> +		 * before we continue.
> +		 */
> +
> +		return sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
> +						 SYNC_FILE_RANGE_WRITE |
> +						 SYNC_FILE_RANGE_WAIT_AFTER);
> +#endif
> +
> +		errno =3D ENOSYS;
> +		return -1;
> +	}

Hmm. I wonder whether we can do this more consistently with how Git
usually does platform-specific things.

In the 3rd patch, the one where you implemented Windows-specific support,
in the Git for Windows PR at
https://github.com/git-for-windows/git/pull/3391, you introduce a
`mingw_fsync_no_flush()` function and define `fsync_no_flush` to expand to
that function name.

This is very similar to how Git does things. Take for example the
`offset_1st_component` macro:
https://github.com/git/git/blob/v2.33.0/git-compat-util.h#L386-L392

Unless defined in a platform-specific manner, it is defined in
`git-compat-util.h`:

	#ifndef offset_1st_component
	static inline int git_offset_1st_component(const char *path)
	{
		return is_dir_sep(path[0]);
	}
	#define offset_1st_component git_offset_1st_component
	#endif

And on Windows, it is defined as following
(https://github.com/git/git/blob/v2.33.0/compat/win32/path-utils.h#L34-L35=
),
before the lines quoted above:

	int win32_offset_1st_component(const char *path);
	#define offset_1st_component win32_offset_1st_component

We could do the exact same thing here. Define a platform-specific
`mingw_fsync_no_flush()` in `compat/mingw.h` and define the macro
`fsync_no_flush` to point to it. In `git-compat-util.h`, in the
`__APPLE__`-specific part, implement it via `fsync()`. And later, in the
platform-independent part, _iff_ the macro has not yet been defined,
implement an inline function that does that `HAVE_SYNC_FILE_RANGE` dance
and falls back to `ENOSYS`.

That would contain the platform-specific `#ifdef` blocks to
`git-compat-util.h`, which is exactly where we want them.

> +
> +#ifdef __APPLE__
> +	return fcntl(fd, F_FULLFSYNC);
> +#else
> +	return fsync(fd);
> +#endif

Same thing here. We would probably want something like `fsync_with_flush`
here.

It is my hope that you find my comments and suggestions helpful.

Thank you,
Johannes

> +}
> +
>  static int warn_if_unremovable(const char *op, const char *file, int rc=
)
>  {
>  	int err;
> diff --git a/write-or-die.c b/write-or-die.c
> index d33e68f6abb..8f53953d4ab 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -57,7 +57,7 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
>
>  void fsync_or_die(int fd, const char *msg)
>  {
> -	while (fsync(fd) < 0) {
> +	while (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0) {
>  		if (errno !=3D EINTR)
>  			die_errno("fsync error on '%s'", msg);
>  	}
> --
> gitgitgadget
>
