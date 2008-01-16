From: Jeff King <peff@peff.net>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 09:32:19 -0500
Message-ID: <20080116143219.GA22744@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <alpine.LSU.1.00.0801161113170.17650@racer.site> <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com> <20080116135420.GA21588@coredump.intra.peff.net> <alpine.DEB.1.00.0801161606160.5260@bender.nucleusys.com> <20080116141836.GA22639@coredump.intra.peff.net> <alpine.DEB.1.00.0801161622030.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:33:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF9K6-0007ik-G9
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040AbYAPOc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 09:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbYAPOc1
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:32:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1148 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754871AbYAPOcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 09:32:22 -0500
Received: (qmail 24295 invoked by uid 111); 16 Jan 2008 14:32:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 16 Jan 2008 09:32:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2008 09:32:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0801161622030.5260@bender.nucleusys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70681>

On Wed, Jan 16, 2008 at 04:25:28PM +0200, Petko Manolov wrote:

>> Right, as loose objects. Did you try running "git-gc" to repack?
>
> I did "git repack -f -a -d", but it didn't reduce the repository size.  
> Those binaries are already compressed so any change adds up their size  
> once again.

OK, that was the answer I was looking for; it looks like you are out
of luck.

BTW, the main space-saver in repacking is _not_ compression, but rather
finding deltas between similar objects (e.g., two versions of the same
file that, although large, differ only by a small amount). So even
compressed files can still produce space savings during a repack, though
perhaps not as well because of randomness introduced by the compression.

As an experiment, it might be worth trying to store the uncompressed
versions instead (git will delta _and_ compress them for you).

-Peff
