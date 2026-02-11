Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D735CBBE
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844288; cv=none; b=ncIsbERp68PmMush6wklrkLJEaLXEda3pZt4SKglN/Yd6kuZBdY5jgTeExTA1VN5iO+jBt2OFFzoA6BD6TE472tddFKwXZsWrS23OGxYYFTb9V9RINDNvxqca10dGIeaJxPWpV5wYWuH4pJDbVIPoibiWcT6yy3ITkNOuwXKLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844288; c=relaxed/simple;
	bh=zDDuoNI5q4fQQRulvnsHfUKvKvbID6xo7ELrmQ+l33o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ii0GkXBiTT7yi8TY64XVInf5TwUrhDud18vY3Qo6lgwBaLTm/Yyb2yXIY31B1HAHTq/3R3Pg9Zvxv7okUzuheUqxgxhRBQ+2qUHAif5Xrtc4CihrG6RC46QTgXbf5gGyfqDK4Eby9POBWoVZuAz6Ua3oU2FvYUMBTPQWkk9XdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=rQM4N7s9; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="rQM4N7s9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1770844278; x=1771103478;
	bh=eqyYFcbXwXmDG0pjQ6aXgyrWcnKTil5DygIokfAbCJw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rQM4N7s93/5uTvwEJdfz+9e20aRJ1lBDVjw3ejT5wIXisBfU/E35lXGlsunvk1cCE
	 jZiY3eHPDks10vSo6ub83OM+5V84ISjyCgkjbhiM089ngV6WP6TLmgwjLqN0ZuQn6R
	 4SN29LCxXoSofrDYUOLR69F9V6xl7Bhj/cAwiVCmyfOpTxYPhrwMgs5WBfG22rStmL
	 sfgVEYCRYDHTCz1QgThkcdeK9+YZjdlS0XOUZAg11AA1kWRBvYrXwdNONriNpKfkzF
	 CO+tHywqsSFEm+jYUwEHTCrHi0nuXkmUKp1YHb5tRzgAYrhje3eMfnFDl8iTlN1UC0
	 ztfxuj8v++nsQ==
Date: Wed, 11 Feb 2026 21:11:15 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Chandra <Chandrakr@pm.me>
Cc: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] add: support pre-add hook
Message-ID: <2kX5wTQeOz3VPzUT6QiH_KyB9RMMtf8L3I8N6WtVWHaVQ1ZguBTaqAqFcFgOGpCqv-RJyALKlsENx-g7E3DMx3TzCfZoaRtPEpoDyx6d9kg=@pm.me>
In-Reply-To: <xmqqseb7rre9.fsf@gitster.g>
References: <pull.2045.git.1770737573475.gitgitgadget@gmail.com> <pull.2045.v2.git.1770822312474.gitgitgadget@gmail.com> <xmqqseb7rre9.fsf@gitster.g>
Feedback-ID: 10057713:user:proton
X-Pm-Message-ID: 05e7df63b024bdd1c246c8963d0ab02f6229d01d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> the word pre-add ... would not look good

Originally, I wanted to call these pre-staging hooks. The ugly pre-add word=
ing was an artifact of my attempt to narrow the scope. The goal here was to=
 be as conservative as possible because I thought this concept would be mor=
e controversial. This implementation didn't contain hooks for stash/merge/r=
ebase/cherry-pick, which modify the index in their own ways. It wasn't a ho=
ok for `commit -a` nor reset/checkout/restore either. I felt it excessively=
 ambitious to name this the pre-staging hook, especially as my first contri=
bution.

Ideally however, I think there should be a category of hooks called pre-sta=
ging hooks, with this as the flagship one, and it would make sense, for bot=
h aesthetic and future-proofing reasons, for the githooks docs to use that =
phrasing.=20

> Is it and will it always be only the pre-add hook that this option
> will bypass, or if we ever add another hook that decides to interfere,
> will that hook also be turned off with this option?  This reads like
> the former, but the intent would be the latter, no?

As it stands, the no-verify flag is only used in the guard for the "pre-add=
" hook given the limited scope I aimed for. The implementation could be fut=
ureproofed in a way where a string could be passed to the --no-verify flag,=
 each with a unique boolean to guard different hooks. If the flag is set bu=
