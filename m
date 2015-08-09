From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] worktree: list operation
Date: Sat, 8 Aug 2015 20:12:17 -0400
Message-ID: <CANoM8SV2mrvAkfi1-zVpc3ZWUNYdnygmqG=KMpkVmous0iKung@mail.gmail.com>
References: <1439066097-85217-1-git-send-email-rappazzo@gmail.com> <1439066097-85217-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 02:12:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOEEF-0006Jn-LJ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 02:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992795AbbHIAMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 20:12:39 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33964 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992728AbbHIAMi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 20:12:38 -0400
Received: by obbfr1 with SMTP id fr1so65277582obb.1
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PmOIPBkzlSvuuLYd0xt0GkGsPcTtL4GeQtoFC2SI3+4=;
        b=QsIU9Mrcr2AfUd828WkrQ/tUYziNnAD4fyiQ9JoB/NIN5DdxWtNGvg/EW8CStxze8t
         WeU945IKLWRuKgCxJRbwbrOnb7J7tqP81BY9lFIn9fN2gB9uskNNPdVOZ2WAOXIeydRM
         enFgKJjgxysmZtXxxZqWtcAKPamW/ONy/yIawBP/UWVeplOUXH69d4Tgc0F6HsSUViag
         SfratFfU+/Vk3xl3IPAdoxJwCDdWU+gfnHHA7VzWeQ4LtWKNGHY5163uGBMybgCDyD+m
         O5uP0/nN59ruY4ghEJC4ABtCrvvbumRQoxGZu+9/ZdkQP1mYSlU8obBprdD60d+sTmBW
         3fAA==
X-Received: by 10.60.79.193 with SMTP id l1mr13223930oex.60.1439079157364;
 Sat, 08 Aug 2015 17:12:37 -0700 (PDT)
Received: by 10.202.232.213 with HTTP; Sat, 8 Aug 2015 17:12:17 -0700 (PDT)
In-Reply-To: <1439066097-85217-2-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275520>

Withdrawn -- I staged but did not amend the final commit.   I will
adjust and resend.

