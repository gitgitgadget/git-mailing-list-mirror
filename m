From: Baz <brian.ewins@gmail.com>
Subject: Re: [PATCH 1/2] Introduce rename factorization in diffcore.
Date: Fri, 7 Nov 2008 11:28:55 +0000
Message-ID: <2faad3050811070328t31babed4v1ba895a6ac36df94@mail.gmail.com>
References: <20081030220532.3325.54457.stgit@gandelf.nowhere.earth>
	 <20081030221645.3325.78288.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 12:30:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyPXg-0003Tj-7g
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 12:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbYKGL26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 06:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYKGL26
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 06:28:58 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:10003 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbYKGL24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 06:28:56 -0500
Received: by rv-out-0506.google.com with SMTP id g9so50057rvb.3
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 03:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iYK8iUBYRUEPdOOUfy9qaY3l6ZZHEMb+A97N1jD/VBk=;
        b=hY7WTLw+Re3r8YeJ1EqChaGReDFaoc0jr8ismklhmJAgmnUym5RtotNazRbVEzOagO
         TqvwjfxVYAHYPpOOJ6FMRhbBzWqy4tX7ax6Oo0rLacBBHQNC+k4ZhuPqOhvWS/u+t8NP
         3k01aisbAFKxErU17iabpdRtlIVBqIH0v2R5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JJ8ANKN5eAczGh3onM+hPxjDZv9+AnpQOXUcNyPxGevg8G3P4cUXpzc+KW2ANkCjrO
         2oBCvmKr0NHdNR5IjJ0yqriLl0Lwo1BE/BIcqlTNXmvOJhn3yOKe34/BiW1fwF7wWECi
         YvJ7lsjUyAc+W0fEhpKWwhaHmg/EDDTq+2VBA=
Received: by 10.141.52.5 with SMTP id e5mr1715391rvk.166.1226057335373;
        Fri, 07 Nov 2008 03:28:55 -0800 (PST)
Received: by 10.141.76.10 with HTTP; Fri, 7 Nov 2008 03:28:55 -0800 (PST)
In-Reply-To: <20081030221645.3325.78288.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100303>

2008/10/30 Yann Dirson <ydirson@altern.org>:
> Rename factorization tries to group together files moving from and to
> identical directories - the most common case being directory renames.
> This feature is activated by the new --factorize-renames diffcore
> flag.

Sorry to bikeshed a bit here, but this isn't what 'factorize' means,
and adding a flag with this name unnecessarily adds to the
git-specific terms users have to learn.

Looking back through the archives, there's only a few people who've
used the word 'factorize', and /mostly/ it seems to have been used as
a synonym for 'refactor' in comments; not common usage but
understandable. However in this case, factorize is being used in the
opposite sense from its dictionary definition - to break down into
factors - and instead is being used to mean to /combine/ things; I
don't think that should be in the UI.

Why not just '--group-renames'?

Cheers,
Baz

