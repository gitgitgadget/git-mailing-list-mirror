Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DF0C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 02:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348427AbiAUCRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 21:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347968AbiAUCRK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 21:17:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA125C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 18:17:09 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m11so36606104edi.13
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 18:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gy+RcKLZOf5sMhwvFaL+o2YeP0fVtlX2O6nFwm7lqCI=;
        b=lUkX/piNHyvP9kYwwW0V6cZPousg5re6BrKQ3yjSBbzQ0/WX6O6kmsK3I/9zhPllsN
         /C9KdveVoM3xP/6x5PBBSystxyOxL+P4OHmcSsfycD1vhJ6PsYqCoEpLuAaBWLJVqSC+
         90zeCKtM+USm/PPol6LqCMo/xdmMH7fjFyGvekqUMHitNxym7tOn1hWsk7D0R1o/XXzw
         znI0jd4GtW5gJgy1Ub9B39Lu3oTctUp7O/gJtZ9gWJRYuEIyR4wWpgoh4pClPy0M9ryN
         w+7bk6uBa0+iUJLwJIpubkR9lh++MJFejQTZEQpi+Vyf73U37Jq55ynGpCZzXj5pe9LB
         HmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gy+RcKLZOf5sMhwvFaL+o2YeP0fVtlX2O6nFwm7lqCI=;
        b=kl95+drDMKYVeavCLOakZxrX8dtwKfm6FVweohTHwLNJuQfG25t5sv7NjFKJoabZs6
         +1kMDWVyfHPS2qVPLu335kFP9x/myzAJ8Xwqom9UKdZjDtcC9Spvf1ncpjcIprsLijbA
         LR16XQIfhsPc6tOf3VA1WKVVh05RREPc3psbypiJmGQ5fvay4VN6wUeO2mR3ybeodWod
         tGp2hmcYsY+LKpaHzM+xlzM/yNnMajYYlFbhm+ysTKbaFcOY5nhDv/IcGKo3phPS+I29
         5Y+bXnYohsSHDTdIwRppjf60uQSc+ctKe37/nGz3MuOkv12ZPlI6uXlb++MDRoNgPjnv
         1LOQ==
X-Gm-Message-State: AOAM533sMxL2cQdBkwIMhV1b50h+MBU5X8wrhBo0Ex03sV02q+gOp7bh
        VBiNxKus/U09tLUbn1xnoJ3nTuA+2dOgGy7Y5oafT8lG
X-Google-Smtp-Source: ABdhPJyBXDzurxriiImArk8FseiYacRnU8GciJqTJTc/N/auyzLMKqYJO8F5UV82D48HbLig7GPhI/dhwZP2537IFk0=
X-Received: by 2002:a17:907:2d10:: with SMTP id gs16mr1599004ejc.100.1642731427705;
 Thu, 20 Jan 2022 18:17:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com> <78ec1f44e4eacdb05c9da749a2160f4748565ad3.1640907369.git.gitgitgadget@gmail.com>
 <220120.868rvamyu9.gmgdl@evledraar.gmail.com>
In-Reply-To: <220120.868rvamyu9.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 20 Jan 2022 18:16:55 -0800
Message-ID: <CABPp-BHjU+wDXNnf-rsGy86GvOFWH6qVLPEfAA2JDfLFRU4WSA@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] show, log: include conflict/warning messages in
 --remerge-diff headers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 20, 2022 at 3:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Dec 30 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Conflicts such as modify/delete, rename/rename, or file/directory are
