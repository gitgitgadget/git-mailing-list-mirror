Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15170C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 17:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiAVR3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 12:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiAVR3R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 12:29:17 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAC4C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 09:29:17 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id k25so9140784ejp.5
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 09:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4u+14/9DlH2lXbFpNsyY2+LJQlW5OqLPZddyT/hw/gk=;
        b=l/IexdeRP6jORhLUwhG07tq0M6tENuM/WiYN1tCp1o/qBSfZP8QKGpdkeofOny+/uK
         I7i839g6R7iGZBf7X4e70XDdoa1Qc/Po5CeQ7xWahAc3DPR+DQ80z+/5L1WY/Btqyda5
         7uMuigPN16LtG1BAwRCVfRx/fnnVB5ufUj90ZnEIC+cCucxkqzHOMa3uP9Dg7T9lbwUh
         FsAl+aWu2eVKJI19LdlT1H8cDrLX9+f8wKKNzChPfc0YKmvq5YF6qX9Atm5vM/jcVHPV
         TZW/ZV0hgqR0gd3y53WDUg0ivrljiqpRbO+kdt+x8ElexcEXmWQkppysMoQ94ty00Kay
         wKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4u+14/9DlH2lXbFpNsyY2+LJQlW5OqLPZddyT/hw/gk=;
        b=jwDIEgRVAyXChgGoF21IUk6dTURjMDZn2x77ubVIKVl5pvEIiX750Qke3hlHOfDM9i
         suGhC4ccNyG9AOb86iWRjt3T7XIjwNhlb/Eoz5bFqD/bOmY7izxDzC9yR9/UpALclxnk
         yxqVIgujO17r26O9juAogG5hmIL4l+C5Mq68aerLzuFdbt2c+0ZgSJSmT62PZ8y/Th05
         mnagKcd0iu/N2SqFThX3e/cmcFowyBRCLrRDg84MWTGbaDQN3GDsYxzpIykd4tLUbaFk
         49bCyv6m+xk9vgr3EYbQuTjWDFEY/DIGw4jrpPcMudIIb3SOhMPpLH0ylPOfWRVoO5PM
         OqIw==
X-Gm-Message-State: AOAM533mZ7HdvAH847LTcbWrFr7BIyeJJyVXzbYUAEv0iqPD3oDOOvTp
        k8FF8t3sZ/OSDoY3bYibPoaXT5/5U7gkV0at290=
X-Google-Smtp-Source: ABdhPJzzYWvRJJjiXeXrP/Y2AffUcVuyboCkqrmhuqf9CGnjfsR/Htos/rQGVi38nmZKZFak8uMgqE8xO0BqkWxltnw=
X-Received: by 2002:a17:906:794f:: with SMTP id l15mr7637443ejo.328.1642872555199;
 Sat, 22 Jan 2022 09:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20220120185548.3648549-1-jonathantanmy@google.com>
 <20220121174441.3991963-1-jonathantanmy@google.com> <220121.8635lgkj17.gmgdl@evledraar.gmail.com>
 <CABPp-BHgRQ+qNvq19wsBsMCR+Cn7FS+0FMYXVyyzEAZTsg-wjA@mail.gmail.com> <220122.86tudwht17.gmgdl@evledraar.gmail.com>
In-Reply-To: <220122.86tudwht17.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 22 Jan 2022 09:29:03 -0800
Message-ID: <CABPp-BG5WzgcEwxnjraEN-SEKxUUvz-wD68afjQd_sWFe6R=Vg@mail.gmail.com>
Subject: Re: [PATCH v2] sparse-checkout: create leading directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, jabolopes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 22, 2022 at 4:08 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jan 21 2022, Elijah Newren wrote:
>
> > On Fri, Jan 21, 2022 at 6:12 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Fri, Jan 21 2022, Jonathan Tan wrote:
> >>
...
> >> > =C3=86var mentioned "git sparse-checkout add" but I think that that =
is a
> >> > different problem - in the "git sparse-checkout init" case, we could=
 get
> >> > into this case with a template that does not have .git/info, but in =
the
> >> > "git sparse-checkout add" case, the user would have had to explicitl=
y
> >> > remove the info directory. So I'll limit this patch to the "init" ca=
se,
> >> > for now.
> > ...
> >>
> >> I agree that it's a slightly different problem, but I was just
> >> advocating for us testing what happened in these cases.
> >>
> >> The below fix-up does that.
> >
> > Different problem...addressed with a "fix-up"?  Why would we squash
> > extra testing of a different problem into the same commit?  I think
> > it'd at least deserve its own commit message.
>
> Sure, or split up, or with an amended commit message etc.

I think it's a totally different kind of thing and wouldn't belong in
the same commit even with an amended commit message.  I'm curious why
we're so far apart on this and whether I'm missing something.

...
> >> +test_expect_success 'git sparse-checkout add -- info/sparse-checkout =
missing' '
> >> +       test_when_finished "rm -rf empty" &&
> >> +       git init --template=3D empty &&
> >> +       git -C empty sparse-checkout init &&
> >> +       rm -rf empty/.git/info &&
> >> +
> >> +       cat >expect <<-\EOF &&
> >> +       fatal: unable to load existing sparse-checkout patterns
> >> +       EOF
> >> +       test_expect_code 128 git -C empty sparse-checkout add bar 2>ac=
tual &&
> >> +       test_cmp expect actual
> >> +'
> >> +
> >> +test_expect_success 'git sparse-checkout list -- info/sparse-checkout=
 missing' '
