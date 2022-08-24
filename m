Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D800CC00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 07:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiHXHhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 03:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiHXHhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 03:37:09 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF422296
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 00:37:07 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a15so12070567qko.4
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=f1EBQe26XVyY8R0HMJjEaK6anr/uUtvqP8HtbereeHE=;
        b=Ncz2NZEov/9MPhAHgnaKofBmG29hajALBR8k5bXTfts9vjgxc/5ps6vJz80CHhGX2B
         vunKG6plFisUR6H5C62JOIghiDMJSvTQXr6y1tRwju5KpkzW83jKb+WnvzekJNsxUiou
         VktMjTYHcluhDX8LdgI16vFAKxkMHC2eVbkNwEcrpDNUz/kyqTTc0Zh8rhTNLQ/ImWWz
         FsVHUEhqV2XbNrdj2Etn6zGb1eIUXZR4T/G8ueQM8Nkc3XjRw9oF/YrDFlpZcd6b3N3O
         jrCsJO0eFM/K0jzQg0SHFkXrQmbFaEsCO3VH7eGWCB9UZPxADB5AtaR1BToPIlZelX0A
         Sy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=f1EBQe26XVyY8R0HMJjEaK6anr/uUtvqP8HtbereeHE=;
        b=kLSV79hniKFmXnkBh9fPL2u9ISQFLre7cRXB8G3bChjfVqrsGoRi+E5o+OhtQnP/6g
         GYDfcj47PEUxbj8612xFD4JiEFN0Qid7fDeE7UVo8E9FYLbh+smmHV5qsban298meHZZ
         Voe9tsmwbYVqhAYPc461z/+j6UQOdPXApLK9w3c36Lt6fqNdc71OZeW5t8cVxuJxEfwL
         eY2YxfjU/wX7KdJWQFL1bhyVrFn3CT3B8TS56aM5fnPu+N5Ya53qSRn8IIXvMbqRkFY/
         pWWoFkoGfGV+Z4OT5dAVpu7SvnNjiDQIYXMlEjss9XgesXUQuMleTyUhTG1V/um+v5At
         HpUg==
X-Gm-Message-State: ACgBeo3btzszXtlPe1aHzpBFdZ5dAtIAHnkb7uJoaH1s/2liIDwfEEpc
        a5kun3KuqXBVJVJ98cfgbfXZiUnMrz6EOYmxG45fW28q7rs=
X-Google-Smtp-Source: AA6agR4nUYIub5NJdgrOoe+M82j7T2p7vu7rVwwcYmVFBOM1Lt5ZR/G0rz8Ct+UoTZnyf92Bdmo7TwR7G8hoINeB+vY=
X-Received: by 2002:a05:620a:1193:b0:6bb:b867:c095 with SMTP id
 b19-20020a05620a119300b006bbb867c095mr18525747qkk.227.1661326627035; Wed, 24
 Aug 2022 00:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <43cf2a1d-058a-fd79-befe-7d9bc62581ed@gmail.com>
