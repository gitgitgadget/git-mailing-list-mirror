Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEBDC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 18:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27BA61CC9
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 18:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhGGSgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhGGSgo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 14:36:44 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F93C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 11:34:02 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id x22-20020a9d6d960000b0290474a76f8bd4so3190436otp.5
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 11:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=m3KzKMWlyObGg6oowbicc0dQODvS1hcs82v5fJ0ORhs=;
        b=PzBd22yxwWo6t+IFgCLN+TmpfJvSh+mfixh0ZXpsZ9TqrjXUm9fK4cX0WmiVAfUftR
         ciUPrDfL+4UX3b2DwSYO2c7XVBvJjfZaTyXeu8gOnJXB5BuaYZQzzActkJDP9UUiu9/1
         bq9Ni1UeSbIrIw08nk7iumxPGn4dHp9UFY4FZigJbAOGf24mtHln6H3kE0L9baith/kX
         Y3hC8oAenvvdOV4lxbvsWeigrF71uBIw6oD3PJPtqcKmVT8/PFBwROEeYT+FPiqGHCIV
         WIIYJRCgxtiHj5N9b1Gp/O8eC6f0sUPkuw/b5uOQ0dzcFwg5vSynYCHsBNlSMhQewETn
         Nr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=m3KzKMWlyObGg6oowbicc0dQODvS1hcs82v5fJ0ORhs=;
        b=Ob/D/R3IoSWnCHw2H9ENHSjz0zEoHzpOd9kqo1vTFJ5WeAw03dNlsCy3b0X7PBN+sX
         2I5/4ROVGheC8tqHg2GgEdCa/aJHb5YkQVRHD07nfVU6oUfranyQNGlNEEHzFwkjArN1
         pQuhu3hde7QANe20SwOALoHXiHrRTKLuB/yvSMDrDVMrPu+sEMCvdQEkNmX8Kngdfhl/
         2F5/Nz8SQt2Xpk7JYzwt8l9/E3Yy+Oos339N0RW+ajT3rlOdA3EFCXTJ+ARg+UL9wDP8
         q/OAfawSfZVIB9zsvYBlccYTqAfSkh6UgKc/ildgPEoK0zoQfKAQdAw4visb0urxy1iZ
         SpSw==
X-Gm-Message-State: AOAM533Z8hDsrbwJ5SrnK6pe0LCGD/xYT6mFHxBwIcya0RzSm0jT5T/f
        J+zVzrdjW+cDJ61Csnk1jzk=
X-Google-Smtp-Source: ABdhPJwT24mj/J6K8VZJoy2ppztHk1NVZR7kvtsn5NQUyv09p7GEnrIGDme4NLvduPr2ZPiya9FarA==
X-Received: by 2002:a9d:6c86:: with SMTP id c6mr10495211otr.256.1625682841880;
        Wed, 07 Jul 2021 11:34:01 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id t10sm2668926oor.48.2021.07.07.11.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:34:01 -0700 (PDT)
Date:   Wed, 07 Jul 2021 13:34:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>, Martin <git@mfriebe.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e5f3981de5f_301437208bc@natae.notmuch>
In-Reply-To: <87wnqaclz8.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Martin <git@mfriebe.de> writes:
> > On 01/07/2021 00:59, Junio C Hamano wrote:
> >> Martin <git@mfriebe.de> writes:
> >>
> >>> And yes, for the documentation, it *should* be clear that, removing=
 a
> >>> branch, removes the
> >>> commits on it.
> >>> But then it must be said, that the branch is first removed. That is=

> >>> not currently the case.
> >> Sorry, but I still do not see how it makes any difference if the
> >> branch is first removed and then made to point at somewhere else, or=

> >> the branch gets just moved without any explicit or impolicit
> >> removal.  A branch cannot point at two different commits at the same=

> >> time, so the end result is that the commit at the old tip is no
> >> longer pointed at by the branch after the update.
> >
> > Well all very obvious, if you know git well.
> >
> > Let's take a step back. How exactly is the word "branch" actually def=
ined? Well it does not matter.
> > What matters is, how the word is used.
> > What does a person mean, when they speak of the branch?
> >
> > And the answer is, it's not always clear.
> =

> Yep. The "branch" may mean a "chain of commits" or a "symbolic referenc=
e
> to the tip of the branch", or even both, depending on the context.
> =

> It's somewhat similar to "file" vs "file name" in UNIX. You in fact
> don't remove files in UNIX, you remove file names that refer to files
> (entities on disk), yet "remove file" and "rename file" are often
> used, even though they are not technically correct.

It's not even specific to computers, it's semantics of identifiers.

You can say John is not a person, "John" is the *name* of a person, the
person is constituted by cells and so on.

Most of the time it's not particularly useful to think on those terms,
but sometimes it useful in the sense that we can confidently say
"master" is not a branch, is the name of a branch.

In Mercurial branches are more like commit labels, so it's easy to see
the difference between a branch (a collection of commits), and a branch
name. In Git it's trickier because the branch is a pointer, and it
doesn't make much sense to think of a pointer without a name, but
strickly speaking they are different.

> > But true, my attempt on adding "the old branch is removed" does not e=
ither.
> > So not sure which wording will do best.
> > Probably
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Creates a new empty branch at <=
start point>"
> >
> > Even though "empty" may be a sloppy usage too....
> >
> =

> Yes, it's sloppy. There are no empty branches from Git point of view, s=
o
> this is not an option for proper documentation. Any branch has at least=

> one commit, the one the branch name is pointing at. It's entirely user
> interpretation how many of the commits from the chain the Git branch ha=
s
> they consider their branch "contains".
> =

> Overall, if we aim at clear documentation, we need to define our
> documentation terms as precise as possible, and then use them
> consistently.
> =

> For example:
> =

> "branch": a chain of commits
> =

> "branch tip": the most recent commit in a branch
> =

> "branch name": specific type of symbolic reference pointing to a branch=
 tip

Completely agree on all three (although I would call it "branch head",
not "branch tip").

Sometimes we can use a shortcut and say "master" is a branch, as we do
in everyday language when we say "John" is a person, but when we are
strict we have to remember what's behind that shortcut.


Slightly related although a little bit off-topic is the fact the *only*
thing Mercurial can do that Git can't is to find the branching point of
a branch [1] (I have really tried, it's truly not possible).

The *only* way it would be possible is by introducing a new concept:
"branch tail". I did implement patches for that (you could reference to
it with master@{tail}).

It is related to this topic because if we had a branch head, and a
branch tail, then you could not automatically assume the branch is the
branch head.

So even though most of the documentation currently conflates the two
concept, that doesn't mean the user does as well.

[1] https://stackoverflow.com/questions/1527234/finding-a-branch-point-wi=
th-git

-- =

Felipe Contreras=
