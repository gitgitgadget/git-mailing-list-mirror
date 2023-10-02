Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B44E784BD
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbjJBPVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbjJBPVr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:21:47 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E904BD
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:21:44 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-418201cb9e9so69554591cf.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696260103; x=1696864903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXZ7vaBqaEljSKOyFuCfRBA1BkS1Z/JyUDG0dxMRbKo=;
        b=EA0JkLQVnbRbHKvANguNDaH2AENm3tEFOoExazn1BSp1nG3GyKZZV+vMTIgpuHbUes
         GivNAbSE+zD56uk27x8FXefI6SO+lo7vQqOj4gIE/cAPL1sqwSog76ueq4E8c3eqvTfI
         mNJ9cnjdNod7d+h9iotwPlvN6JfhKN+4Ve3EeMauF75qSLP78CVOc8naJLp1uyazDkTv
         I+9nRryULKu7uqBkZ72O5pJafQYCyQTBOWQxhiRPL3rjxtfjL892EALfBSv2xa+3j2im
         OgA52cfageNYnM86I3Hd45Bt3sZPMR3cePXFEXBsKShVPHF3cgGA87Qugl2McBFzi1jG
         RvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260103; x=1696864903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXZ7vaBqaEljSKOyFuCfRBA1BkS1Z/JyUDG0dxMRbKo=;
        b=q88lswmnHMPCe+ZVWH/NrhPiCbAQKksGGCqZzIfMqqlAT2zu4ezZ5gEqvOzEQqE8VU
         oQhEqQUnxE2SBsfHHSYN/DPlvUCSGcfe18S5mgp9Hel7qwvGC104RUyoCQf6T9yTNr5p
         Sigm6N3y+E8YPXUO6eeY84I8F+keRznTyG6TRceAdQZ68VvlyKjzb04UFFZY5Qa9+IOz
         tGEao44cKeH/OMoUbXA7p2DAourAOcSwXmvUJdRkDHNP9gVavax3eATDtNkFAsd4dTSS
         5kt85c3WCLxxF33eetTvCSURzcesIOCUdbGjR/+wjF404d5TqRUJGqPpeF8fb4Sevpcb
         MaQQ==
X-Gm-Message-State: AOJu0YyYbdlz3nkLkvSoJgbczjLLTB5BAdNjanTYQSzdtOntFg3vQOJo
        pnKXIBYAHG4osqXI6K5wgA/1XL0pev1X5ucbcrHIFA==
X-Google-Smtp-Source: AGHT+IHlcuv922Mo32C3nGxkqu2ITpSAhGGpgCkmw5qV/ILxHwQH/DT9NRxuVZF0rJmPEvMvrAhaSQ==
X-Received: by 2002:ac8:578d:0:b0:418:1ea6:5530 with SMTP id v13-20020ac8578d000000b004181ea65530mr14718532qta.40.1696260103205;
        Mon, 02 Oct 2023 08:21:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i6-20020ac813c6000000b0041817637873sm5886946qtj.9.2023.10.02.08.21.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:21:42 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:21:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 9/12] Code churn and cleanups
Message-ID: <ZRrgBVDzllpXcLcD@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: Calvin Wan, Notetaker: Taylor Blau)

* Question: When is refactoring worth the churn? The refactoring may or may not
  contribute to a different goal (e.g. libification). Other factors:
   * Should those refactor series be included with the feature?
   * Should they be split up?
   * Do they make sense as isolated units?
* Some examples: Elijah's cache.h cleanup series, which was obviously good.
  Others of dubious value.
* (Elijah) May have done the cache.h series a year or two earlier, but wasn't
  sure that it was obviously good.
* (Jonathan Tan) First have to define the churn. Two kinds:
   * Having reviewers look at it in the first place, since there are no
     objective user-facing improvements.
   * Causes additional toil in revision history.
