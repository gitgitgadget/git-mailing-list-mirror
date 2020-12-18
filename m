Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE06CC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF8723BA8
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgLRWRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 17:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgLRWRr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 17:17:47 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8624C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:17:06 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u18so9215374lfd.9
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gVF4M0D4xdiHUNYGEqSkEgeOqSzRn51/uSqXVMnEhco=;
        b=DtALrtNVgfnOytFIH72GNH1uB2qlvDocPqFyTuDhe8gLn/jmjAKUZ+vFA6fyLz1iQI
         M7lAERpK2uSnRZy4rTTbMOdivytuu6vfSzcTD1BdHS7fF0H0tm6M6K6KcSPez4deRaQt
         rjdIrQ2r0qmv3gA+pPVZUYOs0H9CP1nsVYWLQ/8xawGjSI+ZKEaSqF1dyVbmf6B39CFO
         X5uiM6B/FiUZP6alqpbKla1cB6aIibZJ5DEKCnbYtD7DqFIHabKFT35sQC7gfjnTaKgA
         QZ9cUBF9Rw1eJv0Gfw1RQwEKgXKS8pmAHCrtPXuJeNk+VPdFmcjZuUI3BIV807w9vJ5M
         tAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=gVF4M0D4xdiHUNYGEqSkEgeOqSzRn51/uSqXVMnEhco=;
        b=kd3mwcXxNzkJHZRj9lldJsRYwXUV/IKCWugLJ5IB3odP9n00gldIGbpbj5zJAVz5mh
         rSgBWjxelbRrgNYDbTUOyEaiSyBbApw0pKw2ZhjZUMlA/cIKt1siLpkSiZ3oDf93R3UV
         LdVVeFe4oZ0U4tmhtu3o8cnavT5PW4xCPtRCH+Xa2bVwDZlZnCp4Sojh/mx0M7LFO9iZ
         GICBYXszXaJXkm/hQvnAxk8Uohu0DjF5BNx04uuIMY8QQ2cQCx47EZplhZG5kAfSISEy
         fEigPQ9VZAOoqMy6sG82ucvKR+hJCq882vWxyJpe6Zp2uq8QZArwUtgKjoavcXqDSPEv
         Th+g==
X-Gm-Message-State: AOAM532saI+fvhZzpORlH/fZUeAzkTwXs+2Xo8NKEl0V0Fmklnw4REbl
        y1FvQgzqaNO/BzHARoX0/gEZMu60N7U=
X-Google-Smtp-Source: ABdhPJwpNtqRz7sXUy629Lw19mAtOPxyZ2hkM0qGWDdjlc27qguVncFsAAqzL1WMS3CY9i8i6UI9fg==
X-Received: by 2002:ac2:4209:: with SMTP id y9mr2353934lfh.431.1608329824999;
        Fri, 18 Dec 2020 14:17:04 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v5sm1197535ljj.135.2020.12.18.14.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 14:17:04 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 24/33] diff-merges: handle imply -p on -c/--cc logic
 for log.c
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-25-sorganov@gmail.com>
        <CABPp-BHh4VSTQ=VOzik5H34OcJaQ63wSgPgrZqJ5-_XvBSow+g@mail.gmail.com>
        <875z4zciwd.fsf@osv.gnss.ru>
        <CABPp-BGg9oBkG3ZaWztKMnQE4sREOK_L3so5fer5hbiAKxMaHg@mail.gmail.com>
        <87tusi7pq4.fsf@osv.gnss.ru>
        <CABPp-BG-Nv=pzwTO3J0OK20gFVV67_qFL+m-cL7d9xrMvTjH-Q@mail.gmail.com>
