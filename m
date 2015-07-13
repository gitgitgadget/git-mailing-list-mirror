From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 12/44] builtin-am: implement --skip
Date: Mon, 13 Jul 2015 12:05:21 -0700
Message-ID: <CAGZ79kaWV-hMEgJ8HJP2Jgq78su+YbyBbcYD3sZ0474UUNw=pA@mail.gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<1436278862-2638-13-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 21:05:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEj2p-0000MH-57
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 21:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbbGMTFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 15:05:23 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34280 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbbGMTFW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 15:05:22 -0400
Received: by ykax123 with SMTP id x123so75874011yka.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/xl88W9/Yb22FWOAzuTK533LSsfkl6qdLSK8mUeIk9g=;
        b=Lm51RQqIVL7zy3yWl+4aTFCjxcqrVCq874cZZjl73WyoRiVLwmldNH8YzIgLiYd9PD
         z013HY5gHJ+bCJSV1eP5PCez29dkHYu/Px4wI4z6ixSHVoSW8aqvcAb9e52l5Oq9q8XW
         Y/rR8XUrtDVsASWBxgDapVC12lluZS8u87c2jo4HsZWe5EcwWpej7QmX6EWQRdonvU2F
         uveXWnNpGrIAJe9BwrapSza8uX73Y4y844fyyaqfZNqhNogyNsY3Cuerzp/0QHkXSt2S
         BM+jq3B8b17DeUxHnezqIxp1cD3y1WPZJgA+WCknt1QkKijFyq0BFXoM4cgRWIMGJ+Za
         pu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/xl88W9/Yb22FWOAzuTK533LSsfkl6qdLSK8mUeIk9g=;
        b=jl87CnMcfEAmiXAvui6W+L0OVXDUDg5VmLuKgXNJ2/aklDIdPxxeEEYSewsh2uKhGV
         7NTAJ9jbBOzAn8yUASJXGeOnEdZI+IZfQspoiC1gWmfPA5u4kJ0wZaelzq1R1OGLdIRa
         w6u2p9j54g0eETR7AvfnqQe9Z3rZ+UOiUgrvoCDAXTXbFmc3P4JBY9CHeIIDwi6o8rmr
         yLfJzUh85wT+nkgsfnu1L0yEhT2mhiRo40dr3FbTbgvaB+s2WBqHr3KCRRbuPkWNatJs
         I9mYMajztNDZby8hkhGOYZZzXXU6ChtCSvhh9onrJ02pnRbE4vfnNC7G8JQgHViXTisK
         NObw==
X-Gm-Message-State: ALoCoQkaAAWcLluSxrZZMV4LiJXv4kLj8DR0s55VHO/7mbG+BqE1I9GOTTXJ4Efb7FsfX2xBbN5q
X-Received: by 10.129.101.135 with SMTP id z129mr38209414ywb.81.1436814321613;
 Mon, 13 Jul 2015 12:05:21 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Mon, 13 Jul 2015 12:05:21 -0700 (PDT)
In-Reply-To: <1436278862-2638-13-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273922>

