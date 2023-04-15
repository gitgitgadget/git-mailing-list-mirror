Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C006C77B70
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 19:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDOTH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 15:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDOTH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 15:07:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E5B3C11
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 12:07:24 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2a8aea2a610so4897631fa.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681585643; x=1684177643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReSKf4DDTmWZvP2383UFRTPvQkeB9D49b3itBrxvscs=;
        b=ptyBdfmpJKl0Cr3n3U/va9wOqQqBTY06smDlllbnNhDICe8db/mxe0VBwiWoVsOT5a
         2vBG4zwY2eENULwlaTlgI5QgTgJOLhr1U+w1K3oTGvLQF2HajvbcH13LGTjjh32neO50
         3pXClf9ajPr+eueq9bnG5C6NUIAkDZlEmOCuS1RCSoMm2ikNvOJ7ZDRGM4zm6PDTOrDR
         NT3tDazZbFOBwWXQZ/5Uqt1E75Q2ms3zktuzxOYfncX02+z8MLwiFu94ff7SLojUVxMg
         yDfmEsxyicjSGPtfrDmaN49ZohqzXtOegcEgZvqbv1jlb3n6Z2FevrYorE3eBSoW0XWI
         fw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681585643; x=1684177643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReSKf4DDTmWZvP2383UFRTPvQkeB9D49b3itBrxvscs=;
        b=cL48EL6qAXdSTdZxoQ6k2Hk8EwXdNNzYQN9OEwXrc3gWEhqA+tXVnukW9xpHo+ADB5
         vQunQqxJwbhAkGeUmtJ/U8BkfwBGhIIR5RSWr1O9K7yo+lt1zJZcTUmg/wv38Z56NV7Z
         IKbxWl8h4uiQLCTPT51R1k5B7q/WTwi+hpV14KpqgoAV4W3aakMdP+Pl10kjpx12eFWu
         1sZ9TBBQ5+4d1mn1mmuSrj8/OWiO1U84nlj3uqATxx4mwbiHqr8S4MgHeHOLXQRTrhGi
         AUUB+23bCyRBIv+q4/r8hlNRF6Gxzwq3Da+zt6QEt3KPjzF/qqrsdj2sNyza/Eee41v4
         13QA==
X-Gm-Message-State: AAQBX9fPDGTwKfez4CYWuQSJ7EkDhQTqXPU5ZCcseuoyJQuikYuS9GUa
        H07tgkqlMxofZFZcleiZs2CasYE9cvlZ4GjtkEg=
X-Google-Smtp-Source: AKy350ZK31P3LJz8wDEBK3GUJVuOOYYhETftrz/hCoThd5QbZ2JCHhdgDLtW194XY5sJsvJg7vWVTW26TacBlDyfTgE=
X-Received: by 2002:ac2:563c:0:b0:4eb:1606:48d5 with SMTP id
 b28-20020ac2563c000000b004eb160648d5mr794600lff.7.1681585642578; Sat, 15 Apr
 2023 12:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com>
In-Reply-To: <89c78da5-388a-e52b-b20b-e376ac90de14@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Apr 2023 12:07:10 -0700
Message-ID: <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 7:23=E2=80=AFAM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 4/14/2023 10:09 AM, Derrick Stolee wrote:
> > On 4/7/2023 3:24 AM, Christian Couder wrote:
> >> From: Elijah Newren <newren@gmail.com>
> >>
> >> Instead of the fixed "<oldbase> <branch>" arguments, the replay
> >> command now accepts "<revision-range>..." arguments in a similar
> >> way as many other Git commands. This makes its interface more
> >> standard and more flexible.
> >
> > Unfortunately, while doing this, you have broken the --onto
> > logic:
> >
> >  $ git replay --onto HEAD~2 HEAD~1 HEAD
> >  fatal: replaying down to root commit is not supported yet!
> >
> > The rev-walk you are supplying by this line...
> >
> >> +    argc =3D setup_revisions(argc, argv, &revs, NULL);
> >
> > is taking the remaining arguments and using them as tips to
> > walk. We need to be able to recognize that --onto A B C means
> > that A is the new base and our walk is B..C.
>
> I'm realizing after hitting "send" that this change is
> intentional (based on your test updates). I don't agree with
> it, though.
>
> Sending arbitrary command-line arguments to setup_revisions()
> creates an opportunity for behavior you are not expecting.

Note that fast-export has always accepted the full range of
setup_revisions() flags, even though many options make no sense.
Perhaps we could tighten up the parsing for fast-export, but limiting
fast-export to three commits in order to avoid other nonsensical
combinations would destroy its utility.

