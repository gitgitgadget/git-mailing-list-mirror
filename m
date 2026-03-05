Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3084382366
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710831; cv=none; b=BjuJ1lkNlvgQF4wwXMXl/mFqKkDexQihyhshkGdYUSXdDcUBgWLQ3+fA/4kvtOr8o+rmWmLrekS49Noojs5mRymVNdF6k8QhXqAALd8FZoyMkv/b3UMd9/OojgfHfGuGv/0PSNGyzVu+6VbNubk6c2YWcES9TCrejCEvkWAuAII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710831; c=relaxed/simple;
	bh=c/esq5rzIoL6v5xZEtjG5ZqsYuKbJdwO3buvkc4iIuo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4wSbr3V6dtbNdYGPTEOtUlhS9Rt+m7FftWGfKovU8DsvM2c5idi4wA8FqCb27K5jKxTx+rm0ZOKXah70rbNqpBkQSFDvnu6QFBhnVNBeZXPwenE1+vBv3S8crqWS+MfjcFGK7CCCMtZNwB2jQGUtzMCjL9zmOddP8oKnkudc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aXSTNnQq; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aXSTNnQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1772710818; x=1772970018;
	bh=XC/szvYA3D2H/WtdZZbQqw0elX9xwv/TpcvDBooDNk4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aXSTNnQq9GgO+22+Pn2k5EDSuF28Q1trvJ054Ld2X8eN4BP/eiv5yxqcgKf6Gry7z
	 pEEtjRDoEhVyR6WpQZAP5CNmPkeKZ1Q/7sIH+CDQ46H4T/lRNYx4PLYY0qRx3EPvV5
	 SwR2An4wMBcFj354De1kp7zIZRKpF1VvvJfarLjA4XiZFAWyDuB/vyS/V3LJBQ1WYq
	 JvAafw8IaHQTQE04rHHphSeOKQR/xp6mfLZyUJP/znTCN3eRg6iaEK7AdCyPZG8VtR
	 QR1piOngbYYJO+IQIaHpdN+KA/b7HbyEiDMPqsEqDLZqOF4yEyBw8MisYZ1ePaOr0f
	 IWQBZh/PvvzKA==
Date: Thu, 05 Mar 2026 11:40:13 +0000
To: phillip.wood@dunelm.org.uk
From: Chandra <Chandrakr@pm.me>
Cc: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v4] add: support pre-add hook
Message-ID: <bZlAfG-eGF23RvwXtNxPW4pMGpvnbN9ka2zffmvqFklilQcvMddz6N4K5zajvz3cRPeswIxWkKtXx4fk5DSA1Jq4b6teJN-6nMsAAPp4bkg=@pm.me>
In-Reply-To: <27ee9a9c-0caa-4b6e-a968-51c71c8b6e5f@gmail.com>
References: <pull.2045.v2.git.1770822312474.gitgitgadget@gmail.com> <pull.2045.v3.git.1772171692465.gitgitgadget@gmail.com> <27ee9a9c-0caa-4b6e-a968-51c71c8b6e5f@gmail.com>
Feedback-ID: 10057713:user:proton
X-Pm-Message-ID: 4db20a95b977578a5b8def12febf7ad43c9e1eeb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hello all,

Thank you for your responses. I have incorporated all your documentation an=
d code refactoring feedback. Excessive implementation detail commentary has=
 been removed. A helper function has been added and the extra free removed.=
=20

I have also CC'd Adrian Ratiu, who I believe led the hooks config file and =
parallelization additions. Please let me know if anything for this pre-add =
hook would need to be updated to make the most of your work, which I apprec=
iate.

Chandra Kethi-Reddy
@archonphronesis:matrix.org

Sent with Proton Mail secure email.

On Thursday, March 5th, 2026 at 4:20 PM, Phillip Wood <phillip.wood123@gmai=
l.com> wrote:

> On 27/02/2026 05:54, Chandra Kethi-Reddy via GitGitGadget wrote:
> > From: Chandra Kethi-Reddy <chandrakr@pm.me>
> >
> > "git add" has no hook that lets users inspect what is about to be
> > staged. Users who want to reject certain paths or content must
> > wrap the command in a shell alias or wait for pre-commit, which
> > fires too late to prevent staging.
> >
> > Introduce a "pre-add" hook that runs after "git add" computes the
> > new index state but before committing it to disk. The hook
> > receives two positional arguments:
> >
> >    $1 -- index path used by this invocation (may not exist yet)
>=20
> Does this mean 'the index state before running "git add"'?
>=20
> >    $2 -- lockfile path containing proposed staged index state
> >
> > While the lockfile is active the current index path remains readable
> > and unchanged, so a seperate copy is unnecessary. Hook authors can
> > inspect the computed result with ordinary tools:
> >
> >    GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD
>=20
> If I understand the definition of "$2" above correctly this will show
> all the paths that have been staged since the last commit, not just the
> paths that are staged by the current invocation of "git add". That means
> if for some reason I need to bypass the hook when running "git add" I'll
> have to bypass it every time until I commit and cannot check the other
> changes that I'm staging. It also means that running "git add" several
> times, each with a different path runs the hook multiple times on the
> same content.
>=20
> To get the list of paths that have changed since the last invocation of
> "git add" you'd need to diff against the other index which isn't
> possible to do directly. If there are no unmerged paths you can write a
> tree but if there are unmerged paths "git write-tree" will fail and so
> you cannot use things like "git diff --check" and have to fall back to
> inspecting the changes by running "git diff-index --cached" on each
> index, munging them together and feeding that into "git diff-pairs"
>=20
> >
> > without needing to interpret pathspec or mode flags as the proposed
> > index already reflects their effect.
> >
> > The hook is bypassed with "--no-verify" and is not invoked for
> > --interactive, --patch, --edit, or --dry-run, nor by "git commit -a"
> > which stages through its own code path.
>=20
> These caveats are rather unfortunate as it means to be sure that staged
> changes get checked I have to duplicate the "pre-add" checks in the
> "pre-commit" hook which is rather inefficient. It would be very nice to
> be able to check changes as they're staged rather than just before they
> are committed but I can't help feeling that what's proposed here is
> driven by ease of implementation which leads to a rather incoherent user
> experience.
>=20
> Thanks
>=20
> Phillip
>=20
> >
> > Signed-off-by: Chandra Kethi-Reddy <chandrakr@pm.me>
> > ---
> >      add: support pre-add hook
> >
> >
> >      Summary
> >      =3D=3D=3D=3D=3D=3D=3D
> >
> >       * v3 switches pre-add inputs to stable paths ($1 index, $2 lockfi=
le)
> >         and removes copy-specific tempfile logic
> >       * v3 fixes mixed-result gating so the hook runs whenever index co=
ntent
> >         changed, even if git add returned non-zero
> >       * v3 adds SKIP_INDEX_CHANGE_HOOK flag to write_locked_index() so =
that
> >         post-index-change is not fired while the lockfile is still on d=
isk
> >
> >
> >      Notes
> >      =3D=3D=3D=3D=3D
> >
> >       * This design intentionally trades ODB prevention for correctness=
 of