On Sat, Aug 8, 2015 at 4:34 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> 'git worktree list' will list the main worktree followed by any linked
> worktrees which were created using 'git worktree add'.  The option
> '--main-only' will restrict the list to only the main worktree.
> ---
>  Documentation/git-worktree.txt |  9 ++++-
>  builtin/worktree.c             | 80 ++++++++++++++++++++++++++++++++++++++----
>  t/t2027-worktree-list.sh       | 68 +++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+), 7 deletions(-)
>  create mode 100755 t/t2027-worktree-list.sh
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 3387e2f..39b1330 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
>  'git worktree prune' [-n] [-v] [--expire <expire>]
> +'git worktree list' [--primary]
>
>  DESCRIPTION
>  -----------
> @@ -59,6 +60,10 @@ prune::
>
>  Prune working tree information in $GIT_DIR/worktrees.
>
> +list::
> +
> +List the primary worktree followed by all of the linked worktrees.
> +
>  OPTIONS
>  -------
>
> @@ -86,6 +91,9 @@ OPTIONS
>         With `prune`, do not remove anything; just report what it would
>         remove.
>
> +--primary::
> +       With `list`, only list the primary worktree.
> +
>  -v::
>  --verbose::
>         With `prune`, report all removals.
> @@ -167,7 +175,6 @@ performed manually, such as:
>  - `remove` to remove a linked worktree and its administrative files (and
>    warn if the worktree is dirty)
>  - `mv` to move or rename a worktree and update its administrative files
> -- `list` to list linked worktrees
>  - `lock` to prevent automatic pruning of administrative files (for instance,
>    for a worktree on a portable device)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 6a264ee..1ac1776 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -10,6 +10,7 @@
>  static const char * const worktree_usage[] = {
>         N_("git worktree add [<options>] <path> <branch>"),
>         N_("git worktree prune [<options>]"),
> +       N_("git worktree list [<options>]"),
>         NULL
>  };
>
> @@ -36,7 +37,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
>         fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
>         if (fd < 0) {
>                 strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
> -                           id, strerror(errno));
> +                                id, strerror(errno));
>                 return 1;
>         }
>         len = st.st_size;
> @@ -59,7 +60,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
>                  * accessed since?
>                  */
>                 if (!stat(git_path("worktrees/%s/link", id), &st_link) &&
> -                   st_link.st_nlink > 1)
> +                        st_link.st_nlink > 1)
>                         return 0;
>                 if (st.st_mtime <= expire) {
>                         strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
> @@ -187,7 +188,7 @@ static int add_worktree(const char *path, const char **child_argv)
>
>         name = worktree_basename(path, &len);
>         strbuf_addstr(&sb_repo,
> -                     git_path("worktrees/%.*s", (int)(path + len - name), name));
> +                               git_path("worktrees/%.*s", (int)(path + len - name), name));
>         len = sb_repo.len;
>         if (safe_create_leading_directories_const(sb_repo.buf))
>                 die_errno(_("could not create leading directories of '%s'"),
> @@ -225,7 +226,7 @@ static int add_worktree(const char *path, const char **child_argv)
>         strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
>         write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
>         write_file(sb_git.buf, 1, "gitdir: %s/worktrees/%s\n",
> -                  real_path(get_git_common_dir()), name);
> +                       real_path(get_git_common_dir()), name);
>         /*
>          * This is to keep resolve_ref() happy. We need a valid HEAD
>          * or is_git_directory() will reject the directory. Moreover, HEAD
> @@ -280,9 +281,9 @@ static int add(int ac, const char **av, const char *prefix)
>         struct option options[] = {
>                 OPT__FORCE(&force, N_("checkout <branch> even if already checked out in other worktree")),
>                 OPT_STRING('b', NULL, &new_branch, N_("branch"),
> -                          N_("create a new branch")),
> +                               N_("create a new branch")),
>                 OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
> -                          N_("create or reset a branch")),
> +                               N_("create or reset a branch")),
>                 OPT_BOOL(0, "detach", &detach, N_("detach HEAD at named commit")),
>                 OPT_END()
>         };
> @@ -316,6 +317,71 @@ static int add(int ac, const char **av, const char *prefix)
>         return add_worktree(path, cmd.argv);
>  }
>
> +static int list(int ac, const char **av, const char *prefix)
> +{
> +       int primary = 0;
> +       struct option options[] = {
> +               OPT_BOOL(0, "primary", &primary, N_("only list the primary worktree")),
> +               OPT_END()
> +       };
> +
> +       ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
> +       if (ac)
> +               usage_with_options(worktree_usage, options);
> +
> +       const char *work_tree;
> +       work_tree = get_git_work_tree();
> +       if (!work_tree)
> +               die("This operation must be run in a work tree");
> +
> +       struct strbuf worktree_git_path = STRBUF_INIT;
> +       strbuf_addf(&worktree_git_path, _("%s/.git"), work_tree);
> +
> +       struct strbuf primary_work_tree = STRBUF_INIT;
> +       if (is_directory(worktree_git_path.buf)) {
> +               /* This is the primary tree */
> +               strbuf_addstr(&primary_work_tree, work_tree);
> +       } else {
> +               const char *git_dir = get_git_dir();
> +               strbuf_addf(&primary_work_tree, "%.*s", (int)(strstr(git_dir, "/.git/") - git_dir), git_dir);
> +       }
> +       printf("%s\n", primary_work_tree.buf);
> +
> +       if (!primary) {
> +               chdir( primary_work_tree.buf );
> +               if ( is_directory(git_path("worktrees")) ) {
> +                       DIR *dir = opendir( git_path("worktrees") );
> +                       if (dir != NULL) {
> +                       struct dirent *d;
> +                               struct stat st;
> +                               char *path;
> +                               int fd, len;
> +                               while ((d = readdir(dir)) != NULL) {
> +                                       if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +                                               continue;
> +                                       if (stat(git_path("worktrees/%s/gitdir", d->d_name), &st))
> +                                               continue;
> +                                       fd = open(git_path("worktrees/%s/gitdir", d->d_name), O_RDONLY);
> +                                       if (fd < 0)
> +                                               continue;
> +
> +                                       len = st.st_size;
> +                                       path = xmalloc(len + 1);
> +                                       read_in_full(fd, path, len);
> +                                       close(fd);
> +
> +                                       printf("%.*s\n", (int)(strstr(path, "/.git") - path), path);
> +                                       free(path);
> +                               }
> +                       }
> +                       closedir(dir);
> +               }
> +       }
> +       strbuf_release(&primary_work_tree);
> +       strbuf_release(&worktree_git_path);
> +       return 0;
> +}
> +
>  int cmd_worktree(int ac, const char **av, const char *prefix)
>  {
>         struct option options[] = {
> @@ -328,5 +394,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
>                 return add(ac - 1, av + 1, prefix);
>         if (!strcmp(av[1], "prune"))
>                 return prune(ac - 1, av + 1, prefix);
> +       if (!strcmp(av[1], "list"))
> +               return list(ac - 1, av + 1, prefix);
>         usage_with_options(worktree_usage, options);
>  }
> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> new file mode 100755
> index 0000000..ff48d72
> --- /dev/null
> +++ b/t/t2027-worktree-list.sh
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +
> +test_description='test git worktree list'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       test_commit init
> +'
> +
> +
> +test_expect_success '"list" all worktrees from primary' '
> +       orig_path=$PWD &&
> +       git rev-parse --show-toplevel >expect &&
> +       git worktree add --detach here master &&
> +       (
> +               cd here &&
> +               git rev-parse --show-toplevel >>"$orig_path/expect" &&
> +               cd "$orig_path" &&
> +               git worktree list >actual &&
> +               test_cmp expect actual &&
> +               rm -rf here &&
> +               git worktree prune
> +       )
> +'
> +test_expect_success '"list" all worktrees from linked' '
> +       orig_path=$PWD &&
> +       git rev-parse --show-toplevel >expect &&
> +       git worktree add --detach here master &&
> +       (
> +               cd here &&
> +               git rev-parse --show-toplevel >>"$orig_path/expect" &&
> +               git worktree list >actual &&
> +               test_cmp "$orig_path/expect" actual &&
> +               cd "$orig_path" &&
> +               rm -rf here &&
> +               git worktree prune
> +       )
> +'
> +
> +test_expect_success '"list" main worktree from primary' '
> +       orig_path=$PWD &&
> +       git rev-parse --show-toplevel >expect &&
> +       git worktree add --detach here master &&
> +       (
> +               cd here &&
> +               cd "$orig_path" &&
> +               git worktree list --primary >actual &&
> +               test_cmp expect actual &&
> +               rm -rf here &&
> +               git worktree prune
> +       )
> +'
> +test_expect_success '"list" main worktree from linked' '
> +       orig_path=$PWD &&
> +       git rev-parse --show-toplevel >expect &&
> +       git worktree add --detach here master &&
> +       (
> +               cd here &&
> +               git worktree list --primary >actual &&
> +               test_cmp "$orig_path/expect" actual &&
> +               cd "$orig_path" &&
> +               rm -rf here &&
> +               git worktree prune
> +       )
> +'
> +
> +test_done
> --
> 2.5.0
>
