From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 7/7] submodule: implement `module_clone` as a builtin helper
Date: Mon, 17 Aug 2015 17:26:11 -0700
Message-ID: <CAGZ79kZYk8_266eAtmW72XWNP7xAvQTkdLS8-XTSj_NioiN2-g@mail.gmail.com>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
	<1439857323-21048-8-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:26:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRUjI-0001Hx-Qc
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 02:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbbHRA0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 20:26:12 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34924 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbHRA0M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 20:26:12 -0400
Received: by ykbi184 with SMTP id i184so78837209ykb.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 17:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iTUNDzORHLyqXPi7FcrOrkIPMenZrmCLJji018194Nk=;
        b=jwqadCrJW7OQU3VZR1/lBLoKS9DCR/T5a4/nNupoCQDENGUSJZNtuvB9SNu6wMuijo
         wmGANSvnx4qm9s+uH25S+V6teABAuF5K4tJsMj6TB3wntQsTMf759cfsKdRCqzQho56g
         ijQHQJhDrWIL8yKsuQj7vC+1VnfRB/UxYISf+iqtuYml6hsxVGTeWW4riGbtN3BeC9DR
         f7G58lmqKwcHYtWES+WQhNj3pg1tYTSN6QImVsDmlWcv/mq5d5Q13+6fFR4bSQGCGirw
         48G3nlwxhmtNI/ON4t8NxwMJOxzgM5XxnvrdJCUj6QWEmhoZwWEgOdtzDfbUfsHEz6vI
         UhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=iTUNDzORHLyqXPi7FcrOrkIPMenZrmCLJji018194Nk=;
        b=GzF/NApQB85/K1WNpUbeZ0XgZj3NOXJTdNVk1UMcNlHIDbNcp73u9uAtqNIoHdTB9i
         tlPuGRD1grx/QbtDV0fCCivZb1bzwcXTyPzorZyem+rk3NuFeO6X32vx7AVDYwUepqXc
         nSkWd77Ar4Aundh+up0ZdjmIMTIHobAOLu3YZ9vIPnkx6DXwoYo/2rRc4anh+F8NvWf5
         9xnhBfYaHlmgsA55fPa0KiUxadX1PzOwHmCnpZCZaQFgc+82D4NpiyDEWsD+Imt9eH8e
         xJNUkM3zV75oVrupI8pvFsJ+nksBXqboyizaRe5jEWOVlJUgR4aT905Ed72ZvP4jgimn
         omlw==
X-Gm-Message-State: ALoCoQl2HE3XGKsdkmNf7tdujehRfhg4AiSXgQS5vbdl2FfQEo6Mh8qLfrFSpk0dQabXXgHANDXe
X-Received: by 10.170.200.212 with SMTP id r203mr4188050yke.10.1439857571069;
 Mon, 17 Aug 2015 17:26:11 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Mon, 17 Aug 2015 17:26:11 -0700 (PDT)
In-Reply-To: <1439857323-21048-8-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276118>

