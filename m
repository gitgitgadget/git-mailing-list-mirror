Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8759C677F1
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 17:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjALRyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 12:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjALRyG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 12:54:06 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0E755E4
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 09:14:41 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id q2so20051261ljp.6
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 09:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz3tDBSwtqNoFCoJ1y5/R9EzlW1il2BMvXvzHa4LxRo=;
        b=pvykvnrjkfZANxe/FX2uZFdnU+nY4+lDzuYIKcakMH0FXyt3g3l26iSZhDVbNcafsl
         ZFSCIm4OYGZ9FvkeAFu9aArszvGEmU73GqXzOSYqe1i55PfTf2DCgKorCllckSZzLZtc
         vIY3y0trqA9D6GURLfw/BorF1kggmlr/220W5LeNjc51QAGGCOFuPsoD21aS+Erg3z0C
         DwIqFUKokDcP+KQPy1mqSjeEp6jbe4gkyEFgrmZD/LgOlhBb++Bb3lOTJ6t9q7S0K8uH
         Bv78/un5f3FtzDDd9YVIlWNkNZl5Ka3bSYM/MjZWYCqHyhsKt/IwpjRRzhATSJ69zndx
         izCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iz3tDBSwtqNoFCoJ1y5/R9EzlW1il2BMvXvzHa4LxRo=;
        b=EohuI97MQ47HlYAs+9tNC/TjaJoxa9ha0bwo6Q+MfYUuQMz3eX2tK1k2/ryIj96gJC
         nDX8hy3i8Q1v1rIHW3li+fRU3AvXKscSTicsljTYI7VcbITw/k9EWWizX7XEQABNmu6X
         U/M2BFz0TOTr1LVFJvP5+b5Fuv+04UJgc6fM6wLd/H34JAhsou636m+UD8Jbiq3rUJ0z
         t2WugvKmksJpM3Vk+wJ0EXS2xu8IA8ThFJYGEomKxKQQARUCw+oRMEBpbSpbT4ul1sZF
         xJTWpluKa0QwBnhDiGeM3PfVFhVcMWqvmdGGz6EymtVSNulmOVOPO+jul8nmLYqnJSxg
         MoKg==
X-Gm-Message-State: AFqh2kpy09AQwfn2T2qC66WmfvjsFAV+YG3cAcTZn/wv5FSENU8crTxG
        wUzJhH2MpojukNuATCMduVWUPpcdqKEguylQOr8=
X-Google-Smtp-Source: AMrXdXu56NMs39hXFbe3EWQTX5x7hrsOffVYqa0QZowRfyJL5KdYXjniqJpI+yBVJWDq8aEW5GJPK22xPH0fzKWSIeU=
X-Received: by 2002:a2e:964c:0:b0:284:6390:1f8 with SMTP id
 z12-20020a2e964c000000b00284639001f8mr1616463ljh.167.1673543679139; Thu, 12
 Jan 2023 09:14:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com> <230112.86pmbk0vvj.gmgdl@evledraar.gmail.com>