On Tue, Jul 7, 2015 at 7:20 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
> supported resuming from a failed patch application by skipping the
> current patch. Re-implement this feature by introducing am_skip().
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/am.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 119 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index f21565b..5087094 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -16,6 +16,8 @@
>  #include "commit.h"
>  #include "diff.h"
>  #include "diffcore.h"
> +#include "unpack-trees.h"
> +#include "branch.h"
>
>  /**
>   * Returns 1 if the file is empty or does not exist, 0 otherwise.
> @@ -872,6 +874,114 @@ static void am_resolve(struct am_state *state)
>  }
>
>  /**
> + * Performs a checkout fast-forward from `head` to `remote`. If `reset` is
> + * true, any unmerged entries will be discarded. Returns 0 on success, -1 on
> + * failure.
> + */
> +static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
> +{
> +       struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
> +       struct unpack_trees_options opts;
> +       struct tree_desc t[2];
> +
> +       if (parse_tree(head) || parse_tree(remote))
> +               return -1;
> +
> +       hold_locked_index(lock_file, 1);
> +
> +       refresh_cache(REFRESH_QUIET);
> +
> +       memset(&opts, 0, sizeof(opts));
> +       opts.head_idx = 1;
> +       opts.src_index = &the_index;
> +       opts.dst_index = &the_index;
> +       opts.update = 1;
> +       opts.merge = 1;
> +       opts.reset = reset;
> +       opts.fn = twoway_merge;
> +       init_tree_desc(&t[0], head->buffer, head->size);
> +       init_tree_desc(&t[1], remote->buffer, remote->size);
> +
> +       if (unpack_trees(2, t, &opts)) {
> +               rollback_lock_file(lock_file);
> +               return -1;
> +       }
> +
> +       if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
> +               die(_("unable to write new index file"));
> +
> +       return 0;
> +}
> +
> +/**
> + * Clean the index without touching entries that are not modified between
> + * `head` and `remote`.
> + */
> +static int clean_index(const unsigned char *head, const unsigned char *remote)
> +{
> +       struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
> +       struct tree *head_tree, *remote_tree, *index_tree;
> +       unsigned char index[GIT_SHA1_RAWSZ];
> +       struct pathspec pathspec;
> +
> +       head_tree = parse_tree_indirect(head);
> +       if (!head_tree)
> +               return error(_("Could not parse object '%s'."), sha1_to_hex(head));
> +
> +       remote_tree = parse_tree_indirect(remote);
> +       if (!remote_tree)
> +               return error(_("Could not parse object '%s'."), sha1_to_hex(remote));
> +
> +       read_cache_unmerged();
> +
> +       if (fast_forward_to(head_tree, head_tree, 1))
> +               return -1;
> +
> +       if (write_cache_as_tree(index, 0, NULL))
> +               return -1;
> +
> +       index_tree = parse_tree_indirect(index);
> +       if (!index_tree)
> +               return error(_("Could not parse object '%s'."), sha1_to_hex(index));
> +
> +       if (fast_forward_to(index_tree, remote_tree, 0))
> +               return -1;
> +
> +       memset(&pathspec, 0, sizeof(pathspec));
> +

All returns before this point leak the memory of `lock_file`.

> +       hold_locked_index(lock_file, 1);
> +
> +       if (read_tree(remote_tree, 0, &pathspec)) {
> +               rollback_lock_file(lock_file);
> +               return -1;
> +       }
> +
> +       if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
> +               die(_("unable to write new index file"));
> +
> +       remove_branch_state();
> +
> +       return 0;
> +}
> +
> +/**
> + * Resume the current am session by skipping the current patch.
> + */
> +static void am_skip(struct am_state *state)
> +{
> +       unsigned char head[GIT_SHA1_RAWSZ];
> +
> +       if (get_sha1("HEAD", head))
> +               hashcpy(head, EMPTY_TREE_SHA1_BIN);
> +
> +       if (clean_index(head, head))
> +               die(_("failed to clean index"));
> +
> +       am_next(state);
> +       am_run(state);
> +}
> +
> +/**
>   * parse_options() callback that validates and sets opt->value to the
>   * PATCH_FORMAT_* enum value corresponding to `arg`.
>   */
> @@ -888,7 +998,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
>
>  enum resume_mode {
>         RESUME_FALSE = 0,
> -       RESUME_RESOLVED
> +       RESUME_RESOLVED,
> +       RESUME_SKIP
>  };
>
>  int cmd_am(int argc, const char **argv, const char *prefix)
> @@ -899,7 +1010,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>
>         const char * const usage[] = {
>                 N_("git am [options] [(<mbox>|<Maildir>)...]"),
> -               N_("git am [options] --continue"),
> +               N_("git am [options] (--continue | --skip)"),
>                 NULL
>         };
>
> @@ -913,6 +1024,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>                 OPT_CMDMODE('r', "resolved", &resume,
>                         N_("synonyms for --continue"),
>                         RESUME_RESOLVED),
> +               OPT_CMDMODE(0, "skip", &resume,
> +                       N_("skip the current patch"),
> +                       RESUME_SKIP),
>                 OPT_END()
>         };
>
> @@ -968,6 +1082,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>         case RESUME_RESOLVED:
>                 am_resolve(&state);
>                 break;
> +       case RESUME_SKIP:
> +               am_skip(&state);
> +               break;
>         default:
>                 die("BUG: invalid resume value");
>         }
> --
> 2.5.0.rc1.76.gf60a929
>
