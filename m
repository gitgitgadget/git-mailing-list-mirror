From: Jeff King <peff@peff.net>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 12:18:32 -0400
Message-ID: <20110609161832.GB25885@sigill.intra.peff.net>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DF08D30.7070603@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 09 18:18:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhwU-0007Bp-95
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 18:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab1FIQSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 12:18:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41776
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab1FIQSm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 12:18:42 -0400
Received: (qmail 15180 invoked by uid 107); 9 Jun 2011 16:18:49 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 12:18:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 12:18:32 -0400
Content-Disposition: inline
In-Reply-To: <4DF08D30.7070603@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175547>

On Thu, Jun 09, 2011 at 11:06:56AM +0200, Michael Haggerty wrote:

> My naive understanding is that in the case of a merge commit, the index
> contains information equivalent to *multiple* trees:
> 
> NEXT -- HEAD plus the files that have been resolved
> BASE -- the contents of the common ancestor
> OURS -- equivalent to the tree from HEAD
> THEIRS -- equivalent to the tree from MERGE_HEAD

Almost. Remember that as part of the merge resolution process,
higher-level stages will collapse down to 0. So the "theirs" stage of
the index is equivalent to MERGE_HEAD only if you have a conflict in
every file and have resolved nothing. Otherwise, any resolved entries
will not have a "theirs" entry at all.

So when I do "git diff", we will see for resolved entries that the
working tree matches stage 0 in the index, and show nothing. Whereas
unresolved entries will have their diff shown. But with "git diff
MERGE_HEAD", we will see differences from the other branch, even if
those differences are simply resolutions or even changes made on the
"ours" branch.

So the index is not quite simply a set of four trees. The presence of
various stages for each entry tells us the progress of resolution.

-Peff
