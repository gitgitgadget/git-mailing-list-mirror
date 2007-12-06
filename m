From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] gc --aggressive: make it really aggressive
Date: Thu, 6 Dec 2007 08:42:44 -0500
Message-ID: <20071206134243.GA17037@thunk.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> <20071205.202047.58135920.davem@davemloft.net> <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> <20071205.204848.227521641.davem@davemloft.net> <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org> <Pine.LNX.4.64.0712061201580.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 06 14:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0H0w-0005oZ-Rz
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 14:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbXLFNnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 08:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbXLFNnV
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 08:43:21 -0500
Received: from THUNK.ORG ([69.25.196.29]:46664 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbXLFNnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 08:43:20 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1J0HAz-00028Z-Ll; Thu, 06 Dec 2007 08:54:05 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1J0H00-0004aR-83; Thu, 06 Dec 2007 08:42:44 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712061201580.27959@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67283>

On Thu, Dec 06, 2007 at 12:03:38PM +0000, Johannes Schindelin wrote:
> 
> The default was not to change the window or depth at all.  As suggested
> by Jon Smirl, Linus Torvalds and others, default to
> 
> 	--window=250 --depth=250

I'd also suggest adding a comment in the man pages that this should
only be done rarely, and that it can potentially take a *long* time
(i.e., overnight) for big repositories, and in general it's not worth
the effort to use --aggressive.

Apologies to Linus and to the gcc folks, since I was the one who
originally coded up gc --aggressive, and at the time my intent was
"rarely does it make sense, and it may take a long time".  The reason
why I didn't make the default --window and --depth larger is because
at the time the biggest repo I had easy access to was the Linux
kernel's, and there you rapidly hit diminishing returns at much
smaller numbers, so there was no real point in using --window=250
--depth=250.

Linus later pointed out that what we *really* should do is at some
point was to change repack -f to potentially retry to find a better
delta, but to reuse the existing delta if it was no worse.  That
automatically does the right thing in the case where you had
previously done a repack with --window=<large n> --depth=<large n>,
but then later try using "gc --agressive", which ends up doing a worse
job and throwing away the information from the previous repack with
large window and depth sizes.  Unfortunately no one ever got around to
implementing that.

Regards,

						- Ted