t no strings are passed, then we can assume the user wants no hooks to run,=
 and all of them can be disabled. I thought it overengineering to add somet=
hing like that in the initial commit, but am open to doing so.

> What is a special environment variable?

That's hilarious. I suppose there's nothing "special" about them, I only me=
ant to say that no unexpected environment variables were being set or unset=
 by the implementation. It was mostly to distinguish this from the original=
 implementation that passed GIT_INDEX_FILE as an env-var which you correctl=
y noted didn't even make sense. In hindsight, I don't see much value in spe=
lling this out unless anyone thinks it would help users distinguish from pr=
e-commit hooks in some useful way.

> Do we really need to create a copy of this [index] file?=20

Lockfile protocol should prevent index from being modified. It probably cou=
ld be as easy as 1) write proposed index -> index.lock and run the hook wit=
h $1=3Dindex $2=3Dindex.lock. Good point. I'll try this out and push it if =
it works.

> Shouldn't the die() message mirror the wording used there, i.e.,
> "unable to create temporary index" or something, or is this fine, as
> it will become the new index file once the hook approves?=20

Answer depends on how the rewrite without index-copying goes. I'll be more =
conscientious of die messaging in the next commit.

In all, I'd like hooks for pre-staging to be the operative concept here, no=
t pre-add, for more reasons than just the word's poor aesthetics. With inte=
rest/approval, I can change the --no-verify implementation to be more gener=
ic, although I'm not sure if it's worth actually adding any other pre-stagi=
ng hooks yet because I haven't seen anyone ask for anything besides gates b=
efore add.=20

Thanks again

Chandra Kethi-Reddy

Sent with Proton Mail secure email.

On Thursday, February 12th, 2026 at 1:20 AM, Junio C Hamano <gitster@pobox.=
com> wrote:

