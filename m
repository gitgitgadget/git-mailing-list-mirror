Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02880C4332F
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhLJDwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhLJDwH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:52:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E001C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:48:33 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r25so25393780edq.7
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jmNFoBnj+fszsxYn7qKCOY+F6vSYr6rBOKtnST1izMI=;
        b=e+7pvubO8Fb/ICWCquMl2fv9y1p8C/pQzUirYTQgnHe+Aol0blibZeHt/P6dNnPpMO
         UVmQHP3bnMMeoofVgLx54kC5h20p8aw4QuwqP7A0cAaRPY7cddFr7DIfGvVRzBgG6qrZ
         rRkmySmSGmdNpnk8kJ60blLnr07GmnOl4LR6uqvcjI3UpWPSYXgi/hb/Ze9HDZ1mD8nm
         KyYw5DXu4BIUWhIZUM6wrJjjEVbieppfBLAhNAUpJnzXVUIQDBsHwU/Oxvi7llVKVtyL
         CZKoztpxWgKxQy1qt2PpxeMJRExoyKHsWRtcA5GM6qICFtmkMxP+QabKSWH4eX1pLG5G
         NLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jmNFoBnj+fszsxYn7qKCOY+F6vSYr6rBOKtnST1izMI=;
        b=QuP9WWjz/aFh2nbHqkNVW45X/n6JcxK+yyyBFUL3Ns1KMI65fo17MTrHfCeFkc9WDd
         rW8jEw5uzSXCsruVcGoHg7MVNOvm0RBYALm1M1VFBlQtV5HEUo/HjchqalWbVZiQi02w
         E7HGooALhRPIist/9I6ncXZxa07helJvj9oLPmLTVIbWwDtOB7zWtc4xNo7/isVfDcdw
         2YpEyKZQiirhR+cedvLqCePCQwURbQlRwnJUsktnusu/K5SX+rHDInOYZjUbPmGsOUSj
         KXMQqpH8h+FCHC8lVMnNLXT4oC7tGqisr6dYqF/etAA1Dt3nEWxTrneWL8Db9gx34rnO
         ji1Q==
X-Gm-Message-State: AOAM530u2estFWh8Sh6406cTxsboTGw3HJc8dWq530oEPZTwc3SreDfw
        rDQpHtjqI1ytfQ0vPiWtkBJoL9bUz/bB14sCUTlpKDco1Y8=
X-Google-Smtp-Source: ABdhPJzt9k6Z7GG7KIUyjeV3nn48Zu26MGxfsoToX/JUKNs+BQqjlyt6idVGGLSgh2MJAycXfLADoIbYI1o7/nk3d8o=
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr35065824edu.186.1639108111663;
 Thu, 09 Dec 2021 19:48:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com> <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com>
In-Reply-To: <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Dec 2021 19:48:20 -0800
Message-ID: <CABPp-BGdCizEGcwPS+0VB_vvYLpGCWKLqx-nbZtJ16QkVxzbGQ@mail.gmail.com>
Subject: Re: [PATCH v2] fast-export: fix surprising behavior with --first-parent
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        William Sprent <williams@unity3d.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 On Thu, Dec 9, 2021 at 12:13 AM William Sprent via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: William Sprent <williams@unity3d.com>
>
> When invoking git-fast-export with the --first-parent flag on a branch
> with merges, fast-export would early-out on processing the first merge
> on the branch. If combined with --reverse, fast-export would instead
> output all single parent commits on the branch.
>
> This commit makes fast-export output the same commits as rev-list
> --first-parent, and makes --reverse not have an effect on which commits
> are output.
>
> The fix involves removing logic within fast-export which was responsible
> for ensuring that parents are processed before their children, which was
> what was exiting early due to missing second parents. This is replaced
> by setting 'reverse =3D 1' before revision walking, which, in conjuction
> with topo_order, allows for delegating the ordering of commits to
> revision.c. The reverse flag is set after parsing rev-list arguments to
> avoid having it disabled.

