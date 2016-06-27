Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6A72018A
	for <e@80x24.org>; Mon, 27 Jun 2016 19:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbcF0Tne (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 15:43:34 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34755 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcF0Tne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 15:43:34 -0400
Received: by mail-io0-f180.google.com with SMTP id g13so154195967ioj.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 12:43:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a8kVohw+L3MCMMw31Sn2CxuYoolO67QlI4D+LBpiSKk=;
        b=IRqqzzGSKWTnQ0bPibENcpW5xdC+f7tYXXe56YEJykuNrzmk0EF0r+OsWm6BTpcVjC
         Htj2LK2F2fVuASHBFxU5NeDYWR1KLKXGlwAPO3PE6OIVlGOmdxZnswwiHZVsJXqHT9AM
         dY6MsI+h6OKT7fnf1r0pHql8LGm3EI1Bjy44ItjFs1c7MpglLgj02iSDRvyp2U7o4lov
         PxVGPtPLnqLZOIVg/hdEiuMPkdQul20o6ESgOahcpcoQDzK/BIlWlh4uvkKuOpKYDwTb
         dGk5LgczM3bP8BK8+2llsMtntQ19YYFDszmBX4spjI20ahD9V71TpIrr+rxfl6oyqv5O
         WifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a8kVohw+L3MCMMw31Sn2CxuYoolO67QlI4D+LBpiSKk=;
        b=IT2cN9x6RBWBC6I8R/X7fSE9sULe3/iPrkplN2x9u7Ly5QZ6BvtYou6kDO/Hyy7ndP
         55wDBXsTssBqE8bJKufKkku8zOXmBFReg0k32ZTb6KDWqh0EkK9Iq0skmyhEHBoUeso5
         XudtRzg5RFT9+4qE7nf4xr13a5eJV0rJE8MaTXPykgBkBLzGOrAFrRoNKQ+aFp5gn8W0
         b5I86aox6/LTJ9tXWsMqtGQld8m66GOjINxgp+bRWPRprUmCBNBDAvW164RniDbTFozR
         M3SPTo+fqlY2A4yJmsE4MzQk+johCRZQX5H9kbKYRFjeY7khtf6g14gt82VcUllFb+uY
         81ZA==
X-Gm-Message-State: ALyK8tIT8ZB60on68un0SEDK/ZA0cqZbCjMLpMK1uu3E5suH0iyInRKsyBYKuG5ULgy/+y7r7bn21l4nAtUdSwEO
X-Received: by 10.107.186.196 with SMTP id k187mr2531243iof.173.1467056612803;
 Mon, 27 Jun 2016 12:43:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Mon, 27 Jun 2016 12:43:32 -0700 (PDT)
In-Reply-To: <20160627191720.GE9594@sigill.intra.peff.net>
References: <20160626232112.721-1-e@80x24.org> <20160626232112.721-2-e@80x24.org>
 <20160626234251.GA21668@sigill.intra.peff.net> <xmqqoa6mdbu3.fsf@gitster.mtv.corp.google.com>
 <20160627143648.GA2618@sigill.intra.peff.net> <CAGZ79kZ94PaOfq3GimWiHULbTE7ihMzL9S=Y+npQ4F5gGwFrsA@mail.gmail.com>
 <20160627191720.GE9594@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 27 Jun 2016 12:43:32 -0700
Message-ID: <CAGZ79kZWfGJG=qHtdpuLvQY5XK5P3L0UW7RJ=9ui=PgX+AjErQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 12:17 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 27, 2016 at 09:49:06AM -0700, Stefan Beller wrote:
>
>> Quite a while ago, when I started doing code reviews professionally, I
>> wondered if the code review procedure can be semi-automated, as
>> automation helps keeping the error rate low. By that I mean having a
>> check list which I can check off each point for each patch. That seems
>> to be very good in theory, but when trying it I was finding myself
>> doing a lot of unneeded work as some points of such a check list just
>> do not apply for a specific patch. So I did not follow through with
>> that.
>
> I have wondered, too, if we could have better tooling to help us with
> reviews. But one of the things I really _like_ about doing reviews for
> git (versus other projects) is that doing review via email is
> unconstrained. The primary recipient is human, and I can format and say
> whatever I like in the way that best communicates to the human, without
> worrying about fitting my comments into a pre-made form.

Maybe I did not mean automation, but rather a more structured approach,
in the review itself. (I just realize this is a slightly different
problem than what
we saw here).

Here we had a case of:

   1) Jeff: "Wait, there is a bug, please fix!"
   2) Stefan: "ok will do."
   3) Stefan doesn't do it,
   4) Jeff doesn't notice or is tired of doing a review.
   5) Junio picks up the buggy version.

There are a few issues:

    1) How did you spot the bug? ("Experience/Logical thinking" is the hand
      wavy answer, but if you had a list like
      [ ] check for mem leak
      [ ] check for futureproof design
      [ ] check for failure modes (What if a syscall fails?")
      [ ] ... List is not complete, but has some made up points

    While "Experience/Logical thinking" is a very good approximation
    I find myself not thinking of all these details all the time, so sometimes
    I would fail at step 1 already.

    2) I used to send out only "done"s, i.e. when I already fixed the
issue, instead
    of acknowledging the problem and postponing the fix for later.
I'll revert to that.

    3) Optimally here I would have a list of all reviewers suggestions and can
    check these one by one if I really addressed all of them and not forgot one.

    4) If the list from 3) was available, it becomes much easier in a
follow up review
    to see how the author did address each issue.

    5) likewise as 4, just with less attention to the detail. (Junio
trusts Jeff that he checked
    that Stefan addressed all issues in Patch v1)

>
> That being said, I suspect one could go a long way by picking out basic
> patterns from emailed responses. For example, you could imagine a system
> that makes a todo list of review comments (one comment per response to a
> quoted section) and associates them with given bits of the code (by
> seeing what's in the quoted section). That todo list can become a
> checklist when sending out the next revision, or could even be used
> interactively to see what happened to each code spot (did you fix it?
> How? In which commit?). That would help reviewers, but also would help
> submitters send out the cover letter for the next version (by reminding
> them what to mention).

I agree that would help with 3 and 4 in the case above.

>
> Of course, none of that would have helped my comment, which was in a
> "PS" several emails deep in a discussion thread. ;)

Maybe a "P.S." would get its own point in the todo list not associated
with code?
Then it would still be on the radar.

Stefan

>
> -Peff