> >         hook inputs: blobs may already be written to object storage whe=
n the
> >         hook runs, but hook rejection still leaves the on-disk index
> >         unchanged
> >       * AI Disclosure: Codex and Claude Code CLI were used to assist
> >         drafting. All tests, code, and docs were committed by hand.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2045%=
2Fshatachandra%2Fpre-add-hooks-v3
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2045/sha=
tachandra/pre-add-hooks-v3
> > Pull-Request: https://github.com/gitgitgadget/git/pull/2045
> >
> > Range-diff vs v2:
> >
> >   1:  10244150e24 ! 1:  d0fb5f9da21 add: support pre-add hook
> >       @@ Commit message
> >            "git add" has no hook that lets users inspect what is about =
to be
> >            staged. Users who want to reject certain paths or content mu=
st
> >            wrap the command in a shell alias or wait for pre-commit, wh=
ich
> >       -    fires after staging is already done and objects may already =
be in
> >       -    the object database.
> >       +    fires too late to prevent staging.
> >
> >            Introduce a "pre-add" hook that runs after "git add" compute=
s the
> >            new index state but before committing it to disk. The hook
> >       -    receives two arguments:
> >       +    receives two positional arguments:
> >
> >       -      $1 -- path to a temporary copy of the index before this "g=
it add"
> >       -      $2 -- path to the lockfile containing the proposed index
> >       +      $1 -- index path used by this invocation (may not exist ye=
t)
> >       +      $2 -- lockfile path containing proposed staged index state
> >
> >       -    $1 on first add can be a non-existent path representing an e=
mpty
> >       -    index.
> >       -
> >       -    Hook authors can inspect the computed result with ordinary t=
ools:
> >       +    While the lockfile is active the current index path remains =
readable
> >       +    and unchanged, so a seperate copy is unnecessary. Hook autho=
rs can
> >       +    inspect the computed result with ordinary tools:
> >
> >              GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD
> >
> >       -    without needing to interpret pathspec or mode flags like "-u=
" or
> >       -    "--renormalize" -- the proposed index already reflects their=
 effect.
> >       +    without needing to interpret pathspec or mode flags as the p=
roposed
> >       +    index already reflects their effect.
> >       +
> >       +    At the finish label, write_locked_index() writes the propose=
d index
> >       +    to the lockfile without COMMIT_LOCK so commit_lock_file() ca=
n be
> >       +    called seperately after the hook runs. However, do_write_loc=
ked_index()
> >       +    unconditionally fires post-index-change after every write, a=
nd the
> >       +    existing test suite (t7113) asserts that index.lock does not=
 exist when
> >       +    that hook fires. Tying the hook to COMMIT_LOCK would suppres=
s it for
> >       +    other callers that depend on it after a non-committed write =
(e.g.,
> >       +    prepare_to_commit() in builtin/commit.c). A new SKIP_INDEX_C=
HANGE_HOOK
> >       +    flag lets builtin/add.c suppress the automatic notification =
on just this
> >       +    call, then emit post-index-change manually after commit_lock=
_file()
> >       +    publishes the new index. If the hook rejects, rollback_lock_=
file()
> >       +    discards the lockfile and the original index is left unchang=
ed. When
> >       +    no hook is installed the existing write_locked_index(COMMIT_=
LOCK |
> >       +    SKIP_IF_UNCHANGED) path is taken.
> >
> >       -    The implementation creates a temporary copy of the index via=
 the
> >       -    tempfile API when find_hook("pre-add") reports a hook is pre=
sent,
> >       -    then lets all staging proceed normally. At the finish label,
> >       -    write_locked_index() writes the proposed index to the lockfi=
le
> >       -    without COMMIT_LOCK. If the hook approves, commit_lock_file(=
)
> >       -    atomically replaces the index. If the hook rejects,
> >       -    rollback_lock_file() discards the lockfile and the original =
index
> >       -    is left unchanged. When no hook is installed, the existing
> >       -    write_locked_index(COMMIT_LOCK | SKIP_IF_UNCHANGED) path is =
still
> >       -    taken.
> >       +    The hook gate checks cache_changed regardless of exit_status=
 so that
> >       +    mixed-result adds (e.g., a tracked modification combined wit=
h an
> >       +    ignored path) still run the hook when index content changes.
> >
> >            The hook is bypassed with "--no-verify" and is not invoked f=
or
> >            --interactive, --patch, --edit, or --dry-run, nor by "git co=
mmit -a"
> >            which stages through its own code path.
> >
> >       -    Register t3706-pre-add-hook.sh in t/meson.build to synchroni=
ze Meson
> >       -    and Makefile lists.
> >       -
> >            Signed-off-by: Chandra Kethi-Reddy <chandrakr@pm.me>
> >
> >         ## Documentation/git-add.adoc ##
> >       @@ Documentation/git-add.adoc: use the `--force` option to add ig=
nored files. If yo
> >         filename of an ignored file, `git add` will fail with a list of=
 ignored
> >         files. Otherwise it will silently ignore the file.
> >
> >       -+A pre-add hook can be run to inspect or reject the proposed ind=
ex update
> >       ++A `pre-add` hook can be run to inspect or reject the proposed i=
ndex update
> >        +after `git add` computes staging and writes it to the index loc=
kfile,
> >        +but before writing it to the final index. See linkgit:githooks[=
5].
> >        +
> >       @@ Documentation/git-add.adoc: for `git add --no-all <pathspec>..=
.`, i.e. ignored r
> >         =09information in the index.
> >
> >        +`--no-verify`::
> >       -+=09Bypass the pre-add hook if it exists. See linkgit:githooks[5=
] for
> >       ++=09Bypass the `pre-add` hook if it exists. See linkgit:githooks=
[5] for
> >        +=09more information about hooks.
> >        +
> >         `--ignore-errors`::
> >       @@ Documentation/githooks.adoc: and is invoked after the patch is=
 applied and a com
> >        +`--no-verify` option. It is not invoked for `--interactive`, `-=
-patch`,
> >        +`--edit`, or `--dry-run`.
> >        +
> >       -+It takes two parameters: the path to a copy of the index before=
 this
> >       -+invocation of `git add`, and the path to the lockfile containin=
g the
> >       -+proposed index after staging. It does not read from standard in=
put.
> >       -+If no index exists yet, the first parameter names a path that d=
oes not
> >       -+exist and should be treated as an empty index. No special envir=
onment
> >       -+variables are set. The hook is invoked after the index has been=
 updated
> >       -+in memory and written to the lockfile, but before it is committ=
ed to the
> >       -+final location.
> >       ++It takes two parameters: the path to the index file for this in=
vocation
> >       ++of `git add`, and the path to the lockfile containing the propo=
sed
> >       ++index after staging. It does not read from standard input. If n=
o index
> >       ++exists yet, the first parameter names a path that does not exis=
t and
> >       ++should be treated as an empty index.
> >       ++
> >       ++The hook is invoked after the index has been updated in memory =
and
> >       ++written to the lockfile, but before it is committed to the fina=
l index
> >       ++path. Exiting with a non-zero status causes `git add` to reject=
 the
