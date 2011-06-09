From: Jeff King <peff@peff.net>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 13:20:00 -0400
Message-ID: <20110609172000.GA30983@sigill.intra.peff.net>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <BANLkTinyYjXeg_khoU1dJVenP0mO2++hsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:20:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUitz-0004P5-0C
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 19:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab1FIRUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 13:20:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52664
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753848Ab1FIRUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 13:20:04 -0400
Received: (qmail 16791 invoked by uid 107); 9 Jun 2011 17:20:12 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 13:20:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 13:20:01 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinyYjXeg_khoU1dJVenP0mO2++hsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175555>

On Thu, Jun 09, 2011 at 01:15:38PM -0400, Jay Soffian wrote:

> > So the index is not quite simply a set of four trees. The presence of
> > various stages for each entry tells us the progress of resolution.
> 
> However, it would be useful I think to expose it as four separate
> trees. During conflict resolution, I often want to look at the
> conflicted files in these various states, and end up using various
> incantations that are somewhat baroque.

Oh, I do agree that giving easier access to those things when you want
them is reasonable. I just think that it can't _replace_ diffing with
the index, which is able to look at all of the trees at once and present
you with a useful subset.

> In fact, my first step after a conflicted merge is:
> 
>   $ git tag -f ours HEAD
>   $ git tag -f theirs MERGE_HEAD
>   $ git tag -f base $(git merge-base HEAD MERGE_HEAD)

Do note that this last one is only almost true. There may be multiple
bases, and what merge-recursive does with them may mean that what ends
up in the "base" index stage for a file may not match what is in the
first first merge-base (e.g., if a recursive virtual merge creates a new
base).

But most of the time, it is right. :)

-Peff
