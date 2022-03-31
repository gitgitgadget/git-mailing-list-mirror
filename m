Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FEBC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 02:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352472AbiCaCJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 22:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350504AbiCaCJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 22:09:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3965791
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 19:07:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id c10so26685211ejs.13
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 19:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xs4KogCgPvpgVO+uF/jZQSjebD2sEc8uwjpbAjT3Zd0=;
        b=EF8p71fa1tROpNem3GaJICes/lpx2r8kiv5ap+7qZWxdji9PfbFZ9LmDeVAuGM3Noy
         yQ51NdVdQyYfCipryeqIhczVRrhKWZKp055aI1epOlvl1HDromnoIL6NrKZWeA8fokDs
         SGveF68dU4tDPhOGd/4ysoLA1UsUowILe9cwhbMbQgn4AmnlMFjCoUDZf5lswnr2l480
         0E53eZ+ojThfaCaaBmn1ssbuTwO1CE2/zlzIj0dUIwCgxh0XvdVTBW0KfSHlaCqm6RML
         gHaj175bNCfeLPdyGK+uoFQ9sw7MIVitcMZdnEJRB3nd1HySadxTa9Dxg8jvcePWCh/r
         x6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xs4KogCgPvpgVO+uF/jZQSjebD2sEc8uwjpbAjT3Zd0=;
        b=CMrHCYF5k9vtJpppgxvl/+QWhLNAuDwmVFz+Fs0ZVD8aTGNaT8Zx/ZywUdQca3DYjQ
         V94WdT+s4kaF6RLr+35yWxrtVOoP2tcJ88KhCplQY1n17Ul8CqRThZSCbIGQLIxEpvzS
         qbdbiakiXU3TzoPJuTv6QJZrFIW98nb/FYdx4yLqQd3Cl9Lt5M62J7u7sqwT3DoOuwMF
         aEiSdHjL1OpHZe/ocFnx7X1TKqMdsxmF8yoIS9WO6DWLgjzE9rYz6xdFML4iwtDIlfZH
         aJgSbVI38VFqvLGTLz60W9MFv2iYyVhfsaYtbjcTJBoVNXpUDigo7YEwxj4KxAAp48TV
         Mf3A==
X-Gm-Message-State: AOAM530BCNPFUkWy9Eo39zjwz/lfB+jQqFuOT7F1gj4aZe9L0NBJ49ru
        8FdLWlPqsHBfFusp62gZFfWfr9KqEk1QDQ==
X-Google-Smtp-Source: ABdhPJwVasklo0/nwHsjiaCF5TYLB8Bxafha+S2+5Y6aajy8KB6vbIa+lNKYL+wE6wbIK1Ho84uiWw==
X-Received: by 2002:a17:907:2cc6:b0:6e0:2196:9278 with SMTP id hg6-20020a1709072cc600b006e021969278mr2861758ejc.438.1648692448175;
        Wed, 30 Mar 2022 19:07:28 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fi4-20020a170906da0400b006e4ad0e390fsm134605ejb.176.2022.03.30.19.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:07:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZkDe-0008Uy-L4;
        Thu, 31 Mar 2022 04:07:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/4] builtin/stash: provide a way to export stashes
 to a ref
Date:   Thu, 31 Mar 2022 03:56:01 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-4-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220329214941.2018609-4-sandals@crustytoothpaste.net>
Message-ID: <220331.86pmm2swm9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 29 2022, brian m. carlson wrote:

> A common user problem is how to sync in-progress work to another
> machine.  Users currently must use some sort of transfer of the working
> tree, which poses security risks and also necessarily causes the index
> to become dirty.  The experience is suboptimal and frustrating for
> users.
>
> A reasonable idea is to use the stash for this purpose, but the stash is
> stored in the reflog, not in a ref, and as such it cannot be pushed or
> pulled.  This also means that it cannot be saved into a bundle or
> preserved elsewhere, which is a problem when using throwaway development
> environments.
>
> Let's solve this problem by allowing the user to export the stash to a
> ref (or, to just write it into the repository and print the hash, =C3=A0 =
la
> git commit-tree).  Introduce git stash export, which writes a chain of
> commits where the first parent is always a chain to the previous stash,
> or to a single, empty commit (for the final item) and the second is the
> stash commit normally written to the reflog.
>
> Iterate over each stash from topmost to bottomost, looking up the data
> for each one, and then create the chain from the single empty commit
> back up in reverse order.  Generate a predictable empty commit so our
> behavior is reproducible.  Create a useful commit message, preserving
> the author and committer information, to help users identify stash
> commits when viewing them as normal commits.
>
> If the user has specified specific stashes they'd like to export
> instead, use those instead of iterating over all of the stashes.
>
> As part of this, specifically request quiet behavior when looking up the
> OID for a revision because we will eventually hit a revision that
> doesn't exist and we don't want to die when that occurs.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/git-stash.txt |  22 ++++-
>  builtin/stash.c             | 183 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 204 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 6e15f47525..162110314e 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -20,6 +20,7 @@ SYNOPSIS
>  'git stash' clear
>  'git stash' create [<message>]
>  'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
> +'git stash' export ( --print | --to-ref <ref> ) [<stash>...]
>=20=20
>  DESCRIPTION
>  -----------
> @@ -151,6 +152,12 @@ store::
>  	reflog.  This is intended to be useful for scripts.  It is
>  	probably not the command you want to use; see "push" above.
>=20=20
> +export ( --print | --to-ref <ref> ) [<stash>...]::
> +

