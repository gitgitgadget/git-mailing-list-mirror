Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7271F4B6
	for <e@80x24.org>; Wed, 15 May 2019 21:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfEOVsJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 17:48:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:58578 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726487AbfEOVsI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 17:48:08 -0400
Received: (qmail 27480 invoked by uid 109); 15 May 2019 21:48:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 May 2019 21:48:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24884 invoked by uid 111); 15 May 2019 21:48:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 15 May 2019 17:48:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2019 17:48:06 -0400
Date:   Wed, 15 May 2019 17:48:06 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [WIP] repack leaving stale entries in objects/info/packs
Message-ID: <20190515214806.GA31693@sigill.intra.peff.net>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
 <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
 <20190514115047.oncvfq24fhnp64re@dcvr>
 <87ftphw7mv.fsf@evledraar.gmail.com>
 <20190515004551.emrxvboqemwnqh4g@dcvr>
 <20190515203839.zixx23bwzeyto6a3@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515203839.zixx23bwzeyto6a3@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 08:38:39PM +0000, Eric Wong wrote:

> I've also noticed objects/info/packs contains stale entries
> after repack/gc runs on current git.
> 
> Tried adding reprepare_packed_git before update_server_info,
> but that didn't seem to work; so maybe something isn't cleared.
> Might have time to investigate more this week, might not...

We never delete entries from the in-memory packed_git list; a reprepare
only adds to the list. You'd need to teach update_server_info() to
ignore packs which are no longer present (or switch to exec-ing a
separate update-server-info binary).

-Peff
