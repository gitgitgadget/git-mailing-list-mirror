Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79639C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 04:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbiHRECp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 00:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243182AbiHRECd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 00:02:33 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C05EADCFF
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 21:02:11 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id n21so334483qkk.3
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 21:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kkSv3lUGMSkFpr8fv7j34anx3Nuh+w4LiSLSv1I9Uwg=;
        b=UJKTJ334emf5E8pEm1bU0dZdjt4Z9tc8p+HGHIA6Uz08/JTHXEiWLShT0Eugh6LdiU
         +EPQb89etgTr51xmXZ4Me1ewwGzBoNYGCiQhv64ysQ6LzcBJFL8Gx0abrPZbIF9b+rR3
         FotSvJSvAfz6cx0uuJr9RQClgAhHmt6F4PW8bn3PGDNZFdCgKCEnbdk2Vh2C9aw7lPEp
         +hE74bJqNzSU/AB2jgGcDKr0w3yvCX7vgLlykIxuuQsBGTom8YM9bMcqZzSeQ0B4iP3U
         HSfEzbKyLb4SkHHdZEEctLSc3SxWaC4vs8fgLxiAOmwfu+I+XItI4MVt47UzNP7jgKCs
         NIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kkSv3lUGMSkFpr8fv7j34anx3Nuh+w4LiSLSv1I9Uwg=;
        b=XFyCLHLA0wRaRiFXiEEe3HqnC9LUXzCvsf8ZryXueYD9MlKNv2xhqKz7OpoNMEPc3U
         c5VNASNYOhY1K0JYwDVGwIid23EWfmAAR489wBLB/UznYH7SxjyMA9/V6hL+6lQTWJdy
         eNUvRRyZqHdSCMfdkCAYz9SgfxFh3F7tigysPskQwpGU3C2sEVOOTdpaWb+MC6VPNsSQ
         oXx70vhcMsCNrH+MafMw3fKq9mfkAJmZy3EKvrmZxbpKyDMTn3K+IkmXJyYbEZgts1X+
         uDKDX9nZ6wiL5SMXbLLGlFOPI48eCqB62R2RZaRuS8g0idVEOOFEQhjlnU/Lmm32a1n3
         8/Ug==
X-Gm-Message-State: ACgBeo0icWME/cu0hL1WnibMlLh+x26c67zHofdceEORGfoogGbbYlFt
        P+hpqJB3YcU7Ezq1yWNPZHQHzWBvS4dofvkaEso=
X-Google-Smtp-Source: AA6agR7JU2FgccOSMdq/fWUCz6vcUgKK65y0sVwKuCmRCr6It9qOgcEjshNbA1s2wjP92nGCYJLY2C/hjAKelqaA1bg=
X-Received: by 2002:a05:620a:205d:b0:6bb:2393:b610 with SMTP id
 d29-20020a05620a205d00b006bb2393b610mr825293qka.413.1660795330297; Wed, 17
 Aug 2022 21:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
 <99287b67fd1c1e9fbceb4877738fb0aed722ec4a.1660704498.git.gitgitgadget@gmail.com>
 <xmqqpmgysda8.fsf@gitster.g>
In-Reply-To: <xmqqpmgysda8.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Aug 2022 21:01:59 -0700
Message-ID: <CABPp-BHmj+QCBFDrH77iNfEU41V=UDu7nhBYkAbCsbXhshJzzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] revision: allow --ancestry-path to take an argument
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 3:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > We have long allowed users to run e.g.
> >     git log --ancestry-path next..seen
> > which shows all commits which satisfy all three of these criteria:
> >   * are an ancestor of seen
> >   * are not an ancestor next
> >   * have next as an ancestor
>
> Is it a very good example, though?  Nothing builds on next, and next
> is not an ancestor of seen, so the command without --ancestry-path
> does give us individual commits that are not in 'next' yet, plus all
> the merge commits in master..seen but with --ancestry-path the
> answer is most likely an empty set.
>
> If you replace 'next' with 'master', it does start to make sense,
> but that is a bit too straight first-parent merge chain that may not
> be all that interesting.

Yeah, I should have written master..seen.