> > not representable via content conflict markers, and the normal output
> > messages notifying users about these were dropped with --remerge-diff.
> > While we don't want these messages randomly shown before the commit
> > and diff headers, we do want them to still be shown; include them as
> > part of the diff headers instead.
> > [...]
> > +test_expect_success 'setup non-content conflicts' '
> > +     git switch --orphan base &&
> > +
> > +     test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
> > +     test_write_lines a b c d e f g h i >letters &&
> > +     test_write_lines in the way >content &&
> > +     git add numbers letters content &&
> > +     git commit -m base &&
> > +
> > +     git branch side1 &&
> > +     git branch side2 &&
> > +
> > +     git checkout side1 &&
> > +     test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
> > +     git mv letters letters_side1 &&
> > +     git mv content file_or_directory &&
> > +     git add numbers &&
> > +     git commit -m side1 &&
> > +
> > +     git checkout side2 &&
> > +     git rm numbers &&
> > +     git mv letters letters_side2 &&
> > +     mkdir file_or_directory &&
> > +     echo hello >file_or_directory/world &&
> > +     git add file_or_directory/world &&
> > +     git commit -m side2 &&
> > +
> > +     git checkout -b resolution side1 &&
> > +     test_must_fail git merge side2 &&
> > +     test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
> > +     git add numbers &&
> > +     git add letters_side1 &&
> > +     git rm letters &&
> > +     git rm letters_side2 &&
> > +     git add file_or_directory~HEAD &&
> > +     git mv file_or_directory~HEAD wanted_content &&
> > +     git commit -m resolved
> > +'
> > +
> > +test_expect_success 'remerge-diff with non-content conflicts' '
> > +     git log -1 --oneline resolution >tmp &&
> > +     cat <<-EOF >>tmp &&
> > +     diff --git a/file_or_directory~HASH (side1) b/wanted_content
> > +     similarity index 100%
> > +     rename from file_or_directory~HASH (side1)
> > +     rename to wanted_content
> > +     remerge CONFLICT (file/directory): directory in the way of file_o=
r_directory from HASH (side1); moving it to file_or_directory~HASH (side1) =
instead.
> > +     diff --git a/letters b/letters
> > +     remerge CONFLICT (rename/rename): letters renamed to letters_side=
1 in HASH (side1) and to letters_side2 in HASH (side2).
> > +     diff --git a/letters_side2 b/letters_side2
> > +     deleted file mode 100644
> > +     index b236ae5..0000000
> > +     --- a/letters_side2
> > +     +++ /dev/null
> > +     @@ -1,9 +0,0 @@
> > +     -a
> > +     -b
> > +     -c
> > +     -d
> > +     -e
> > +     -f
> > +     -g
> > +     -h
> > +     -i
> > +     diff --git a/numbers b/numbers
> > +     remerge CONFLICT (modify/delete): numbers deleted in HASH (side2)=
 and modified in HASH (side1).  Version HASH (side1) of numbers left in tre=
e.
> > +     EOF
> > +     # We still have some sha1 hashes above; rip them out so test work=
s
> > +     # with sha256
> > +     sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
> > +
> > +     git show --oneline --remerge-diff resolution >tmp &&
> > +     sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> >  test_done
>
> Re my comment about --diff-filter in an earlier round, I think testing
> for that option should really be added here.
>
> With current master and seen:
>
>     $ git rev-parse origin/master
>     50b2d72e110cad39ecaf2322bfdf1b60cd13dd96
>     $ git rev-parse origin/seen
>     9e835a8bdafce2aaeb6df5f57f11014051bbfdca
>
> I will, with A, M, D get:
>
>     for i in A M D; do echo With $i: && git -P log --oneline --remerge-di=
ff --diff-filter=3D$i origin/master..origin/seen; done
>
> Some of which is expected, and some of which is still weird, e.g.:
>
>     $ git log --oneline --remerge-diff --diff-filter=3DD origin/master..o=
rigin/seen
>     d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) in=
to seen
>     diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>     remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.=
sh
>     61239ae3ee7 Merge branch 'pw/fix-some-issues-in-reset-head' into seen
>     diff --git a/reset.c b/reset.c
>     remerge CONFLICT (content): Merge conflict in reset.c
>     diff --git a/sequencer.c b/sequencer.c
>     remerge CONFLICT (content): Merge conflict in sequencer.c
>     9b44aca15e4 Merge branch 'hn/reftable-coverity-fixes' into jch
>     diff --git a/reftable/stack.c b/reftable/stack.c
>     remerge CONFLICT (content): Merge conflict in reftable/stack.c
>     [...]

Thanks for the detailed testing and report.  Much appreciated.

I agree that this output doesn't make sense...but...we might have a
bit of a pickle.  I want to be able to do
   $ git show --remerge-diff ${merge_commit}
and have it show me whether the user did something to resolve that
merge.  That is NOT the same as asking whether the
as-merged-as-possible-tree matches the final tree.  Some examples
where those results differ:
  * The original merge had a binary conflict.  Merge machinery bailed
and put the copy from the first parent in the working tree.  User
resolved it by keeping copy from the first parent.
  * The original merge had a modify/delete conflict.  Merge machinery
bailed and left the file from the modified side in place.  User
resolved by keeping the file.
  * Similar to the previous case, but rename/delete instead of modify/delet=