>
> This is only the first step, adding the basic functionnality and
> adding support to raw diff output (and it breaks unified-diff output
> which does not know how to handle that stuff yet).
>
> Even the output format may not be kept as is.  For now both the result
> of "mv a b" and "mv a/* b/" are displayed as "Rnnn a/ b/", which is
> probably not what we want.  "Rnnn a/* b/" could be a good choice for
> the latter if we want them to be distinguished, and even if we want
> them to look the same.
>
> Other future developements to be made on top of this include:
> * extension of unified-diff format to express this
> * application of such new diffs
> * teach git-svn (and others ?) to make use of that flag
> * merge correctly in case of addition into a moved dir
> * detect "directory splits" so merge can flag a conflict on file adds
> * use inexact dir renames to bump score of below-threshold renames
>  from/to same locations
> * add yours here
> ---
>
>  diff-lib.c        |    6 +
>  diff.c            |    5 +
>  diff.h            |    3 +
>  diffcore-rename.c |  227 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  diffcore.h        |    1
>  tree-diff.c       |    4 +
>  6 files changed, 235 insertions(+), 11 deletions(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index ae96c64..dcc4c2c 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -179,7 +179,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>                changed = ce_match_stat(ce, &st, ce_option);
>                if (!changed) {
>                        ce_mark_uptodate(ce);
> -                       if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
> +                       if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
> +                           !DIFF_OPT_TST(&revs->diffopt, FACTORIZE_RENAMES))
>                                continue;
>                }
>                oldmode = ce->ce_mode;
> @@ -310,7 +311,8 @@ static int show_modified(struct oneway_unpack_data *cbdata,
>
>        oldmode = old->ce_mode;
>        if (mode == oldmode && !hashcmp(sha1, old->sha1) &&
> -           !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
> +           !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
> +           !DIFF_OPT_TST(&revs->diffopt, FACTORIZE_RENAMES))
>                return 0;
>
>        diff_change(&revs->diffopt, oldmode, mode,
> diff --git a/diff.c b/diff.c
> index e368fef..f91fcf6 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2437,6 +2437,11 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>                DIFF_OPT_SET(options, REVERSE_DIFF);
>        else if (!strcmp(arg, "--find-copies-harder"))
>                DIFF_OPT_SET(options, FIND_COPIES_HARDER);
> +       else if (!strcmp(arg, "--factorize-renames")) {
> +               DIFF_OPT_SET(options, FACTORIZE_RENAMES);
> +               if (!options->detect_rename)
> +                       options->detect_rename = DIFF_DETECT_RENAME;
> +       }
>        else if (!strcmp(arg, "--follow"))
>                DIFF_OPT_SET(options, FOLLOW_RENAMES);
>        else if (!strcmp(arg, "--color"))
> diff --git a/diff.h b/diff.h
> index a49d865..db1658b 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -65,6 +65,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
>  #define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
>  #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
>  #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
> +#define DIFF_OPT_FACTORIZE_RENAMES   (1 << 21)
>  #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
>  #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
>  #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
> @@ -220,6 +221,8 @@ extern void diffcore_std(struct diff_options *);
>  "  -C            detect copies.\n" \
>  "  --find-copies-harder\n" \
>  "                try unchanged files as candidate for copy detection.\n" \
> +"  --factorize-renames\n" \
> +"                factorize renames of all files of a directory.\n" \
>  "  -l<n>         limit rename attempts up to <n> paths.\n" \
>  "  -O<file>      reorder diffs according to the <file>.\n" \
>  "  -S<string>    find filepair whose only one side contains the string.\n" \
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 1b2ebb4..fc789bc 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -52,6 +52,32 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
>        return &(rename_dst[first]);
>  }
>
> +static struct diff_rename_dst *locate_rename_dst_dir(struct diff_filespec *dir)
> +{
> +       /* code mostly duplicated from locate_rename_dst - not sure we
> +        * could merge them efficiently,though
> +        */
> +       int first, last;
> +       int dirlength = strlen(dir->path);
> +
> +       first = 0;
> +       last = rename_dst_nr;
> +       while (last > first) {
> +               int next = (last + first) >> 1;
> +               struct diff_rename_dst *dst = &(rename_dst[next]);
> +               int cmp = strncmp(dir->path, dst->two->path, dirlength);
> +               if (!cmp)
> +                       return dst;
> +               if (cmp < 0) {
> +                       last = next;
> +                       continue;
> +               }
> +               first = next+1;
> +       }
> +       /* not found */
> +       return NULL;
> +}
> +
>  /* Table of rename/copy src files */
>  static struct diff_rename_src {
>        struct diff_filespec *one;
> @@ -409,6 +435,165 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
>                m[worst] = *o;
>  }
>
> +struct diff_dir_rename {
> +       struct diff_filespec *one;
> +       struct diff_filespec *two;
> +       int discarded;
> +       struct diff_dir_rename* next;
> +};
> +
> +/*
> + * Marks as such file_rename if it is made uninteresting by dir_rename.
> + * Returns -1 if the file_rename is outside of the range in which given
> + * renames concerned by dir_rename are to be found (ie. end of loop),
> + * 0 otherwise.
> + */
> +static int maybe_mark_uninteresting(struct diff_rename_dst* file_rename,
> +                                   struct diff_dir_rename* dir_rename,
> +                                   int one_len, int two_len)
> +{
> +       if (!file_rename->pair) /* file add */
> +               return 0;
> +       if (strncmp(file_rename->two->path,
> +                   dir_rename->two->path, two_len))
> +               return -1;
> +       if (strncmp(file_rename->pair->one->path,
> +                   dir_rename->one->path, one_len) ||
> +           !basename_same(file_rename->pair->one, file_rename->two) ||
> +           file_rename->pair->score != MAX_SCORE)
> +               return 0;
> +
> +       file_rename->pair->uninteresting_rename = 1;
> +       fprintf (stderr, "[DBG] %s* -> %s* makes %s -> %s uninteresting\n",
> +               dir_rename->one->path, dir_rename->two->path,
> +               file_rename->pair->one->path, file_rename->two->path);
> +       return 0;
> +}
> +
> +// FIXME: prevent possible overflow
> +/*
> + * Copy dirname of src into dst, with final "/".
> + * Only handles relative paths since there is no relative path in a git repo.
> + * Writes "./" when there is no "/" in src.
> + * May overwrite more chars than really needed, if src ends with a "/".
> + */
> +static const char* copy_dirname(char* dst, const char* src)
> +{
> +       char* lastslash = strrchr(src, '/');
> +       if (!lastslash)
> +               return strcpy(dst, "./");
> +       strncpy(dst, src, lastslash - src + 1);
> +       dst[lastslash - src + 1] = '\0';
> +
> +       // if src ends with a "/" strip the last component
> +       if (lastslash[1] == '\0') {
> +               lastslash = strrchr(dst, '/');
> +               if (!lastslash)
> +                       return strcpy(dst, ".");
> +               lastslash[1] = '\0';
> +       }
> +
> +       return dst;
> +}
> +
> +/*
> + * FIXME: we could optimize the 100%-rename case by preventing
> + * recursion to unfold what we know we would refold here.
> + * FIXME: do we want to replace linked list with sorted array ?
> + * FIXME: this prototype only handles renaming of dirs without
> + * a subdir.
> + * FIXME: leaks like hell.
> + * FIXME: ideas to evaluate a similarity score, anyone ?
> + *  10% * tree similarity + 90% * moved files similarity ?
> + */
> +static struct diff_dir_rename* factorization_candidates = NULL;
> +static void diffcore_factorize_renames(void)
> +{
> +       char one_parent_path[PATH_MAX], two_parent_path[PATH_MAX];
> +       int i;
> +
> +       for (i = 0; i < rename_dst_nr; i++) {
> +               // FIXME: what are those ?
> +               if (!rename_dst[i].pair)
> +                       continue;
> +               // dummy renames used by copy detection
> +               if (!strcmp(rename_dst[i].pair->one->path, rename_dst[i].pair->two->path))
> +                       continue;
> +
> +               copy_dirname(one_parent_path, rename_dst[i].pair->one->path);
> +
> +               struct diff_filespec* one_parent = alloc_filespec(one_parent_path);
> +               fill_filespec(one_parent, null_sha1 /*FIXME*/, S_IFDIR);
> +
> +               if (!locate_rename_dst_dir(one_parent)) {
> +                       // one_parent_path is empty in result tree
> +
> +                       // already considered ?
> +                       struct diff_dir_rename* seen;
> +                       for (seen=factorization_candidates; seen; seen = seen->next)
> +                               if (!strcmp(seen->one->path, one_parent_path)) break;
> +                       if (!seen) {
> +                               // record potential dir rename
> +                               copy_dirname(two_parent_path, rename_dst[i].pair->two->path);
> +
> +                               seen = xmalloc(sizeof(*seen));
> +                               seen->one = one_parent;
> +                               seen->two = alloc_filespec(two_parent_path);
> +                               fill_filespec(seen->two, null_sha1 /*FIXME*/, S_IFDIR);
> +                               seen->discarded = 0;
> +                               seen->next = factorization_candidates;
> +                               factorization_candidates = seen;
> +                               fprintf (stderr, "[DBG] %s -> %s suggests possible rename from %s to %s\n",
> +                                      rename_dst[i].pair->one->path,
> +                                      rename_dst[i].pair->two->path,
> +                                      one_parent_path, two_parent_path);
> +                               fflush(stdout);
> +                               continue;
> +                       }
> +                       if (seen->discarded)
> +                               continue;
> +                       // check that seen entry matches this rename
> +                       copy_dirname(two_parent_path, rename_dst[i].pair->two->path);
> +                       if (strcmp(two_parent_path, seen->two->path)) {
> +                               fprintf (stderr, "[DBG] discarding dir split of %s from renames (into %s and %s)\n",
> +                                      one_parent_path, two_parent_path, seen->two->path);
> +                               seen->discarded = 1;
> +                       }
> +
> +                       /* all checks ok, we keep that entry */
> +               }
> +       }
> +
> +       // turn candidates into real renames
> +       struct diff_dir_rename* candidate;
> +       for (candidate=factorization_candidates; candidate; candidate = candidate->next) {
> +               int two_idx, i, one_len, two_len;
> +               if (candidate->discarded)
> +                       continue;
> +
> +               if (!locate_rename_dst_dir(candidate->two)) {
> +                       fprintf (stderr, "PANIC: %s candidate of rename not in target tree (from %s)\n",
> +                               candidate->two->path, candidate->one->path);
> +               }
> +               // bisect to an entry within candidate dst dir
> +               two_idx = locate_rename_dst_dir(candidate->two) - rename_dst;
> +
> +               // now remove extraneous 100% files inside.
> +               one_len = strlen(candidate->one->path);
> +               two_len = strlen(candidate->two->path);
> +               for (i = two_idx; i < rename_dst_nr; i++)
> +                       if (maybe_mark_uninteresting (rename_dst+i, candidate,
> +                                                     one_len, two_len) < 0)
> +                               break;
> +               for (i = two_idx-1; i >= 0; i--)
> +                       if (maybe_mark_uninteresting (rename_dst+i, candidate,
> +                                                     one_len, two_len) < 0)
> +                               break;
> +       }
> +
> +       return;
> +}
> +
>  void diffcore_rename(struct diff_options *options)
>  {
>        int detect_rename = options->detect_rename;
> @@ -446,13 +631,22 @@ void diffcore_rename(struct diff_options *options)
>                                p->one->rename_used++;
>                        register_rename_src(p->one, p->score);
>                }
> -               else if (detect_rename == DIFF_DETECT_COPY) {
> -                       /*
> -                        * Increment the "rename_used" score by
> -                        * one, to indicate ourselves as a user.
> -                        */
> -                       p->one->rename_used++;
> -                       register_rename_src(p->one, p->score);
> +               else {
> +                       if (detect_rename == DIFF_DETECT_COPY) {
> +                               /*
> +                                * Increment the "rename_used" score by
> +                                * one, to indicate ourselves as a user.
> +                                */
> +                               p->one->rename_used++;
> +                               register_rename_src(p->one, p->score);
> +                       }
> +                       if (DIFF_OPT_TST(options, FACTORIZE_RENAMES)) {
> +                               /* similarly, rename factorization needs to
> +                                * see all files from second tree
> +                                */
> +                               //p->two->rename_used++; // FIXME: would we need that ?
> +                               locate_rename_dst(p->two, 1);
> +                       }
>                }
>        }
>        if (rename_dst_nr == 0 || rename_src_nr == 0)
> @@ -561,8 +755,24 @@ void diffcore_rename(struct diff_options *options)
>        /* At this point, we have found some renames and copies and they
>         * are recorded in rename_dst.  The original list is still in *q.
>         */
> +
> +       /* Now possibly factorize those renames and copies. */
> +       if (DIFF_OPT_TST(options, FACTORIZE_RENAMES))
> +               diffcore_factorize_renames();
> +
>        outq.queue = NULL;
>        outq.nr = outq.alloc = 0;
> +
> +       // first, turn factorization_candidates into real renames
> +       struct diff_dir_rename* candidate;
> +       for (candidate=factorization_candidates; candidate; candidate = candidate->next) {
> +               struct diff_filepair* pair;
> +               if (candidate->discarded) continue;
> +               pair = diff_queue(&outq, candidate->one, candidate->two);
> +               pair->score = MAX_SCORE;
> +               pair->renamed_pair = 1;
> +       }
> +
>        for (i = 0; i < q->nr; i++) {
>                struct diff_filepair *p = q->queue[i];
>                struct diff_filepair *pair_to_free = NULL;
> @@ -577,7 +787,8 @@ void diffcore_rename(struct diff_options *options)
>                        struct diff_rename_dst *dst =
>                                locate_rename_dst(p->two, 0);
>                        if (dst && dst->pair) {
> -                               diff_q(&outq, dst->pair);
> +                               if (!dst->pair->uninteresting_rename)
> +                                       diff_q(&outq, dst->pair);
>                                pair_to_free = p;
>                        }
>                        else
> diff --git a/diffcore.h b/diffcore.h
> index 713cca7..6d2e65b 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -66,6 +66,7 @@ struct diff_filepair {
>        unsigned broken_pair : 1;
>        unsigned renamed_pair : 1;
>        unsigned is_unmerged : 1;
> +       unsigned uninteresting_rename : 1;
>  };
>  #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
>
> diff --git a/tree-diff.c b/tree-diff.c
> index 9f67af6..872f757 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -49,7 +49,9 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
>                show_entry(opt, "+", t2, base, baselen);
>                return 1;
>        }
> -       if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) && mode1 == mode2)
> +       if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) &&
> +           !DIFF_OPT_TST(opt, FACTORIZE_RENAMES) &&
> +           !hashcmp(sha1, sha2) && mode1 == mode2)
>                return 0;
>
>        /*
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
