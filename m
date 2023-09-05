Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BE8CCF9AE
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjIEP7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 11:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353561AbjIEGn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 02:43:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2FE1B4
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 23:43:22 -0700 (PDT)
Received: (qmail 13620 invoked by uid 109); 5 Sep 2023 06:43:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Sep 2023 06:43:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19382 invoked by uid 111); 5 Sep 2023 06:43:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Sep 2023 02:43:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Sep 2023 02:43:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/10] merge: simplify parsing of "-n" option
Message-ID: <20230905064307.GA199565@coredump.intra.peff.net>
References: <20230831211637.GA949188@coredump.intra.peff.net>
 <20230831211716.GB949469@coredump.intra.peff.net>
 <75100a68-78d1-b22c-0497-36548c518b7b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75100a68-78d1-b22c-0497-36548c518b7b@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 02, 2023 at 08:20:28AM +0200, René Scharfe wrote:

> >  static struct option builtin_merge_options[] = {
> > -	OPT_CALLBACK_F('n', NULL, NULL, NULL,
> > -		N_("do not show a diffstat at the end of the merge"),
> > -		PARSE_OPT_NOARG, option_parse_n),
> > +	OPT_SET_INT('n', NULL, &show_diffstat,
> > +		N_("do not show a diffstat at the end of the merge"), 0),
> >  	OPT_BOOL(0, "stat", &show_diffstat,
> >  		N_("show a diffstat at the end of the merge")),
> 
> Makes it easier to see that we can replace the two complementary
> definitions with a single one:
> 
> 	OPT_NEGBIT('n', "no-stat",
> 		N_("do not show a diffstat at the end of the merge"), 1),
> 
> Which is a separate topic, of course.  And if we did that, however, ...

Ah, I thought we had a "reverse bool" of some kind, but I couldn't find
it. NEGBIT was what I was looking for. But yeah, I agree it gets more
complicated with the various aliases. I think what I have here is a good
stopping point for this series, but if you want to go further on it, be
my guest. :)

-Peff