This explains how you discovered the issue, but seems to focus on
these particular flags, leaving the reader wondering whether there are
other flags that are also mishandled that need additional care, and
whether this fix might break things for other sets of flags.  It took
me quite a bit of reasoning to satisfy myself on those points; it's
actually somewhat complex.  May I suggest an alternative commit
message based on that?  Here's what I think are the relevant points
(and yeah, it's lengthy):


The revision traversal machinery typically processes and returns all
children before any parent.  fast-export needs to operate in the
reverse fashion, handling parents before any of their children in
order to build up the history starting from the root commit(s).  This
would be a clear case where we could just use the revision traversal
machinery's "reverse" option to achieve this desired affect.

However, this wasn't what the code did.  It added its own array for
queuing.  The obvious hand-rolled solution would be to just push all
the commits into the array and then traverse afterwards, but it didn't
quite do that either.  It instead attempted to process anything it
could as soon as it could, and once it could, check whether it could
process anything that had been queued.  As far as I can tell, this was
an effort to save a little memory in the case of multiple root commits
since it could process some commits before queueing all of them.  This
involved some helper functions named has_unshown_parent() and
handle_tail().  For typical invocations of fast-export, this
alternative essentially amounted to a hand-rolled method of reversing
the commits -- it was a bunch of work to duplicate the revision
traversal machinery's "reverse" option.

This hand-rolled reversing mechanism is actually somewhat difficult to
reason about.  It takes some time to figure out how it ensures in
normal cases that it will actually process all traversed commits
(rather than just dropping some and not printing anything for them).

And it turns out there are some cases where the code does drop commits
without handling them, and not even printing an error or warning for
the user.  Due to the has_unshown_parent() checks, some commits could
be left in the array at the end of the "while...get_revision()" loop
which would be unprocessed.  This could be triggered for example with
    git fast-export main -- --first-parent
or non-sensical traversal rules such as
    git fast-export main -- --grep=3DMerge --invert-grep

While most traversals that don't include all parents should likely
trigger errors in fast-export (or at least require being used in
combination with --reference-excluded-parents), the --first-parent
traversal is at least reasonable and it'd be nice if it didn't just
drop commits.  It'd also be nice to have a simpler "reverse traversal"
mechanism.  Use the "reverse" option of the revision traversal
machinery to achieve both.

Even for the non-sensical traversal flags like the --grep one above,
this would be an improvement.  For example, in that case, the code
previously would have silently truncated history to only those commits
that do not have an ancestor containing "Merge" in their commit
message.  After this code change, that case would would include all
commits without "Merge" in their commit message -- but any commit that
previously had a "Merge"-mentioning parent would lose that parent
(likely resulting in many new root commits).  While the new behavior
is still odd, it is at least understandable given that
--reference-excluded-parents is not the default.


>
> Signed-off-by: William Sprent <williams@unity3d.com>
> ---
>     fast-export: fix surprising behavior with --first-parent
>
>     Hi,
>
>     I've noticed that git fast-export exhibits some odd behavior when pas=
sed
>     the --first-parent flag. In the repository I was working on, it would
>     only output the initial commit before exiting. Moreover, adding the
>     --reverse flag causes it to behave differently and instead output all
>     commits in the first parent line that only have one parent. My
>     expectation is more or less that git fast-export should output the sa=
me
>     set of commits as git rev-list would output given the same arguments,
>     which matches how it acts when given revision ranges.
>
>     It seems like this behavior comes from the fact that has_unshown_pare=
nts
>     will never be false for any merge commits encountered when fast-expor=
t
>     is called with --first-parent. This causes the while loop to follow t=
he
>     pattern of pushing all commits into the "commits" queue until the
>     initial commit is encountered, at which point it calls handle_tail wh=
ich
>     falls through on the first merge commit, causing most of the commits =
to
>     be unhandled.
>
>     My impression is that this logic only serves to ensure that parents a=
re
>     processed before their children, so in my patch I've opted to fix the
>     issue by delegating that responsibility to revision.c by adding the
>     reverse flag before performing the revision walk. From what I can see=
,
>     this should be equivalent to what the previous logic is trying to
>     achieve, but I can also see that there could be risk in these changes=
.
>
>     Changes since v1:
>
>      * Moved revs.reverse assignment down to similar assignments below.
>      * Removed braces around single statement while loop.
>      * The test now only changes directory inside a sub-shell.
>      * Applied stylistic feedback on test such as: making redirections be=
 on
>        the form >FILE etc.
>
>     There were questions raised about whether it makes sense at all for
>     fast-export to simply accept all git rev-list arguments whether they
>     have an effect or not - in particular for a flag like --reverse. I th=
ink
>     I agree that it is questionable behavior, or at least questionably
>     documented, but I also think it is out of scope for this change.
>
>     I did consider teaching fast-export to complain if given --reverse, b=
ut
>     it seemed inconsistent to me as it will gladly accept every other
>     rev-list argument (for example, "git fast-export HEAD --show-signatur=
e
>     --graph" works just fine).
>
>     cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason avarab@gmail.com
>
...
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 8e2caf72819..cb1d6473f12 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -107,18 +107,6 @@ static int parse_opt_reencode_mode(const struct opti=
on *opt,
>
>  static struct decoration idnums;
>  static uint32_t last_idnum;
> -
> -static int has_unshown_parent(struct commit *commit)
> -{
> -       struct commit_list *parent;
> -
> -       for (parent =3D commit->parents; parent; parent =3D parent->next)
> -               if (!(parent->item->object.flags & SHOWN) &&
> -                   !(parent->item->object.flags & UNINTERESTING))
> -                       return 1;
> -       return 0;
> -}
> -
>  struct anonymized_entry {
>         struct hashmap_entry hash;
>         const char *anon;
> @@ -752,20 +740,6 @@ static char *anonymize_tag(void *data)
>         return strbuf_detach(&out, NULL);
>  }
>
> -static void handle_tail(struct object_array *commits, struct rev_info *r=
evs,
> -                       struct string_list *paths_of_changed_objects)
> -{
> -       struct commit *commit;
> -       while (commits->nr) {
> -               commit =3D (struct commit *)object_array_pop(commits);
> -               if (has_unshown_parent(commit)) {
> -                       /* Queue again, to be handled later */
> -                       add_object_array(&commit->object, NULL, commits);
> -                       return;
> -               }
> -               handle_commit(commit, revs, paths_of_changed_objects);
> -       }
> -}

Deleted code is debugged code!  :-)

>
>  static void handle_tag(const char *name, struct tag *tag)
>  {
> @@ -1185,7 +1159,6 @@ static int parse_opt_anonymize_map(const struct opt=
ion *opt,
>  int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  {
>         struct rev_info revs;
> -       struct object_array commits =3D OBJECT_ARRAY_INIT;
>         struct commit *commit;
>         char *export_filename =3D NULL,
>              *import_filename =3D NULL,
> @@ -1283,18 +1256,13 @@ int cmd_fast_export(int argc, const char **argv, =
const char *prefix)
>
>         if (prepare_revision_walk(&revs))
>                 die("revision walk setup failed");
> +
> +       revs.reverse =3D 1;

I really wanted to see this next to the
    rev.topo_order =3D 1
statement elsewhere, but as you alluded to in the commit message, this
part of revision.c makes that unsafe:

"""
} else if (!strcmp(arg, "--reverse")) {
    revs->reverse ^=3D 1;
"""

However, given that it's unsafe to set revs.reverse=3D1 earlier, now
that I think about it, isn't it also unsafe to set revs.topo_order
where it is?  Someone could override it by passing --date-order to
fast-export.  (It's okay if you want to leave fixing that to someone
else, just thought I'd mention it while reviewing.)

>         revs.diffopt.format_callback =3D show_filemodify;
>         revs.diffopt.format_callback_data =3D &paths_of_changed_objects;
>         revs.diffopt.flags.recursive =3D 1;
> -       while ((commit =3D get_revision(&revs))) {
> -               if (has_unshown_parent(commit)) {
> -                       add_object_array(&commit->object, NULL, &commits)=
;
> -               }
> -               else {
> -                       handle_commit(commit, &revs, &paths_of_changed_ob=
jects);
> -                       handle_tail(&commits, &revs, &paths_of_changed_ob=
jects);
> -               }
> -       }
> +       while ((commit =3D get_revision(&revs)))
> +               handle_commit(commit, &revs, &paths_of_changed_objects);

Looks good.  Nice work on finding this.

>
>         handle_tags_and_duplicates(&extra_refs);
>         handle_tags_and_duplicates(&tag_refs);
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 409b48e2442..df1a5b1013a 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -750,4 +750,39 @@ test_expect_success 'merge commit gets exported with=
 --import-marks' '
>         )
>  '
>
> +
> +test_expect_success 'fast-export --first-parent outputs all revisions ou=
tput by revision walk' '
> +       git init first-parent &&
> +       (
> +               cd first-parent &&
> +               test_commit A &&
> +               git checkout -b topic1 &&
> +               test_commit B &&
> +               git checkout main &&
> +               git merge topic1 --no-ff &&
> +
> +               git checkout -b topic2 &&
> +               test_commit C &&
> +               git checkout main &&
> +               git merge topic2 --no-ff &&

micro nit: I'd really prefer the --no-ff before the "topic1" and "topic2".

> +
> +               test_commit D &&
> +
> +               git rev-list --format=3D"%ad%B" --first-parent --topo-ord=
er --no-commit-header main >expected &&

I'd much prefer this were changed to
    git log --format=3D"%ad %s" --first-parent >expected &&
because:
  * --topo-order is irrelevant when you have a linear history (which
--first-parent gives you)
  * --no-commit-header can be tossed by using log instead of rev-list
  * %B provides the entire (multi-line) commit message body but you
clearly care about how many commits you saw below and were assuming
just one line per commit, so %s is better.
  * The format looks weird when inspecting as a human; it's much nicer
with a space between the %ad and %s.

> +
> +               git fast-export main -- --first-parent >first-parent-expo=
rt &&
> +               git fast-export main -- --first-parent --reverse >first-p=
arent-reverse-export &&
> +
> +               git init import &&
> +               git -C import fast-import <first-parent-export &&
> +
> +               git -C import rev-list --format=3D"%ad%B" --topo-order --=
all --no-commit-header >actual &&

Same simplifications as above here:
   git -C import log --format=3D"%ad %s" --topo-order --all >actual &&

However, is there a reason you're using "--all" instead of "main"?
Although main is the only branch, which makes either output the same
thing, it'd be easier for folks reading to catch the equivalence if it
was clear you were now listing information about the same branch.

> +               git -C import rev-list --all >tmp &&
> +
> +               test_line_count =3D 4 tmp &&

I don't understand why you need tmp.  Why not just use actual on the
test_line_count line?

> +               test_cmp expected actual &&
> +               test_cmp first-parent-export first-parent-reverse-export

This last line would be much nicer to include right after
first-parent-reverse-export is created.  Or else move the creation of
first-parent-reverse-export down to just above this line.

> +       )
> +'
> +
>  test_done
