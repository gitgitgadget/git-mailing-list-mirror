From: Jeff King <peff@peff.net>
Subject: Re: Why does send-pack call pack-objects for all remote refs?
Date: Wed, 9 Dec 2015 23:19:42 -0500
Message-ID: <20151210041941.GA4056@sigill.intra.peff.net>
References: <4766c8518c2a46afb88fc0a2dd9a1688@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
 <xmqqvb89lw5f.fsf@gitster.mtv.corp.google.com>
 <20151207225714.GA3785@sigill.intra.peff.net>
 <8712f730fb4c414ebc2b1168ca7948b8@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Daniel Koverman <dkoverman@predictiveTechnologies.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 05:19:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6shp-00088G-6T
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 05:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbbLJETp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 23:19:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:39650 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752392AbbLJETo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 23:19:44 -0500
Received: (qmail 27146 invoked by uid 102); 10 Dec 2015 04:19:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 22:19:44 -0600
Received: (qmail 16574 invoked by uid 107); 10 Dec 2015 04:19:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 23:19:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Dec 2015 23:19:42 -0500
Content-Disposition: inline
In-Reply-To: <8712f730fb4c414ebc2b1168ca7948b8@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282210>

On Tue, Dec 08, 2015 at 05:34:43PM +0000, Daniel Koverman wrote:

> Your interpretation of my email was correct. As you picked up on, I
> had a fundamental misunderstanding of what pack-objects was doing.
> Thanks for the explanation, I have a much better idea of what is
> going on now.
> 
> Given my use pattern, it may be reasonable for me to patch in an
> option to compute
> 
>     git rev-list --objects $my_topic --not $subset_of_remote_refs

You might also try repacking with "git repack -adb", which will build
reachability bitmaps. Pack-objects can use them to compute the set of
required objects much faster.

> It is also good to know that 2000 remote refs is insane. The lower
> hanging fruit here sounds like trimming that to a reasonable
> number, so I'll try that approach first.

It's definitely a lot, but it's not unheard of. The git project has over
500 tags. That's not 2000, but you're within an order of magnitude.

I have seen repositories with 20,000+ tags. I consider that a bit more
ridiculous, but it does work in practice.

-Peff