e.
  * Directory rename detection -- the merge machinery put the file in
the new directory but marked it as conflicted.  User decided they
liked the location and kept it.
In any of the above cases, there were conflicts for the user to
resolve, but none of them will show up by diffing the
tree-at-start-of-conflict-resolution to the final-tree.  The only
notification we will have is the conflict header.  When I'm looking
for how users resolved merge conflicts, I do not want these merges to
show up empty for me (implying they were clean merges); that would
miss out on important information.

Perhaps this means that the conflict header is a change of some type,
but not one that fits into the traditional ACDMRTUXB categories of
diff-filter?  Maybe we could attempt to categorize them (e.g. content
conflicts are modifications, modify/delete are...deletes? adds?
modifies?), but I think madness and corner cases lie down that route.
My attempt to make these conflict headers show up despite empty diffs
in the simple case (which required extra code in patch 7), caused it
to also show up for all your diff-filter cases.  I agree it doesn't
seem to make as much sense in your diff-filter cases...and I can
remove it from them by removing my extra code in patch 7, but then I'm
back to not seeing anything conflict headers for diffs that are
otherwise empty even when that is the info I'm looking for.

What should be done?  Treat conflict notices as an "unmerged" type of
change (maybe flagged with diff-filter=3DU)?  Treat it as some new type
of diff-filter change?  Something else?

I'm open to bright ideas here.

> Let's take the jh/builtin-fsmonitor-part2 merge, with =3DM I get this
> output:
>
>     $ git -P show --oneline --remerge-diff --diff-filter=3DM d120673d7cc
>     d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) in=
to seen
>     diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>     remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.=
sh
>     index 03269b5553b..e70252ed65a 100755
>     --- a/t/perf/p7519-fsmonitor.sh
>     +++ b/t/perf/p7519-fsmonitor.sh
>     @@ -127,18 +127,11 @@ test_expect_success "one time repo setup" '
>             fi &&
>
>             mkdir 1_file 10_files 100_files 1000_files 10000_files &&
>     -<<<<<<< 61239ae3ee7 (Merge branch 'pw/fix-some-issues-in-reset-head'=
 into seen)
>     -       for i in $(test_seq 1 10); do touch 10_files/$i || return 1; =
done &&
>     -       for i in $(test_seq 1 100); do touch 100_files/$i || return 1=
; done &&
>     -       for i in $(test_seq 1 1000); do touch 1000_files/$i || return=
 1; done &&
>     -       for i in $(test_seq 1 10000); do touch 10000_files/$i || retu=
rn 1; done &&
>     -=3D=3D=3D=3D=3D=3D=3D
>             touch_files 1 &&
>             touch_files 10 &&
>             touch_files 100 &&
>             touch_files 1000 &&
>             touch_files 10000 &&
>     ->>>>>>> e89980feb1d (t7527: test status with untracked-cache and fsm=
onitor--daemon)
>             git add 1_file 10_files 100_files 1000_files 10000_files &&
>             git commit -qm "Add files" &&
>
> Which is fully expected, i.e. here the diff is modified (M).
>
> But there aren't any added lines, so why do I get it under =3DA, and why
> isn't the diff shown with =3DD (compare a normal 'git log --diff-filter=
=3DD
> -p')?:

Note that 'A' and 'D' diff filters are NOT about added/deleted lines,
they are about added/deleted files.  Those diff-filters will not find
add/deleted lines except when the entire file is added/deleted.  So
this part is fully expected.

>     $ for i in A D; do echo With $i: && git -P show --oneline --remerge-d=
iff --diff-filter=3D$i d120673d7cc; done
>     With A:
>     d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) in=
to seen
>     diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>     remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.=
sh
>     With D:
>     d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) in=
to seen
>     diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>     remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.=
sh

Yes, this is the same issue as the first one above: my extra code in
patch 7 makes it always show the conflict headers (there are no add or
delete changes to show for this particular commit).

> Furthermore pathspec arguments seem to be broken. I.e. to use that
> commit we can see without --remerge-diff that it's not directly modified
> in a non-merge in that range:
>
>     $ git -P log --oneline origin/master..origin/next -- t/perf/p7519-fsm=
onitor.sh
>     d6f56f3248e Merge branch 'es/test-chain-lint' into next
>
> But this should surely work, but doesn't. It's faking up a diff with =3DM=
,
> so the pathspec filters should show it, shouldn't they?
>
>     $ for i in A M D; do git -P show --oneline --remerge-diff --diff-filt=
er=3D$i d120673d7cc -- t/perf/p7519-fsmonitor.sh; done
>     $

