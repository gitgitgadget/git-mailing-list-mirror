Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBD8C07E95
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 03:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278E861CD8
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 03:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhGHDP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 23:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhGHDPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 23:15:25 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA755C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 20:12:43 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t3so6133789oic.5
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 20:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4oVR/6uvWeMzEwz5ti7bthkAf010XCPiplkmOlfK+SI=;
        b=TGbvkndtQj3C9bX6y3oPF45E0jbCbRvYFdynkw5WpTT/9s9VIy4a0PidDLftGhbM/H
         JskWVDQSrmYkNymoWtQ7kQ+1k33caPOzxF7e3i/7dZTC+s+bj4dQLV761cjpgH/EYWKg
         gUNAqlNBLDw21Pvk/7cWHdzBU2Xx7pm+MMRRcNnTFSG5Fjrf/LzNo6A+FSVxTZH9hQXr
         R+lJf54oH9b/i9gehohoImO/8Rp+DmUuqljhGGW6Fy+rZopjPRJbWOxQ169ewphqYY1q
         BAPdz5k57xNF2E1jiqwU2AaSXb3ONxi0DzMq58pOBzY0dkuA40g753xf5A3UXGuYTBR3
         EQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4oVR/6uvWeMzEwz5ti7bthkAf010XCPiplkmOlfK+SI=;
        b=s3CEZX4Aw32isBQRllyqYgc/3jRnAq6/OKLFkKZX+FZ23WMX0NLuUtRxFe9mRogscV
         7/8pztoJLgYBa8uvfk56TxRQqaJjo44j7RKmk+18yoz7wGiiPcxbLfkl4CIjOt3Jg5UH
         cRLmVfeAOdqm3FAKltdgyxNoN0b40osBKdCqezwp6Ye5xxA5XvP6hajL+AuUfoLziCsX
         //v/Dsh3hbN4Xsrlurq4em52v9wHNyaABYT3rljyllE3m8cuHN2k0GO/FReLhhw2ZCiI
         mo0LWWeCWs9l2WzCdCI/cxwXaJW+++uMLTXDBx2kHHkGqtUbx9X4XSwbIzHA1aBjQO0s
         Wajw==
X-Gm-Message-State: AOAM532/lmod9mjC0X21/syw/iv2yyo3uakgA6HBxHBIko9kMSDkbEOF
        h1qtAHS6nNDMjKnD7qCl0Us=
X-Google-Smtp-Source: ABdhPJxQMyNWZO7ZLUENe96rV9orHRycNNtl3NfBrR7GV4CFYhjWAI88M/mlLac0I1EejvcyqSJMxA==
X-Received: by 2002:a54:4797:: with SMTP id o23mr10975066oic.158.1625713963158;
        Wed, 07 Jul 2021 20:12:43 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id q13sm179525oov.6.2021.07.07.20.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 20:12:42 -0700 (PDT)
Date:   Wed, 07 Jul 2021 22:12:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Message-ID: <60e66d28c0cb3_306ac120813@natae.notmuch>
In-Reply-To: <877di13hhe.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
Subject: Re: What actually is a branch?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Since this is not strictly related to the topic of `git switch` I
> > renamed the thread.
> >
> > Sergey Organov wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> > Sergey Organov wrote:
> >
> >> >> Overall, if we aim at clear documentation, we need to define our
> >> >> documentation terms as precise as possible, and then use them
> >> >> consistently.
> >> >> 
> >> >> For example:
> >> >> 
> >> >> "branch": a chain of commits
> >> >> 
> >> >> "branch tip": the most recent commit in a branch
> >> >> 
> >> >> "branch name": specific type of symbolic reference pointing to a
> >> >> branch tip
> >> >
> >> > Completely agree on all three (although I would call it "branch head",
> >> > not "branch tip").
> >> 
> >> I see why "branch head", as you later introduce "branch tail", but a
> >> branch (of a plant) has no "head" (nor "tail"), right? BTW, how the base
> >> of a plant branch is called in English, and how one finds "branch tail"
> >> on a real tree anyway? I mean, there are probably a few of them, at
> >> every fork. In Git it's even more vague, as a branch could logically
> >> begin at any place, not necessarily at a fork point.
> >
> > We don't necessarily need a 1-to-1 mapping with common English (although
> > that would be nice). Anoher option could be "base" and "tip".
> >
> >> OTOH, "head" and "tail" are obviously taken from CS "list" concept, and,
> >> provided "chain" == "list", it does make sense.
> >
> > I took it from Mercurial, where the tip of a branch is called "head",
> > and in fact a branch can have multiple heads.
> >
> >> And then we have 'HEAD' that points to the current branch tip anyway.
> >
> > It actually points to a branch, or rather references a branch, since it
> > uses the branch name.
> 
> Yes, but it still points to the branch tip, indirectly, or even
> directly, when in "detached head" state, that, by the way, I'd vote to
> abandon, replacing it with more user-friendly "unnamed branch" or
> something like that.