> >       ++proposed state, roll back the lockfile, and leave the index unc=
hanged.
> >       ++Exiting with zero status allows the index update to be committe=
d.
> >        +
> >       -+Exiting with a non-zero status causes `git add` to abort and le=
aves the
> >       -+index unchanged. Exiting with zero status causes the staged cha=
nges to
> >       -+take effect.
> >       ++Git does not set `GIT_INDEX_FILE` for this hook. Hook authors m=
ay
> >       ++set `GIT_INDEX_FILE=3D"$1"` to inspect current index state and
> >       ++`GIT_INDEX_FILE=3D"$2"` to inspect proposed index state.
> >        +
> >        +This hook can be used to prevent staging of files based on name=
s, content,
> >        +or sizes (e.g., to block `.env` files, secret keys, or large fi=
les).
> >        +
> >        +This hook is not invoked by `git commit -a` or `git commit --in=
clude`
> >       -+which still can run the pre-commit hook, providing a control po=
int at
> >       ++which still can run the `pre-commit` hook, providing a control =
point at
> >        +commit time.
> >        +
> >         pre-commit
> >       @@ builtin/add.c
> >         #include "submodule.h"
> >         #include "add-interactive.h"
> >        +#include "hook.h"
> >       -+#include "copy.h"
> >       ++#include "abspath.h"
> >
> >         static const char * const builtin_add_usage[] =3D {
> >         =09N_("git add [<options>] [--] <pathspec>..."),
> >       @@ builtin/add.c: int cmd_add(int argc,
> >         =09struct lock_file lock_file =3D LOCK_INIT;
> >         =09struct odb_transaction *transaction;
> >        +=09int run_pre_add =3D 0;
> >       -+=09struct tempfile *orig_index =3D NULL;
> >        +=09char *orig_index_path =3D NULL;
> >
> >         =09repo_config(repo, add_config, NULL);
> >       @@ builtin/add.c: int cmd_add(int argc,
> >         =09}
> >
> >        +=09if (!show_only && !no_verify && find_hook(repo, "pre-add")) =
{
> >       -+=09=09int fd_in, status;
> >       -+=09=09const char *index_file =3D repo_get_index_file(repo);
> >       -+=09=09char *template;
> >       -+
> >        +=09=09run_pre_add =3D 1;
> >       -+=09=09template =3D xstrfmt("%s.pre-add.XXXXXX", index_file);
> >       -+=09=09orig_index =3D xmks_tempfile(template);
> >       -+=09=09free(template);
> >       -+
> >       -+=09=09fd_in =3D open(index_file, O_RDONLY);
> >       -+=09=09if (fd_in >=3D 0) {
> >       -+=09=09=09status =3D copy_fd(fd_in, get_tempfile_fd(orig_index))=
;
> >       -+=09=09=09if (close(fd_in))
> >       -+=09=09=09=09die_errno(_("unable to close index for pre-add hook=
"));
> >       -+=09=09=09if (close_tempfile_gently(orig_index))
> >       -+=09=09=09=09die_errno(_("unable to close temporary index copy")=
);
> >       -+=09=09=09if (status < 0)
> >       -+=09=09=09=09die(_("failed to copy index for pre-add hook"));
> >       -+=09=09} else if (errno =3D=3D ENOENT) {
> >       -+=09=09=09orig_index_path =3D xstrdup(get_tempfile_path(orig_ind=
ex));
> >       -+=09=09=09if (delete_tempfile(&orig_index))
> >       -+=09=09=09=09die_errno(_("unable to remove temporary index copy"=
));
> >       -+=09=09} else {
> >       -+=09=09=09die_errno(_("unable to open index for pre-add hook"));
> >       -+=09=09}
> >       ++=09=09orig_index_path =3D absolute_pathdup(repo_get_index_file(=
repo));
> >        +=09}
> >        +
> >         =09transaction =3D odb_transaction_begin(repo->objects);
> >       @@ builtin/add.c: int cmd_add(int argc,
> >         =09if (take_worktree_changes && !add_renormalize && !ignore_add=
_errors &&
> >        -=09    report_path_error(ps_matched, &pathspec))
> >        +=09    report_path_error(ps_matched, &pathspec)) {
> >       -+=09=09if (orig_index)
> >       -+=09=09=09delete_tempfile(&orig_index);
> >        +=09=09free(orig_index_path);
> >         =09=09exit(128);
> >        +=09}
> >       @@ builtin/add.c: int cmd_add(int argc,
> >        -=09if (write_locked_index(repo->index, &lock_file,
> >        -=09=09=09       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> >        -=09=09die(_("unable to write new index file"));
> >       -+=09if (run_pre_add && !exit_status && repo->index->cache_change=
d) {
> >       ++=09if (run_pre_add && repo->index->cache_changed) {
> >        +=09=09struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
> >        +
> >       -+=09=09if (write_locked_index(repo->index, &lock_file, 0))
> >       -+=09=09=09die(_("unable to write new index file"));
> >       ++=09=09if (write_locked_index(repo->index, &lock_file,
> >       ++=09=09=09=09SKIP_INDEX_CHANGE_HOOK))
> >       ++=09=09=09die(_("unable to write proposed index"));
> >        +
> >       -+=09=09strvec_push(&opt.args, orig_index ? get_tempfile_path(ori=
g_index) :
> >       -+=09=09=09=09=09     orig_index_path);
> >       ++=09=09strvec_push(&opt.args, orig_index_path);
> >        +=09=09strvec_push(&opt.args, get_lock_file_path(&lock_file));
> >        +=09=09if (run_hooks_opt(repo, "pre-add", &opt)) {
> >        +=09=09=09rollback_lock_file(&lock_file); /* hook rejected */
> >        +=09=09=09exit_status =3D 1;
> >       ++=09=09} else if (commit_lock_file(&lock_file)) {
> >       ++=09=09=09die(_("unable to write new index file"));
> >        +=09=09} else {
> >       -+=09=09=09if (commit_lock_file(&lock_file)) /* hook approved */
> >       -+=09=09=09=09die(_("unable to write new index file"));
> >       ++=09=09=09run_hooks_l(repo, "post-index-change",
> >       ++=09=09=09=09    repo->index->updated_workdir ? "1" : "0",
> >       ++=09=09=09=09    repo->index->updated_skipworktree ? "1" : "0",
> >       ++=09=09=09=09    NULL);
> >        +=09=09}
> >       ++=09=09repo->index->updated_workdir =3D 0;
> >       ++=09=09repo->index->updated_skipworktree =3D 0;
> >        +=09} else {
> >        +=09=09if (write_locked_index(repo->index, &lock_file,
> >        +=09=09=09=09       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> >        +=09=09=09die(_("unable to write new index file"));
> >        +=09}
> >        +
> >       -+=09delete_tempfile(&orig_index);
> >        +=09free(orig_index_path);
> >
> >         =09free(ps_matched);
> >         =09dir_clear(&dir);
> >
> >       + ## read-cache-ll.h ##
> >       +@@ read-cache-ll.h: int is_index_unborn(struct index_state *);
> >       + /* For use with `write_locked_index()`. */
> >       + #define COMMIT_LOCK=09=09(1 << 0)
> >       + #define SKIP_IF_UNCHANGED=09(1 << 1)
> >       ++#define SKIP_INDEX_CHANGE_HOOK=09(1 << 2)
> >       +
> >       + /*
> >       +  * Write the index while holding an already-taken lock. Close t=
he lock,
> >       +
> >       + ## read-cache.c ##
> >       +@@ read-cache.c: static int do_write_locked_index(struct index_s=
tate *istate,
> >       + =09else
> >       + =09=09ret =3D close_lock_file_gently(lock);
> >       +
> >       +-=09run_hooks_l(the_repository, "post-index-change",
> >       +-=09=09    istate->updated_workdir ? "1" : "0",
> >       +-=09=09    istate->updated_skipworktree ? "1" : "0", NULL);
> >       +-=09istate->updated_workdir =3D 0;
> >       +-=09istate->updated_skipworktree =3D 0;
> >       +-
> >       ++=09if (!(flags & SKIP_INDEX_CHANGE_HOOK)) {
> >       ++=09=09run_hooks_l(the_repository, "post-index-change",
> >       ++=09=09=09    istate->updated_workdir ? "1" : "0",
> >       ++=09=09=09    istate->updated_skipworktree ? "1" : "0", NULL);
> >       ++=09=09istate->updated_workdir =3D 0;
> >       ++=09=09istate->updated_skipworktree =3D 0;
> >       ++=09}
> >       + =09return ret;
> >       + }
> >       +
> >       +
> >         ## t/meson.build ##
> >        @@ t/meson.build: integration_tests =3D [
> >           't3703-add-magic-pathspec.sh',
> >       @@ t/t3706-pre-add-hook.sh (new)
> >        +=09test_path_is_missing actual
> >        +'
> >        +
> >       -+test_expect_success 'hook receives original and proposed index =
as arguments' '
> >       -+=09test_when_finished "rm -f tracked expected hook-ran" &&
> >       -+=09echo "initial" >tracked &&
> >       -+=09git add tracked &&
> >       -+=09git commit -m "initial" &&
> >       ++test_expect_success 'setup for path-based tests' '
> >       ++=09git add file &&
> >       ++=09git commit -m "initial"
> >       ++'
> >       ++
> >       ++test_expect_success 'hook receives index-path and lockfile-path=
 arguments' '
> >       ++=09test_when_finished "git reset --hard &&
> >       ++=09=09=09    rm -f staged expect-count arg-count arg-one arg-tw=
o \
> >       ++=09=09=09    expect-index expect-lockpath" &&
> >       ++=09echo staged >staged &&
> >       ++=09cat >expect-count <<-\EOF &&
> >       ++=092
> >       ++=09EOF
> >        +=09test_hook pre-add <<-\EOF &&
> >       -+=09test $# -eq 2 &&
> >       -+=09test -f "$1" &&
> >       -+=09test -f "$2" &&
> >       -+=09echo pass >hook-ran
> >       ++=09echo "$#" >arg-count &&
> >       ++=09echo "$1" >arg-one &&
> >       ++=09echo "$2" >arg-two &&
> >       ++=09test "$1" !=3D "$2" &&
> >       ++=09test -r "$2"
> >        +=09EOF
> >       ++=09git add staged &&
> >       ++=09test_cmp expect-count arg-count &&
> >       ++=09printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >e=
xpect-index &&
> >       ++=09test_cmp expect-index arg-one &&
> >       ++=09sed "s/$/.lock/" expect-index >expect-lockpath &&
> >       ++=09test_cmp expect-lockpath arg-two
> >       ++'
> >        +
> >       -+=09echo "modified" >tracked &&
> >       -+=09git add tracked &&
> >       -+=09echo pass >expected &&
> >       -+=09test_cmp expected hook-ran
> >       ++test_expect_success 'hook rejection leaves final index unchange=
d' '
> >       ++=09test_when_finished "git reset --hard && rm -f reject index.b=
efore" &&
> >       ++=09cp .git/index index.before &&
> >       ++=09test_hook pre-add <<-\EOF &&
> >       ++=09exit 1
> >       ++=09EOF
> >       ++=09echo reject >reject &&
> >       ++=09test_must_fail git add reject &&
> >       ++=09test_cmp_bin index.before .git/index &&
> >       ++=09test_path_is_missing .git/index.lock
> >        +'
> >        +
> >       -+test_expect_success 'hook handles first add with no existing in=
dex' '
> >       -+=09test_when_finished "rm -rf no-index" &&
> >       -+=09test_create_repo no-index &&
> >       -+=09echo ok >no-index/expected &&
> >       -+=09test_hook -C no-index pre-add <<-\EOF &&
> >       -+=09test $# -eq 2 &&
> >       ++test_expect_success 'missing pre-existing index path treated as=
 empty' '
> >       ++=09test_when_finished "git reset --hard &&
> >       ++=09=09=09    rm -f newfile arg-one after.raw after expect-index=
" &&
> >       ++=09rm -f .git/index &&
> >       ++=09test_hook pre-add <<-\EOF &&
> >       ++=09echo "$1" >arg-one &&
> >        +=09test ! -e "$1" &&
> >       -+=09test -f "$2" &&
> >       -+=09echo ok >hook-ran
> >       ++=09GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD >af=
ter.raw &&
> >       ++=09sort after.raw >after
> >        +=09EOF
> >       -+
> >       -+=09echo first >no-index/file &&
> >       -+=09git -C no-index add file &&
> >       -+=09test_cmp no-index/expected no-index/hook-ran
> >       ++=09echo newfile >newfile &&
> >       ++=09git add newfile &&
> >       ++=09printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >e=
xpect-index &&
> >       ++=09test_cmp expect-index arg-one &&
> >       ++=09grep "^newfile$" after &&
> >       ++=09grep "^file$" after
> >        +'
> >        +
> >       -+test_expect_success 'hook is not invoked with --dry-run (show-o=
nly)' '
> >       -+=09test_when_finished "rm -f actual" &&
> >       ++test_expect_success 'hook respects GIT_INDEX_FILE' '
> >       ++=09test_when_finished "git reset --hard &&
> >       ++=09=09=09    rm -f arg-one arg-two expect-index expect-lockpath=
 \
> >       ++=09=09=09    alt-index alt-index.lock" &&
> >        +=09test_hook pre-add <<-\EOF &&
> >       -+=09echo should-not-run >>actual
> >       -+=09exit 1
> >       ++=09echo "$1" >arg-one &&
> >       ++=09echo "$2" >arg-two
> >        +=09EOF
> >       ++=09echo changed >>file &&
> >       ++=09GIT_INDEX_FILE=3Dalt-index git add file &&
> >       ++=09echo "$PWD/alt-index" >expect-index &&
> >       ++=09test_cmp expect-index arg-one &&
> >       ++=09echo "$PWD/alt-index.lock" >expect-lockpath &&
> >       ++=09test_cmp expect-lockpath arg-two
> >       ++'
> >        +
> >       -+=09echo content >file &&
> >       -+=09git add --dry-run file &&
> >       -+=09test_path_is_missing actual
> >       ++test_expect_success 'setup for mixed-result tests' '
> >       ++=09echo "*.ignored" >.gitignore &&
> >       ++=09git add .gitignore &&
> >       ++=09git commit -m "add gitignore"
> >        +'
> >        +
> >       -+test_expect_success 'hook is invoked with git add -u' '
> >       -+=09test_when_finished "rm -f actual expected file" &&
> >       -+=09echo "initial" >file &&
> >       -+=09git add file &&
> >       -+=09git commit -m "initial" &&
> >       -+=09echo "pre-add" >expected &&
> >       ++test_expect_success 'mixed-result add invokes pre-add hook' '
> >       ++=09test_when_finished "git reset --hard &&
> >       ++=09=09=09    rm -f bad.ignored index.before hook-ran proposed" =
&&
> >       ++=09echo changed >>file &&
> >       ++=09echo ignored >bad.ignored &&
> >       ++=09cp .git/index index.before &&
> >        +=09test_hook pre-add <<-\EOF &&
> >       -+=09echo pre-add >>actual
> >       ++=09GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD >pr=
oposed &&
> >       ++=09grep "^file$" proposed &&
> >       ++=09echo invoked >hook-ran &&
> >       ++=09exit 1
> >        +=09EOF
> >       -+
> >       -+=09echo modified >file &&
> >       -+=09git add -u &&
> >       -+=09test_cmp expected actual
> >       ++=09test_must_fail git add file bad.ignored &&
> >       ++=09test_path_is_file hook-ran &&
> >       ++=09test_cmp_bin index.before .git/index &&
> >       ++=09test_path_is_missing .git/index.lock
> >        +'
> >        +
> >       -+test_expect_success 'hook can compare original and proposed ind=
ex' '
> >       -+=09test_when_finished "rm -f old-raw new-raw old-list new-list =
\
> >       -+=09=09=09    expected-old expected-new" &&
> >       -+=09echo "initial" >file1 &&
> >       -+=09echo "initial" >file2 &&
> >       -+=09git add file1 file2 &&
> >       -+=09git commit -m "initial" &&
> >       -+=09echo "staged-before" >file1 &&
> >       -+=09git add file1 &&
> >       ++test_expect_success 'mixed-result add stages tracked update on =
approve' '
> >       ++=09test_when_finished "git reset --hard &&
> >       ++=09=09=09    rm -f bad.ignored hook-ran staged proposed" &&
> >       ++=09echo changed >>file &&
> >       ++=09echo ignored >bad.ignored &&
> >        +=09test_hook pre-add <<-\EOF &&
> >       -+=09GIT_INDEX_FILE=3D"$1" git diff --cached --name-only HEAD >ol=
d-raw &&
> >       -+=09GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD >ne=
w-raw &&
> >       -+=09sort old-raw >old-list &&
> >       -+=09sort new-raw >new-list
> >       ++=09GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD >pr=
oposed &&
> >       ++=09grep "^file$" proposed &&
> >       ++=09echo invoked >hook-ran
> >        +=09EOF
> >       -+
> >       -+=09echo "modified" >file2 &&
> >       -+=09git add file2 &&
> >       -+=09echo file1 >expected-old &&
> >       -+=09printf "%s\n" file1 file2 >expected-new &&
> >       -+=09test_cmp expected-old old-list &&
> >       -+=09test_cmp expected-new new-list
> >       ++=09test_must_fail git add file bad.ignored &&
> >       ++=09test_path_is_file hook-ran &&
> >       ++=09git diff --cached --name-only HEAD >staged &&
> >       ++=09grep "^file$" staged &&
> >       ++=09test_path_is_missing .git/index.lock
> >        +'
> >        +
> >       -+test_expect_success 'hook rejection rolls back index unchanged'=
 '
> >       -+=09test_when_finished "rm -f file before after old-raw new-raw =
\
> >       -+=09=09=09    old-list new-list expected-old expected-new" &&
> >       -+=09echo "initial" >file &&
> >       ++test_expect_success 'post-index-change fires after pre-add appr=
oval' '
> >       ++=09test_when_finished "git reset --hard &&
> >       ++=09=09=09    rm -f hook-order expect lockfile-present" &&
> >       ++=09test_hook pre-add <<-\EOF &&
> >       ++=09echo pre >>hook-order
> >       ++=09EOF
> >       ++=09test_hook post-index-change <<-\EOF &&
> >       ++=09if test -f ".git/index.lock"
> >       ++=09then
> >       ++=09=09echo locked >lockfile-present
> >       ++=09fi
> >       ++=09echo post >>hook-order
> >       ++=09EOF
> >       ++=09echo updated >>file &&
> >        +=09git add file &&
> >       -+=09git commit -m "initial" &&
> >       -+=09git diff --cached --name-only HEAD >before &&
> >       ++=09cat >expect <<-\EOF &&
> >       ++=09pre
> >       ++=09post
> >       ++=09EOF
> >       ++=09test_cmp expect hook-order &&
> >       ++=09test_path_is_missing lockfile-present
> >       ++'
> >       ++
> >       ++test_expect_success 'post-index-change is suppressed on pre-add=
 rejection' '
> >       ++=09test_when_finished "git reset --hard &&
> >       ++=09=09=09    rm -f index.before hook-order expect" &&
> >       ++=09cp .git/index index.before &&
> >        +=09test_hook pre-add <<-\EOF &&
> >       -+=09GIT_INDEX_FILE=3D"$1" git diff --cached --name-only HEAD >ol=
d-raw &&
> >       -+=09GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD >ne=
w-raw &&
> >       -+=09sort old-raw >old-list &&
> >       -+=09sort new-raw >new-list &&
> >       ++=09echo pre >>hook-order &&
> >        +=09exit 1
> >        +=09EOF
> >       -+
> >       -+=09echo "modified" >file &&
> >       ++=09test_hook post-index-change <<-\EOF &&
> >       ++=09echo post >>hook-order
> >       ++=09EOF
> >       ++=09echo reject >>file &&
> >        +=09test_must_fail git add file &&
> >       -+=09git diff --cached --name-only HEAD >after &&
> >       -+=09test_cmp before after &&
> >       -+=09: >expected-old &&
> >       -+=09echo file >expected-new &&
> >       -+=09test_cmp expected-old old-list &&
> >       -+=09test_cmp expected-new new-list
> >       ++=09echo pre >expect &&
> >       ++=09test_cmp expect hook-order &&
> >       ++=09test_cmp_bin index.before .git/index &&
> >       ++=09test_path_is_missing .git/index.lock
> >       ++'
> >       ++
> >       ++test_expect_success '--dry-run does not invoke hook' '
> >       ++=09test_when_finished "rm -f hook-ran dry" &&
> >       ++=09test_hook pre-add <<-\EOF &&
> >       ++=09echo invoked >hook-ran
> >       ++=09EOF
> >       ++=09echo dry >dry &&
> >       ++=09git add --dry-run dry &&
> >       ++=09test_path_is_missing hook-ran
> >       ++'
> >       ++
> >       ++test_expect_success 'hook runs for git add -u' '
> >       ++=09test_when_finished "git reset --hard && rm -f hook-ran" &&
> >       ++=09test_hook pre-add <<-\EOF &&
> >       ++=09echo invoked >hook-ran
> >       ++=09EOF
> >       ++=09echo changed >>file &&
> >       ++=09git add -u &&
> >       ++=09test_path_is_file hook-ran
> >        +'
> >        +
> >        +test_expect_success 'hook example: block .env files' '
> >       -+=09test_when_finished "rm -f .env safe.txt new-paths" &&
> >       -+=09echo "initial" >base &&
> >       -+=09git add base &&
> >       -+=09git commit -m "initial" &&
> >       ++=09test_when_finished "git reset --hard &&
> >       ++=09=09=09    rm -f .env safe.txt new-paths" &&
> >        +=09test_hook pre-add <<-\EOF &&
> >        +=09GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD >ne=
w-paths &&
> >        +=09while read path
> >        +=09do
> >        +=09=09case "$path" in
> >       -+=09=09*.env|.env)
> >       ++=09=09*.env)
> >        +=09=09=09echo "error: $path must not be staged" >&2
> >        +=09=09=09exit 1
> >        +=09=09=09;;
> >        +=09=09esac
> >        +=09done <new-paths
> >        +=09EOF
> >       -+
> >        +=09echo "DB_PASS=3Dsecret" >.env &&
> >        +=09test_must_fail git add .env &&
> >        +=09echo "safe content" >safe.txt &&
> >       @@ t/t3706-pre-add-hook.sh (new)
> >        +'
> >        +
> >        +test_expect_success 'hook example: block secrets in content' '
> >       -+=09test_when_finished "rm -f config.txt secret" &&
> >       -+=09echo "initial" >config.txt &&
> >       -+=09git add config.txt &&
> >       -+=09git commit -m "initial" &&
> >       ++=09test_when_finished "git reset --hard && rm -f config.txt sec=
ret" &&
> >        +=09test_hook pre-add <<-\EOF &&
> >        +=09GIT_INDEX_FILE=3D"$2" git diff --cached HEAD >secret &&
> >       -+=09if grep -qE "(API_KEY|SECRET_KEY|PRIVATE_KEY)=3D" secret
> >       ++=09if grep -q "API_KEY=3D" secret ||
> >       ++=09   grep -q "SECRET_KEY=3D" secret ||
> >       ++=09   grep -q "PRIVATE_KEY=3D" secret
> >        +=09then
> >        +=09=09echo "error: staged content contains secrets" >&2
> >        +=09=09exit 1
> >        +=09fi
> >        +=09EOF
> >       -+
> >        +=09echo "API_KEY=3Dsksksk-live-12345" >config.txt &&
> >        +=09test_must_fail git add config.txt &&
> >        +=09echo "LOG_LEVEL=3Ddebug" >config.txt &&
> >
> >
> >   Documentation/git-add.adoc  |  11 +-
> >   Documentation/githooks.adoc |  30 ++++
> >   builtin/add.c               |  47 +++++-
> >   read-cache-ll.h             |   1 +
> >   read-cache.c                |  13 +-
> >   t/meson.build               |   1 +
> >   t/t3706-pre-add-hook.sh     | 289 +++++++++++++++++++++++++++++++++++=
+
> >   7 files changed, 381 insertions(+), 11 deletions(-)
> >   create mode 100755 t/t3706-pre-add-hook.sh
> >
> > diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> > index 6192daeb03..b47751acca 100644
> > --- a/Documentation/git-add.adoc
> > +++ b/Documentation/git-add.adoc
> > @@ -10,7 +10,7 @@ SYNOPSIS
> >   [synopsis]
> >   git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interacti=
ve | -i] [--patch | -p]
> >   =09[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update=
 | -u]] [--sparse]
> > -=09[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-miss=
ing] [--renormalize]
> > +=09[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-miss=
ing] [--renormalize] [--no-verify]
> >   =09[--chmod=3D(+|-)x] [--pathspec-from-file=3D<file> [--pathspec-file=
-nul]]
> >   =09[--] [<pathspec>...]
> >
> > @@ -42,6 +42,10 @@ use the `--force` option to add ignored files. If yo=
u specify the exact
> >   filename of an ignored file, `git add` will fail with a list of ignor=
ed
> >   files. Otherwise it will silently ignore the file.
> >
> > +A `pre-add` hook can be run to inspect or reject the proposed index up=
date
> > +after `git add` computes staging and writes it to the index lockfile,
> > +but before writing it to the final index. See linkgit:githooks[5].
> > +
> >   Please see linkgit:git-commit[1] for alternative ways to add content =
to a
> >   commit.
> >
> > @@ -163,6 +167,10 @@ for `git add --no-all <pathspec>...`, i.e. ignored=
 removed files.
> >   =09Don't add the file(s), but only refresh their stat()
> >   =09information in the index.
> >
> > +`--no-verify`::
> > +=09Bypass the `pre-add` hook if it exists. See linkgit:githooks[5] for
> > +=09more information about hooks.
> > +
> >   `--ignore-errors`::
> >   =09If some files could not be added because of errors indexing
> >   =09them, do not abort the operation, but continue adding the
> > @@ -451,6 +459,7 @@ linkgit:git-reset[1]
> >   linkgit:git-mv[1]
> >   linkgit:git-commit[1]
> >   linkgit:git-update-index[1]
> > +linkgit:githooks[5]
> >
> >   GIT
> >   ---
> > diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> > index 056553788d..657e14d306 100644
> > --- a/Documentation/githooks.adoc
> > +++ b/Documentation/githooks.adoc
> > @@ -94,6 +94,36 @@ and is invoked after the patch is applied and a comm=
it is made.
> >   This hook is meant primarily for notification, and cannot affect
> >   the outcome of `git am`.
> >
> > +pre-add
> > +~~~~~~~
> > +
> > +This hook is invoked by linkgit:git-add[1], and can be bypassed with t=
he
> > +`--no-verify` option. It is not invoked for `--interactive`, `--patch`=
,
> > +`--edit`, or `--dry-run`.
> > +
> > +It takes two parameters: the path to the index file for this invocatio=
n
> > +of `git add`, and the path to the lockfile containing the proposed
> > +index after staging. It does not read from standard input. If no index
> > +exists yet, the first parameter names a path that does not exist and
> > +should be treated as an empty index.
> > +
> > +The hook is invoked after the index has been updated in memory and
> > +written to the lockfile, but before it is committed to the final index
> > +path. Exiting with a non-zero status causes `git add` to reject the
> > +proposed state, roll back the lockfile, and leave the index unchanged.
> > +Exiting with zero status allows the index update to be committed.
> > +
> > +Git does not set `GIT_INDEX_FILE` for this hook. Hook authors may
> > +set `GIT_INDEX_FILE=3D"$1"` to inspect current index state and
> > +`GIT_INDEX_FILE=3D"$2"` to inspect proposed index state.
> > +
> > +This hook can be used to prevent staging of files based on names, cont=
ent,
> > +or sizes (e.g., to block `.env` files, secret keys, or large files).
> > +
> > +This hook is not invoked by `git commit -a` or `git commit --include`
> > +which still can run the `pre-commit` hook, providing a control point a=
t
> > +commit time.
> > +
> >   pre-commit
> >   ~~~~~~~~~~
> >
> > diff --git a/builtin/add.c b/builtin/add.c
> > index 32709794b3..d4d004a35b 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -25,6 +25,8 @@
> >   #include "strvec.h"
> >   #include "submodule.h"
> >   #include "add-interactive.h"
> > +#include "hook.h"
> > +#include "abspath.h"
> >
> >   static const char * const builtin_add_usage[] =3D {
> >   =09N_("git add [<options>] [--] <pathspec>..."),
> > @@ -36,6 +38,7 @@ static int take_worktree_changes;
> >   static int add_renormalize;
> >   static int pathspec_file_nul;
> >   static int include_sparse;
> > +static int no_verify;
> >   static const char *pathspec_from_file;
> >
> >   static int chmod_pathspec(struct repository *repo,
> > @@ -271,6 +274,7 @@ static struct option builtin_add_options[] =3D {
> >   =09OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refres=
h the index")),
> >   =09OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip f=
iles which cannot be added because of errors")),
> >   =09OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - ev=
en missing - files are ignored in dry run")),
> > +=09OPT_BOOL( 0 , "no-verify", &no_verify, N_("bypass pre-add hook")),
> >   =09OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries =
outside of the sparse-checkout cone")),
> >   =09OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
> >   =09=09   N_("override the executable bit of the listed files")),
> > @@ -391,6 +395,8 @@ int cmd_add(int argc,
> >   =09char *ps_matched =3D NULL;
> >   =09struct lock_file lock_file =3D LOCK_INIT;
> >   =09struct odb_transaction *transaction;
> > +=09int run_pre_add =3D 0;
> > +=09char *orig_index_path =3D NULL;
> >
> >   =09repo_config(repo, add_config, NULL);
> >
> > @@ -576,6 +582,11 @@ int cmd_add(int argc,
> >   =09=09string_list_clear(&only_match_skip_worktree, 0);
> >   =09}
> >
> > +=09if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
> > +=09=09run_pre_add =3D 1;
> > +=09=09orig_index_path =3D absolute_pathdup(repo_get_index_file(repo));
> > +=09}
> > +
> >   =09transaction =3D odb_transaction_begin(repo->objects);
> >
> >   =09ps_matched =3D xcalloc(pathspec.nr, 1);
> > @@ -587,8 +598,10 @@ int cmd_add(int argc,
> >   =09=09=09=09=09=09  include_sparse, flags);
> >
> >   =09if (take_worktree_changes && !add_renormalize && !ignore_add_error=
s &&
> > -=09    report_path_error(ps_matched, &pathspec))
> > +=09    report_path_error(ps_matched, &pathspec)) {
> > +=09=09free(orig_index_path);
> >   =09=09exit(128);
> > +=09}
> >
> >   =09if (add_new_files)
> >   =09=09exit_status |=3D add_files(repo, &dir, flags);
> > @@ -598,9 +611,35 @@ int cmd_add(int argc,
> >   =09odb_transaction_commit(transaction);
> >
> >   finish:
> > -=09if (write_locked_index(repo->index, &lock_file,
> > -=09=09=09       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> > -=09=09die(_("unable to write new index file"));
> > +=09if (run_pre_add && repo->index->cache_changed) {
> > +=09=09struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
> > +
> > +=09=09if (write_locked_index(repo->index, &lock_file,
> > +=09=09=09=09SKIP_INDEX_CHANGE_HOOK))
> > +=09=09=09die(_("unable to write proposed index"));
> > +
> > +=09=09strvec_push(&opt.args, orig_index_path);
> > +=09=09strvec_push(&opt.args, get_lock_file_path(&lock_file));
> > +=09=09if (run_hooks_opt(repo, "pre-add", &opt)) {
> > +=09=09=09rollback_lock_file(&lock_file); /* hook rejected */
> > +=09=09=09exit_status =3D 1;
> > +=09=09} else if (commit_lock_file(&lock_file)) {
> > +=09=09=09die(_("unable to write new index file"));
> > +=09=09} else {
> > +=09=09=09run_hooks_l(repo, "post-index-change",
> > +=09=09=09=09    repo->index->updated_workdir ? "1" : "0",
> > +=09=09=09=09    repo->index->updated_skipworktree ? "1" : "0",
> > +=09=09=09=09    NULL);
> > +=09=09}
> > +=09=09repo->index->updated_workdir =3D 0;
> > +=09=09repo->index->updated_skipworktree =3D 0;
> > +=09} else {
> > +=09=09if (write_locked_index(repo->index, &lock_file,
> > +=09=09=09=09       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> > +=09=09=09die(_("unable to write new index file"));
> > +=09}
> > +
> > +=09free(orig_index_path);
> >
> >   =09free(ps_matched);
> >   =09dir_clear(&dir);
> > diff --git a/read-cache-ll.h b/read-cache-ll.h
> > index 71b49d9af4..a43971c07e 100644
> > --- a/read-cache-ll.h
> > +++ b/read-cache-ll.h
> > @@ -284,6 +284,7 @@ int is_index_unborn(struct index_state *);
> >   /* For use with `write_locked_index()`. */
> >   #define COMMIT_LOCK=09=09(1 << 0)
> >   #define SKIP_IF_UNCHANGED=09(1 << 1)
> > +#define SKIP_INDEX_CHANGE_HOOK=09(1 << 2)
> >
> >   /*
> >    * Write the index while holding an already-taken lock. Close the loc=
k,
> > diff --git a/read-cache.c b/read-cache.c
> > index 0c07c3aef7..5051cda4ce 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -3161,12 +3161,13 @@ static int do_write_locked_index(struct index_s=
tate *istate,
> >   =09else
> >   =09=09ret =3D close_lock_file_gently(lock);
> >
> > -=09run_hooks_l(the_repository, "post-index-change",
> > -=09=09    istate->updated_workdir ? "1" : "0",
> > -=09=09    istate->updated_skipworktree ? "1" : "0", NULL);
> > -=09istate->updated_workdir =3D 0;
> > -=09istate->updated_skipworktree =3D 0;
> > -
> > +=09if (!(flags & SKIP_INDEX_CHANGE_HOOK)) {
> > +=09=09run_hooks_l(the_repository, "post-index-change",
> > +=09=09=09    istate->updated_workdir ? "1" : "0",
> > +=09=09=09    istate->updated_skipworktree ? "1" : "0", NULL);
> > +=09=09istate->updated_workdir =3D 0;
> > +=09=09istate->updated_skipworktree =3D 0;
> > +=09}
> >   =09return ret;
> >   }
> >
> > diff --git a/t/meson.build b/t/meson.build
> > index f80e366cff..2419a9adbb 100644
> > --- a/t/meson.build
> > +++ b/t/meson.build
> > @@ -415,6 +415,7 @@ integration_tests =3D [
> >     't3703-add-magic-pathspec.sh',
> >     't3704-add-pathspec-file.sh',
> >     't3705-add-sparse-checkout.sh',
> > +  't3706-pre-add-hook.sh',
> >     't3800-mktag.sh',
> >     't3900-i18n-commit.sh',
> >     't3901-i18n-patch.sh',
> > diff --git a/t/t3706-pre-add-hook.sh b/t/t3706-pre-add-hook.sh
> > new file mode 100755
> > index 0000000000..f5092f0727
> > --- /dev/null
> > +++ b/t/t3706-pre-add-hook.sh
> > @@ -0,0 +1,289 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'pre-add hook tests
> > +
> > +These tests run git add with and without pre-add hooks to ensure funct=
ionality. Largely derived from t7503 (pre-commit and pre-merge-commit hooks=
) and t5571 (pre-push hooks).'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'with no hook' '
> > +=09test_when_finished "rm -f actual" &&
> > +=09echo content >file &&
> > +=09git add file &&
> > +=09test_path_is_missing actual
> > +'
> > +
> > +test_expect_success POSIXPERM 'with non-executable hook' '
> > +=09test_when_finished "rm -f actual" &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09echo should-not-run >>actual
> > +=09exit 1
> > +=09EOF
> > +=09chmod -x .git/hooks/pre-add &&
> > +
> > +=09echo content >file &&
> > +=09git add file &&
> > +=09test_path_is_missing actual
> > +'
> > +
> > +test_expect_success '--no-verify with no hook' '
> > +=09echo content >file &&
> > +=09git add --no-verify file &&
> > +=09test_path_is_missing actual
> > +'
> > +
> > +test_expect_success 'with succeeding hook' '
> > +=09test_when_finished "rm -f actual expected" &&
> > +=09echo "pre-add" >expected &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09echo pre-add >>actual
> > +=09EOF
> > +
> > +=09echo content >file &&
> > +=09git add file &&
> > +=09test_cmp expected actual
> > +'
> > +
> > +test_expect_success 'with failing hook' '
> > +=09test_when_finished "rm -f actual" &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09echo pre-add-rejected >>actual
> > +=09exit 1
> > +=09EOF
> > +
> > +=09echo content >file &&
> > +=09test_must_fail git add file
> > +'
> > +
> > +test_expect_success '--no-verify with failing hook' '
> > +=09test_when_finished "rm -f actual" &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09echo should-not-run >>actual
> > +=09exit 1
> > +=09EOF
> > +
> > +=09echo content >file &&
> > +=09git add --no-verify file &&
> > +=09test_path_is_missing actual
> > +'
> > +
> > +test_expect_success 'setup for path-based tests' '
> > +=09git add file &&
> > +=09git commit -m "initial"
> > +'
> > +
> > +test_expect_success 'hook receives index-path and lockfile-path argume=
nts' '
> > +=09test_when_finished "git reset --hard &&
> > +=09=09=09    rm -f staged expect-count arg-count arg-one arg-two \
> > +=09=09=09    expect-index expect-lockpath" &&
> > +=09echo staged >staged &&
> > +=09cat >expect-count <<-\EOF &&
> > +=092
> > +=09EOF
> > +=09test_hook pre-add <<-\EOF &&
> > +=09echo "$#" >arg-count &&
> > +=09echo "$1" >arg-one &&
> > +=09echo "$2" >arg-two &&
> > +=09test "$1" !=3D "$2" &&
> > +=09test -r "$2"
> > +=09EOF
> > +=09git add staged &&
> > +=09test_cmp expect-count arg-count &&
> > +=09printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >expect-i=
ndex &&
> > +=09test_cmp expect-index arg-one &&
> > +=09sed "s/$/.lock/" expect-index >expect-lockpath &&
> > +=09test_cmp expect-lockpath arg-two
> > +'
> > +
> > +test_expect_success 'hook rejection leaves final index unchanged' '
> > +=09test_when_finished "git reset --hard && rm -f reject index.before" =
&&
> > +=09cp .git/index index.before &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09exit 1
> > +=09EOF
> > +=09echo reject >reject &&
> > +=09test_must_fail git add reject &&
> > +=09test_cmp_bin index.before .git/index &&
> > +=09test_path_is_missing .git/index.lock
> > +'
> > +
> > +test_expect_success 'missing pre-existing index path treated as empty'=
 '
> > +=09test_when_finished "git reset --hard &&
> > +=09=09=09    rm -f newfile arg-one after.raw after expect-index" &&
> > +=09rm -f .git/index &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09echo "$1" >arg-one &&
> > +=09test ! -e "$1" &&
> > +=09GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD >after.raw=
 &&
> > +=09sort after.raw >after
> > +=09EOF
> > +=09echo newfile >newfile &&
> > +=09git add newfile &&
> > +=09printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >expect-i=
ndex &&
> > +=09test_cmp expect-index arg-one &&
> > +=09grep "^newfile$" after &&
> > +=09grep "^file$" after
> > +'
> > +
> > +test_expect_success 'hook respects GIT_INDEX_FILE' '
> > +=09test_when_finished "git reset --hard &&
> > +=09=09=09    rm -f arg-one arg-two expect-index expect-lockpath \
> > +=09=09=09    alt-index alt-index.lock" &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09echo "$1" >arg-one &&
> > +=09echo "$2" >arg-two
> > +=09EOF
> > +=09echo changed >>file &&
> > +=09GIT_INDEX_FILE=3Dalt-index git add file &&
> > +=09echo "$PWD/alt-index" >expect-index &&
> > +=09test_cmp expect-index arg-one &&
> > +=09echo "$PWD/alt-index.lock" >expect-lockpath &&
> > +=09test_cmp expect-lockpath arg-two
> > +'
> > +
> > +test_expect_success 'setup for mixed-result tests' '
> > +=09echo "*.ignored" >.gitignore &&
> > +=09git add .gitignore &&
> > +=09git commit -m "add gitignore"
> > +'
> > +
> > +test_expect_success 'mixed-result add invokes pre-add hook' '
> > +=09test_when_finished "git reset --hard &&
> > +=09=09=09    rm -f bad.ignored index.before hook-ran proposed" &&
> > +=09echo changed >>file &&
> > +=09echo ignored >bad.ignored &&
> > +=09cp .git/index index.before &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD >proposed =
&&
> > +=09grep "^file$" proposed &&
> > +=09echo invoked >hook-ran &&
> > +=09exit 1
> > +=09EOF
> > +=09test_must_fail git add file bad.ignored &&
> > +=09test_path_is_file hook-ran &&
> > +=09test_cmp_bin index.before .git/index &&
> > +=09test_path_is_missing .git/index.lock
> > +'
> > +
> > +test_expect_success 'mixed-result add stages tracked update on approve=
' '
> > +=09test_when_finished "git reset --hard &&
> > +=09=09=09    rm -f bad.ignored hook-ran staged proposed" &&
> > +=09echo changed >>file &&
> > +=09echo ignored >bad.ignored &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD >proposed =
&&
> > +=09grep "^file$" proposed &&
> > +=09echo invoked >hook-ran
> > +=09EOF
> > +=09test_must_fail git add file bad.ignored &&
> > +=09test_path_is_file hook-ran &&
> > +=09git diff --cached --name-only HEAD >staged &&
> > +=09grep "^file$" staged &&
> > +=09test_path_is_missing .git/index.lock
> > +'
> > +
> > +test_expect_success 'post-index-change fires after pre-add approval' '
> > +=09test_when_finished "git reset --hard &&
> > +=09=09=09    rm -f hook-order expect lockfile-present" &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09echo pre >>hook-order
> > +=09EOF
> > +=09test_hook post-index-change <<-\EOF &&
> > +=09if test -f ".git/index.lock"
> > +=09then
> > +=09=09echo locked >lockfile-present
> > +=09fi
> > +=09echo post >>hook-order
> > +=09EOF
> > +=09echo updated >>file &&
> > +=09git add file &&
> > +=09cat >expect <<-\EOF &&
> > +=09pre
> > +=09post
> > +=09EOF
> > +=09test_cmp expect hook-order &&
> > +=09test_path_is_missing lockfile-present
> > +'
> > +
> > +test_expect_success 'post-index-change is suppressed on pre-add reject=
ion' '
> > +=09test_when_finished "git reset --hard &&
> > +=09=09=09    rm -f index.before hook-order expect" &&
> > +=09cp .git/index index.before &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09echo pre >>hook-order &&
> > +=09exit 1
> > +=09EOF
> > +=09test_hook post-index-change <<-\EOF &&
> > +=09echo post >>hook-order
> > +=09EOF
> > +=09echo reject >>file &&
> > +=09test_must_fail git add file &&
> > +=09echo pre >expect &&
> > +=09test_cmp expect hook-order &&
> > +=09test_cmp_bin index.before .git/index &&
> > +=09test_path_is_missing .git/index.lock
> > +'
> > +
> > +test_expect_success '--dry-run does not invoke hook' '
> > +=09test_when_finished "rm -f hook-ran dry" &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09echo invoked >hook-ran
> > +=09EOF
> > +=09echo dry >dry &&
> > +=09git add --dry-run dry &&
> > +=09test_path_is_missing hook-ran
> > +'
> > +
> > +test_expect_success 'hook runs for git add -u' '
> > +=09test_when_finished "git reset --hard && rm -f hook-ran" &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09echo invoked >hook-ran
> > +=09EOF
> > +=09echo changed >>file &&
> > +=09git add -u &&
> > +=09test_path_is_file hook-ran
> > +'
> > +
> > +test_expect_success 'hook example: block .env files' '
> > +=09test_when_finished "git reset --hard &&
> > +=09=09=09    rm -f .env safe.txt new-paths" &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09GIT_INDEX_FILE=3D"$2" git diff --cached --name-only HEAD >new-paths=
 &&
> > +=09while read path
> > +=09do
> > +=09=09case "$path" in
> > +=09=09*.env)
> > +=09=09=09echo "error: $path must not be staged" >&2
> > +=09=09=09exit 1
> > +=09=09=09;;
> > +=09=09esac
> > +=09done <new-paths
> > +=09EOF
> > +=09echo "DB_PASS=3Dsecret" >.env &&
> > +=09test_must_fail git add .env &&
> > +=09echo "safe content" >safe.txt &&
> > +=09git add safe.txt
> > +'
> > +
> > +test_expect_success 'hook example: block secrets in content' '
> > +=09test_when_finished "git reset --hard && rm -f config.txt secret" &&
> > +=09test_hook pre-add <<-\EOF &&
> > +=09GIT_INDEX_FILE=3D"$2" git diff --cached HEAD >secret &&
> > +=09if grep -q "API_KEY=3D" secret ||
> > +=09   grep -q "SECRET_KEY=3D" secret ||
> > +=09   grep -q "PRIVATE_KEY=3D" secret
> > +=09then
> > +=09=09echo "error: staged content contains secrets" >&2
> > +=09=09exit 1
> > +=09fi
> > +=09EOF
> > +=09echo "API_KEY=3Dsksksk-live-12345" >config.txt &&
> > +=09test_must_fail git add config.txt &&
> > +=09echo "LOG_LEVEL=3Ddebug" >config.txt &&
> > +=09git add config.txt
> > +'
> > +
> > +test_done
> >
> > base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
>=20
>=20
> 
