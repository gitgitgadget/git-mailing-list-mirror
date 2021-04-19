Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5D3C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 20:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BF0613AA
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 20:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhDSUeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 16:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhDSUeC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 16:34:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327DCC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 13:33:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so31637981wrt.5
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dU5/QCrBF31++JwSumi6VhvY3x6nnZhiwDZP3wkjvd4=;
        b=EYHwf8vpHLrP3w4UdJAP9hzkpYeVwVCO+2i3sYoY+1HKE97G3zeytt8JIczpfogVDZ
         J9ItIdChzdQbID2mO1mxXSkxrx8LYvHFfvzHgWOqMwwUeOqswXksl7nityoHTx6Rs/jj
         SHpMwDYqyCx+vNR1mo+LOxmP8XqmRvEm55UYWTAOEgNE3TyLHtqT+lEvLpAQ1wP3ShuS
         MaDtsXtiqoBjsmrvmckVhsySbDuDh6sEL0EpTmvnRajiBO2XRXCxELM8rrAUUn0eXWvF
         PsX0BCzRGtQF4emws27SBlkD1eAKUkglCy9Sy0+zHQ7LSZray70k4xJsBLAJge/FnHfB
         KRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dU5/QCrBF31++JwSumi6VhvY3x6nnZhiwDZP3wkjvd4=;
        b=Z+fP9O7ZtYHkvN31LUAS5xxRKEtDqAyt698g6uX7qEKIWmXB4T0UxL33NYJtaYULPC
         +OP3U1wBMCsmGeifp3A4Hmn3om8v6iAuMYI9aE9CRpUMNKMxSOLBUyPYmUicjFD8N9yU
         Gbj1JwvrpBqHTBCQ0ByoRA2pdOwPsPwBceO2+PKB+O/3KUhsI2Rk+wqdumT3gD8tK/pS
         dI5jkA/75GL8bIhKT/yBD2VK749epZ6TWVxYR/5zR16iWbSFrks/dx0mxpKBsmwohZkm
         4g1REoYi3ZERtwg4JzKcbsLoM4fC+CWp0WtwaoXuuNSWU9dt7kZk1V8/fxy5A3UisoTj
         xQpw==
X-Gm-Message-State: AOAM533LaU5kt0KRhsgqjEg0MhbV7lQwOCZCDha6/DKrqBCrRrs/ZBgc
        Rrecwecp9UkeROgi9n6allk=
X-Google-Smtp-Source: ABdhPJwlhQIdY38bSmL/ShjoQk2NJIRpqJEJxxsIXBjPnvFSE+D6uqHSmNd/W6s5uunSeJU+Hc1q3w==
X-Received: by 2002:a05:6000:178c:: with SMTP id e12mr16629049wrg.42.1618864409980;
        Mon, 19 Apr 2021 13:33:29 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id u17sm739892wmq.30.2021.04.19.13.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 13:33:29 -0700 (PDT)
Date:   Mon, 19 Apr 2021 22:33:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Pain points in PRs [was: Re: RFC: Moving git-gui development to
 GitHub]
Message-ID: <20210419203327.GV2947267@szeder.dev>
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
 <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
 <86k18rbbyz.fsf@gmail.com>
 <CABPp-BG2SkH0GrRYpHLfp2Wey91ThwQoTgf9UmPa9f5Szn+v3Q@mail.gmail.com>
 <CAGr--=LKBq17XSLpe=uJbEPSfCp5Fpi_uw4d87DgJ8-S4Md0kQ@mail.gmail.com>
 <CABPp-BEcpasV4vBTm0uxQ4Vzm88MQAX-ArDG4e9QU8tEoNsZWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEcpasV4vBTm0uxQ4Vzm88MQAX-ArDG4e9QU8tEoNsZWw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 09:13:04AM -0800, Elijah Newren wrote:
> > On Wed, Oct 30, 2019 at 7:21 AM Elijah Newren <newren@gmail.com> wrote:
> > > Projects which switch to GitHub tend to have overall commit quality go
> > > down IMO, because the system (a) makes it nearly impossible to review
> > > commit messages, so people eventually degrade to writing really bad
> > > ones,
> > What do you mean here, exactly? In what way is it "nearly impossible"
> > to review commit messages in GH?
> 
> My lengthy rant wasn't good enough for you?  ;-)  Well, I'll try even
> harder to bore everyone to death, then and extend my rant a bit...

Thank you very much for taking the time and effort to write it up.

It summarized some of my main gripes with PR-based collaboration on
GitHub with such clarity that I would never been able to achive.

