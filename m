From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-export: ensure we traverse commits in topological
	order
Date: Wed, 11 Feb 2009 08:56:40 -0500
Message-ID: <20090211135640.GA19600@coredump.intra.peff.net>
References: <1234332233-10017-1-git-send-email-newren@gmail.com> <1234332233-10017-2-git-send-email-newren@gmail.com> <alpine.DEB.1.00.0902111125410.10279@pacific.mpi-cbg.de> <e2b179460902110248m8055b3amdebcfc550438cff2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 14:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXFbP-000078-Tx
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 14:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbZBKN4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 08:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbZBKN4o
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 08:56:44 -0500
Received: from peff.net ([208.65.91.99]:46969 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbZBKN4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 08:56:43 -0500
Received: (qmail 30098 invoked by uid 107); 11 Feb 2009 13:56:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 08:56:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 08:56:40 -0500
Content-Disposition: inline
In-Reply-To: <e2b179460902110248m8055b3amdebcfc550438cff2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109415>

On Wed, Feb 11, 2009 at 10:48:18AM +0000, Mike Ralphson wrote:

> > On Tue, 10 Feb 2009, newren@gmail.com wrote:
> > fast-export will only list as parents those commits which have already
> > been traversed (making it appear as if merges have been squashed if not
> > all parents have been traversed).  To avoid this silent squashing of
> > merge commits, we request commits in topological order.
> 
> Any comparative timings? We don't need to rename this to 'git
> reasonably-speedy-export'? 8-)

Hmm.

In git.git:

  $ time git fast-export --all --signed-tags=strip >/dev/null
  real    1m6.013s
  user    1m3.840s
  sys     0m2.140s

  $ time git fast-export --all --signed-tags=strip --topo-order >/dev/null
  real    0m49.018s
  user    0m47.987s
  sys     0m0.888s

I certainly didn't expect it to be _faster_.  More efficient use of the
delta cache, maybe?

-Peff