* (Jonathan Tan) Let's start with reviewer churn. What constitutes "good" or
  "clean" code is subjective, so authors and reviewers may spend a large amount
  of time debating whether or not the refactoring meets that criteria. Can be
  avoided when the feature is on top in the same series.
   * (Junio) Speaking cynically: the new feature may be taking a subjective
     change or rejection of it hostage.
   * (Calvin) In other words, refactorings are of lower value than features?
   * (Junio) After you implement some features, you may discover opportunities
     for clean-up after the fact.
   * (Jonathan Nieder) In the course of solving a given problem, may come up
     with a lot of different changes that all help. If you generate a long patch
     series, you are over-constraining the maintainer in determining how to slot
     those changes in. Also makes applying to a maintenance branch, rolling back
     particular pieces harder, etc harder.
      * If I make a one-line bug fix and notice "this code was hard to
        understand, here's a refactoring that makes it more obvious", it's often
        more helpful to the project for the one-line bug fix to come first in
        the series and the refactoring to be a followup or later part of the
        series.
   * (Taylor) One thing that helps is motivating a refactoring. Saying "here's
     what this refactoring makes easier".
   * (Martin) What is "refactoring for its own sake"? For example, is removing
     global state something that we want without additional justification?
   * (Emily) Can we split the difference? Can we send cleanup patches with less
     context? With more context? Should we be better about committing to a
     feature and presumptively merging clean-up patches along the way.
   * (Junio) I rarely hear from reviewers the signals that would allow me to do
     this. "I have reviewed this series, and patches 1-4 look ready, I'd be
     happy with those landing and being built on top of".
   * (Emily) Could change our habits to add "LGTMs" part of the way through the
     series.
   * (Jonathan Tan) We often need to add a feature to "sweeten the deal". The
     feature proves that the refactoring is good. Doesn't add to the overall
     value, but makes it cost less to review the refactoring. Perhaps that the
     presence of the feature is proof enough, even if it isn't merged right
     away.
   * (Terry) Sounds like the question is, "what is the value proposition for
     refactoring?" Usually to lower tech debt. Challenge: maybe every
     refactoring should stand on its own?
      * In implementing a feature, I might notice "the object database interface
        is causing problems in this way". Then my cover letter can spell out
        those problems and how the refactoring addresses them.
      * It's hard work to describe why something isn't good, especially in a
        legacy codebase with some tech debt and some old changes missing clear
        commit messages. It's work but I think it's worthwhile. It builds an
        understanding in the community of how that subsystem should function.
   * (Elijah) My series might be an example of that, didn't have a feature
     associated with it. Helped with libification effort, and started with a
     smaller series to illustrate the direction. Guessing that there are certain
     types of refactoring that we already consider to be good.
   * (Jonathan Nieder) Could having a wiki page that lists helpful refactorings
     that would be likely to be accepted on their own?
   * (Jonathan Tan) I'd like to challenge Terry's challenge. It's a laudable
     goal, but a subsequent patch implementing the feature is worth 1,000 words.
   * (Jonathan Nieder) If we want to be doing more refactoring, then we're going
     to have to develop different skills as developers and reviewers. Reviewing
     refactoring is more like reviewing technical writing. Having examples to
     illustrate the idea can help, even if those examples are changes that
     aren't changes we want to make right now to Git.
   * (Terry) Some people are visual learners, some people are auditory learners,
     and so on. Having a change in place on top of a refactoring is worth 1,000
     words. But if you write well, maybe you don't need the latter patch.
   * (Taylor) I think I agree with both these things - I like having the
     documentation and explanation, but I also see Jonathan Tan's point about
     examples being helpful.
   * We should become more comfortable with throwing away work. Suppose I've
     made a refactoring and we decide not to ship the change it was meant to
     support. Is it worth the reviewer's time to take anyway?
      * We need to make the cover letters clearer, make the case for it being
        worth the time.
   * (Calvin) I think I agree with Taylor. To re-describe: our cost is code
     churn and reviewer time. Feature patches show that there is a 100%
     guarantee the preceding changes are worthwhile. There is a discount factor
     when you don't have a feature to illustrate the value. Authors need to be
     more clear when there doesn't exist a feature patch on what the value is.
      * Reviewers can encourage the author to give better examples of how the
        change will pay off.
   * (Glen) Are there things we could do to help newer contributors in this
     regard? Should we have a more opinionated style guide?
      * (Taylor) Separate CodingGuidelines into semantic requirements and more
        subjective "here are kinds of refactorings we like"
   * (Jonathan Nieder) For newer contributors: better/more worked examples of
     how experienced contributors justify their refactoring changes. E.g. "here
     are some series in the past that were harder to review because of the lack
     of this change". If people had examples to emulate, they would be doing it
     more.
   * (Emily) Difficult to synthesize commit messages without examples,
     especially for non-native English speakers, people who aren't great
     writers, etc.
* (Jonathan Tan) The other kind of churn in looking back at history and seeing
  what has happened in the file. One thing I worry about is that there may be
  another feature in the future that forces us to partially or entirely revert
  the refactoring. That reduces the probability of the refactoring being "good"
  in the first place.
* (Terry) Emily's point about inclusivity: that work (writing a persuasive
  essay, emulating examples) is tedious and difficult, it may not be natural to
  everybody. As a project, we should be creating those examples. Reviewers
  should help newer contributors along the way.
