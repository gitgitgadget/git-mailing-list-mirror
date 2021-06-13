Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4AC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 17:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C619661279
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 17:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhFMRMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 13:12:41 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:46680 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhFMRMk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 13:12:40 -0400
Received: by mail-oi1-f178.google.com with SMTP id c13so11850387oib.13
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=gca2qqFQtaOY84cRcp97V4uJxvYATfbl84K2nh8dMY8=;
        b=ba7DBqilrIStD0+HtlXBJpluEZDFpVRkY/oTCj7sXygUxRq5JmJ6RN51q4N8HRNM5T
         j9ZS0lO4E5K5gACObcK02vkX1led3+/P1nyjmrDsIGsCQaRXcnuVUPnBcfD3r2uMKbvx
         lVcuz8nR4mrmeyt7gkCqvK/4Fczprt4Wk1eEUPw5JzWq5fi4TWj6kHa/11e4DCpUec9j
         VUStToz1NPwuFax7ikEFd0FQrgQCc6zXGBd+5ZIE8UKLqWzUJQZ3uX6m7PBG5Rs2YPRK
         wCIxcXbpgSSDC46jfDn2xPT09KMUFYn1soiitS7N6y8r7RcDdnP2xleC9I3lhgfH6/zW
         JDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=gca2qqFQtaOY84cRcp97V4uJxvYATfbl84K2nh8dMY8=;
        b=pLPkNXXxadnwqLzpBLTLWDjUDt6QLlRO73fnyDQGsDosU8bCpcI3skNItB5iDvX52p
         fJF2cxI0g4epgO850EZ4OyaHY4gw3X6Y1S0bh9PBtuRMkIOUEhHFPIF1swhI6H11pWL+
         XqKDpauwB0u6UB2aiby7TUwVnXRmsIbimoJ93hoaDI/FF/U34VvH47BlLfGu+5l4GHLF
         097Huv0RAXFX9cv6s5HpZlJ3U6W2VD/PZbltY5xsQIYWnU3S+mbeE3XgrpwyBNXy43bU
         dk7UH6pIIr6poE+JiqFSuDe67nh/Ac+PJXp0oAZXSwrvy99qzycQ52wrXfpTKkdvcfN9
         HArQ==
X-Gm-Message-State: AOAM5328jqJHjh2lC1/l5Ct77VQIKMoVyyZrw07MqZItNJl4WAVbu3+l
        GJR08ecgdiX2Bvq1vX5B3xo=
X-Google-Smtp-Source: ABdhPJyvQbgR9SIdwqXXKZZMESnWPnYEBOQyHMbugksP+nW2y9roVvYSu6bAObH2F0gb5/sfOkksuQ==
X-Received: by 2002:aca:fc91:: with SMTP id a139mr3747202oii.12.1623604165045;
        Sun, 13 Jun 2021 10:09:25 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x7sm2614985ooc.23.2021.06.13.10.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 10:09:24 -0700 (PDT)
Date:   Sun, 13 Jun 2021 12:09:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60c63bc3f616_41f452086b@natae.notmuch>
In-Reply-To: <CABPp-BE4r=Nhw2sJS++7Eh1K5rpyWgg+f8vDTf92JBayt1B_cA@mail.gmail.com>
References: <20210613004434.10278-1-felipe.contreras@gmail.com>
 <CAPig+cSE2h7A52drhELfZJLDEgQ1z+nEXoXhYMUSA00Z+S=OUA@mail.gmail.com>
 <60c588d452750_3d86c2085c@natae.notmuch>
 <CABPp-BE4r=Nhw2sJS++7Eh1K5rpyWgg+f8vDTf92JBayt1B_cA@mail.gmail.com>
Subject: Re: [PATCH] doc: revisions: improve single range explanation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Sat, Jun 12, 2021 at 9:25 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Eric Sunshine wrote:
> > > On Sat, Jun 12, 2021 at 8:44 PM Felipe Contreras
> > > <felipe.contreras@gmail.com> wrote:
> > > > The original explanation didn't seem clear enough to some people.
> > > >
> > > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > > ---
> > > > diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> > > > @@ -299,22 +299,22 @@ empty range that is both reachable and unreachable from HEAD.
> > > > +For example, if you have a linear history like this:
> > > >
> > > > +    ---A---B---C---D---E---F
> > > >
> > > > +Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
> > > > +commits, but doing A..F B..E will not retrieve two revision ranges
> > > > +totalling 8 commits. Instead the starting point A gets overriden by B,
> > > > +and the ending point of E by F, effectively becoming B..F, a single
> > > > +revision range.
> > >
> > > s/overriden/overridden/
> > >
> > > For what it's worth, as a person who is far from expert at revision
> > > ranges, I had to read this revised text five or six times and think
> > > about it quite a bit to understand what it is saying,
> >
> > Can you explain why?
> 
> I tend to agree with Eric.  I think the example you chose is likely to
> be misinterpreted and your wording magnifies it.  A..F B..E simplifies
> to B..F which is *almost* the union of A..F and B..E, it's only
> missing A.  Off-by-one errors are easy to miss.

Yes, but right before it's explained that the ending point is F.
Not E, F.

> You make it more likely that they'll miss it, because there are only 6
> commits total in the union, and you are trying to explain why listing
> A..F B..E while not be 8 commits, which readers can easily respond
> with, "Well, of course it's not 8 commits.  There's only 6.

If the reader understands that no more than 6 commits can be returned,
then the reader has understood the point that the operation is not
addition.

> When you do the union operation, of course the duplicates go away",
> and miss the actual point that A got excluded.

But that is not the point. This is the point:

  Unless otherwise noted, all git commands that operate on a set of
  commits work on a single revision range.

You are missing the forest for the trees.

In the context of gitrevisions(7) the user has just been told that:

  1. We are trying to specify a graph of commits reachable from a
     commit, or commits.

The user was shown this graph:

  G   H   I   J
   \ /     \ /
    D   E   F
     \  |  / \
      \ | /   |
       \|/    |
        B     C
         \   /
          \ /
           A

And that B is A^, therefore doing `git log A B` is redundant, as is
doing `git log A B D`.

  2. The caret notation `^r1 r2` means commits reachable from r2, but
     exclude commits reachable from r1 (r1 and it's ancestors)

That means '^D A' will exclude D G and H.

  3. The two-dot range notation `r1..r2` is the same as `^r1 r2`


Now, whith this context in mind, we are trying to hedge the corner-case
of `r1..r2 r3..r4` in other words: `^r1 r2 ^r3 r4`.

The user has been told already that C..A is the same as `^C A` (I'm
changing the order to be consistent with the graph above). And to make
my point clear I actually don't need two starting points.

So how about this:

  Commands that are specifically designed to take two distinct ranges
  (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but
  they are exceptions.  Unless otherwise noted, all git commands
  that operate on a set of commits work on a single revision range. Just
  like 'A A' coalesces to 'A', 'B..A C..A' is the same as the
  single revision range '^B ^C A'.

-- 
Felipe Contreras
