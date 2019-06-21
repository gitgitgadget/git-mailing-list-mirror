Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257BB1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 22:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFUWY1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:24:27 -0400
Received: from avasout07.plus.net ([84.93.230.235]:55134 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUWY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:24:27 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2019 18:24:26 EDT
Received: from hashpling.plus.com ([212.159.69.125])
        by smtp with ESMTP
        id eRpyhHOjwljKgeRpzhw2Hp; Fri, 21 Jun 2019 23:16:54 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=ermhMbhX c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=dq6fvYVFJ5YA:10
 a=5rxgeBVgAAAA:8 a=Ew9TdX-QAAAA:8 a=x1ibdp7xoucimdHk3yUA:9 a=wPNLvfGTeEIA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=obabQ9O6v7JZJTLIbnk7:22
Received: from seabee by hashpling.plus.com with local (Exim 4.89)
        (envelope-from <seabee@hashpling.org>)
        id 1heRpy-0005t7-4r; Fri, 21 Jun 2019 23:16:50 +0100
Date:   Fri, 21 Jun 2019 23:16:50 +0100
From:   CB Bailey <cb@hashpling.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Deadname rewriting
Message-ID: <20190621221650.hoet5juwjhjcw5mh@hashpling.org>
References: <CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com>
 <87sgsb8dmx.fsf@evledraar.gmail.com>
 <CABURp0p2Z=qD2gF59AHBLaRn9iiTOeJyNXYsQDNk-_KEC4uSGg@mail.gmail.com>
 <877e9e8vxt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877e9e8vxt.fsf@evledraar.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfOHBZDV+iyO+kqWjynyu9IuwU/IC9jsuXMqJC7iOYCT4cB0akYA3mb4OHOUfEuVo7nTWxIZXAIEUOyshaBPpD9qqX/zd/fh0xm0CcfxDbHDDbpHgBJ9f
 h7iEAFB3VjdbAP77BNLfaPj+qJqISjGZJlE2gv8GcSz2khwF2dJIajtShFQ0jn35bxEPNjShkY7x+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 11:34:06PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> This topic was discussed at the last git contributor summit (brought up
> >> by CB Bailey) resulting in this patch, which I see didn't make it in &
> >> needs to be resurrected again:
> >> https://public-inbox.org/git/20181212171052.13415-1-cb@hashpling.org/
> >
> > Thanks for the link.
> >
> > I didn't know about config options for mailmap.file and log.mailmap
> > before. These do make this option much more useful, especially when we
> > can insert default settings for them into /etc/gitconfig across the
> > company.
> 
> Right, and to the extent that we don't --use-mailmap by default I think
> that's mainly because nobody's cared enough to advocate for it. I think
> it would be a sensible default.

That was this patch:

https://public-inbox.org/git/20181213120940.26477-1-cb@hashpling.org/

There were no objections so I was going to re-propose it but I haven't
got around to this for a number of reasons, many of which are not Git
related. Ideally, I wanted to fix all of the known issues with mailmap
such as some behaviors of shortlog fixed with the shortlog patch above.

I also noticed some more artifacts that I would like to be fixed. In
particular the RFC 822 style "trailers" should be rewritten by default.

Having something like this pop up is not likely to be acceptable in a
project which uses trailers:

commit abcd...
Author: Bob <bob@...>

    important commit message

    Signed-off-by: Alice <alice@...?

Obviously it's virtually impossible to account for everything such as
someone referencing Bob by their deadname in the free text body of a
historical commit.

CB