Yes, but most of the time it's indirectly.

> >> Dunno, in fact I don't have any preference among "tip" and "head".
> >
> > I don't either, but from different sources (non-git-specific) I've heard
> > "head" more often.
> >
> >> As for branch tail, I do have convention of marking start of a
> >> long-standing branch with corresponding tag, where branch "foo" has
> >> corresponding "foo-bp" tag marking its "branch point". Recently I
> >> started to mark start of feature branch with yet another branch "foo-bp"
> >> rather than tag, "foo" being set to track "foo-bp", that allows to
> >> automate rebasing of "foo" against correct base.
> >
> > So foo-bp is the upstream of foo, and you do basically:
> >
> >   git rebase foo@{upstream}
> 
> Yep, but essential feature to me is that I in fact use tools that simply
> run bare
> 
>    git rebase
> 
> and that "just works" (tm).

I typed the revision explicitly, but `git rebase` would work just fine.

> > This is works if your base (or tail, or whatever) is static, but many
> > branches jump around, and that's where @{tail} comes in handy.
> 
> Yeah, I see. When I need to make a branch jump around, I do need to
> manually move my references, but that's fortunately very rare use-case
> for me. Having direct support for that is still a win.
> 
> >
> > You can do this:
> >
> >   git rebase --onto foo@{upstream} foo@{tail}
> >
> > This will always rebase the right commits (no need to look into the
> > reflog). So you can say that the branch is foo@{tail}..foo.
> 
> I see where and when it's useful, but for a feature branch 99% of times
> I don't want to rebase it onto some true upstream. I rather want to just
> fiddle with the branch in place, and I prefer to setup things the way
> that ensures that bare "git rebase" does "the right thing".

But that's precisely the point: when you do `git rebase` you don't have
to type the base or --onto anymore. It's done automatically.

Not just for your long-standing branches, but for *any* branch.

> Probably that could be solved by a branch-local configuration that makes
> "git rebase" become "git rebase @{tail}" for the branch instead of "git
> rebase @{upstream}"

No. @{upstream} is where you want to rebase *to*, @{tail} is where you
want to rebase *from*.

When you do:

  git rebase foo@{upstream}

This is basically the same as:

  git checkout foo@{upstream}^0
  git cherry-pick --right-only foo@{upstream}...foo

git is smart enough to figure out what commits are already part of
foo@{upstream}, and those are skipped, but at no point was any "base"
calculated (at least not from `git rebase`).

Most of the time `git rebase` works fine, because there aren't too many
commits to figure out where they should go, but it's definitely not
efficient, and there's many corner-cases (see a Linux kernel maintaner
baffled by what the hell `git rebase` is doing [1]).

> > Another advantage of having this notion is that `git rebase`
> > automatically updates the tail (in this case to foo@{upstream}).
> 
> Yep, looks useful. Is it all local to given repo, or else?

I implented it as 'refs/tails' (as opposed to 'refs/heads'), so it's
local to a given repo, but could easily be exported.

[1] https://lore.kernel.org/git/60b272ff6bfa4_265861208d6@natae.notmuch/

-- 
Felipe Contreras
