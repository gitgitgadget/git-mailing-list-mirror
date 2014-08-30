From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working directory
Date: Sat, 30 Aug 2014 21:50:15 +0100
Organization: OPDS
Message-ID: <70985AC885404243A2B95F534083A0E9@PhilipOakley>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com> <1409387642-24492-23-git-send-email-pclouds@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:50:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNpbP-0003Me-PI
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 22:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbaH3UuS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 16:50:18 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:42502 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751921AbaH3UuQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2014 16:50:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AocvAE84AlQCYJAzPGdsb2JhbABbgw1TEQFFgnyFO7wkgxiHTAICCIEHFwUBAQEBODaDfgYBBQgBARkECwEFHgEBIQsCAwUCAQMVBQIFIQICFAEECBIGBwMUBgESCAIBAgMBiB0DFaZUhn+HXg2FZRiBLIt0gUEVUgU1gks2gR0FhhSLHViDVoRtkHeKGTwvgQcIF4EpAQEB
X-IPAS-Result: AocvAE84AlQCYJAzPGdsb2JhbABbgw1TEQFFgnyFO7wkgxiHTAICCIEHFwUBAQEBODaDfgYBBQgBARkECwEFHgEBIQsCAwUCAQMVBQIFIQICFAEECBIGBwMUBgESCAIBAgMBiB0DFaZUhn+HXg2FZRiBLIt0gUEVUgU1gks2gR0FhhSLHViDVoRtkHeKGTwvgQcIF4EpAQEB
X-IronPort-AV: E=Sophos;i="5.04,432,1406588400"; 
   d="scan'208";a="508799312"
Received: from host-2-96-144-51.as13285.net (HELO PhilipOakley) ([2.96.144.51])
  by out1.ip03ir2.opaltelecom.net with SMTP; 30 Aug 2014 21:50:13 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256263>

=46rom: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com>
> "git checkout --to" sets up a new working directory with a .git file
> pointing to $GIT_DIR/repos/<id>. It then executes "git checkout" agai=
n
> on the new worktree with the same arguments except "--to" is taken
> out. The second checkout execution, which is not contaminated with an=
y
> info from the current repository, will actually check out and
> everything that normal "git checkout" does.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> Documentation/git-checkout.txt         | 34 ++++++++++++
> Documentation/git.txt                  |  3 +-
> Documentation/gitrepository-layout.txt |  7 +++
> builtin/checkout.c                     | 95=20
> +++++++++++++++++++++++++++++++++-
> path.c                                 |  2 +-
> t/t2025-checkout-to.sh (new +x)        | 63 ++++++++++++++++++++++
> 6 files changed, 200 insertions(+), 4 deletions(-)
> create mode 100755 t/t2025-checkout-to.sh
>
> diff --git a/Documentation/git-checkout.txt=20
> b/Documentation/git-checkout.txt
> index 33ad2ad..38c70c5 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -225,6 +225,13 @@ This means that you can use `git checkout -p` to=
=20
> selectively discard
> edits from your current working tree. See the ``Interactive Mode''
> section of linkgit:git-add[1] to learn how to operate the `--patch`=20
> mode.
>
> +--to=3D<path>::
> + Check out a new branch in a separate working directory at

Is this actually a 'new' branch? Perhaps s/new //. More below.

> + `<path>`. A new working directory is linked to the current
> + repository, sharing everything except working directory
> + specific files such as HEAD, index... See "MULTIPLE CHECKOUT
> + MODE" section for more information.
> +
> <branch>::
>  Branch to checkout; if it refers to a branch (i.e., a name that,
>  when prepended with "refs/heads/", is a valid ref), then that
> @@ -388,6 +395,33 @@ $ git reflog -2 HEAD # or
> $ git log -g -2 HEAD
> ------------
>
> +MULTIPLE CHECKOUT MODE
> +----------------------
> +Normally a working directory is attached to repository. When "git
> +checkout --to" is used, a new working directory is attached to the
> +current repository. This new working directory is called "linked
> +checkout" as compared to the "main checkout" prepared by "git init"=20
> or
> +"git clone". A repository has one main checkout and zero or more
> +linked checkouts.
> +
> +All checkouts share the same repository. Linked checkouts see the
> +repository a bit different from the main checkout. When the checkout
> +"new" reads the path $GIT_DIR/HEAD for example, the actual path

