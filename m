Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB661FEAA
	for <e@80x24.org>; Sun, 19 Jun 2016 09:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbcFSJYw (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 05:24:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:56864 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751578AbcFSJYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 05:24:52 -0400
Received: (qmail 28739 invoked by uid 102); 19 Jun 2016 09:24:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 05:24:52 -0400
Received: (qmail 6162 invoked by uid 107); 19 Jun 2016 09:25:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 05:25:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Jun 2016 05:24:48 -0400
Date:	Sun, 19 Jun 2016 05:24:48 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/8] object_id part 4
Message-ID: <20160619092448.GA12221@sigill.intra.peff.net>
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
 <57665CC6.6070208@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57665CC6.6070208@kdbg.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 19, 2016 at 10:50:14AM +0200, Johannes Sixt wrote:

> Am 19.06.2016 um 00:13 schrieb brian m. carlson:
> > * Adjust the Coccinelle patches to transform plain structs before
> >    pointers to structs to avoid misconversions.  This addresses the issue
> >    that Peff caught originally.
> 
> To avoid future mistakes, can you write down how "transform plain structs
> before pointers to structs" looks like? Is it a particular order of
> Coccinelle rules? Which part of the interdiff between the previous round and
> this round makes the difference?

Yeah, I'd also like a better understanding of what went wrong in the
original (just to be able to better evaluate the tool).

Also, for the record, the issue was noticed by Johannes originally, not
me, as indicated above (I just found a similar case after seeing his
report).

> On a tangent, I wondered recently, why we need oidcpy() and oidclr(). After
> all, in place of, e.g.,
> 
> 	oidcpy(&pair->two->oid, &p->oid);
> 	oidclr(&one->oid);
> 
> we can write
> 
> 	pair->two->oid = p->oid;
> 	one->oid = null_oid;
> 
> Is there a particular reason *not* to make this transition? I find the
> latter less cluttered with equal clarity.

I think traditionally we've avoided struct assignment because some
ancient compilers didn't do it. But it's in C89, and I suspect it's
crept into the code base anyway over the years without anyone
complaining.

-Peff