> > This commit allows another variant:
> >     git log --ancestry-path=$TOPIC next..seen
> > which shows all commits which satisfy all of these criteria:
> >   * are an ancestor of seen
> >   * are not an ancestor of next
> >   * have $TOPIC in their ancestry-path
> > that last bullet can be defined as commits meeting any of these
> > criteria:
> >     * are an ancestor of $TOPIC
> >     * have $TOPIC as an ancestor
> >     * are $TOPIC
>
> So, I have en/ancestry-path-in-a-range topic merged somewhere
> between 'master' and 'seen'.  Here is what I see:
>
>     $ seen/git log --oneline --ancestry-path=en/ancestry-path-in-a-range master..seen
>     21aef6c754 Merge branch 'ab/submodule-helper-leakfix' into seen
>     2a57fcc25e Merge branch 'ab/submodule-helper-prep' into seen
>     72ff5f5d3a ###
>     edb5cf4c31 Merge branch 'cw/remote-object-info' into seen
>     cc8f65a665 Merge branch 'ag/merge-strategies-in-c' into seen
>     c1bacacabf Merge branch 'es/mark-gc-cruft-as-experimental' into seen
>     fdf2d207d2 Merge branch 'js/bisect-in-c' into seen
>     2a1bbfc016 Merge branch 'po/glossary-around-traversal' into seen
>     7ecf004b9e Merge branch 'vd/scalar-enables-fsmonitor' into jch
>     9dba189986 Merge branch 'en/ancestry-path-in-a-range' into jch
>     4461e34d7d revision: allow --ancestry-path to take an argument
>     0605b4aad9 rev-list-options.txt: fix simple typo
>
> which is very much expected.  Two commits are what we want to
> highlight, and its merge into the first-parent-chain that leads to
> 'seen', and all its descendants on 'seen' are shown.
>
> Due to the way "ancestry-path" is defined, replacing the value to
> "--ancestry-path" from 4461e34d7d to 0605b4aad9 would not change the
> output, which is also expected.  If this were a three-commit topic,
> giving the middle commit would find both the first one (i.e. the
> ancestor) and the third one (i.e. the descendant) in the topic, while
> excluding the much-less-interesting base commit and its ancestors
> the topic builds on.

Yes.

> I am not exactly sure when this feature is useful, though.  It is
> handy to be able to enumerate descendants of a given commit, so
> perhaps the user knows about 0605b4aad9 and is trying to find other
> commits on the same topic, or something?  But then the merges nearer
> the tip of 'seen' than 9dba189986 are not very useful for that
> purpose.  It somehow feels like a solution in search of a problem.

Here's my usecase:
    git replay --i --keep-base --contained --ancestry-path=$TOPIC master..seen

Explanation of usecase: I want to be able to replay commits, much like
the current interactive rebase feature.  Unlike rebase, the selection
of commits is done via a standard <revision range>, for flexibility.
Now, replaying of commits in $TOPIC implies I probably want all the
topics that depend on it to be updated, and all the merges that depend
on any of those to be updated.  But, to achieve that, I don't want to
have to manually run N rebases and manually remerge things and whatnot
-- I want it all done in one command.  (And yes, replaying of merges
needs to handle squashed-in semantic fixes and replay those.)  So, I
want this command to replay all commits in the ancestry path of $TOPIC
in the range master..seen, keeping the current base (--keep-base), and
I want it to also update any --contained branches (meaning any
branches pointing to commits in the range being replayed).

Alternatives: For this usecase,

  * I cannot just use $TOPIC_TO_EDIT..seen, because that excludes the
    commits I want to tweak.

  * I could technically use `--ancestry-path master..seen`, but it's
    almost uselessly suboptimal as it would put hundreds of irrelevant
    commits in the TODO list (making it hard for the user to find what
    they want to edit) and then wastes time replaying all those commits
    unnecessarily as well.

  * As far as I can tell, there are no good alternatives here; and my
    question about it on the list didn't spur any satisfying answers[1].

If you'd rather I waited to submit the patch as part of a much larger
series implementing git-replay, I can do that.  I just thought it was
useful to send upstream independently.  But then I ran into the problem
that I thought it was weird to describe a usecase depending on something
that isn't yet very usable, and tried to explain it without that.

[1] https://lore.kernel.org/git/CABPp-BEqWX3Nr2HDxwS9d-_QjcKb_jS=fSjsP_Pbutw7-P5gbg@mail.gmail.com/

