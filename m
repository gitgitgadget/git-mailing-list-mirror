From: Jeff King <peff@peff.net>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 20:08:19 -0400
Message-ID: <20110610000818.GA10872@sigill.intra.peff.net>
References: <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <4DF10ADA.5070206@alum.mit.edu>
 <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
 <20110609200403.GA3955@sigill.intra.peff.net>
 <4DF13D00.2060000@alum.mit.edu>
 <BANLkTinAxWfAgBOOF0gkYDWmXDCRH+6zYg@mail.gmail.com>
 <20110609223825.GA7771@sigill.intra.peff.net>
 <BANLkTim7ZAGHO3a-G6cBwKjg4wKzskbVTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Fri Jun 10 02:08:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUpH6-0003XY-Ep
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 02:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433Ab1FJAI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 20:08:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51608
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754972Ab1FJAI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 20:08:26 -0400
Received: (qmail 21471 invoked by uid 107); 10 Jun 2011 00:08:34 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 20:08:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 20:08:19 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTim7ZAGHO3a-G6cBwKjg4wKzskbVTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175590>

On Thu, Jun 09, 2011 at 08:00:12PM -0400, Michael Nahas wrote:

> A partial step towards the right idea is not always a good thing.  It
> could leave users confused or give them the power to create a mess but
> not fix it.  We should be careful, but not fearful.

Yeah, that was what I was trying get at. We do need to be careful not to
make things worse.

> I took a quick look at some documentation.  The index has almost all
> the stats about a file that are directly available from a file in the
> working tree.  It also looks like the index has far more stats than
> can be stored in a tree object entry.  Is that right?

Yeah. The index does double duty by holding both the sha1 of what is at
each stage, but also the stat cache for files in the worktree. That's
what lets us avoid even opening unchanged files during a diff (we lstat
them and check the size, modification time, etc).

In general, that particular duty probably doesn't have a place in the UI
for porcelain. Most commands will transparently go through the cache,
find any stat-dirty entries, and actually open and check what's in the
file.

-Peff