> >> +       test_when_finished "rm -rf empty" &&
> >> +       git init --template=3D empty &&
> >> +       git -C empty sparse-checkout init &&
> >> +       rm -rf empty/.git/info &&
> >> +
> >> +       cat >expect <<-\EOF &&
> >> +       warning: this worktree is not sparse (sparse-checkout file may=
 not exist)
> >> +       EOF
> >> +       git -C empty sparse-checkout list 2>actual &&
> >> +       test_cmp expect actual
> >> +'
> >> +
> >
> > So...you're trying to test what happens when a user intentionally
> > bricks their repository?
>
> I'm just saying that it's cheap to add a regression test for this
> missing bit of related coverage, so why not add it?

So, this is a slightly different issue than I was getting at before,
but this feels slightly obstructionist to me.  Now, suggesting related
improvements and ideas sounds totally fine; we should point those out
-- once.  But pushing it again as though it needs to be addressed as
part of the submission just doesn't feel right.  Jonathan's patch
fixes a real problem and feels complete to me.  There are always
additional things that could also be fixed or addressed for any patch
or series.  Expecting folks submitting a series to address every "next
step improvement along these lines" that any reviewer can think of
seems unfriendly, especially as it has a snowball effect.

Granted, if there's a bug with the patch, or it doesn't fully solve
the stated problem, then it's a different situation, but I don't think
that's the case here.  (Well, modulo the leftover removing of
"blank-template" which is a real issue you identified with the patch.)

And I think I'd say the same thing even if I saw your tests as being
much more closely related to what Jonathan was checking.

That's my $0.02 on "why not?".  The story totally changes if you want
to submit these tests separate from Jonathan's series.  If that's the
scenario, then I fully agree with you on "it's cheap to add more test
coverage so why not include it?"

Anyway...back to my curiosity about why we're so far apart on the
relatedness of your tests...

> We need to deal with the real world, a repo might be in all sorts of odd
> states, including because of a user mistake.

So, Jonathan was fixing behavior seen when the user hadn't even made a
mistake.  Opening up to all possible user mistakes seems to widening
scope pretty dramatically and feels like a different kind of thing to
me.  But even that scope doesn't seem to include the tests you've
proposed, at least not to me.  Under what circumstances would your
tests model a user mistake?  A user mistake to me looks like one of
the following:

  * "I hit Ctrl+C while a `git switch` or `git sparse-checkout set
...`  just happened to be furiously writing files"
  * "I ran `git sparse-checkout (add|list|reapply)` without first
running `git sparse-checkout (init|set)` as per the docs"

Your tests look roughly the same class as the following kinds of things:

  * echo garbage >.git/refs/heads/master
  * rm .git/objects/${random_loose_object_or_pack}

I know users can attempt surgery on $GIT_DIR, and that perhaps curious
ones will do that to see how things break in order to help them
understand how things work, but that seems to me to be a different
realm.

Note that I'm not saying we shouldn't test what happens when the repo
is intentionally corrupted; there's probably merit in that.  I'm just
curious why we're so far apart on this.  You view your tests as a
"slightly different problem" and feel these tests could be included in
Jonathan's commit with an "amended commit message".  I think they're
not only different classes of problems, but separated by a third class
("user mistake") between the two types of problems.  If Jonathan had
included your tests in his commit, I think I'd ask that they at
_least_ be split into different commits.

Am I missing the boat entirely somewhere?

> > (Note that `sparse-checkout init` sets core.sparseCheckout=3Dtrue, as
> > explicitly documented.  core.sparseCheckout=3Dtrue instructs git to pay
> > attention to $GIT_DIR/info/sparse-checkout for every unpack_trees()
> > call that updates the working tree, which basically means nearly any
> > significant Git operation involving a worktree update now needs that
> > file in order to function.  So, your commands told Git that this
> > directory is mandatory, and then you nuked the directory.)
>
> *nod*. But in that case shouldn't the errors say that you've configured
> core.sparseCheckout=3Dtrue but you're missing XYZ file?

Yeah, it probably should.

I just did a little more testing and it looks like commands like
"switch" don't even error out; they just treat the missing
$GIT_DIR/info/sparse-checkout files the same as all files being
included.  Weird.  It seems to come from dir.c:add_patterns(), which
appears to have perhaps gotten that way due to assuming the code was
exclusively about .gitignore files rather than the sparse-checkout
file.  I think this may be yet another example of why it was a mistake
to use gitignore-style patterns for the sparse-checkout feature,
though I'm more than a decade too late with my complaints.

Ugh.

But yeah, you're right to suggest we should have tests for this, and
perhaps some fixes as well...in a separate submission from this one.
;-)

> > Now, if you could find a testcase based on `git worktree add ...`
> > (which doesn't create an "info" directory) and then triggers problems
> > somehow without the intentional bricking, then what you'd have would
> > be more in line with what Jonathan is addressing here, but as it
> > stands it's hard to even call your testcases related.  There may be
> > some merit to testing deliberately broken repositories, but I'm just
> > not sure if that's what you really intended and were suggesting.  Was
> > it?  Or am I just missing something here?
>
> Doesn't the worktree case just use the "main" info/*, e.g. for
> info/excludes (didn't have time to test it now).

Maybe for info/excludes, I don't know.  But it certainly won't use the
main info/sparse-checkout; that'd be _horribly_ broken.  Each worktree
should be allowed to have its own sparsity rules.  And having multiple
worktrees where one worktree is not sparse, while others are sparse
but with different sparsity patterns from each other (often only
slightly different, but sometimes completely unrelated) is actually a
common usecase.  We do that a lot at $DAYJOB.