I was caught out by "new" (in quotes) here. I see that the commit msg i=
n=20
patch 24 uses 'new-branch', while in patch 30 <new> is used. Is this=20
"new" (above) refering to the branch name (or detatched head), or a=20
nmemonic for the path? The use of "new working directory" in the=20
previous paragraph is a well qualified use of new, so I'm looking to=20
ensure that it's well qualified here.

My immediate reaction was that a consistent use of <new> in the three=20
patches may be all that's needed

> +returned could be $GIT_DIR/repos/new/HEAD. This ensures checkouts

surely s/could/would/? or have I misunderstood?
Also maybe s/new/<new-name>/, given the 'usually named' below, or=20
s/new/<id>/ based on the commit message.

> +won't step on each other.
> +
> +Each linked checkout has a private space in $GIT_DIR/repos, usually
> +named after the base name of the working directory with a number=20
> added
> +to make it unique. The linked checkout's $GIT_DIR points to this
> +private space while $GIT_COMMON_DIR points to the main checkout's
> +$GIT_DIR. These settings are done by "git checkout --to".
> +
> +Because in this mode $GIT_DIR becomes a lightweight virtual file
> +system where a path could be rewritten to some place else, accessing
> +$GIT_DIR from scripts should use `git rev-parse --git-path` to=20
> resolve
> +a path instead of using it directly unless the path is known to be
> +private to the working directory.
> +
> EXAMPLES
> --------
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 749052f..c0a4940 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -792,7 +792,8 @@ Git so take care if using Cogito etc.
>  If this variable is set to a path, non-worktree files that are
>  normally in $GIT_DIR will be taken from this path
>  instead. Worktree-specific files such as HEAD or index are
> - taken from $GIT_DIR. See linkgit:gitrepository-layout[5] for
> + taken from $GIT_DIR. See linkgit:gitrepository-layout[5] and
> + the section 'MULTIPLE CHECKOUT MODE' in linkgit:checkout[1]
>  details. This variable has lower precedence than other path
>  variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...
>
> diff --git a/Documentation/gitrepository-layout.txt=20
> b/Documentation/gitrepository-layout.txt
> index 58d1087..fab398a 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -248,6 +248,13 @@ modules::
>  directory is ignored if $GIT_COMMON_DIR is set and
>  "$GIT_COMMON_DIR/modules" will be used instead.
>
> +repos::
> + Contains worktree specific information of linked
> + checkouts. Each subdirectory contains the worktree-related
> + part of a linked checkout. This directory is ignored if
> + $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/repos" will be
> + used instead.
> +
> SEE ALSO
> --------
> linkgit:git-init[1],
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 8023987..6373823 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -48,6 +48,10 @@ struct checkout_opts {
>  const char *prefix;
>  struct pathspec pathspec;
>  struct tree *source_tree;
> +
> + const char *new_worktree;
> + const char **saved_argv;
> + int new_worktree_mode;
> };
>
> static int post_checkout_hook(struct commit *old, struct commit *new,
> @@ -250,6 +254,9 @@ static int checkout_paths(const struct=20
> checkout_opts *opts,
>  die(_("Cannot update paths and switch to branch '%s' at the same=20
> time."),
>      opts->new_branch);
>
> + if (opts->new_worktree)
> + die(_("'%s' cannot be used with updating paths"), "--to");
> +
>  if (opts->patch_mode)
>  return run_add_interactive(revision, "--patch=3Dcheckout",
>     &opts->pathspec);
> @@ -485,7 +492,7 @@ static int merge_working_tree(const struct=20
> checkout_opts *opts,
>  topts.dir->flags |=3D DIR_SHOW_IGNORED;
>  setup_standard_excludes(topts.dir);
>  }
> - tree =3D parse_tree_indirect(old->commit ?
> + tree =3D parse_tree_indirect(old->commit && !opts->new_worktree_mod=
e ?
>     old->commit->object.sha1 :
>     EMPTY_TREE_SHA1_BIN);
>  init_tree_desc(&trees[0], tree->buffer, tree->size);
> @@ -796,7 +803,8 @@ static int switch_branches(const struct=20
> checkout_opts *opts,
>  return ret;
>  }
>
> - if (!opts->quiet && !old.path && old.commit && new->commit !=3D=20
> old.commit)
> + if (!opts->quiet && !old.path && old.commit &&
> +     new->commit !=3D old.commit && !opts->new_worktree_mode)
>  orphaned_commit_warning(old.commit, new->commit);
>
>  update_refs_for_switch(opts, &old, new);
> @@ -806,6 +814,76 @@ static int switch_branches(const struct=20
> checkout_opts *opts,
>  return ret || writeout_error;
> }
>
> +static int prepare_linked_checkout(const struct checkout_opts *opts,
> +    struct branch_info *new)
> +{
> + struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT;
> + struct strbuf sb =3D STRBUF_INIT;
> + const char *path =3D opts->new_worktree, *name;
> + struct stat st;
> + struct child_process cp;
> + int counter =3D 0, len;
> +
> + if (!new->commit)
> + die(_("no branch specified"));
> + if (file_exists(path))
> + die(_("'%s' already exists"), path);
> +
> + len =3D strlen(path);
> + while (len && is_dir_sep(path[len - 1]))
> + len--;
> +
> + for (name =3D path + len - 1; name > path; name--)
> + if (is_dir_sep(*name)) {
> + name++;
> + break;
> + }
> + strbuf_addstr(&sb_repo,
> +       git_path("repos/%.*s", (int)(path + len - name), name));
> + len =3D sb_repo.len;
> + if (safe_create_leading_directories_const(sb_repo.buf))
> + die_errno(_("could not create leading directories of '%s'"),
> +   sb_repo.buf);
> + while (!stat(sb_repo.buf, &st)) {
> + counter++;
> + strbuf_setlen(&sb_repo, len);
> + strbuf_addf(&sb_repo, "%d", counter);
> + }
> + name =3D strrchr(sb_repo.buf, '/') + 1;
> + if (mkdir(sb_repo.buf, 0777))
> + die_errno(_("could not create directory of '%s'"), sb_repo.buf);
> +
> + strbuf_addf(&sb_git, "%s/.git", path);
> + if (safe_create_leading_directories_const(sb_git.buf))
> + die_errno(_("could not create leading directories of '%s'"),
> +   sb_git.buf);
> +
> + write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
> +    real_path(get_git_common_dir()), name);
> + /*
> + * This is to keep resolve_ref() happy. We need a valid HEAD
> + * or is_git_directory() will reject the directory. Any valid
> + * value would do because this value will be ignored and
> + * replaced at the next (real) checkout.
> + */
> + strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
> + write_file(sb.buf, 1, "%s\n",=20
> sha1_to_hex(new->commit->object.sha1));
> + strbuf_reset(&sb);
> + strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
> + write_file(sb.buf, 1, "../..\n");
> +
> + if (!opts->quiet)
> + fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
> +
> + setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
> + setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
> + setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
> + memset(&cp, 0, sizeof(cp));
> + cp.git_cmd =3D 1;
> + cp.argv =3D opts->saved_argv;
> + return run_command(&cp);
> +}
> +
> static int git_checkout_config(const char *var, const char *value,=20
> void *cb)
> {
>  if (!strcmp(var, "diff.ignoresubmodules")) {
> @@ -1067,6 +1145,9 @@ static int checkout_branch(struct checkout_opts=
=20
> *opts,
>  die(_("Cannot switch branch to a non-commit '%s'"),
>      new->name);
>
> + if (opts->new_worktree)
> + return prepare_linked_checkout(opts, new);
> +
>  if (!new->commit && opts->new_branch) {
>  unsigned char rev[20];
>  int flag;
> @@ -1109,6 +1190,8 @@ int cmd_checkout(int argc, const char **argv,=20
> const char *prefix)
>  N_("do not limit pathspecs to sparse entries only")),
>  OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
>  N_("second guess 'git checkout no-such-branch'")),
> + OPT_FILENAME(0, "to", &opts.new_worktree,
> +    N_("check a branch out in a separate working directory")),
>  OPT_END(),
>  };
>
> @@ -1117,6 +1200,9 @@ int cmd_checkout(int argc, const char **argv,=20
> const char *prefix)
>  opts.overwrite_ignore =3D 1;
>  opts.prefix =3D prefix;
>
> + opts.saved_argv =3D xmalloc(sizeof(const char *) * (argc + 2));
> + memcpy(opts.saved_argv, argv, sizeof(const char *) * (argc + 1));
> +
>  gitmodules_config();
>  git_config(git_checkout_config, &opts);
>
> @@ -1125,6 +1211,11 @@ int cmd_checkout(int argc, const char **argv,=20
> const char *prefix)
>  argc =3D parse_options(argc, argv, prefix, options, checkout_usage,
>       PARSE_OPT_KEEP_DASHDASH);
>
> + /* recursive execution from checkout_new_worktree() */
> + opts.new_worktree_mode =3D getenv("GIT_CHECKOUT_NEW_WORKTREE") !=3D=
=20
> NULL;
> + if (opts.new_worktree_mode)
> + opts.new_worktree =3D NULL;
> +
>  if (conflict_style) {
>  opts.merge =3D 1; /* implied */
>  git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
> diff --git a/path.c b/path.c
> index 8a6586c..e41d6b3 100644
> --- a/path.c
> +++ b/path.c
> @@ -92,7 +92,7 @@ static void replace_dir(struct strbuf *buf, int len=
,=20
> const char *newdir)
>
> static const char *common_list[] =3D {
>  "/branches", "/hooks", "/info", "/logs", "/lost-found", "/modules",
> - "/objects", "/refs", "/remotes", "/rr-cache", "/svn",
> + "/objects", "/refs", "/remotes", "/repos", "/rr-cache", "/svn",
>  "config", "gc.pid", "packed-refs", "shallow",
>  NULL
> };
> diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
> new file mode 100755
> index 0000000..8c73b18
> --- /dev/null
> +++ b/t/t2025-checkout-to.sh
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +
> +test_description=3D'test git checkout --to'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> + test_commit init
> +'
> +
> +test_expect_success 'checkout --to not updating paths' '
> + test_must_fail git checkout --to -- init.t
> +'
> +
> +test_expect_success 'checkout --to an existing worktree' '
> + mkdir existing &&
> + test_must_fail git checkout --detach --to existing master
> +'
> +
> +test_expect_success 'checkout --to a new worktree' '
> + git checkout --to here master &&
> + (
> + cd here &&
> + test_cmp ../init.t init.t &&
> + git symbolic-ref HEAD >actual &&
> + echo refs/heads/master >expect &&
> + test_cmp expect actual &&
> + git fsck
> + )
> +'
> +
> +test_expect_success 'checkout --to a new worktree from a subdir' '
> + (
> + mkdir sub &&
> + cd sub &&
> + git checkout --detach --to here master &&
> + cd here &&
> + test_cmp ../../init.t init.t
> + )
> +'
> +
> +test_expect_success 'checkout --to from a linked checkout' '
> + (
> + cd here &&
> + git checkout --to nested-here master
> + cd nested-here &&
> + git fsck
> + )
> +'
> +
> +test_expect_success 'checkout --to a new worktree creating new=20
> branch' '
> + git checkout --to there -b newmaster master &&
> + (
> + cd there &&
> + test_cmp ../init.t init.t &&
> + git symbolic-ref HEAD >actual &&
> + echo refs/heads/newmaster >expect &&
> + test_cmp expect actual &&
> + git fsck
> + )
> +'
> +
> +test_done
> --=20
> 2.1.0.rc0.78.gc0d8480
>
> --
Philip=20