For pinpointing this down a bit more, you could simplify this command
line to just

    $ git show --remerge-diff d120673d7cc -- t/perf/p7519-fsmonitor.sh
    $

and see that it doesn't include any output.  In other words, it's not
an interaction with --diff-filter (or --oneline), but just the
pathspecs.

(Also, it turns out that you can also leave out --remerge-diff and
you'll also get no output, but I'm not sure if that helps or hurts
with the "debugging", which I'll continue below.)

> Probably what's happening is that the filtering is being done on the
> pre-"-remerge-diff" output. I.e. the traversal code needs to be updated
> to inject modified paths into the commits we show --remerge-diff commits
> for (but I'm just guessing).

Yes, the filtering is being done on the commit before
do_remerge_diff() is ever called.  In fact, do_remerge_diff() is NOT
called; it never even gets a chance to look at this commit.

But this isn't unique to remerge-diff; check this out:

    $ git show --diff-merges=3Dfirst-parent d120673d7cc --
t/perf/p7519-fsmonitor.sh
    $ git show --diff-merges=3Dseparate d120673d7cc -- t/perf/p7519-fsmonit=
or.sh
    $

This might explain what's going on to you:

    $ git diff --raw d120673d7cc^1 d120673d7cc -- t/perf/p7519-fsmonitor.sh
    :100755 100755 c8be58f3c7 e70252ed65 M  t/perf/p7519-fsmonitor.sh
    $ git diff --raw d120673d7cc^2 d120673d7cc -- t/perf/p7519-fsmonitor.sh
    $

Basically, git-log's (and git-show's) default history simplification
says "oh, the file version matches what was seen in the second parent?
 UNINTERESTING."  Which is kinda broken when diffing against the first
parent OR against the remerge-diff.

This particular issue is probably worth bringing up in the
remerge-diff documentation (and perhaps also the diff-merges=3Dseparate
and diff-merges=3Dfirst-parent documentation), so that users know they
may want to specify --full-history together with these options.  (Or
maybe these particular types of diff-merges should just automatically
turn full history on?)

Now, just to show that this really is a history simplification issue,
here's the output when I include the --full-history flag together with
your command line:

$ git show --remerge-diff --oneline --full-history --diff-filter=3DM
d120673d7cc -- t/perf/p7519-fsmonitor.sh
d120673d7c Merge branch 'jh/builtin-fsmonitor-part2' (early part) into seen
diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.sh
index 02b53bcaec..e70252ed65 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -127,23 +127,11 @@ test_expect_success "one time repo setup" '
        fi &&

        mkdir 1_file 10_files 100_files 1000_files 10000_files &&
-<<<<<<< 61239ae3ee (Merge branch 'pw/fix-some-issues-in-reset-head' into s=
een)
-       for i in $(test_seq 1 10); do touch 10_files/$i || return 1; done &=
&
-       for i in $(test_seq 1 100); do touch 100_files/$i || return 1; done=
 &&
-       for i in $(test_seq 1 1000); do touch 1000_files/$i || return 1; do=
ne &&
-       for i in $(test_seq 1 10000); do touch 10000_files/$i ||
return 1; done &&
-||||||| 9d530dc002
-       for i in $(test_seq 1 10); do touch 10_files/$i; done &&
-       for i in $(test_seq 1 100); do touch 100_files/$i; done &&
-       for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
-       for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
-=3D=3D=3D=3D=3D=3D=3D
        touch_files 1 &&
        touch_files 10 &&
        touch_files 100 &&
        touch_files 1000 &&
        touch_files 10000 &&
->>>>>>> e89980feb1 (t7527: test status with untracked-cache and
fsmonitor--daemon)
        git add 1_file 10_files 100_files 1000_files 10000_files &&
        git commit -qm "Add files" &&

So, for this pathspec with remerge-diff, we're at least behaving
exactly as git-log is documented.  But I do agree that folks might not
be expecting the default history simplification that log/show do when
using these other diff types.

> For the rest of the --diff-filter flags the behavior also seems wrong, I
> really didn't expect this to show any output:
>
>     $ for i in R T U X B; do echo With $i: && git -P show --oneline --rem=
erge-diff --diff-filter=3D$i d120673d7cc; done
>     With R:
>     d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) in=
to seen
>     diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>     remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.=
sh
>     With T:
>     d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) in=
to seen
>     diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>     remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.=
sh
>     With U:
>     d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) in=
to seen
>     diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>     remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.=
sh
>     With X:
>     d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) in=
to seen
>     diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>     remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.=
sh
>     With B:
>     d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) in=
to seen
>     diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>     remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.=
sh
>
> I.e. we don't have a (R)ename, (T)type change, (U)nmerged (well, maybe,
> but isn't it just for the index? See t6060-merge-index.sh) or Unknown
> (X) there. Are they all being shown because of that generic "remerge
> CONFLICT" line?

