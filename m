Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F0C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 01:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D283161211
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 01:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbhIXB2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 21:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243740AbhIXB2m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 21:28:42 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD89C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 18:27:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 24so12439385oix.0
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 18:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pP7aEVSw/6SWSP4Y66iHs/eyircMrLrt8Olz6bhzHwI=;
        b=jffHZo7mMNDeo4SfwrdazGlWk+zChrKHRvwH270eTe9V6Rqw8J8DiW0+iH+lyyKhtx
         RSM4Z/h7llwqHc25hRYOXD0HNXNj0R2UeaDtr2c0pK52IMbKOmVYo71IaUHGe2hoiM+e
         w4h5Ax460Re3l43GRV7ZtJdMCFVAKWSvnsaV5tFtWoFrRCH3G5Q5S9EFi2jkVI9zxQgL
         vWkPARr3KxYPl0w1Al8ZdmfscmusOulkcqzFD6B2yLiXvHWwmq73b+PTulH73JP2YQ8f
         o4GpPZ0LA0pIFA7ToknNdY5lx3BFrvMZJj0OcxggGJ4ohUEs80/Nu9ZNhIUnPWlYRKNT
         +jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pP7aEVSw/6SWSP4Y66iHs/eyircMrLrt8Olz6bhzHwI=;
        b=WlmcekFFYZkF0+s2imn+gYvyoUXwbF1WPjxwPvDqzqcLzrm8fgzHoPPWyVyn1znla5
         l98ktzyP8lnoiWP24yYWfZNZmyRjUhfQr/IU30l6uQ9T4KIfMldxqIsCALncBhy4mFIh
         HSi5EQUszE6IupyDrlvwCVaiEKqxousgJ4RvJEqSrNNu6o8ZlDdEVOr2Rkk0UtIpbOVj
         j2Q+6t5YE6jxDNPUtd9rZdLgh8ObHLB2kJK+phpo7nXfsBoUOl01/t9USRQAhAnB5xE0
         QYD2/GnE9LF4M85ZCTh0mMtTHJ41eabZlylBlAPwt3HMy2uK8hM6ElRfmeQnL46z1rdC
         88tA==
X-Gm-Message-State: AOAM532JcUpqRYD+7aQorUglDqs6K9xZetobkIAZgaNtJ4E7BCvt32Aw
        8Ex7vOUUKpdvoB9jG6tAO5Mwx9fu6Hd2TU0/9Jw=
X-Google-Smtp-Source: ABdhPJzSwGj6ydB5hEc7XqAACaEGtsN9k536Lk6V/Y91v49yg0N2OQyTZTlXuBPs8cpjIM/g0L2bYVguO6tH5iB3hbg=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr15607090oib.39.1632446829910;
 Thu, 23 Sep 2021 18:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com> <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Sep 2021 18:26:58 -0700
Message-ID: <CABPp-BHznKM_Y8cz55aP2xtB4a6XEgpFK2USOU=z32EwF6tgGw@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] rebase: dereference tags
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 3:24 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Thanks for the comments on V2. Here are the changes from that version:
>
>  * dropped the controversial cleanup that was patch 8
>  * reworded patch 10 as suggested by Junio
>
> Cover letter for v2: Thanks to =C3=86var and Johannes for their comments.

This version looks good to me.

