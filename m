Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570D3C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 16:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjD0QzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 12:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjD0QzW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 12:55:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD5610DC
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 09:55:21 -0700 (PDT)
Received: (qmail 23966 invoked by uid 109); 27 Apr 2023 16:55:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 16:55:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20961 invoked by uid 111); 27 Apr 2023 16:55:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 12:55:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 12:55:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 3/4] parse_commit(): handle broken whitespace-only
 timestamp
Message-ID: <20230427165519.GB1976451@coredump.intra.peff.net>
References: <20230427081330.GA1461786@coredump.intra.peff.net>
 <20230427081715.GA1478467@coredump.intra.peff.net>
 <a04e7950-b74e-d43f-4d19-86def079748c@gmail.com>
 <xmqqpm7pl2je.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm7pl2je.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 09:20:53AM -0700, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> >> I did also allow "-" here, which may be controversial, as we don't
> >> currently support negative timestamps. My reasoning was two-fold. One,
> >> the design of parse_timestamp() is such that we should be able to easily
> >> switch it to handling signed values, and this otherwise creates a
> >> hard-to-find gotcha that anybody doing that work would get tripped up
> >> on. And two, the status quo is that we currently parse them, though the
> >> result of course ends up as a very large unsigned value (which is likely
> >> to just get clamped to "0" for display anyway, since our date routines
> >> can't handle it).
> >
> > I think this makes a good case for accepting '-'. The commit message
> > is well explained as always :-) This all looks good to me apart from a
> > query about one of the tests.
> 
> I agree.  I was somewhat surprised that the big comment before that
> code did not mention it, but hopefully those who would be tempted to
> remove the check for '-' would either be careful enough themselves
> or be stopped by reviewers who are careful enough to go back to the
> log message of the commit that added the check in the first place,
> so it is OK.

Hmph, I thought I did write something in that comment. But I think in
the end I just migrated it to the commit message (and skimming my reflog
I don't think it even made it as far as a commit).

I think it's OK. I was mostly trying to help out Future Peff, who has a
series almost completed to handle negative timestamps. But I think the
worst case is that the tests in that new series would fail, and I'd
figure it out. :)

-Peff