Here you're repeating the same issue as at the beginning of the email,
though I guess just to check all the other diff-filter types besides
A, M, and D?  I agree we want to be able to filter these away somehow,
but, if a merge had conflicts and was resolved without making any file
changes, I don't want those conflicts notices to be filtered away when
I do a simple
    $ git show --remerge-diff ${merge_commit}
So, we need a clever solution that handles both kinds of cases, and
hopefully in a way that generically makes sense.  Perhaps the conflict
notices are selected by --diff-filter=3DU; maybe something else.  I'm
open to ideas.

> If the answer to all of the above is "yes, some of it is weird or
> unintended, but let's deal with it later" I'd think that would also be
> fine.
>
> But let's then at least add something like what I added to the
> git-range-diff.txt docs in df569c3f31f (range-diff doc: add a section
> about output stability, 2018-11-09). I.e. explicitly say that we might
> change the output when combined with other log options in the future,
> and that any combination not currently documented won't be supported.
>
> Re the CL mention of:
>
>      * =C3=86var suggested also extending the docs with usage guidelines,=
 but the
>        example he picked was IMO best handled by just add --remerge-diff,=
 so I'm
>        not sure what to add to the docs. Maybe the log -S<string> --remer=
ge-diff
>        example as a way to more reliably determine when a string was adde=
d to or
>        removed from the codebase? Where would that go anyway?
>
> I don't think we need to document how --remerge-diff interacts with -S,
> -G, or perhaps even most of --diff-filter.
>
> But per the above it seems to me that we should at least have basic
> tests (perhaps TODO tests), or explicitly document/note that some of the
> interactions are buggy/weird (or not, maybe I'm just missing something).
>
> The same goes for some other diff options, particularly those where
> we're showing output we didn't before because of --remerge-diff,
> e.g. --check is one such option. When I alter your tests with:
>
>     diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
>     index c1b44138145..d96320e6ab8 100755
>     --- a/t/t4069-remerge-diff.sh
>     +++ b/t/t4069-remerge-diff.sh
>     @@ -120,7 +120,8 @@ test_expect_success 'setup non-content conflicts'=
 '
>
>             git checkout -b resolution side1 &&
>             test_must_fail git merge side2 &&
>     -       test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
>     +       test_write_lines 1 2 three 4 5 6 7 8 >numbers &&
>     +       echo "9 " >>numbers &&
>             git add numbers &&
>             git add letters_side1 &&
>             git rm letters &&
>
> The --check option works as expected, but we've got no test for the
> combination of the two. Maybe we don't need them since we're confident
> enough in the shared machinery, but I'd think it would be better to
> consider this a black box and test it. I.e. maybe another --check
> implementation would filter on whatever we use for the pathspecs
> (showing it doesn't need to look at merge commits), and show nothing.
>
> All of the above is just noting the journy of testing this, i.e. "hrm,
> will it work with XYZ? No? Seems odd, and it's not tested at all...".
>
> As noted before I find the current output really useful already. I've
> just been trying to poke it in various ways to see if I can uncover any
> bugs or unintended behavior.

Very helpful, thanks.  So, I think there are three issues here:

   * default history simplification is surprising for
--diff-merges=3D{separate,first-parent,remerge}, particularly in
combination with pathspecs.  Document that, or just have these options
turn on --full-history.
   * more tests would be useful (though I'm worried about
combinatorial explosion, so I think just a few more would be good,
particularly around the --diff-filter options)
   * interactions with --diff-filter are suboptimal.  We need
something better, but if I revert my other changes to fix that issue
then I break the simple "Did this merge have conflicts?" usecase.  We
need some clever solution.
