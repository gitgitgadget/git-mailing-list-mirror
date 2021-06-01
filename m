Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21257C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 22:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F55613BD
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 22:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhFAWMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 18:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhFAWMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 18:12:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A95C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 15:10:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g8so784943ejx.1
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dU9vske5O/Dqxr7i5uGEBSzpMbigIESdboDeFRuxhiA=;
        b=jxVJUSVhPn7KENJXa9iTMLD4jmRd+C5MSbCM46ElMqZyavpAh5iwYPQ4lQoJje1Tdz
         VKkF7W+AmwwPyKraDrQ/HbuUJETlsTxT9XwP4E9iIQ+WuxTduP2tNJaJkKetWJNf/i9Q
         kWpDkc357wMKNPF+qBWzSSB1E5NU0aBrJe8qh7ORK5JS/oBFJd0ZbMyIjiwNtsoNO8Ie
         DL0SpKRuhabntYZA4FQFpL7LCqVX4sIOFFc9yZAES0ipNyRawDAtZSRIPuNOECAQOaHl
         30+q1QtiP6tP3rnCIp7zJjcGd8XDdwDomteqOIsJeGVtAzuSyLpZuyKKdgjcyjWCUAPx
         xdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dU9vske5O/Dqxr7i5uGEBSzpMbigIESdboDeFRuxhiA=;
        b=OobmRYGwb5pQY1t9lTLSoCyNyDOx3nuPv9Ef+N4hpUKCdyAlUyAoqJnXKQssR2sX9T
         DEyT69fN0jKRH/7ViMQLBrwwyahQB3oNMfPS3grWHAR27ZpHCEjXVqpGgvlVbON4lb6z
         2/mc4xyrEd9l/5JMjtWUgo+8LXGlNofP3qiAn5Uvv0fErRLheouGgWy1SVVIOMCfKx19
         YzwEXVnJ8c+IFEUW2bK4KtdJ5XUbRi9by3aE4Qm/22hnpUINpy67gQ7Exfj8CYS1h66t
         xAc5JC3JnIuRK7isP+ewr+wpYF1g9PojmwSQOqeHM3qVC62tmy/zKhSxf8qOFjr85ktJ
         QynQ==
X-Gm-Message-State: AOAM5302NMomj5FiW7gnwcNJ2fmTzhTeB9nWRMrkMw5F0bjXN2dh/FxI
        WKGd0lHR77oqJQg0WHdsisptVSnXo2W4dbpqVaI=
X-Google-Smtp-Source: ABdhPJz1ZL7fjOHxtXR6Ioi5770S3A/+jkirXTccLeuryvr/SwovQhZcL3GR4EvOGfB0V8y5zkTPrido/h3GjOAACcI=
X-Received: by 2002:a17:906:3598:: with SMTP id o24mr17996217ejb.551.1622585424962;
 Tue, 01 Jun 2021 15:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210528081224.69163-1-raykar.ath@gmail.com>
In-Reply-To: <20210528081224.69163-1-raykar.ath@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 2 Jun 2021 00:10:13 +0200
Message-ID: <CAP8UFD3SMghGb0y0jKuLScrKqqHgZFDxW1c97MwoEz+1hXt1hA@mail.gmail.com>
Subject: Re: [PATCH][GSoC] submodule: introduce add-clone helper for submodule add
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 10:13 AM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> Convert the the shell code that performs the cloning of the repository that is

s/the the/the/

> to be added, and checks out to the appropriate branch.

Something a bit more explicit might make things easier to understand.
For example:

"Let's add a new "add-clone" subcommand to `git submodule--helper`
with the goal of converting part of the shell code in git-submodule.sh
related to `git submodule add` into C code. This new subcommand clones
the repository that is to be added, and checks out to the appropriate
branch."

Then a simpler title could be:

"submodule--helper: introduce add-clone subcommand"

> This is meant to be a faithful conversion that leaves the behaviour of
> 'submodule add' unchanged. The only minor change is that if a submodule name has
> been supplied with a name that clashes with a local submodule, the message shown
> to the user ("A git directory for 'foo' is found locally...") is prepended with
> "error" for clarity.

Good.

> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> Based-on-patch-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>
> This is part of a series of changes that will result in all of 'submodule add'
> being converted to C, which is a more familiar language for Git developers, and
> paves the way to improve performance and portability.
>
> I have made this patch based on Shourya's patch[1]. I have decided to send the
> changes in smaller, more reviewable parts. The add-clone subcommand of
> submodule--helper is an intermediate change, while I work on translating all of
> the code. So in the next few patches, this helper subcommand is likely to be
> removed as its functionality would be invoked from the C code itself.

