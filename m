Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623201F731
	for <e@80x24.org>; Sat,  3 Aug 2019 23:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfHCX7Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 19:59:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:33326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725385AbfHCX7P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 19:59:15 -0400
Received: (qmail 23626 invoked by uid 109); 3 Aug 2019 23:59:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Aug 2019 23:59:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15888 invoked by uid 111); 4 Aug 2019 00:01:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 03 Aug 2019 20:01:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 3 Aug 2019 19:59:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mark Rushakoff <mark.rushakoff@gmail.com>,
        Mark Rushakoff via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix two documentation typos
Message-ID: <20190803235914.GA5353@sigill.intra.peff.net>
References: <pull.304.git.gitgitgadget@gmail.com>
 <xmqqsgqii9u3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgqii9u3.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 03, 2019 at 07:48:20AM -0700, Junio C Hamano wrote:

> > Then I noticed a "can not" and updated that and other occurrences in
> > Documentation to cannot. The glossary sentence with "can not" was
> > "Consequently, an object can not be changed." To me, that reads like "it is
> 
> Hmph, I am not a native speaker, but I have to say that this is the
> first time I heard that "I can not drive" to mean "I have a choice
> of not driving (even though I am capable of driving)".

I think in writing I would assume that "can not" is "unable to" (and a
brief skim of online resources indicates they have equivalent meanings).
But colloquially, I might say something like: "I can _not_ put mushrooms
in the soup if you'd prefer" (where the underscores indicate an emphasis
I'd give when speaking).

So I don't find it overly ambiguous, but I think there's no reason not
to prefer "cannot".

That said, I think in many error messages, "unable to" is often better
(and we already use it quite frequently). This one (that Mark mentioned
but didn't change in this patch) is especially bad:

  $ git grep -in 'can not' '*.c' | head -1
  builtin/checkout.c:834: fprintf(stderr, _("Can not do reflog for '%s': %s\n"),

because of the vague "do". Maybe "unable to create reflog for '%s': %s'"
would be better. Also, why isn't this an error()?

The other one he mentioned:

  $ git --no-pager grep -B2 -A3 'can not' builtin/mv.c
  builtin/mv.c-		else if (!strncmp(src, dst, length) &&
  builtin/mv.c-				(dst[length] == 0 || dst[length] == '/')) {
  builtin/mv.c:			bad = _("can not move directory into itself");
  builtin/mv.c-		} else if ((src_is_dir = S_ISDIR(st.st_mode))
  builtin/mv.c-				&& lstat(dst, &st) == 0)
  builtin/mv.c-			bad = _("cannot move directory over file");

is rather egregious as the message just below uses "cannot". And here
"cannot" makes more sense to me than "unable to", as we did not try a
thing that failed; it is literally something that one cannot do at all,
because it does not make sense. So it is Git saying "you cannot do
this", not "I was unable to do this". :)

-Peff
