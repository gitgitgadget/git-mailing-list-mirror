Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC18C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 04:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3176023F
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 04:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhFMEG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 00:06:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:53612 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhFMEG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 00:06:58 -0400
Received: (qmail 26787 invoked by uid 109); 13 Jun 2021 04:04:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 13 Jun 2021 04:04:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22965 invoked by uid 111); 13 Jun 2021 04:04:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 13 Jun 2021 00:04:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 13 Jun 2021 00:04:56 -0400
From:   Jeff King <peff@peff.net>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Timothy Madden <terminatorul@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Wrong tabs in terminal output for git diff
Message-ID: <YMWD6G14YxfM1uE6@coredump.intra.peff.net>
References: <8d3f8cf4-24ec-1271-ccd3-70db24f53523@gmail.com>
 <CABURp0pUDtKEDcFx+Yh3hZRXnHOzUxiOEU=epBz3SB1O5e2HqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABURp0pUDtKEDcFx+Yh3hZRXnHOzUxiOEU=epBz3SB1O5e2HqA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 04:10:04PM -0700, Phil Hord wrote:

> On Fri, Jun 11, 2021 at 12:30 PM Timothy Madden <terminatorul@gmail.com> wrote:
> > For git diff and git show commands, terminal output appears with wrong
> > tab stops (missaligned).
> >
> > Because diff operation inserts a new column at character position 1, for
> > the +, - and space characters, the diff content appears shifted to the
> > right by 1 column. But not the tab stop positions. So relative to the
> > text, the tab stops now appear off-by-one (shifted to the left).
> 
> I think "fixing" this would require modifying the diff output so it
> would no longer be correct. If we accept that a switch can make a
> incorrect diff for display only, though, it seems something could be
> done here.

We do have a few "display only" modes. You mentioned --color-words, but
--textconv is similar (and of course --ext-diff can generate whatever it
wants). I'm not sure how helpful that is, though, because humans end up
needing to look at "real" diffs that can be applied often enough (and as
you note, changing those would break them).

This could be addressed at the viewing layer, though, which is what's
converting the tabstops to screen positions. For example, "less -x9,17"
adjusts the tab stops in the pager to account for the extra leading
character (and you can put it into $LESS or $GIT_PAGER to have it kick
in automatically).

> I think the only approach that can fix the alignment, however, is to
> remove the +/- prefix markers altogether.  We do this now with the
> `--color-words` switch. This kind of solution only works if there is
> some way to indicate added/removed lines other than the line-prefix
> marker; ANSI color codes, for example.  Would that work for your
> needs, or were you thinking of something else?

There are other diff-viewing projects which can be used as a Git pager
to do stuff like this. E.g.:

  https://github.com/so-fancy/diff-so-fancy

-Peff
