Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB23C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E970613B3
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 20:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhD2UP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:15:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:40320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236795AbhD2UPX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 16:15:23 -0400
Received: (qmail 16230 invoked by uid 109); 29 Apr 2021 20:14:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Apr 2021 20:14:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22514 invoked by uid 111); 29 Apr 2021 20:14:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Apr 2021 16:14:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Apr 2021 16:14:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: Nesting topics within other threads
Message-ID: <YIsTqmSoR5k2r6kD@coredump.intra.peff.net>
References: <87k0omzv3h.fsf@evledraar.gmail.com>
 <patch-1.1-e1d8c842c70-20210428T161817Z-avarab@gmail.com>
 <1ecb3727-106f-3d04-976a-36aa03a61caf@gmail.com>
 <xmqqsg397jyj.fsf@gitster.g>
 <8735v9z32l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735v9z32l.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 02:14:52PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I really appreciate the way some people (Peff is a stellar example,
> > but there are others who are as good at this) handle these tangents,
> > where the message sent to an existing thread is limited to only give
> > an outline of the idea (possibly with "something like this?" patch
> > for illustration) and then they quickly get out of the way of the
> > discussion by starting a separate thread, while back-referencing "So
> > here is a proper patch based on the idea I interjected in the
> > discussion of that other topic."  And the discussion on the tangent
> > will be done on its own thread.
> 
> In RFC 822 terms. Are you talking about the In-Reply-To[1] or
> References[2] headers, or both/neither?

Since I got listed as an example, I can tell you what I do: I start a
totally new thread with no in-reply-to or references to the old thread.
And the subject is new (usually "[PATCH 0/N] foo..."), so no clever
group-by-subject heuristics will link them.

It's usually a good idea to reference the message-id/lore link in at
least one direction, though (usually I'd do it in the new thread, saying
"this is a followup to ...", but you could also follow-up in the
original to say "I've spun this off into its own series here...").

Which is really _sort of_ like putting it into "References", except that
it's not machine readable. Which is a good thing, because it's a weaker
form and doesn't tell mail clients to group it all into one thread.

> Threading isn't a concept that exists in E-Mail protocols per-se. Just
> In-Reply-To and References. The References header can reference N
> messages most would think about as a separate "thread", and "thread" is
> ultimately some fuzzy MUA-specific concept on top of these (and others).
> 
> E.g. in my client right now I'm looking at just 4 messages in this
> "thread", it doesn't descend down the whole In-Reply-To, others would
> act differently.

Interesting. Mutt (and notmuch, and public-inbox) definitely view these
as part of a larger thread.  It looks like you're using mu4e; I'm
surprised it doesn't, too (of course some clients will give a partial
view of a thread if you've already marked the older messages as read and
moved them into an archival folder).

> It seems to me to be better to veer on the side of using standard fields
> for their intended purpose for archiving / future use. I.e. making "a
> reference" universally machine-readable, as opposed to a lore.kernel.org
> link, or a free-form "in a recent thread" blurb.

I'd disagree here. There's a long history of intentionally breaking the
thread in mailing lists and newsgroups exactly because the topic is
sufficiently different that you want to make it easy for people to treat
it as a separate unit. I admit there's a bit of an art form to deciding
when that is appropriate and when not.

-Peff
