From: Jeff King <peff@peff.net>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
	#04; Mon, 19)
Date: Tue, 20 Jan 2009 18:24:39 -0500
Message-ID: <20090120232439.GA17746@coredump.intra.peff.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 00:26:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPPyv-0001Zx-6r
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 00:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbZATXYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 18:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbZATXYm
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 18:24:42 -0500
Received: from peff.net ([208.65.91.99]:38399 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087AbZATXYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 18:24:41 -0500
Received: (qmail 5196 invoked by uid 107); 20 Jan 2009 23:24:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Jan 2009 18:24:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2009 18:24:39 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106538>

On Tue, Jan 20, 2009 at 03:50:28PM +0100, Johannes Schindelin wrote:

> > How will you deal with race conditions between two simultaneously 
> > running scripts? I.e., where are you going to put it?
> 
> There are no race conditions, as for every git executable, a symbolic link 
> is created, pointing to the valgrind.sh script [*1*].

Hmm. I suppose that would work, since every test run is trying to create
the same state.

> Besides, what with valgrind being a memory hog, you'd be nuts to call 
> valgrinded scripts simultaneously.

I have to disagree there. I think there are two obvious usage patterns:

  - run script $X specifically under valgrind to track down a bug

  - run the whole test suite under valgrind occasionally to find
    latent bugs that wouldn't otherwise show up

In the latter, you want a pretty beefy box.  When I did the original
patches, I ran through the whole test suite under valgrind. It took
several hours on a 6GB quad-core box, using "-j4". I would hate for it
to have taken an entire day. :)

-Peff
