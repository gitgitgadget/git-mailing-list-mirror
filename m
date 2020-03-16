Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A16C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 19:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C288720674
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 19:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbgCPTUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:20:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:41172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732383AbgCPTUB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 15:20:01 -0400
Received: (qmail 23503 invoked by uid 109); 16 Mar 2020 19:20:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Mar 2020 19:20:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 560 invoked by uid 111); 16 Mar 2020 19:29:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Mar 2020 15:29:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Mar 2020 15:20:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/2] dir: improve naming of oid_stat fields in two structs
Message-ID: <20200316192000.GB1073710@coredump.intra.peff.net>
References: <cover.1584329834.git.matheus.bernardino@usp.br>
 <6fee28469e49d501e5184162bc820350f60cc3de.1584329834.git.matheus.bernardino@usp.br>
 <xmqq1rpsako1.fsf@gitster.c.googlers.com>
 <CAHd-oW4OpoW0Qbp6_HfFiXRXasLXVnw3hDkzDG3S4WR3yH9Wuw@mail.gmail.com>
 <xmqqsgi8882t.fsf@gitster.c.googlers.com>
 <xmqqo8sw87xj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8sw87xj.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 16, 2020 at 11:35:04AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The potential for confusion with "path to these files" is real, I
> > would think, so they may benefit from some prefix.
> >
> > But instead of basing the prefix on their type, can we name it after
> > what this struct holds about the excludes file, and what the data
> > the struct holds is used for?  Is "oidst" something that conveys it
> > well to the readers of the code?
> > ...
> > In a sense, this struct is a pared down version of cache_entry that
> > keeps the filesystem stat data to allow us quickly find if the path
> > was modified, and also lets us know if two contents are the same
> > without comparing bytes.  It is a mechanism for us to tell validity
> > of our cached data.  "struct path_validity" perhaps?  I dunno.
> 
> I think "path_validity", while it probably is much better than
> "oid_stat", is a horrible name for the struct, so I'd welcome
> suggestions from third-party ;-)

We also have "struct stat_validity" already, which is an even more
pared-down version of the same concept. :)

> But I think renaming "ss_info_exclude" to "info_exclude_validity"
> (or any name that talks about "info/exclude" and "validity") would
> be a vast improvement, regardless of what the struct is called.

Yeah. I think it is good to get rid of the "ss_", but it's probably not
worth spending too many more brain cycles coming up with a perfect name.
IMHO "info_exclude_validity" and "excludes_file_validity" seem quite
descriptive.

-Peff