On Mon, Aug 17, 2015 at 5:22 PM, Stefan Beller <sbeller@google.com> wrote:
> `module_clone` is part of the update command, which I want to convert
> to C next.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 161 +++++++++++++++++++++++++++++++++++++++++++-
>  git-submodule.sh            |  78 +--------------------
>  2 files changed, 162 insertions(+), 77 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 80d13f5..44ff935 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -8,6 +8,7 @@
>  #include "submodule.h"
>  #include "submodule-config.h"
>  #include "string-list.h"
> +#include "run-command.h"
>
>  static const struct cache_entry **ce_entries;
>  static int ce_alloc, ce_used;
> @@ -124,6 +125,156 @@ static int module_name(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +static int clone_submodule(const char *path, const char *gitdir, const char *url,
> +                          const char *depth, const char *reference, int quiet)
> +{
> +       struct child_process cp;
> +       child_process_init(&cp);
> +
> +       argv_array_push(&cp.args, "clone");
> +       argv_array_push(&cp.args, "--no-checkout");
> +       if (quiet)
> +               argv_array_push(&cp.args, "--quiet");
> +       if (depth && strcmp(depth, "")) {
> +               argv_array_push(&cp.args, "--depth");
> +               argv_array_push(&cp.args, depth);
> +       }
> +       if (reference && strcmp(reference, "")) {
> +               argv_array_push(&cp.args, "--reference");
> +               argv_array_push(&cp.args, reference);
> +       }
> +       if (gitdir) {
> +               argv_array_push(&cp.args, "--separate-git-dir");
> +               argv_array_push(&cp.args, gitdir);
> +       }
> +       argv_array_push(&cp.args, url);
> +       argv_array_push(&cp.args, path);
> +
> +       cp.git_cmd = 1;
> +       cp.env = local_repo_env;
> +
> +       cp.no_stdin = 1;
> +       cp.no_stdout = 1;
> +       cp.no_stderr = 1;
> +       return run_command(&cp);
> +}
> +
> +/*
> + * Clone a submodule
> + *
> + * $1 = submodule path
> + * $2 = submodule name
> + * $3 = URL to clone
> + * $4 = reference repository to reuse (empty for independent)
> + * $5 = depth argument for shallow clones (empty for deep)
> + *
> + * Prior to calling, cmd_update checks that a possibly existing
> + * path is not a git repository.
> + * Likewise, cmd_add checks that path does not exist at all,
> + * since it is the location of a new submodule.
> + */
> +static int module_clone(int argc, const char **argv, const char *prefix)
> +{
> +       const char *path = NULL, *name = NULL, *url = NULL, *reference = NULL, *depth = NULL;
> +       int quiet = 0;
> +       FILE *submodule_dot_git;
> +       const char *sm_gitdir, *p;
> +       struct strbuf rel_path = STRBUF_INIT;
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       struct option module_update_options[] = {
> +               OPT_STRING(0, "prefix", &alternative_path,
> +                          N_("path"),
> +                          N_("alternative anchor for relative paths")),
> +               OPT_STRING(0, "path", &path,
> +                          N_("path"),
> +                          N_("where the new submodule will be cloned to")),
> +               OPT_STRING(0, "name", &name,
> +                          N_("string"),
> +                          N_("name of the new submodule")),
> +               OPT_STRING(0, "url", &url,
> +                          N_("string"),
> +                          N_("url where to clone the submodule from")),
> +               OPT_STRING(0, "reference", &reference,
> +                          N_("string"),
> +                          N_("reference repository")),
> +               OPT_STRING(0, "depth", &depth,
> +                          N_("string"),
> +                          N_("depth for shallow clones")),
> +               OPT_END()
> +       };
> +
> +       static const char * const git_submodule_helper_usage[] = {
> +               N_("git submodule--helper update [--prefix=<path>] [--quiet] [--remote] [-N|--no-fetch]"
> +                  "[-f|--force] [--rebase|--merge] [--reference <repository>]"
> +                  "[--depth <depth>] [--recursive] [--] [<path>...]"),
> +               NULL
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, module_update_options,
> +                            git_submodule_helper_usage, 0);
> +
> +       if (getenv("GIT_QUIET"))
> +               quiet = 1;
> +
> +       strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> +       sm_gitdir = strbuf_detach(&sb, NULL);
> +       strbuf_reset(&sb);
> +
> +       if (!file_exists(sm_gitdir)) {
> +               safe_create_leading_directories_const(sm_gitdir);
> +               if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
> +                       die(N_("Clone of '%s' into submodule path '%s' failed"),
> +                           url, path);
> +       } else {
> +               safe_create_leading_directories_const(path);
> +               unlink(sm_gitdir);
> +       }
> +
> +       /* Write a .git file in the submodule to redirect to the superproject. */
> +       const char *t;

declaration after statement.

> +       if (alternative_path && !strcmp(alternative_path, "")) {
> +               t = relative_path(path, alternative_path, &sb);
> +               strbuf_reset(&sb);
> +       } else
> +               t = path;
> +
> +       if (safe_create_leading_directories_const(t) < 0)
> +               die("Could not create directory '%s'", t);
> +
> +       strbuf_addf(&sb, "%s/.git", t);
> +
> +       if (safe_create_leading_directories_const(sb.buf) < 0)
> +               die(_("could not create leading directories of '%s'"), sb.buf);
> +       submodule_dot_git = fopen(sb.buf, "w");
> +       if (!submodule_dot_git)
> +               die ("Cannot open file '%s': %s", sb.buf, strerror(errno)       );
> +
> +       fprintf(submodule_dot_git, "gitdir: %s\n",
> +               relative_path(sm_gitdir, path, &rel_path));
> +       if (fclose(submodule_dot_git))
> +               die("Could not close file %s", sb.buf);
> +       strbuf_reset(&sb);
> +
> +       /* Redirect the worktree of the submodule in the superprojects config */
> +       if (!is_absolute_path(sm_gitdir)) {
> +               char *s = (char*)sm_gitdir;
> +               strbuf_addf(&sb, "%s/%s", xgetcwd(), sm_gitdir);
> +               sm_gitdir = strbuf_detach(&sb, NULL);
> +               strbuf_reset(&sb);
> +               free(s);
> +       }
> +       strbuf_addf(&sb, "%s/%s", xgetcwd(), path);
> +       t = relative_path(sb.buf, sm_gitdir, &rel_path);
> +
> +       p = git_pathdup_submodule(path, "config");
> +       if (!p)
> +               die("Could not get submodule directory for '%s'", path);
> +       git_config_set_in_file(p, "core.worktree", t);
> +       strbuf_release(&sb);
> +       return 0;
> +}
> +
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>  {
>         if (argc < 2)
> @@ -135,6 +286,14 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>         if (!strcmp(argv[1], "module_name"))
>                 return module_name(argc - 2, argv + 2, prefix);
>
> +       if (!strcmp(argv[1], "module_clone"))
> +               return module_clone(argc - 1, argv + 1, prefix);
> +       if (!strcmp(argv[1], "test")) {
> +               struct strbuf sb = STRBUF_INIT;
> +
> +               relative_path(".git/modules/example", "init", &sb);
> +               return 0;
> +       }
>  usage:
> -       usage("git submodule--helper [module_list module_name]\n");
> +       usage("git submodule--helper [module_list module_name module_clone]\n");
>  }
> diff --git a/git-submodule.sh b/git-submodule.sh
> index e6ff38d..6e8561e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -178,80 +178,6 @@ get_submodule_config () {
>         printf '%s' "${value:-$default}"
>  }
>
> -#
> -# Clone a submodule
> -#
> -# $1 = submodule path
> -# $2 = submodule name
> -# $3 = URL to clone
> -# $4 = reference repository to reuse (empty for independent)
> -# $5 = depth argument for shallow clones (empty for deep)
> -#
> -# Prior to calling, cmd_update checks that a possibly existing
> -# path is not a git repository.
> -# Likewise, cmd_add checks that path does not exist at all,
> -# since it is the location of a new submodule.
> -#
> -module_clone()
> -{
> -       sm_path=$1
> -       name=$2
> -       url=$3
> -       reference="$4"
> -       depth="$5"
> -       quiet=
> -       if test -n "$GIT_QUIET"
> -       then
> -               quiet=-q
> -       fi
> -
> -       gitdir=
> -       gitdir_base=
> -       base_name=$(dirname "$name")
> -
> -       gitdir=$(git rev-parse --git-dir)
> -       gitdir_base="$gitdir/modules/$base_name"
> -       gitdir="$gitdir/modules/$name"
> -
> -       if test -d "$gitdir"
> -       then
> -               mkdir -p "$sm_path"
> -               rm -f "$gitdir/index"
> -       else
> -               mkdir -p "$gitdir_base"
> -               (
> -                       clear_local_git_env
> -                       git clone $quiet ${depth:+"$depth"} -n ${reference:+"$reference"} \
> -                               --separate-git-dir "$gitdir" "$url" "$sm_path"
> -               ) ||
> -               die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
> -       fi
> -
> -       # We already are at the root of the work tree but cd_to_toplevel will
> -       # resolve any symlinks that might be present in $PWD
> -       a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
> -       b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
> -       # Remove all common leading directories after a sanity check
> -       if test "${a#$b}" != "$a" || test "${b#$a}" != "$b"; then
> -               die "$(eval_gettext "Gitdir '\$a' is part of the submodule path '\$b' or vice versa")"
> -       fi
> -       while test "${a%%/*}" = "${b%%/*}"
> -       do
> -               a=${a#*/}
> -               b=${b#*/}
> -       done
> -       # Now chop off the trailing '/'s that were added in the beginning
> -       a=${a%/}
> -       b=${b%/}
> -
> -       # Turn each leading "*/" component into "../"
> -       rel=$(printf '%s\n' "$b" | sed -e 's|[^/][^/]*|..|g')
> -       printf '%s\n' "gitdir: $rel/$a" >"$sm_path/.git"
> -
> -       rel=$(printf '%s\n' "$a" | sed -e 's|[^/][^/]*|..|g')
> -       (clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
> -}
> -
>  isnumber()
>  {
>         n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
> @@ -412,7 +338,7 @@ Use -f if you really want to add it." >&2
>                                 echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
>                         fi
>                 fi
> -               module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" || exit
> +               git submodule--helper module_clone --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" --reference "$reference_path" --depth "$depth" || exit
>                 (
>                         clear_local_git_env
>                         cd "$sm_path" &&
> @@ -774,7 +700,7 @@ Maybe you want to use 'update --init'?")"
>
>                 if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
>                 then
> -                       module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
> +                       git submodule--helper module_clone --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
>                         cloned_modules="$cloned_modules;$name"
>                         subsha1=
>                 else
> --
> 2.5.0.330.g130be8e.dirty
>
