Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07B7E20954
	for <e@80x24.org>; Thu, 30 Nov 2017 11:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdK3L6L (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 06:58:11 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:27933 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdK3L6K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 06:58:10 -0500
X-Greylist: delayed 2355 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Nov 2017 06:58:10 EST
Received: from [91.248.197.178] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1eKMri-0004Rt-HZ; Thu, 30 Nov 2017 12:18:50 +0100
Date:   Thu, 30 Nov 2017 12:18:49 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>, hsed@unimetic.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH V4] config: add --expiry-date
Message-ID: <20171130111849.GA98794@book.hvoigt.net>
References: <xmqqlgj7xcuf.fsf@gitster.mtv.corp.google.com>
 <20171118022727.30179-1-hsed@unimetic.com>
 <xmqq8tf4qmu8.fsf@gitster.mtv.corp.google.com>
 <20171120170443.awpvcuubsi5o6zmp@sigill.intra.peff.net>
 <CAGZ79ka+5o07cz4A8=Gu_VqO1hYqqO=8Ju1uAaDY23s7xjCWvw@mail.gmail.com>
 <20171120203702.mdd3hkwezxyf7vtg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120203702.mdd3hkwezxyf7vtg@sigill.intra.peff.net>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 03:37:03PM -0500, Jeff King wrote:
> On Mon, Nov 20, 2017 at 12:28:11PM -0800, Stefan Beller wrote:
> 
> > > +cc Stefan, who added the die(). It may be that we don't care that much
> > > these days about recovering from broken .gitmodules files.
> > 
> > By that you mean commits like 37f52e9344 (submodule-config:
> > keep shallow recommendation around, 2016-05-26) for example?
> > That adds a git_config_bool to the submodule config machinery.
> 
> I actually meant ea2fa5a338 (submodule-config: keep update strategy
> around, 2016-02-29), which adds an actual die() into parse_config(). But
> yeah, I think the end result is the same.
> 
> > I agree that we'd want to be more careful, but for now I'd put it to the
> > #leftoverbits.
> 
> Fine by me. While I think the original intent was to be more lenient to
> malformed .gitmodules, it's not like we're seeing bug reports about it.

My original intent was not about being more lenient about malformed
.gitmodules but having a way to deal with repository history that might
have a malformed .gitmodules in its history. Since depending on the
branch it is on it might be quite carved in stone.
On an active project it would not be that easy to rewrite history to get
out of that situation.

When a .gitmodules file in the worktree is malformed it is easy to fix.
That is not the case when we are reading configurations from blobs.

My guess why there are no reports is that maybe not too many users are
using this infrastructure yet, plus it is probably seldom that someone
edits the .gitmodules file by hand which could lead to such a situation.
But if such an error occurs it will be very annoying if we die while
parsing submodule configurations. The only solution I see currently is
to turn submodule recursion off completely.

But maybe I am being overly cautious here.

Cheers Heiko
