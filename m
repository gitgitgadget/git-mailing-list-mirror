Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107EFC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED127208DB
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407190AbgE1UfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 16:35:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:59242 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388955AbgE1UfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 16:35:19 -0400
Received: (qmail 31986 invoked by uid 109); 28 May 2020 20:35:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 May 2020 20:35:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18148 invoked by uid 111); 28 May 2020 20:35:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 May 2020 16:35:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 May 2020 16:35:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, hji@dyntopia.com
Subject: Re: [PATCH] t: avoid alternation (not POSIX) in grep's BRE
Message-ID: <20200528203516.GA1245262@coredump.intra.peff.net>
References: <20200528083745.15273-1-carenas@gmail.com>
 <xmqqo8q83x3v.fsf@gitster.c.googlers.com>
 <20200528154349.GA1215380@coredump.intra.peff.net>
 <xmqqh7w03vnq.fsf@gitster.c.googlers.com>
 <20200528165245.GA1223396@coredump.intra.peff.net>
 <xmqqsgfj3lym.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgfj3lym.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 12:20:49PM -0700, Junio C Hamano wrote:

> I've seen "Fixes: bug number" in projects that maintain bug
> databases and automatically updates the status of the named bug when
> a commit with such a footer hits certain integration branches; the
> utility of such a usecase would be fairly obvious.
> 
> But "Fixes: <commit>" makes me nervous.  One reason is because a
> commit very often introduces multiple bugs (or no bugs at all), so
> which one (or more) of the bug is corrected cannot be read from such
> a footer that _only_ blames a particular commit.
> 
> 	Side note: also "fixes:" footer would cast a claim made when
> 	a commit was created in stone---which may later turn out to
> 	be false.  But the issue is not unique to "Fixes: <commit>";
> 	"Fixes: <bugid>" suffers exactly from the same problem.
> 
> An interesting aspect of "Fixes: <commit>" is that we can use it to
> easily see who is the buggiest by dividing number of buggy commit by
> number of total commits per author ;-)

Thanks for writing this out. I agree with all of it.

You could probably get interesting numbers in our project by grepping
for [0-9a-f]{7,} in commit messages to see which commits are referenced
a lot. Those aren't always bug-fixes exactly, but they are often "we did
this in commit XYZ, but that missed this case". Or maybe it would just
tell you which commits are interesting enough that we keep coming back
to them. ;)

> I'd rather not to see people adding random footers whose utility is
> dubious, but for this particular one, I am not against it strongly
> enough to be tempted to declare an immediate ban.

Sounds reasonable.

-Peff
