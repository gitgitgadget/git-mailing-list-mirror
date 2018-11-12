Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959D31F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 20:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeKMGCX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 01:02:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:36272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725832AbeKMGCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 01:02:23 -0500
Received: (qmail 8618 invoked by uid 109); 12 Nov 2018 20:07:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 20:07:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14078 invoked by uid 111); 12 Nov 2018 20:06:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 15:06:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 15:07:35 -0500
Date:   Mon, 12 Nov 2018 15:07:35 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 9/9] fetch-pack: drop custom loose object cache
Message-ID: <20181112200735.GA7598@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145558.GI7400@sigill.intra.peff.net>
 <a08d8e20-ecb5-3135-f294-56dec1730b5f@web.de>
 <87efbq2isk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87efbq2isk.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 08:32:43PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >>  	for (ref = *refs; ref; ref = ref->next) {
> >>  		struct object *o;
> >> -		unsigned int flags = OBJECT_INFO_QUICK;
> >>
> >> -		if (use_oidset &&
> >> -		    !oidset_contains(&loose_oid_set, &ref->old_oid)) {
> >> -			/*
> >> -			 * I know this does not exist in the loose form,
> >> -			 * so check if it exists in a non-loose form.
> >> -			 */
> >> -			flags |= OBJECT_INFO_IGNORE_LOOSE;
> >
> > This removes the only user of OBJECT_INFO_IGNORE_LOOSE.  #leftoverbits
> 
> With this series applied there's still a use of it left in
> oid_object_info_extended()

That's just the code that does something with the flag. No callers pass
it in anymore, so we could drop the flag _and_ that code.

-Peff
