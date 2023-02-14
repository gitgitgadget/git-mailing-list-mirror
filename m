Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA1EC61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 18:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjBNSiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 13:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjBNSiT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 13:38:19 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2322B282
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 10:38:14 -0800 (PST)
Received: (qmail 589 invoked by uid 109); 14 Feb 2023 18:38:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Feb 2023 18:38:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3679 invoked by uid 111); 14 Feb 2023 18:38:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Feb 2023 13:38:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Feb 2023 13:38:12 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 0/3] get rid of sscanf() when shortening refs
Message-ID: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
References: <Y+rmNvfjIA/u81em@coredump.intra.peff.net>
 <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
 <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
 <xmqq7cwk955b.fsf@gitster.g>
 <CAPig+cQx24PRUsEjEcnuDtokS02SS3n_dUi8MO=WJbBazget8g@mail.gmail.com>
 <xmqq3578924s.fsf@gitster.g>
 <CAPig+cQLRDJY_9zjEu2DdZug8h9QNSUVCzDC7W65Cm=eQ-3MiQ@mail.gmail.com>
 <Y+uwW0I0k7urZ3do@coredump.intra.peff.net>
 <CAPig+cTH1hUTSN+TRCo9brGMosEW-OWV0JVBATK+moB0EZec3w@mail.gmail.com>
 <Y+u/xUQJoWVWULn6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+u/xUQJoWVWULn6@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 12:07:17PM -0500, Jeff King wrote:

> There's a leak in it when there is an ambiguous ref (because we allocate
> short_name in each iteration of the loop, rather than overwriting the
> buffer). I'll post a fixed version in a moment.

OK, here it is. I split it into a few patches to hopefully make it a bit
easier to follow.

  [1/3]: shorten_unambiguous_ref(): avoid integer truncation
  [2/3]: shorten_unambiguous_ref(): use NUM_REV_PARSE_RULES constant
  [3/3]: shorten_unambiguous_ref(): avoid sscanf()

 refs.c | 92 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 47 insertions(+), 45 deletions(-)

-Peff