You may think I've gone on a tangent, but I think it's an important
comparison point here.  I think limiting replay to three commits does
the same: destroys its intended utility.  replay is a patch-based
analogue to fast-export, and we need a wide range of the revision
ranges for it to work.

(There are other interesting comparisons here too.  For example, if
someone specifies commits rather than branches to fast-export, then
things break down: new commits may be written but nothing takes
advantage of them so they merely become garbage to be gc'ed later.
Likely not what the user wanted.  The exact same issue existed for
replay.  However, in replay's case I tried to add some sanity checking
for it -- perhaps that sanity checking would be useful to copy to
fast-export?)

> For instance, can users pass multiple ranges?

There's no such thing as multiple ranges for most commands (see
f302c1e4aa0 ("revisions(7): clarify that most commands take a single
revision range", 2021-05-18))

However, users should absolutely be allowed to specify something like

  $ git replay --onto new-base master..my-topic some-base..other-topic

which is one revision range, and I'd expect replay to take commits in
the history of either my-topic or other-topic, which are not in the
history of either master or some-base, and replay them.  It'd be
equivalent, in most cases, to the separate commands:

   $ git replay --onto new-base ^master ^some-base my-topic
   $ git replay --onto new-base ^master ^some-base other-topic

The first of the two commands above, for example, would replay the
commits in my-topic back to nearer of (master, some-base) and do the
replaying on top of new-base.  The second command is similar, but with
my-topic replaced by other-topic.

Notice, though, that I said most cases.  There's an important case
where the single command is different from the two commands: when
my-topic and other-topic share common commits (which is not also
shared by master and some-base), we want the replayed common history
to remain common.  If you do two separate commands, the replayed
common history is no longer common (those commits will instead be
duplicated with separate committer dates).  So, supporting the single
command form is an intrinsic design consideration for git-replay.

> Can users supply --first-parent?

Absolutely, and it might be a useful replacement for or supplement to
--[no-]rebase-cousins.

Also, we definitely want to allow --ancestry-path and
--ancestry-path=3D<commit>, the latter of which was specifically written
for use in git-replay.

In fact, --first-parent sometimes might be equivalent to a particular
specialization of --ancestry-path=3D<commit>, so yeah, I definitely want
to allow it.

> What happens if they add an --author filter?

git fast-export accepts full revision ranges, including ones that make
no sense like this.  We could add patches to exclude such options, to
both replay and fast-export.  Or just document that they make no
sense.

To answer the question as asked, though, let me first provide a little
background: for a commit A with parent B, git-replay checks whether
the parent of the current commit (i.e. for A that'd be B) has been
replayed (as B').  If so, it will make the parent of A' be B'.  If
there is no B' (e.g. because B was part of "upstream" and thus wasn't
replayed), it makes the parent of A' be whatever is passed to --onto.
This allows git-replay to not only rebase/replay a linear set of
patches, but a partially or even fully divergent set of branches.

Now, with that background, if someone passes --author, there will be a
lot of parent commits that aren't replayed, resulting in each new
"first" commit being rebased on top of --onto, and only the final
one(s) being referenced by the updated ref commands.  In other words,
it'll leave lots of orphaned commits behind and only keep the "newest"
contiguous ones belonging to the author.  In simpler terms, passing
--author to git-replay would "make a really big mess of things" from
the user perspective, but an implementationally well-defined mess.
This, again, is similar to passing --author to fast-export -- that
tool has very different primitives involved causing it to make a
completely different big mess of things (and perhaps even bigger mess
of things), but the mess is at least implementationally well-defined
to those that understand the data structures and implementation.  (And
yes, I thought of this exact case while developing the tool, for what
it's worth.)

Does that mean I want to allow people to pass --author to fast-export
or replay?  I'd be perfectly happy with patches that prohibit it in
both tools.  But I'm also not worried about people off-roading and
trying it and getting non-sense.  A documentation patch stating that
using options that "disconnect" history make no sense with either
replay or fast-export might be the easiest (and most future-proof)
solution.

> [unstated: and what about other similar options?]

I'd really rather not have an allowlist of which revision options
should be allowed for use by git-replay.  A denylist might be okay, if
also implemented for fast-export, but I'm more of the opinion that we
just document that both commands only make sense with "contiguous"
history.

Most importantly, though, at a minimum I do absolutely want to allow
several negative revisions to be specified, several positive revisions
to be specified, and special flags like --ancestry-path or
--first-parent to be specified.  There may well be additional flags,
both current and future, that should be allowed too.

In short, I don't want another limited rebase; I want a more generic tool.


Hope that helps,
Elijah
