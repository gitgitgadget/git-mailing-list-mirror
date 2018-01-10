Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82BEF1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 07:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754203AbeAJH6l (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 02:58:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:39764 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751755AbeAJH6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 02:58:40 -0500
Received: (qmail 17113 invoked by uid 109); 10 Jan 2018 07:58:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Jan 2018 07:58:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13441 invoked by uid 111); 10 Jan 2018 07:59:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Jan 2018 02:59:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2018 02:58:38 -0500
Date:   Wed, 10 Jan 2018 02:58:38 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/9] object: add clear_commit_marks_all()
Message-ID: <20180110075838.GD16315@sigill.intra.peff.net>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
 <ec45f9a8-292a-53e2-52b6-44d744cb6c36@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec45f9a8-292a-53e2-52b6-44d744cb6c36@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 06:44:58PM +0100, René Scharfe wrote:

> Add a function for clearing the commit marks of all in-core commit
> objects.  It's similar to clear_object_flags(), but more precise, since
> it leaves the other object types alone.  It still has to iterate through
> them, though.

Makes sense.

Is it worth having:

  void clear_object_flags_from_type(int type, unsigned flags);

rather than having two near-identical functions? I guess we'd need some
way of saying "all types" to reimplement clear_object_flags() as a
wrapper (OBJ_NONE, I guess?).

The run-time check is maybe a little bit slower in the middle of a tight
loop, but I'm not sure it would matter much (I'd actually be curious if
this approach is faster than the existing traversal code, too).

-Peff