>
>  * Changed "! test_cmp_rev" to "test_cmp_rev !" (suggested by =C3=86var)
>  * Fixed the quoting for the title of the "rebase --quit" tests.
>  * Reworked the last commit to handle the error case first (suggested by
>    =C3=86var)
>  * Tweaked the commit messages for patches 8 & 11
>  * Rebased onto 31e4a0db03 ("Merge branch 'ab/rebase-fatal-fatal-fix'",
>    2021-09-08) to avoid a merge conflict that upset gitgitgadget
>
> Cover letter for V1: Aborting a rebase stated with git rebase <upstream>
> <tag-object> should checkout the commit pointed to by . Instead it gives
>
>     error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD': tr=
ying to write non-commit object       710d743b2b9892457fdcc3970f397e6ec0744=
7e0 to branch 'HEAD'
>
>
> The fix for that is in the last patch, the rest of the patches are cleanu=
ps
> to t3407 and builtin/rebase.c
>
> Phillip Wood (10):
>   t3407: run tests in $TEST_DIRECTORY
>   t3407: use test_commit
>   t3407: use test_cmp_rev
>   t3407: rename a variable
>   t3407: use test_path_is_missing
>   t3407: strengthen rebase --abort tests
>   t3407: rework rebase --quit tests
>   rebase: use our standard error return value
>   rebase: use lookup_commit_reference_by_name()
>   rebase: dereference tags
>
>  builtin/rebase.c        |  49 ++++++++-----------
>  t/t3407-rebase-abort.sh | 105 ++++++++++++++++++----------------------
>  2 files changed, 67 insertions(+), 87 deletions(-)
>
>
> base-commit: 31e4a0db0337e2aa972d9b9f11a332dff7c4cbcb
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1033%2F=
phillipwood%2Fwip%2Frebase-handle-tags-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1033/phill=
ipwood/wip/rebase-handle-tags-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1033
>
> Range-diff vs v2:
>
>   1:  bac009d8543 =3D  1:  bac009d8543 t3407: run tests in $TEST_DIRECTOR=
Y
>   2:  abfffb31a56 =3D  2:  abfffb31a56 t3407: use test_commit
>   3:  7755ce17fef =3D  3:  7755ce17fef t3407: use test_cmp_rev
>   4:  38eee11baf5 =3D  4:  38eee11baf5 t3407: rename a variable
>   5:  61a37c89f1e =3D  5:  61a37c89f1e t3407: use test_path_is_missing
>   6:  6866630528b =3D  6:  6866630528b t3407: strengthen rebase --abort t=
ests
>   7:  fd55a3196b1 =3D  7:  fd55a3196b1 t3407: rework rebase --quit tests
>   8:  ad3c4efc027 <  -:  ----------- rebase: remove redundant strbuf
>   9:  ad940b633d0 !  8:  d3af62c746c rebase: use our standard error retur=
n value
>      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, con=
st char *prefix
>                 } else if (!(options.flags & REBASE_NO_QUIET))
>                         ; /* be quiet */
>       @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, co=
nst char *prefix)
>      -          reset_head(the_repository, NULL, "Fast-forwarded", option=
s.head_name,
>      -                     RESET_HEAD_REFS_ONLY, "HEAD", buf.buf,
>      +                     RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
>                            DEFAULT_REFLOG_ACTION);
>      +          strbuf_release(&msg);
>       -         ret =3D !!finish_rebase(&options);
>       +         ret =3D finish_rebase(&options);
>                 goto cleanup;
>  10:  bc103e703e8 =3D  9:  4eedd3ae766 rebase: use lookup_commit_referenc=
e_by_name()
>  11:  951de6bb199 ! 10:  55a6250ab38 rebase: dereference tags
>      @@ Metadata
>        ## Commit message ##
>           rebase: dereference tags
>
>      -    Aborting a rebase stated with 'git rebase <upstream> <tag-objec=
t>'
>      -    should checkout the commit pointed to by <tag-object>. Instead =
it gives
>      +    A rebase started with 'git rebase <A> <B>' is conceptually to f=
irst
>      +    checkout <B> and run 'git rebase <A>' starting from that state.=
  'git
>      +    rebase --abort' in the middle of such a rebase should take us b=
ack to
>      +    the state we checked out <B>.
>
>      -        error: update_ref failed for ref 'HEAD': cannot update ref =
'HEAD':
>      -        trying to write non-commit object
>      -        710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'
>      +    This used to work, even when <B> is a tag that points at a comm=
it,
>      +    until Git 2.20.0 when the command was reimplemented in C.  The =
command
>      +    now complains that the tag object itself cannot be checked out,=
 which
>      +    may be technically correct but is not what the user asked to do=
.
>
>      -    This is because when we parse the command line arguments althou=
gh we
>      -    check that the tag points to a commit we remember the oid of th=
e tag
>      -    and try and checkout that object rather than the commit it poin=
ts
>      -    to. Fix this by using lookup_commit_reference_by_name() when pa=
rsing
>      -    the command line.
>      +    Fix this old regression by using lookup_commit_reference_by_nam=
e()
>      +    when parsing <B>. The scripted version did not need to peel the=
 tag
>      +    because the commands it passed the tag to (e.g 'git reset') pee=
led the
>      +    tag themselves.
>
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>           ---
>
> --
> gitgitgadget