I think this extra \n here isn't needed.

> +static const char * const git_stash_export_usage[] =3D {
> +	N_("git stash export (--print | --to-ref <ref>) [<stash>...]"),
> +	NULL
> +};
> +
> +

Stray too-much-whitespace.

>  static const char ref_stash[] =3D "refs/stash";
>  static struct strbuf stash_index_path =3D STRBUF_INIT;
>=20=20
> @@ -1773,6 +1780,180 @@ static int save_stash(int argc, const char **argv=
, const char *prefix)
>  	return ret;
>  }
>=20=20
> +static int write_commit_with_parents(struct object_id *out, const struct=
 object_id *oid, struct commit_list *parents)
> +{
> +	size_t author_len, committer_len;
> +	struct commit *this;
> +	const char *orig_author, *orig_committer;
> +	char *author =3D NULL, *committer =3D NULL;
> +	const char *buffer;
> +	unsigned long bufsize;
> +	const char *p;
> +	struct strbuf msg =3D STRBUF_INIT;
> +	int ret =3D 0;

With this...

> +	this =3D lookup_commit_reference(the_repository, oid);
> +	buffer =3D get_commit_buffer(this, &bufsize);
> +	orig_author =3D find_commit_header(buffer, "author", &author_len);
> +	orig_committer =3D find_commit_header(buffer, "committer", &committer_l=
en);
> +	p =3D memmem(buffer, bufsize, "\n\n", 2);
> +
> +	if (!orig_author || !orig_committer || !p) {
> +		error(_("cannot parse commit %s"), oid_to_hex(oid));
> +		goto out;

..isn't this a logic error, shouldn't we return -1 here?

> +	}
> +	/* Jump to message. */
> +	p +=3D 2;
> +	strbuf_addstr(&msg, "git stash: ");
> +	strbuf_add(&msg, p, bufsize - (p - buffer));
> +
> +	author =3D xmemdupz(orig_author, author_len);
> +	committer =3D xmemdupz(orig_committer, committer_len);
> +
> +	if (commit_tree_extended(msg.buf, msg.len,
> +				 the_hash_algo->empty_tree, parents,
> +				 out, author, committer,
> +				 NULL, NULL)) {
> +		ret =3D -1;
> +		error(_("could not write commit"));

better as "ret =3D error(..."?

> +		goto out;
> +	}
> +out:
> +	strbuf_reset(&msg);
> +	unuse_commit_buffer(this, buffer);
> +	free(author);
> +	free(committer);
> +	return ret;
> +}
> +
> +static int do_export_stash(const char *ref, size_t argc, const char **ar=
gv)
> +{
> +	struct object_id base;
> +	struct object_context unused;
> +	struct commit *prev;
> +	struct object_id *items =3D NULL;
> +	int nitems =3D 0, nalloc =3D 0;

Can nalloc be moved into the if=3Delse scopes?

Also shouldn't these be size_t...?

> +	int res =3D 0;
> +	struct strbuf revision;
> +	const char *author, *committer;
> +
> +	/*
> +	 * This is an arbitrary, fixed date, specifically the one used by git
> +	 * format-patch.  The goal is merely to produce reproducible output.
> +	 */
> +	prepare_fallback_ident("git stash", "git@stash");
> +	author =3D fmt_ident("git stash", "git@stash", WANT_BLANK_IDENT, "2001-=
09-17T00:00:00Z", 0);
> +	committer =3D fmt_ident("git stash", "git@stash", WANT_BLANK_IDENT, "20=
01-09-17T00:00:00Z", 0);
> +
> +	/* First, we create a single empty commit. */
> +	if (commit_tree_extended(NULL, 0, the_hash_algo->empty_tree, NULL, &bas=
e, author, committer, NULL, NULL))

Some very long lines here.

> +		return error(_("unable to write base commit"));
> +
> +	prev =3D lookup_commit_reference(the_repository, &base);
> +
> +	if (argc) {
> +		/*
> +		 * Find each specified stash, and load data into the array.
> +		 */
> +		for (int i =3D 0; i < argc; i++) {

...as this is size_t, not int.

> +			ALLOC_GROW_BY(items, nitems, 1, nalloc);
> +			if (parse_revision(&revision, argv[i], 0) ||
> +			    get_oid_with_context(the_repository, revision.buf,
> +						 GET_OID_QUIETLY | GET_OID_GENTLY,
> +						 &items[i], &unused)) {
> +				error(_("unable to find stash entry %s"), argv[i]);
> +				res =3D -1;

ditto "ret =3D error(..."
> +				goto out;
> +			}
> +		}
> +	} else {
> +		/*
> +		 * Walk the reflog, finding each stash entry, and load data into the
> +		 * array.
> +		 */
> +		for (int i =3D 0;; i++) {

Aside from the C99 dependency Junio mentioned, this should also be size_t.

> +	/*
> +	 * Now, create a set of commits identical to the regular stash commits,
> +	 * but where their first parents form a chain to our original empty
> +	 * base commit.
> +	 */
> +	for (int i =3D nitems - 1; i >=3D 0; i--) {

Did you spot my "count down" suggestion in
https://lore.kernel.org/git/220311.86bkydi65v.gmgdl@evledraar.gmail.com/
on the v1?

> +		struct commit_list *parents =3D NULL;
> +		struct commit_list **next =3D &parents;
> +		struct object_id out;
> +
> +		next =3D commit_list_append(prev, next);
> +		next =3D commit_list_append(lookup_commit_reference(the_repository, &i=
tems[i]), next);
> +		if (write_commit_with_parents(&out, &items[i], parents)) {

Here we returned -1 from this earlier, I think this would be more
straightforward as:
=09
	res =3D write_commit_with_parents(...)
	if (res < 0)
		goto out;
=09

> +			res =3D -1;
> +			goto out;

So one doesn't have to wonder why we're ignoring the error value, and
using -1, but then treating all non-zero as errors.

> +		}
> +		prev =3D lookup_commit_reference(the_repository, &out);
> +	}
> +	if (ref)
> +		update_ref(NULL, ref, &prev->object.oid, NULL, 0, UPDATE_REFS_DIE_ON_E=
RR);
> +	else
> +		puts(oid_to_hex(&prev->object.oid));
> +out:
> +	free(items);
> +
> +	return res;
> +}
> +
> +enum export_action {
> +	ACTION_NONE,
> +	ACTION_PRINT,
> +	ACTION_TO_REF,
> +};
> +
> +static int export_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int ret =3D 0;

It looks like we don't need to initialize this.

> +	const char *ref =3D NULL;
> +	enum export_action action =3D ACTION_NONE;
> +	struct option options[] =3D {
> +		OPT_CMDMODE(0, "print", &action,
> +			    N_("print the object ID instead of writing it to a ref"),
> +			    ACTION_PRINT),
> +		OPT_CMDMODE(0, "to-ref", &action,
> +			    N_("save the data to the given ref"),
> +			    ACTION_TO_REF),
> +		OPT_END()
> +	};
> +
> +	argc =3D parse_options(argc, argv, prefix, options,
> +			     git_stash_export_usage,
> +			     PARSE_OPT_KEEP_DASHDASH);
> +
> +	if (action =3D=3D ACTION_NONE) {
> +		return error(_("exactly one of --print and --to-ref is required"));
> +	} else if (action =3D=3D ACTION_TO_REF) {
> +		if (!argc)
> +			return error(_("--to-ref requires an argument"));
> +		ref =3D argv[0];
> +		argc--;
> +		argv++;
> +	}
> +
> +

nit: Too much whitespace

> +	ret =3D do_export_stash(ref, argc, argv);
> +	return ret;

Aside from the "ret" case above, maybe this would be better if the
"action" check became a swith, then the compiler would help check it
against the enum, and this wouldn't implicitly be both ACTION_PRINT and
ACTION_TO_REF, but could be done via a fall-through.