It might be a good idea to let us know how many such new subcommands
you'd like to introduce before removing them.

Anyway I think it's a good idea to send changes in smaller, more
easily reviewable parts. Hopefully this way more work will end up
being merged.

> [1] https://lore.kernel.org/git/20201214231939.644175-1-periperidip@gmail.com/
>
>  builtin/submodule--helper.c | 221 ++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  38 +------
>  2 files changed, 222 insertions(+), 37 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d55f6262e9..39a844b0b1 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2745,6 +2745,226 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
>         return !!ret;
>  }
>
> +struct add_data {
> +       const char *prefix;
> +       const char *branch;
> +       const char *reference_path;
> +       const char *sm_path;
> +       const char *sm_name;
> +       const char *repo;
> +       const char *realrepo;
> +       int depth;
> +       unsigned int force: 1;
> +       unsigned int quiet: 1;
> +       unsigned int progress: 1;
> +       unsigned int dissociate: 1;
> +};
> +#define ADD_DATA_INIT { 0 }
> +
> +static char *parse_token(char **begin, const char *end)
> +{
> +       int size;
> +       char *token, *pos = *begin;
> +       while (pos != end && (*pos != ' ' && *pos != '\t' && *pos != '\n'))
> +               pos++;
> +       size = pos - *begin;
> +       token = xstrndup(*begin, size);
> +       *begin = pos + 1;
> +       return token;
> +}
> +
> +static char *get_next_line(char *const begin, const char *const end)
> +{
> +       char *pos = begin;
> +       while (pos != end && *pos++ != '\n');
> +       return pos;
> +}
> +
> +static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
> +{
> +       struct child_process cp_remote = CHILD_PROCESS_INIT;
> +       struct strbuf sb_remote_out = STRBUF_INIT;
> +
> +       cp_remote.git_cmd = 1;
> +       strvec_pushf(&cp_remote.env_array,
> +                    "GIT_DIR=%s", git_dir_path);
> +       strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=.");
> +       strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
> +       if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
> +               char *next_line, *name, *url, *tail;

Maybe name, url and tail could be declared in the while loop below
where they are used.

> +               char *begin = sb_remote_out.buf;
> +               char *end = sb_remote_out.buf + sb_remote_out.len;
> +               while (begin != end &&
> +                      (next_line = get_next_line(begin, end))) {

It would be nice if the above 2 lines could be reduced into just one
line. Maybe renaming "next_line" to just "line" could help with that.

> +                       name = parse_token(&begin, next_line);
> +                       url = parse_token(&begin, next_line);
> +                       tail = parse_token(&begin, next_line);
> +                       if (!memcmp(tail, "(fetch)", 7))
> +                               fprintf(output, "  %s\t%s\n", name, url);
> +                       free(url);
> +                       free(name);
> +                       free(tail);
> +               }
> +       }
> +
> +       strbuf_release(&sb_remote_out);
> +}
> +
> +static int add_submodule(const struct add_data *info)
> +{
> +       char *submod_gitdir_path;
> +       /* perhaps the path already exists and is already a git repo, else clone it */
> +       if (is_directory(info->sm_path)) {
> +               printf("sm_path=%s\n", info->sm_path);

Is this a leftover debug statement?

> +               submod_gitdir_path = xstrfmt("%s/.git", info->sm_path);
> +               if (is_directory(submod_gitdir_path) || file_exists(submod_gitdir_path))
> +                       printf(_("Adding existing path at '%s' to index\n"),
> +                              info->sm_path);
> +               else
> +                       die(_("'%s' already exists and is not a valid git repo"),
> +                           info->sm_path);
> +               free(submod_gitdir_path);
> +       } else {
> +               struct strvec clone_args = STRVEC_INIT;
> +               struct child_process cp = CHILD_PROCESS_INIT;
> +               submod_gitdir_path = xstrfmt(".git/modules/%s", info->sm_name);
> +
> +               if (is_directory(submod_gitdir_path)) {
> +                       if (!info->force) {
> +                               error(_("A git directory for '%s' is found "
> +                                       "locally with remote(s):"), info->sm_name);
> +                               show_fetch_remotes(stderr, info->sm_name,
> +                                                  submod_gitdir_path);
> +                               fprintf(stderr,
> +                                       _("If you want to reuse this local git "
> +                                         "directory instead of cloning again from\n"
> +                                         "  %s\n"
> +                                         "use the '--force' option. If the local git "
> +                                         "directory is not the correct repo\n"
> +                                         "or if you are unsure what this means, choose "
> +                                         "another name with the '--name' option.\n"),
> +                                       info->realrepo);
> +                               free(submod_gitdir_path);
> +                               return 1;
> +                       } else {
> +                               printf(_("Reactivating local git directory for "
> +                                        "submodule '%s'\n"), info->sm_name);
> +                       }
> +               }
> +               free(submod_gitdir_path);
> +
> +               strvec_push(&clone_args, "clone");
> +
> +               if (info->quiet)
> +                       strvec_push(&clone_args, "--quiet");
> +
> +               if (info->progress)
> +                       strvec_push(&clone_args, "--progress");
> +
> +               if (info->prefix)
> +                       strvec_pushl(&clone_args, "--prefix", info->prefix, NULL);
> +
> +               strvec_pushl(&clone_args, "--path", info->sm_path, "--name",
> +                            info->sm_name, "--url", info->realrepo, NULL);

Maybe this unconditional strvec_pushl(...) could be squashed into the
strvec_push(&clone_args, "clone") above.

> +               if (info->reference_path)
> +                       strvec_pushl(&clone_args, "--reference",
> +                                    info->reference_path, NULL);
> +
> +               if (info->dissociate)
> +                       strvec_push(&clone_args, "--dissociate");
> +

Blank lines since the above strvec_push(&clone_args, "clone") could
perhaps be removed.

> +               if (info->depth >= 0)
> +                       strvec_pushf(&clone_args, "--depth=%d", info->depth);
> +
> +               if (module_clone(clone_args.nr, clone_args.v, info->prefix)) {
> +                       strvec_clear(&clone_args);
> +                       return -1;
> +               }
> +               strvec_clear(&clone_args);
> +
> +               prepare_submodule_repo_env(&cp.env_array);
> +               cp.git_cmd = 1;
> +               cp.dir = info->sm_path;
> +               strvec_pushl(&cp.args, "checkout", "-f", "-q", NULL);
> +
> +               if (info->branch) {
> +                       strvec_pushl(&cp.args, "-B", info->branch, NULL);
> +                       strvec_pushf(&cp.args, "origin/%s", info->branch);
> +               }
> +
> +               if (run_command(&cp))
> +                       die(_("unable to checkout submodule '%s'"), info->sm_path);
> +       }
> +       return 0;
> +}
> +
> +static int add_clone(int argc, const char **argv, const char *prefix)
> +{
> +       const char *branch = NULL, *sm_path = NULL;
> +       const char *wt_prefix = NULL, *realrepo = NULL;
> +       const char *reference = NULL, *sm_name = NULL;
> +       int force = 0, quiet = 0, dissociate = 0, depth = -1, progress = 0;
> +       struct add_data info = ADD_DATA_INIT;
> +
> +       struct option options[] = {
> +               OPT_STRING('b', "branch", &branch,
> +                          N_("branch"),
> +                          N_("branch of repository to checkout on cloning")),
> +               OPT_STRING(0, "prefix", &wt_prefix,
> +                          N_("path"),
> +                          N_("alternative anchor for relative paths")),
> +               OPT_STRING(0, "path", &sm_path,
> +                          N_("path"),
> +                          N_("where the new submodule will be cloned to")),
> +               OPT_STRING(0, "name", &sm_name,
> +                          N_("string"),
> +                          N_("name of the new submodule")),
> +               OPT_STRING(0, "url", &realrepo,
> +                          N_("string"),
> +                          N_("url where to clone the submodule from")),
> +               OPT_STRING(0, "reference", &reference,
> +                          N_("repo"),
> +                          N_("reference repository")),
> +               OPT_BOOL(0, "dissociate", &dissociate,
> +                          N_("use --reference only while cloning")),
> +               OPT_INTEGER(0, "depth", &depth,
> +                           N_("depth for shallow clones")),
> +               OPT_BOOL(0, "progress", &progress,
> +                          N_("force cloning progress")),
> +               OPT_BOOL('f', "force", &force,
> +                        N_("allow adding an otherwise ignored submodule path")),
> +               OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
> +               OPT_END()
> +       };
> +
> +       const char *const usage[] = {
> +               N_("git submodule--helper clone [--prefix=<path>] [--quiet] [--force] "

s/clone/add-clone/

> +                  "[--reference <repository>] [--depth <depth>] [-b|--branch <branch>]"
> +                  "--url <url> --path <path> --name <name>"),

The --progress and --dissociate options seem to be missing.

> +               NULL
> +       };
