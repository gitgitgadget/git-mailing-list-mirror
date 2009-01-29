From: Jeff King <peff@peff.net>
Subject: Re: "malloc failed"
Date: Thu, 29 Jan 2009 00:14:51 -0500
Message-ID: <20090129051451.GA31507@coredump.intra.peff.net>
References: <878wow7pth.fsf@mcbain.luannocracy.com> <20090128050225.GA18546@coredump.intra.peff.net> <3af572ac0901281416x5adef0eak89bd4b40fda52c2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 06:16:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSPGF-0004zn-LH
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 06:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbZA2FO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 00:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbZA2FO4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 00:14:56 -0500
Received: from peff.net ([208.65.91.99]:48943 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbZA2FOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 00:14:55 -0500
Received: (qmail 28947 invoked by uid 107); 29 Jan 2009 05:15:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 00:15:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 00:14:51 -0500
Content-Disposition: inline
In-Reply-To: <3af572ac0901281416x5adef0eak89bd4b40fda52c2b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107633>

On Wed, Jan 28, 2009 at 11:16:32PM +0100, Pau Garcia i Quiles wrote:

> My case: I have a 500 MB repository with a 1GB working tree, with
> binary files ranging from 100KB to 50MB and a few thousand source
> files.
> 
> I have two branches ('master' and 'cmake') and the latter has suffered
> a huge hierarchy reorganization.
> 
> When I merge 'master' in 'cmake', if I use the 'subtree' strategy, it
> works fine. If I use any other strategy, after a couple of minutes I
> receive a "malloc failed" and the tree is all messed up. As I said, on
> Linux it works fine, so maybe it's a Windows-specific problem.

Hmm. It very well might be the rename detection allocating a lot of
memory to do inexact rename detection. It does try to limit the amount
of work, but based on number of files. So if you have a lot of huge
files, that might be fooling it.

Try setting merge.renamelimit to something small (but not '0', which
means "no limit").

-Peff
