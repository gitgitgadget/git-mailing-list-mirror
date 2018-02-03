Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D451F404
	for <e@80x24.org>; Sat,  3 Feb 2018 01:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeBCBCN (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 20:02:13 -0500
Received: from mail-yw0-f175.google.com ([209.85.161.175]:38418 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeBCBCL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 20:02:11 -0500
Received: by mail-yw0-f175.google.com with SMTP id m84so14556021ywd.5
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 17:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Glw3hUvLgGu811D+GQsyTbVhT+A32N/yd4dyY/651JI=;
        b=nx/xzGXw5AHpR94VB2fgEmvu3jpa2kpC+n0hl2OQ2fhjFqR6la+wWGVzYFKWPjbthe
         N+VmcbPFLDNDh1q5zQY3OIKIaRX8Y+BmJ1ZTaMusyvV30Ucsq2v5QDrKRdzoiuqjmZos
         0jR7Ey+emorprBV32pDRoNcXTmkNLDdDOPPO1aLwwUdCP8818TiNvSERk5KZpLVwslK0
         jDei5QSjfioNECEjzeOz566NYmBqcodKJjytDj27SlCrQV4R6Uflpt6DhcJ5G8byPHBK
         xK1epArHXt9v3BOBaSoArEyMKbvVKhaw/daED6p9jDI9VM8QVAAqS/TNY59t8eut/22n
         IsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Glw3hUvLgGu811D+GQsyTbVhT+A32N/yd4dyY/651JI=;
        b=mSL/djIZiTNGyNQpRFRYAqhdz4WY44LWw0XtiyIMGjoZDmUEikEnjdjbtsP6Vr1J2T
         AKLXpbI2OrvOuJcg76l/Oyr61Rkj01mMKV6/LAOj3xo99LmwjuyKLDmvPJRtvUhsfo93
         w1V1q3h/94nMOKs+FGShBCqG7+kEt6pBTR+2jS+PHIUH97tt4yGpe9cqclqaIBQ9yaN7
         4lpxfmJEEwppWTEgZqc2xPMZcKj+mx8jzaBPOx1t79ZtIrVo8rGdky7JRf8l5Xazspgy
         owft7++njYXlgX6J45jHGRo9rzahiAhr4MOly0Ay4PlUoL5/8b0+47l/lewWchtyfjQf
         ADcg==
X-Gm-Message-State: AKwxytfeXvrTrC+sY8FhsQszlE1O886ImgH8m0ZPBUGnHZcLTgP0MVsA
        crQlXkp9v3kJGZzzihs9n6JSzScNnS1oowdHwkw3sw==
X-Google-Smtp-Source: AH8x2261cWKHSQ8plA5XA4GHHJNl0do6Y2V1axgfsNY1cbrcyD4hCCaP7nZXESiNr5EOWRgANBNH4hg6hQPJpPovsGw=
X-Received: by 10.37.34.8 with SMTP id i8mr28827609ybi.114.1517619730712; Fri,
 02 Feb 2018 17:02:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 2 Feb 2018 17:02:10 -0800 (PST)
In-Reply-To: <20180130232533.25846-20-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-20-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Feb 2018 17:02:10 -0800
Message-ID: <CAGZ79kb2+tpr0K0x2VVfFR-u3W2htvbxokxfKBpG60mNjXGPEw@mail.gmail.com>
Subject: Re: [PATCH v7 19/31] merge-recursive: add get_directory_renames()
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> This populates a list of directory renames for us.  The list of
> directory renames is not yet used, but will be in subsequent commits.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 152 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 40ed8e1f39..c75d3a5139 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1393,6 +1393,138 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
>         return ret;
>  }
>
> +static void get_renamed_dir_portion(const char *old_path, const char *new_path,
> +                                   char **old_dir, char **new_dir)
> +{
> +       char *end_of_old, *end_of_new;
> +       int old_len, new_len;
> +
> +       *old_dir = NULL;
> +       *new_dir = NULL;
> +
> +       /* For

comment style.

    /*
     * we prefer to keep the beginning
     * and ending line of a comment free.
     */
    /* unless you write single line comments */

> +        *    "a/b/c/d/foo.c" -> "a/b/something-else/d/foo.c"
> +        * the "d/foo.c" part is the same, we just want to know that
> +        *    "a/b/c" was renamed to "a/b/something-else"
> +        * so, for this example, this function returns "a/b/c" in
> +        * *old_dir and "a/b/something-else" in *new_dir.

So we would not see multi-directory renames?

    "a/b/c/d/foo.c" -> "a/b/something-else/e/foo.c"

could be detected as

    "a/b/{c/d/ => something-else/e}/foo.c"

I assume this patch series is not bringing that to the table.
(which is fine, I am just wondering)

> +        *
> +        * Also, if the basename of the file changed, we don't care.  We
> +        * want to know which portion of the directory, if any, changed.
> +        */
> +       end_of_old = strrchr(old_path, '/');
> +       end_of_new = strrchr(new_path, '/');
> +
> +       if (end_of_old == NULL || end_of_new == NULL)
> +               return;

return early as the files are in the top level, and apparently we do
not support top level renaming?

What about a commit like 81b50f3ce4 (Move 'builtin-*' into
a 'builtin/' subdirectory, 2010-02-22) ?

Well that specific commit left many files outside the new builtin dir,
but conceptually we could see a directory rename of

    /* => /src/*

> +       while (*--end_of_new == *--end_of_old &&
> +              end_of_old != old_path &&
> +              end_of_new != new_path)
> +               ; /* Do nothing; all in the while loop */

We have to compare manually as we'd want to find
the first non-equal and there doesn't seem to be a good
library function for that.

Assuming many repos are UTF8 (including in their paths),
how does this work with display characters longer than one char?
It should be fine as we cut at the slash?

> +       /*
> +        * We've found the first non-matching character in the directory
> +        * paths.  That means the current directory we were comparing
> +        * represents the rename.  Move end_of_old and end_of_new back
> +        * to the full directory name.
> +        */
> +       if (*end_of_old == '/')
> +               end_of_old++;
> +       if (*end_of_old != '/')
> +               end_of_new++;
> +       end_of_old = strchr(end_of_old, '/');
> +       end_of_new = strchr(end_of_new, '/');
> +
> +       /*
> +        * It may have been the case that old_path and new_path were the same
> +        * directory all along.  Don't claim a rename if they're the same.
> +        */
> +       old_len = end_of_old - old_path;
> +       new_len = end_of_new - new_path;
> +
> +       if (old_len != new_len || strncmp(old_path, new_path, old_len)) {

How often are we going to see this string-is-equal case?
Would it make sense to do that first in the function?

> +               *old_dir = xstrndup(old_path, old_len);
> +               *new_dir = xstrndup(new_path, new_len);
> +       }
> +}
> +
> +static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
> +                                            struct tree *tree)
> +{
> +       struct hashmap *dir_renames;
> +       struct hashmap_iter iter;
> +       struct dir_rename_entry *entry;
> +       int i;
> +
> +       dir_renames = malloc(sizeof(struct hashmap));

xmalloc

> +       dir_rename_init(dir_renames);
> +       for (i = 0; i < pairs->nr; ++i) {
> +               struct string_list_item *item;
> +               int *count;
> +               struct diff_filepair *pair = pairs->queue[i];
> +               char *old_dir, *new_dir;
> +
> +               /* File not part of directory rename if it wasn't renamed */
> +               if (pair->status != 'R')
> +                       continue;
> +
> +               get_renamed_dir_portion(pair->one->path, pair->two->path,
> +                                       &old_dir,        &new_dir);
> +               if (!old_dir)
> +                       /* Directory didn't change at all; ignore this one. */
> +                       continue;


So the first loop is about counting the number of files in each directory
that are renamed and the later while loop is about mapping them?

> +               /* Strings were xstrndup'ed before inserting into string-list,
> +                * so ask string_list to remove the entries for us.
> +                */

comment style.

> +               entry->possible_new_dirs.strdup_strings = 1;

Why do we need to set strdup_strings here (so late in the
game, we are about to clear it?) Could we set it earlier?

Or rather have the string list duplicate the strings instead of
get_renamed_dir_portion ?
