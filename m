From: Jeff King <peff@peff.net>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 12:00:16 -0400
Message-ID: <20080313160016.GB30847@coredump.intra.peff.net>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com> <20080313114738.GC2414@genesis.frugalware.org> <alpine.LSU.1.00.0803131254580.1656@racer.site> <20080313121644.GD2414@genesis.frugalware.org> <20080313125853.GA12927@mit.edu> <alpine.LSU.1.00.0803131620270.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@mit.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 17:01:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZprX-0000Hb-A5
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 17:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbYCMQAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 12:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbYCMQAU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 12:00:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4327 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbYCMQAT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 12:00:19 -0400
Received: (qmail 9960 invoked by uid 111); 13 Mar 2008 16:00:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 12:00:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 12:00:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803131620270.1656@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77098>

On Thu, Mar 13, 2008 at 04:21:44PM +0100, Johannes Schindelin wrote:

> > No, and you wouldn't want to use gpg because of the overhead it adds
> > around an encrypted message.
> 
> To the contrary: if your files are small (which they are most likely), you 
> _want_ the overhead, in order to make the encryption harder to crack.

Not necessarily. Using random IVs, random salts, and random padding does
increase security.  Adding headers to every object that tell which
algorithm and parameters were used are nice for interoperability, but
don't help with security. Doing per-object asymmetric encryptions (gpg
--encrypt without --symmetric) is performance insanity.

> AFAICT gpg is a good all-round encryption tool, and reinventing the wheel 
> just for encrypting things in a git repository just does not cut it.

Keep in mind that in the example you posted before, you were not using
99% of gpg. You were just asking it to do a symmetric CBC cipher using a
passphrase. So it is overkill for that, but at the same time not
actually very flexible for doing those sorts of low-level things.
OpenSSL provides a much better toolkit for that.

-Peff