> "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> > index 6192daeb03..c864ce272d 100644
> > --- a/Documentation/git-add.adoc
> > +++ b/Documentation/git-add.adoc
> > @@ -10,7 +10,7 @@ SYNOPSIS
> >  [synopsis]
> >  git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactiv=
e | -i] [--patch | -p]
> >  =09[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update =
| -u]] [--sparse]
> > -=09[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-miss=
ing] [--renormalize]
> > +=09[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-miss=
ing] [--renormalize] [--no-verify]
> >  =09[--chmod=3D(+|-)x] [--pathspec-from-file=3D<file> [--pathspec-file-=
nul]]
> >  =09[--] [<pathspec>...]
> >
> > @@ -42,6 +42,10 @@ use the `--force` option to add ignored files. If yo=
u specify the exact
> >  filename of an ignored file, `git add` will fail with a list of ignore=
d
> >  files. Otherwise it will silently ignore the file.
> >
> > +A pre-add hook can be run to inspect or reject the proposed index upda=
te
> > +after `git add` computes staging and writes it to the index lockfile,
> > +but before writing it to the final index. See linkgit:githooks[5].
> >
> > +`--no-verify`::
> > +=09Bypass the pre-add hook if it exists. See linkgit:githooks[5] for
> > +=09more information about hooks.
>=20
> I'll leave it up to others to comment on and make concrete
> suggestions for the formatting and markups, but the word pre-add the
> users must use verbatim that is not marked up in any way would not
> look good in the documentation.
>=20
> Is it and will it always be only the pre-add hook that this option
> will bypass, or if we ever add another hook that decides to interfere,
> will that hook also be turned off with this option?  This reads like
> the former, but the intent would be the latter, no?
>=20
> I'll also leve it up to others (including the original author of the
> patch) to propose a better wording here, as I am not good at naming
> things ;-)
>=20
>=20
> > +pre-add
> > +~~~~~~~
> > +
> > +This hook is invoked by linkgit:git-add[1], and can be bypassed with t=
he
> > +`--no-verify` option. It is not invoked for `--interactive`, `--patch`=
,
> > +`--edit`, or `--dry-run`.
> > +
> > +It takes two parameters: the path to a copy of the index before this
> > +invocation of `git add`, and the path to the lockfile containing the
> > +proposed index after staging. It does not read from standard input.
> > +If no index exists yet, the first parameter names a path that does not
> > +exist and should be treated as an empty index. No special environment
> > +variables are set. The hook is invoked after the index has been update=
d
>=20
> What are "special environment variables"?  What happens, for
> example, if the end user has an "special environment variable" set
> and exported when running "git add"---are you unexporting them?
> E.g., Does GIT_INDEX_FILE environment variable visible to the hook
> when you do this ...
>=20
>     $ GIT_INDEX_FILE=3D.git/alt-index git add .
>=20
> ... and if so, what value does it have?
>=20
> In other words, is it worth spelling this "special environment
> variables" thing out?
>=20
> > +=09if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
> > +=09=09int fd_in, status;
> > +=09=09const char *index_file =3D repo_get_index_file(repo);
> > +=09=09char *template;
> > +
> > +=09=09run_pre_add =3D 1;
> > +=09=09template =3D xstrfmt("%s.pre-add.XXXXXX", index_file);
> > +=09=09orig_index =3D xmks_tempfile(template);
> > +=09=09free(template);
> > +
> > +=09=09fd_in =3D open(index_file, O_RDONLY);
> > +=09=09if (fd_in >=3D 0) {
> > +=09=09=09status =3D copy_fd(fd_in, get_tempfile_fd(orig_index));
> > +=09=09=09if (close(fd_in))
> > +=09=09=09=09die_errno(_("unable to close index for pre-add hook"));
> > +=09=09=09if (close_tempfile_gently(orig_index))
> > +=09=09=09=09die_errno(_("unable to close temporary index copy"));
> > +=09=09=09if (status < 0)
> > +=09=09=09=09die(_("failed to copy index for pre-add hook"));
> > +=09=09} else if (errno =3D=3D ENOENT) {
> > +=09=09=09orig_index_path =3D xstrdup(get_tempfile_path(orig_index));
> > +=09=09=09if (delete_tempfile(&orig_index))
> > +=09=09=09=09die_errno(_("unable to remove temporary index copy"));
> > +=09=09} else {
> > +=09=09=09die_errno(_("unable to open index for pre-add hook"));
> > +=09=09}
> > +=09}
>=20
> Do we really need to create a copy of the file?  I am just asking
> without knowing the answer myself, but given that the general
> architecture of file writing used in our codebase, which is to (1)
> prepare a new temporary file, (2) write new contents to that
> temporary file, and then finally (3) rename the temporary file to
> the final location, I would expect that between the time the control
> passes this point and the latter half of write_locked_index() calls
> commit_locked_index(), the original index file would not be touched
> by anybody, and can be readable by the hook.
>=20
> > +=09if (run_pre_add && !exit_status && repo->index->cache_changed) {
> > +=09=09struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
> > +
> > +=09=09if (write_locked_index(repo->index, &lock_file, 0))
> > +=09=09=09die(_("unable to write new index file"));
>=20
> This mimics the pattern used in builtin/commit.c:prepare_index()
> that populates the index file (the real one, when making a
> non-partial commit, or the temporary one when making a partial
> commit), closes it, and let us later commit or roll back depending
> on what happens in between.  Looks sensible (but I have to admit
> that I may have missed resource leakage etc., as I didn't seriously
> look for such flaws).
>=20
> Shouldn't the die() message mirror the wording used there, i.e.,
> "unable to create temporary index" or something, or is this fine, as
> it will become the new index file once the hook approves?  I dunno.
>=20
> Thanks.
>=20
> > +=09=09strvec_push(&opt.args, orig_index ? get_tempfile_path(orig_index=
) :
> > +=09=09=09=09=09     orig_index_path);
> > +=09=09strvec_push(&opt.args, get_lock_file_path(&lock_file));
> > +=09=09if (run_hooks_opt(repo, "pre-add", &opt)) {
> > +=09=09=09rollback_lock_file(&lock_file); /* hook rejected */
> > +=09=09=09exit_status =3D 1;
> > +=09=09} else {
> > +=09=09=09if (commit_lock_file(&lock_file)) /* hook approved */
> > +=09=09=09=09die(_("unable to write new index file"));
> > +=09=09}
> > +=09} else {
> > +=09=09if (write_locked_index(repo->index, &lock_file,
> > +=09=09=09=09       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> > +=09=09=09die(_("unable to write new index file"));
> > +=09}
>=20
> 