In-Reply-To: <43cf2a1d-058a-fd79-befe-7d9bc62581ed@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Aug 2022 00:36:56 -0700
Message-ID: <CABPp-BEkC8xEkNa+hyKFKhO=cbBZqNqGWehqxbRzE6-BVR27NQ@mail.gmail.com>
Subject: Re: Bug in 'git log --remerge-diff' when used with '--find-object'
 and '--submodule=log|diff'
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Mon, Aug 22, 2022 at 4:58 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Elijah,
>
> I found two bugs in '--remerge-diff' when combined with both '--find-object' and
> '--submodule=log|diff'. I don't know if they have the same cause.
>
> When using these flags together, *all* 2-parents merge commits are shown (even in a repo with
> no submodule!)
>
> Moreover, for merges with conflicted paths, all conflicted paths are shown as "(new submodule)",
> even if they are not a submodule (in fact, even when no submodule is present
> in the repository!).
>
> This artificial example reproduces the bug:
>
> ```bash
> #!/bin/bash
>
> set -euEo pipefail
>
> repo=repro
> rm -rf $repo
>
> TEST_AUTHOR_LOCALNAME=author
> TEST_AUTHOR_DOMAIN=example.com
> GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
> GIT_AUTHOR_NAME='A U Thor'
> GIT_AUTHOR_DATE='1112354055 +0200'
> TEST_COMMITTER_LOCALNAME=committer
> TEST_COMMITTER_DOMAIN=example.com
> GIT_COMMITTER_EMAIL=${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
> GIT_COMMITTER_NAME='C O Mitter'
> GIT_COMMITTER_DATE='1112354055 +0200'
> export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
> export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
> export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> export HOME=
>
> git -c init.defaultBranch=unimportant init $repo
> cd $repo
> echo i>file
> git add file
> git commit -m file
> git checkout -b side
> echo s>>file2
> git add file2
> git commit -am side
> git checkout -
> echo m >>file
> git commit -am main
> git merge side -m clean
> git checkout side
> echo c>>file
> git add file
> git commit -am side2
> git checkout -
> echo cc>>file
> git commit -am main2
> git merge side || true
> printf 'i\nm' > file
> git commit -am conflicted
> # look for a dummy object
> git log --oneline --diff-merges=r --submodule=log --find-object=2c042ac4213768e55791098110d2ef2ef845881a
> # same output with --submodule=diff
> ```
>
> This is the output I get from the 'git log' call:
>
> b4f1be9 (HEAD -> unimportant) conflicted
> Submodule file 0000000...0000000 (new submodule)
> a4ef223 clean
>
> Notice both merges are shown despite none of them changing the number of occurences of
> 2c042ac4213768e55791098110d2ef2ef845881a, which does not even exist in this repository,
> and also that the conflicted merge shows 'file' as "new submodule".

Thanks for the report, and the steps to reproduce.  Very helpful.

After some digging, it appears the remerge-diff headers are
misinterpreted by the submodule code.  They transform what would have
been the following output:

    b4f1be9 (HEAD -> unimportant) conflicted
    diff --git a/file b/file
    remerge CONFLICT (content): Merge conflict in file
    a4ef223 clean

into what you saw, namely

    b4f1be9 (HEAD -> unimportant) conflicted
    Submodule file 0000000...0000000 (new submodule)
    a4ef223 clean

We can recover the intended remerge-diff header with the following simple patch:

diff --git a/diff.c b/diff.c
index 974626a621..be23f66057 100644
--- a/diff.c
+++ b/diff.c
@@ -3429,14 +3429,16 @@ static void builtin_diff(const char *name_a,

        if (o->submodule_format == DIFF_SUBMODULE_LOG &&
            (!one->mode || S_ISGITLINK(one->mode)) &&
-           (!two->mode || S_ISGITLINK(two->mode))) {
+           (!two->mode || S_ISGITLINK(two->mode)) &&
+           (one->mode || two->mode)) {
                show_submodule_diff_summary(o, one->path ? one->path :
two->path,
                                &one->oid, &two->oid,
                                two->dirty_submodule);
                return;
        } else if (o->submodule_format == DIFF_SUBMODULE_INLINE_DIFF &&
                   (!one->mode || S_ISGITLINK(one->mode)) &&
-                  (!two->mode || S_ISGITLINK(two->mode))) {
+                  (!two->mode || S_ISGITLINK(two->mode)) &&
+                  (one->mode || two->mode)) {
                show_submodule_inline_diff(o, one->path ? one->path : two->path,
                                &one->oid, &two->oid,
                                two->dirty_submodule);

In other words, when we have information about something other than a
submodule, don't attempt to treat it as information about a submodule.

Now, whether the remerge-diff header should be shown is an interesting
one -- it's a carry on to the discussion in the thread at [1], and
isn't simple to answer.
[1] https://lore.kernel.org/git/CABPp-BHjU+wDXNnf-rsGy86GvOFWH6qVLPEfAA2JDfLFRU4WSA@mail.gmail.com/

As for the first bug, the showing of any 2-parent commits, yes that's
true.  But it's not limited to remerge-diff; you can change
--diff-merges=r to --diff-merges=c or --diff-merges=cc and see the
same thing.  I'm not sure if that means that my looking at the
do_diff_combined() logic when developing the do_remerge_diff()
function meant I copied a bug, or if I independently came up with it
on my own.  But, for now, I need some sleep.  Just thought I'd give
you an update on what I have found so far, though.