> > diff --git a/revision.c b/revision.c
> > index 0c6e26cd9c8..660f1dd1b9b 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -1105,7 +1105,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
> >                          struct commit_list **list, struct prio_queue *queue)
> >  {
> >       struct commit_list *parent = commit->parents;
> > -     unsigned left_flag;
> > +     unsigned left_flag, ancestry_flag;
> >
> >       if (commit->object.flags & ADDED)
> >               return 0;
> > @@ -1161,6 +1161,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
> >               return 0;
> >
> >       left_flag = (commit->object.flags & SYMMETRIC_LEFT);
> > +     ancestry_flag = (commit->object.flags & ANCESTRY_PATH);
>
> Wouldn't we want
>
>         if (revs->ancestry_path)
>                 ancestry_flag = (commit->object.flags & ANCESTRY_PATH);
>
> instead, so that the propagation of contaminated flag bits ...
>
> >       for (parent = commit->parents; parent; parent = parent->next) {
> >               struct commit *p = parent->item;
> > @@ -1181,6 +1182,8 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
> >                       if (!*slot)
> >                               *slot = *revision_sources_at(revs->sources, commit);
> >               }
> > +             if (revs->ancestry_path)
> > +                     p->object.flags |= ancestry_flag;
> >               p->object.flags |= left_flag;
>
> ... can become a simple
>
>                 p->object.flags |= ancestry_flag;
>
> here?  Or even just use a single variable to compute the set of
> flags to pass down i.e.
>
>         pass_flags = commit->object.flags & (SYMMETRIC_LEFT | ANCESTRY_PATH);
>
> before the loop, and then pass these two bits down at once, i.e.
>
> -               p->object.flags |= left_flag;
> +               p->object.flags |= pass_flags;
>
> taking advantage of the fact that ANCESTRY_PATH and SYMMETRIC_LEFT
> bits can be set to any object only when these features are in use?

Ooh, that does seem better.  I'll make that change.

> Or did I misread the patch and sometimes ANCESTRY_PATH bit is set on
> objects even when revs->ancestry_path is not in use?
>
> > +static void limit_to_ancestry(struct commit_list *bottoms, struct commit_list *list)
> >  {
> >       struct commit_list *p;
> >       struct commit_list *rlist = NULL;
> > @@ -1323,7 +1333,7 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
> >       for (p = list; p; p = p->next)
> >               commit_list_insert(p->item, &rlist);
> >
> > -     for (p = bottom; p; p = p->next)
> > +     for (p = bottoms; p; p = p->next)
> >               p->item->object.flags |= TMP_MARK;
> >
> >       /*
> > @@ -1356,38 +1366,39 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
> >        */
> >
> >       /*
> > -      * The ones that are not marked with TMP_MARK are uninteresting
> > +      * The ones that are not marked with either TMP_MARK or
> > +      * ANCESTRY_PATH are uninteresting
> >        */
> >       for (p = list; p; p = p->next) {
> >               struct commit *c = p->item;
> > -             if (c->object.flags & TMP_MARK)
> > +             if (c->object.flags & (TMP_MARK | ANCESTRY_PATH))
> >                       continue;
> >               c->object.flags |= UNINTERESTING;
> >       }
> >
> > -     /* We are done with the TMP_MARK */
> > +     /* We are done with TMP_MARK and ANCESTRY_PATH */
> >       for (p = list; p; p = p->next)
> > -             p->item->object.flags &= ~TMP_MARK;
> > -     for (p = bottom; p; p = p->next)
> > -             p->item->object.flags &= ~TMP_MARK;
> > +             p->item->object.flags &= ~(TMP_MARK | ANCESTRY_PATH);
> > +     for (p = bottoms; p; p = p->next)
> > +             p->item->object.flags &= ~(TMP_MARK | ANCESTRY_PATH);
> >       free_commit_list(rlist);
> >  }
>
> We have called process_parents() to paint ancestor commits that can
> be reached from the commit(s) of interest.  This helper function is
> called after that is done, and propagates the ancestry_path bit in
> the reverse direction, i.e. from parent to child.
>
> Once we are done with this processing, we no longer need
> ANCESTRY_PATH bit because the surviving ones without UNINTERESTING
> bit set are the commits on the ancestry_path.  OK.
