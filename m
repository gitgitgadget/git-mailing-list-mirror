Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2D9C433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617B764E90
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355313AbhCDAWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835984AbhCCIDc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 03:03:32 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3997C0617A9
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 23:44:06 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id e45so22669120ote.9
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 23:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oY005ssX0S2D0bxaXK7pKqkMXvDfMwEBLzSJqxbeKZc=;
        b=CnyziSV81YNnmaCMbRg7z+x6hLcvHGGwVkgD7DfbmomMa20XHZtNBryjvf+Q8EACc+
         kwRMCmXuD9yX70XKvIellrEAkASfDTvres93QWT/iEyEOipVJos9ty0JWF/cp6/XY835
         6qVjxtgTq0cFAVsFiHxlzGqLJbK4K5BmKLWmdWLyQ7ZmIiX9hNnDkCXluvWBC/HmKVal
         ZSzeCdu2oo6RPvGFumT+MKPneVrALkZrJLJNDv2YjGpM/yz6De2aR8dEvnoz8MGXHt9/
         Mn1q85uJ76FKdJTs30kWvdeQJMDpUodqzJYM7g+5FiCL4Jj7YkmiQOettxGCZ45M4JmN
         FcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oY005ssX0S2D0bxaXK7pKqkMXvDfMwEBLzSJqxbeKZc=;
        b=lwG6cKi6PxXmHHK/HxbAeTgd057BXsGdyZEznCGVPgLE4krbt7iMKmaecoFLQyCjV0
         +kawXjo8RrBBu634iVZrYC8xG1Yq8xvjqfwuiYZdad0rmQVBgjFuZB84XhyelFDp/eFV
         wLDFMCwFUQd22wnTqmjbfyQuHDDR2j3UxJDkAcY02IPbAb1TFchAbrGM/l5qpqFYOFQU
         DkTXaYnBA10AgDYwFS+1h9t+jD0+01vHLg11v6GvBfoVb7zMuClldn4wrggZt+waBzs3
         AFTdTi6w2VfUbcN1Q3frzPzKY1j5CAs9VpVScL3iSkr90OWRdkzyd9DDrLoaLTLinUKw
         dLhA==
X-Gm-Message-State: AOAM530A7og8n6EZ5lahpnGyLdT2HO9kW/z7BQed+i806kJfhZWRHVWw
        AdXhY4c9pXhX5lgsNtEMEhm/rlYEnPGyyS8Dtic=
X-Google-Smtp-Source: ABdhPJzYMC3Rd+iUhFVPTcMMEjvKx4oqd0Jxi8nP1DGH2Y8tbycMXDg4wTDdJTH94RolWqvF9/A2znX/JpMCMofsqbI=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr21556963otq.210.1614757446111;
 Tue, 02 Mar 2021 23:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-7-charvi077@gmail.com>
 <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com>