In-Reply-To: <230112.86pmbk0vvj.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Jan 2023 09:14:26 -0800
Message-ID: <CABPp-BFf4pbRAy+Oaghx5d8DZgBjY_OUM-rJZna+JyNwx9WB-Q@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2023 at 5:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Jan 12 2023, Phillip Wood via GitGitGadget wrote:
>
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > When adding a "break" command to a rebase todo list it can be helpful t=
o
> > add a comment as a reminder as to what the user was planning to do when
> > the rebase stopped. Anything following the command is interpreted as an
> > argument to the command and results in an error. Change this so that a
> > "break command may be followed by "# <comment>" in the same way as
> > a "merge" command. Requiring the comment to begin with "# " allows the
> > break command to start taking an argument in the future if that turns
> > out to be useful.
> >
> > Reported-by: Olliver Schinagl <oliver@schinagl.nl>
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> >     rebase -i: allow a comment after a "break" command
> >
> >     I'm open to suggestions for other ways to handle comments but copyi=
ng
> >     what we do to separate merge parents from the merge commit subject
> >     seemed simplest.
> >
> >     Should this print the comment when stopping for a break command?
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1460%=
2Fphillipwood%2Fsequencer-allow-comment-after-break-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1460/phi=
llipwood/sequencer-allow-comment-after-break-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1460
> >
> >  Documentation/git-rebase.txt |  4 +++-
> >  sequencer.c                  |  7 +++++--
> >  t/lib-rebase.sh              |  2 +-
> >  t/t3418-rebase-continue.sh   | 16 ++++++++++++++++
> >  4 files changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
> > index f9675bd24e6..511ace43db0 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -869,7 +869,9 @@ the files and/or the commit message, amend the comm=
it, and continue
> >  rebasing.
> >
> >  To interrupt the rebase (just like an "edit" command would do, but wit=
hout
> > -cherry-picking any commit first), use the "break" command.
> > +cherry-picking any commit first), use the "break" command. A "break"
> > +command may be followed by a comment beginning with `#` followed by a
> > +space.
>
> You're missing a corresponding edit here to the help string in
> append_todo_help(), as you note you're making "break" support what
> "merge" does, and that help string documents that "merge" accepts a
> comment, after this we don't do that for "break", but should one way or
> the other (see below).
>
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2509,7 +2509,9 @@ static int parse_insn_line(struct repository *r, =
struct todo_item *item,
> >       padding =3D strspn(bol, " \t");
> >       bol +=3D padding;
> >
> > -     if (item->command =3D=3D TODO_NOOP || item->command =3D=3D TODO_B=
REAK) {
> > +     if (item->command =3D=3D TODO_NOOP ||
> > +         (item->command =3D=3D TODO_BREAK &&
> > +          (bol[0] !=3D '#' || (bol[1] && !isspace (bol[1]))))) {
> >               if (bol !=3D eol)
> >                       return error(_("%s does not accept arguments: '%s=
'"),
> >                                    command_to_string(item->command), bo=
l);
> > @@ -2524,7 +2526,8 @@ static int parse_insn_line(struct repository *r, =
struct todo_item *item,
> >                            command_to_string(item->command));
> >
> >       if (item->command =3D=3D TODO_EXEC || item->command =3D=3D TODO_L=
ABEL ||
> > -         item->command =3D=3D TODO_RESET || item->command =3D=3D TODO_=
UPDATE_REF) {
> > +         item->command =3D=3D TODO_RESET || item->command =3D=3D TODO_=
UPDATE_REF ||
> > +         item->command =3D=3D TODO_BREAK) {
> >               item->commit =3D NULL;
> >               item->arg_offset =3D bol - buf;
> >               item->arg_len =3D (int)(eol - bol);
> > diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> > index b57541356bd..a648013f299 100644
> > --- a/t/lib-rebase.sh
> > +++ b/t/lib-rebase.sh
> > @@ -51,7 +51,7 @@ set_fake_editor () {
> >               case $line in
> >               pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|re=
set|r|merge|m)
> >                       action=3D"$line";;
> > -             exec_*|x_*|break|b)
> > +             exec_*|x_*|break_*|b_*|break|b)
> >                       echo "$line" | sed 's/_/ /g' >> "$1";;
> >               merge_*|fixup_*)
> >                       action=3D$(echo "$line" | sed 's/_/ /g');;
> > diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> > index 130e2f9b553..18d82869b38 100755
> > --- a/t/t3418-rebase-continue.sh
> > +++ b/t/t3418-rebase-continue.sh
> > @@ -266,6 +266,22 @@ test_expect_success 'the todo command "break" work=
s' '
> >       test_path_is_file execed
> >  '
> >
> > +test_expect_success 'the todo command "break" accepts a comment' '
> > +     rm -f execed &&
> > +     test_write_lines "break # comment" "break #" "exec >execed" >expe=
ct &&
> > +     write_script cat-todo.sh <<-\EOS &&
> > +     GIT_SEQUENCE_EDITOR=3D"grep ^\[^#\]" git rebase --edit-todo >actu=
al
> > +     EOS
> > +     FAKE_LINES=3D"exec_./cat-todo.sh break_#_comment b_# exec_>execed=
" \
> > +             git rebase -i HEAD &&
> > +     test_cmp expect actual &&
> > +     test_path_is_missing execed &&
> > +     git rebase --continue &&
> > +     test_path_is_missing execed &&
> > +     git rebase --continue &&
> > +     test_path_is_file execed
> > +'
> > +
> >  test_expect_success '--reschedule-failed-exec' '
> >       test_when_finished "git rebase --abort" &&
> >       test_must_fail git rebase -x false --reschedule-failed-exec HEAD^=
 &&
> >
> > base-commit: 8a4e8f6a67e7fc97048d4666eec38399b88e0e3b
>
> I like this direction, but I don't see why we need to continue this
> special-snowflakeness of only allowing specific commands to accept these
> #-comments.
[...]
> For "pick" we probably need to explicitly exclude it, although I can't
> remember if we do anything useful with the part of the line after the
> OID (maybe not...).

I disagree; pick should automatically always have comments.  In
particular, everything after the OID should be preceded by a '# '.
The fact that we don't do that confuses people into thinking the
commit summary is part of the directive or that by editing the commit
summary in the todo list, that the commit message of the picked commit
will somehow be updated to reflect such edits.  I think the fact that
even you can't remember whether we do anything useful with the part of
the line after the OID, despite being one of the most prolific git
contributors of all time, reinforces the point that no one knows what
that commit summary means and we shouldn't be surprised that users get
confused by it.  We should just comment it out to make it clear that
we will always ignore those words (and any changes thereto); the
commit summary is only there as an aid to the user.

I've been meaning to send in a patch to do precisely this
(https://github.com/newren/git/commit/f1ae608477e010b96557d6fc87eed9f3f39b9=
05e).

Of course, the same applies to edit/squash/fixup/reword, though if I
could go back in time...(warning, long tangent coming)...I would make
it so those four directives did not accept any commit ID argument.
Only "pick" and "reset" would accept a commit ID.  Instead, today's
"edit X" would be two commands ("pick X" followed by either "break" or
"edit"), "fixup X" would be "pick X" + "fixup", and "reword X" would
be "pick X" + "reword".  That'd help users understand rebase state
much better (it's so easy for users to get confused by whether they
should be using `git commit --amend` vs. `git rebase --continue` and I
think this is partially to blame, though there's other changes we
could make to help with that dichotomy as well).  The separate
directives would also make it much easier to figure out how to both
fixup and edit a single commit in the same rebase (pick the commit,
then add a fixup directive, then an edit directive).  In fact, "squash
X" could just be discarded as superfluous, since it's just "pick X" +
"fixup" + "reword" (or we could keep squash as an abbreviation for
both "fixup" + "reword").  There's other things I'd change as well,
which are tangential to this tangent, but I'm clearly veering way off
the topic of comments in the rebase todo list, so I'll stop here.
