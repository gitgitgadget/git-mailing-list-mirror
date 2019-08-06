Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34BF51F731
	for <e@80x24.org>; Tue,  6 Aug 2019 21:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfHFVQj (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 17:16:39 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42694 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfHFVQj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 17:16:39 -0400
Received: by mail-ua1-f68.google.com with SMTP id a97so34177475uaa.9
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fz6aLFg9PyRbj1WBo9bLdgsecS51WEH4vajthMmeLZc=;
        b=Anm9WNCVwJhxW85RBQ0zC7sW7HwjbuPM8KigrPaRnTebKO5R+5JED0bOi5MzRaYjNp
         IScOWZgwaCtRWzh9Jh/uV3v0eCbak6hPNnZwKRH3QSYRH8wMUtxtTGf5exyiWeZ0OTk4
         TUbdjaXy2zsobboc8pTVgoN+qdIfnEV9zrlbFgQ2d8hiY9zzWhoAIrfOFuDyZkUYHgIS
         WS0byD91IhCGtXb46RxXLqq/1uyqX4e8FO8pBWKwedXKLRviQXR8eHIPip70rupfvsPJ
         TZSDd35Vt8r3LakOTTVQbjor3DvKrSe/Qk+LnFvSNArf/vKbNsVtk8wdudroMtqMLyrD
         cDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fz6aLFg9PyRbj1WBo9bLdgsecS51WEH4vajthMmeLZc=;
        b=m+N461WMPQgc+KfgxdT+SupFdLwVp4kd5pr72Sdk+Fu66TbComZJy39PSR1ebIwsFm
         v6ntICQO9TR5kX8jhMiu4wQ3zGDfQL1WLLKWmvn1KkngMR1j6Aq19gRfRbNcZf0Zrejl
         tlNpwiflewgtYl8r+zuphJrEAZ6MPi+7baJQDBnH559XPPPtcbFNydXCErW4BGcwp04b
         iFY16Xev1gBCXLLEtqdWCR+A3dDJjaw472qoxhXXZpAVf+swYmz6vf7MELB+xjnoVo74
         sXMhNqqwcDj2KcgvOBcD7wiyZ5hEAqYrODPzh+1I7fVlmS9WMwYw/V6KBfzyBBFUN4Dq
         Tlrg==
X-Gm-Message-State: APjAAAUIglzpKjUpReEVuUPAAZAOQ+dssL5QE0cC+QpUHQQT/h/5gyJp
        gv7JZqA+xBdyR5mXwYIK6wIeiNcTtDAoae6smapSUA==
X-Google-Smtp-Source: APXvYqwkeAAGSS6bmOBIXd1P5LeCxEGT01TB2Ruu9Zio+gq4DzZOFqWt6i7fV9XyOR5ttDd8bap1wuVu/oB2Z7hhD/M=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr3826823uaf.95.1565126197562;
 Tue, 06 Aug 2019 14:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190726220928.GG113966@google.com> <20190805223350.27504-1-newren@gmail.com>
 <20190806202829.GB26909@google.com>
In-Reply-To: <20190806202829.GB26909@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 6 Aug 2019 14:16:25 -0700
Message-ID: <CABPp-BFZig73jXKkKNaz=YpT4enB3_ARQ1KTz_ttPYobkY6Bhg@mail.gmail.com>
Subject: Re: [PATCH 1/1] merge-recursive: avoid directory rename detection in
 recursive case
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 6, 2019 at 1:28 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Mon, Aug 05, 2019 at 03:33:50PM -0700, Elijah Newren wrote:
> > Ever since commit 8c8e5bd6eb33 ("merge-recursive: switch directory
> > rename detection default", 2019-04-05), the default handling with
> > directory rename detection was to report a conflict and leave unstaged
> > entries in the index.  However, when creating a virtual merge base in
> > the recursive case, we absolutely need a tree, and the only way a tree
> > can be written is if we have no unstaged entries -- otherwise we hit a
> > BUG().
...
> Thanks for picking this up and sorry I didn't end up sending anything -
> priority shifts on this end. :)

I totally understand.

...
> > +             git checkout C &&
> > +             test_must_fail git -c merge.directoryRenames=conflict merge B &&
> > +             git add b/x &&
> > +             test_tick &&
> > +             git commit -m "C" &&
>
> Then we merge C with B which places B as a mutual ancestor of D as well
> as C.
>
> > +
> > +
> > +             git checkout D &&
> > +             test_must_fail git -c merge.directoryRenames=conflict merge A &&
>
> Now we do the same thing merging A with D, which means that D has
> ancestors B from branching and A from merge, and C has ancestors A from
> branching and B from merge. So D and C have two closest ancestors
> (criss-cross merge).
>
> > +             git add b/x &&
> > +             mkdir a &&
> > +             git mv b/x a/x &&
>
> Now D adds contention over a/x and b/x (which were both mentioned in the
> ancestry too) to induce a conflict... or is this adding a resolution
> which can be decided on automatically? I guess later you are looking to
> make sure no CONFLICT still exists in the output, so you must be
> resolving the conflict here?

Yes, we are resolving the conflict for D by choosing to reject the
directory rename, placing 'x' in a/x instead of b/x.

When merge.directoryRenames=conflict, it'll make only b/x be present
in the working directory and mark it as conflicted (i.e. assume the
directory rename is probably the right resolution, but print a warning
and mark the index as needing to be updated to verify -- this allows
e.g. "git add -u" to do the "right thing").  For commit C, we just did
a "git add b/x" to accept the directory rename.  For commit D, we
wanted to say we didn't want the directory rename which you'd first
guess would be "git mv b/x a/x" BUT: (1) a/x has unstaged entries
which will cause git-mv to fail, and (2) directory a/ didn't exist --
both of these issues had to be corrected before running git-mv.

> > +             test_tick &&
> > +             git commit -m "D"
> > +     )
> > +'
> > +
> > +test_expect_success '13e-check: directory rename detection in recursive case' '
> > +     (
> > +             cd 13e &&
> > +
> > +             git checkout --quiet D^0 &&
> > +
> > +             git -c merge.directoryRenames=conflict merge -s recursive C^0 >out 2>err &&
>
> Now we finally do the recursive merge - C and D have equally likely
> ancestors A and B, and A and B have a rename conflict.
>
> > +
> > +             test_i18ngrep ! CONFLICT out &&
> > +             test_i18ngrep ! BUG: err &&
>
> The BUG is gone. But should it not use i18ngrep? BUG() isn't localized.

Technically, yes, you're right. However, this line's purpose isn't
correctness of the test but documentation for the person reading the
testcase about what it's real original purpose was; my real test was
the "test_must_be_empty err" check I have below it, but I added this
line just to document the intent better.  I kind of like the
"CONFLICT" and "BUG" lines looking similar just so the reader of the
testcase doesn't have to try to reason through why they are different,
although I guess it does present the problem that more careful readers
like yourself might do a double take.

If folks find it more readable to use regular grep instead of
test_i18ngrep, I can change this line as well as the "core dumped"
check immediately below over to regular grep.

> > +             test_i18ngrep ! core.dumped err &&
> > +             test_must_be_empty err &&
> > +
> > +             git ls-files >paths &&
> > +             ! grep a/x paths &&
> Finally, make sure that a/x has been truly disappeared...
>
> > +             grep b/x paths
> ...and b/x is the only x left standing.


Thanks for taking a look.  :-)