(The recent "Pain points in Git's patch flow" thread reminded me that
I saved this message and even marked it as important ages ago... but
haven't gotten around to read it until now.

  https://public-inbox.org/git/YHaIBvl6Mf7ztJB3@google.com/T/
)

> Reviewing is the process of providing feedback on proposed changes.
> Code review tools and mechanisms typically provide ways to (a) see
> proposed changes in isolation and (b) comment on individual lines and
> preserve context (with the goal of later merging a group of commits
> that implement something useful).
> 
> git-format-patch and git-send-email combined with usage of email
> clients that know how to quote previous emails and let you respond
> inline are a natural way of achieving both (a) and (b).
> 
> GUI tools can, of course, also achieve something similar by showing
> proposed changes and allowing commenting on individual lines in
> context.  GitHub fails pretty hard on both counts, particularly for
> commit messages.  It guides people to an overall diff rather than to
> the diffs inside individual commits and completely omits all commit
> messages when you do so.  It does provide a way to access individual
> commits and their diffs, though it makes it somewhat unnatural.  (It
> at least isn't as awful as it used to be in years past, when any
> comments on individual commits were completely lost and separated from
> the PR.)  And even if you do "go against the grain" to comment on
> individual commits, there is no provided mechanism for commenting on
> the commit message itself.  Instead it has to be given as a general
> comment on the overall set of changes, which then loses the context of
> what you are commenting on unless you re-include and quote it
> yourself.  That usually doesn't happen, so when you comment on four
> commit messages in a review, you have four separate global comments
> and someone attempting to respond to them doesn't get to see the
> commit messages next to them, resulting in confusion.  Even if you do
> re-include and quote the commit message bits you are commenting on,
> the resulting comment isn't in any way tied to the commit in question
> in the UI.
> 
> So people who use GitHub for code review just don't bother.   They
> write non-isolated commits and far from rarely use awful commit
> messages.  Then they merge this abomination of history, or possibly
> even worse, they squash merge it all to make it impossible for any
> future readers to be able to dissect.
> 
> Yeah, yeah, small features so that the review is smaller and easier.
> That is important, yes, but it still conflates two things and thus
> ruins reviews.  Each PR should implement something useful.  Commits
> should be designed both for current and future reviewers to see a
> clear path towards how that useful thing was implemented.  Sometimes
> one commit is enough, but conflating the two necessarily either means
> sometimes creating one-commit PRs that don't actually implement
> anything useful, or a cognitive overload for code reviewers.  GitHub
> simultaneously encourages bad behavior (bad commit messages since they
> are designed to not be reviewable, non-isolated commits, fixup commits
> that are never properly squashed, etc.) and penalizes good behavior
> (folks who try to clean up their sequence of commits are met with
> problems ranging from GitHub screwing up the topological ordering of a
> linear commit history, to poor ability to see incremental changes
> whenever rebasing happens, to reckless squash merging of all their
> careful work into a single commit as something close to an act of war
> against any future readers who want to dig into why certain changes
> were made).  Yes, GitHub has gotten much better at code reviews; it's
> merely abysmally awful these days as opposed to a complete joke as it
> was in years past.  But it's still so bad that I have seen people try
> to solve this by having a sequence of PRs per (small) feature they
> want to implement, even though GitHub provides no way to denote
> dependencies or ordering between PRs.
> 
> You may think I've gone off on a bunch of tangents, but fundamentally
> I believe that almost all of these other problems predominantly arise
> as secondary and tertiary effects of not understanding that commit
> messages should be a first class citizen of code review.
> 
> Sure, you can claim all you want that it is entirely possible to
> review commit messages within the GitHub UI and it's just extremely
> inconvenient, yadda, yadda, but the truth of the matter is that people
> everywhere struggle to even do code reviews at all, and when they do
> they all too often turn into rubberstamp exercises or don't delve
> deeply enough.  In that context, I believe my "nearly impossible"
> wording is entirely warranted.  Using a tool that simultaneously
> encourages bad behavior and penalizes good behavior will not so
> surprisingly yield bad behavior.  GitHub PRs are such a tool, IMO.
> 
> (To be fair, I'll note that GitHub has awesome code browsing, really
> easy setup and administration of new repositories and organizations,
> simple and reasonable and thus pretty nice code search, etc., etc.
> I'm not saying GitHub is a bad tool, I actually think most of it is a
> very excellent tool; I am just claiming that the PR section of it is
> very bad.)
> 
> 
> Elijah