Date:   Sat, 19 Dec 2020 01:17:03 +0300
In-Reply-To: <CABPp-BG-Nv=pzwTO3J0OK20gFVV67_qFL+m-cL7d9xrMvTjH-Q@mail.gmail.com>
        (Elijah Newren's message of "Fri, 18 Dec 2020 14:12:46 -0800")
Message-ID: <87k0te7o9s.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 18, 2020 at 1:45 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Fri, Dec 18, 2020 at 6:01 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> Elijah Newren <newren@gmail.com> writes:
>> >>
>> >> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov
>> >> > <sorganov@gmail.com> wrote:
>> >> >>
>> >> >> Move logic that handles implying -p on -c/--cc from
>> >> >> log_setup_revisions_tweak() to diff_merges_setup_revs(), where it
>> >> >> belongs.
>> >> >
>> >> > A very minor point, but I'd probably drop the "where it belongs";
>> >> > while I think the new place makes sense for it, it reads to me like
>> >> > you're either relying on a consensus to move it or implying there was
>> >> > a mistake to not put it here previously, neither of which makes sense.
>> >>
>> >> Well, it was meant to be an excuse for not moving it there earlier in
>> >> the patch series indeed. I just overlooked this piece of code that
>> >> logically belongs to the diff-merges module. I think you need to
>> >> consider the state of the sources right before this patch to see the
>> >> point of phrasing it like this.
>> >>
>> >> That said, I'm fine removing this either.
>> >
>> > If it should have been moved there earlier, then you should amend the
>> > relevant previous commit instead of making a new one.  rebase -i is
>> > your friend and should be used, especially with long patch series.
>> > :-)
>>
>> This is to be a separate commit anyway. I can move the commit itself
>> more closer to the beginning, but I don't see how it'd make things
>> any better.
>>
>> By "earlier" above I mostly meant that I should have noticed and moved
>> it in the first issue or the patch series.
>
> Even if keeping the commit as-is, moving it earlier would have one benefit...
>
>> >
>> >> > Much more importantly, this patch doesn't do what you said in
>> >> > discussions on the previous round.  It'd be helpful if the commit
>> >> > message called out that you are just moving the logic for now and that
>> >> > a subsequent patch will tweak the logic to only trigger this for
>> >> > -c/--cc and not for --diff-merges=.* flags.
>> >>
>> >> I believe this patch is useful by itself, even without any future
>> >> improvements (that we actually discussed), if any, so I don't see the
>> >> point in describing what this patch doesn't do.
>> >>
>> >> OTOH, the commit message seems to be clear enough to expect this patch
>> >> to be pure refactoring, without any functional changes, no?
>> >
>> > I'm just pointing out that reading the patch triggers a "wait, you
>> > said you wanted to enable diffs for merges without diffs for regular
>> > commits" reaction and makes reviewers start diving into the code to
>> > check if they missed where that happened.  Sometimes they'll even
>> > respond to the commit asking about it...and then read a later patch
>> > and find the answer.  Perhaps I'm more attuned to this, because I've
>> > done this to reviewers a number of times and they have asked me to add
>> > a note in the earlier commit message to make it easier for other
>> > reviewers to follow and read the series.  You don't need to describe
>> > in full detail the subsequent changes that will come, just highlight
>> > that they are coming to give reviewers an aid.  For example, this
>> > could be as simple as:
>> >
>> > """
>> > Move logic that handles implying -p on -c/--cc from
>> > log_setup_revisions_tweak() to diff_merges_setup_revs().  A
>> > subsequent commit will tweak this logic further.
>> > """
>>
>> I think I see what you mean, but I still don't like this, sorry, as:
>>
>> First, this commit doesn't tweak the logic at all, so "further" doesn't
>> sound right.
>
> Good point, I should have left off "further".
>
>> Second, the purpose of this move is not to have subsequent commits that
>> will tweak this logic further in any particular way. One of the aims of
>> this commit is rather to make it more simple to have /any/ further
>> tweaks to the logic.
>>
>> Third, if the "tweak" you mention is not accepted, I'd need not to only
>> get rid of the tweaking commit, but not to forget to edit the
>> description of this one, that is basically unrelated?
>
> ...so, one advantage of moving this commit earlier in the series is
> that if it appears before the introduction of --diff-merges, then it
> doesn't trigger the "What?  I thought we weren't making the
> diff-merges flags trigger patches for non-merge commits" reaction, and
> thus makes it clearer that the patch is just pure refactoring.
>
>> >
>> > (Note that 'git log --grep=subsequent' in git.git will find you
>> > several examples of where people have done this kind of thing.)
>>
>> Yeah, I agree it's useful when commits are tightly coupled and thus the
>> purpose of single commit is unclear. I just don't think this one is such
>> a case.
>
> I think where it appears in the series makes its purpose unclear.

Fine, I'll move it earlier in the series then.

Thanks,
-- Sergey