In-Reply-To: <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 3 Mar 2021 13:13:55 +0530
Message-ID: <CAPSFM5c1zR6yz=gATGxih0wL-W18AWgCHQhL_SPno5SeTzGQGg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Mar 2021 at 12:09, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Mar 1, 2021 at 3:52 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > ---
> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> > @@ -9,7 +9,7 @@ SYNOPSIS
> > +          [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
> > @@ -86,11 +86,39 @@ OPTIONS
> > ---fixup=<commit>::
> > +--fixup=[(amend|reword):]<commit>::
>
> Although technically correct, I can't help but wonder if we can be
> more friendly to readers by rephrasing this as:
>
>     --fixup=<commit>::
>     --fixup=amend:<commit>::
>     --fixup=reword:<commit>::
>
> which is probably a lot easier to take in and understand at a glance.
> Same comment applies to the synopsis.
>
> Not necessarily worth a re-roll.
>
> > +       Without `amend:` or `reword:`, create a `fixup!` commit where
> > +       the commit message will be the subject line from the specified
> > +       commit with a prefix of "fixup!'". The resulting "fixup!" commit
> > +       is further used with `git rebase --autosquash` to fixup the
> > +       content of the specified commit.
>
> I think it becomes important at this point to make it more clear that
> _only_ the content of <commit> gets changed by the "fixup!" commit,
> and that the log message of <commit> is untouched.
>
> > +The `--fixup=amend:<commit>` form creates an "amend!" commit to
> > +fixup both the content and the commit log message of the specified
> > +commit. The resulting "amend!" commit's commit message subject
> > +will be the subject line from the specified commit with a prefix of
> > +"amend!'" and the message body will be commit log message of the
> > +specified commit. It also invokes an editor seeded with the log
> > +message of the "amend!" commit to allow to edit further. And it
> > +refuses to create "amend!" commit if it's commit message body is
> > +empty unless used with the `--allow-empty-message` option. "amend!"
> > +commit when rebased with `--autosquash` will fixup the contents and
> > +replace the commit message of the specified commit with the "amend!"
> > +commit's message body.
>
> I had to read this several times to understand what it is trying to
> say. I believe that part of the problem is that the bulk of the
> description goes into great detail describing bits and behaviors which
> make no sense without understanding what an "amend!" commit actually
> does, which isn't explained until the very last sentence. So, I think
> the entire description needs to be flipped on its head. In particular,
> it should start by saying "create a new commit which both fixes up the
> content of <commit> and replaces <commit>'s log message", and only
> then dive into the details.
>
> In fact, what I just wrote suggests a larger problem with the
> description of `--fixup` overall. There is no high-level explanation
> of what a "fixup" (or "amend" or "reword") is; it just dives right
> into the minutiae without providing the reader with sufficient context
> to understand any of it. Only a reader who is already familiar with
> interactive rebase is likely to grok what is being said here. So,
> extending the thought I expressed above, it would be helpful for the
> description of `--fixup=[amend:|reword:]` to start by first explaining
> what a "fixup" is, followed by simple descriptions of "amend" and
> "reword" (building upon "fixup"), and followed finally by details of
> each. Very roughly, something like this:
>
>     Creates a new commit which "fixes up" <commit> when applied with
>     `git rebase --autosquash`.
>
>     A "fixup" commit changes the content of <commit> but leaves its
>     log message untouched.
>
>     An "amend" commit is like "fixup" but also replaces the log
>     message of <commit> with the log message of the "amend" commit.
>
>     A "reword" commit replaces the log message of <commit> with its
>     own log message but makes no changes to the content.
>
> And then dive into the details of each variation.
>

Agree, thanks for pointing this out in detail. I will rewrite the doc
in the above suggested way and update in the next version.

> > +The `--fixup=amend:` and `--fixup=reword:` forms cannot be used with
> > +other options to add to the commit log message i.e it is incompatible
> > +with `-m`/`-F`/`-c`/`-C` options.
>
> I suppose it doesn't hurt, but I wonder if it's really necessary to
> document this considering that the user will learn soon enough upon
> trying invalid combinations.
>

Not necessary, but I thought that users must know that `-m` is
otherwise supported with plain `--fixup` and not with the `amend` and
`reword` suboptions. So, I think to reword it and add with the above.

> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > @@ -593,16 +593,17 @@ See also INCOMPATIBLE OPTIONS below.
> >  --autosquash::
> >  --no-autosquash::
> > +       When the commit log message begins with "squash! ..." (or "fixup! ..."
> > +       or "amend! ..."), and there is already a commit in the todo list that
>
> Should this also be mentioning `reword!`?

No, as both `amend` and `reword` suboptions create "amend!" commit
only. I think it seems a bit confusing but I will try another attempt
to reword the document.

>
> > +       matches the same `...`, automatically modify the todo list of
> > +       `rebase -i`, so that the commit marked for squashing comes right after
> > +       the commit to be modified, and change the action of the moved commit
> > +       from `pick` to `squash` (or `fixup` or `fixup -C`) respectively. A commit
>
> It's becoming difficult to know which of the "foo!" prefixes get
> transformed into which sequencer command since there is no longer a
> one-to-one correspondence between "foo!" prefixes and sequencer
> commands as there was when only "squash!" and "fixup!" existed. The
> reader should be told what sequencer command(s) "amend!" and "reword!"
> become.
>

Okay, I will change it and explain it in more detail.

> > +       matches the `...` if the commit subject matches, or if the `...` refers
> > +       to the commit's hash. As a fall-back, partial matches of the commit
> > +       subject work, too. The recommended way to create fixup/squash/amend
> > +       commits is by using the `--fixup=[amend|reword]`/`--squash` options of
> > +       linkgit:git-commit[1].
>
> At this point, it may be beneficial to write these out long-form to
> make it easier on the reader; something along the lines of:
>
>     ... the `--fixup`, `--fixup:amend:`, `--fixup:reword:`, and
>     `--squash` options of ...

Agree, I will fix it.


Thanks for all the detailed reviews and suggestions. I will update all
the changes in the next revision.

Thanks and Regards,
Charvi
