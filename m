From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch
 when appropriate to do so
Date: Tue, 13 Oct 2009 18:06:40 -0400
Message-ID: <20091013220640.GB12603@coredump.intra.peff.net>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
 <200910131051.47117.trast@student.ethz.ch>
 <7vy6nfwssk.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Euguess@gmail.com,
	Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 00:18:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxpXZ-0001jO-Jn
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 00:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761249AbZJMWHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 18:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760908AbZJMWHR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 18:07:17 -0400
Received: from peff.net ([208.65.91.99]:41025 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760276AbZJMWHP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 18:07:15 -0400
Received: (qmail 21729 invoked by uid 107); 13 Oct 2009 22:10:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 13 Oct 2009 18:10:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Oct 2009 18:06:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130224>

On Tue, Oct 13, 2009 at 11:20:28PM +0200, Johannes Schindelin wrote:

> So in my opinion, we should DWIM "git checkout $X" to mean "git checkout 
> -b $X refs/remotes/$REMOTE/$X" when there is no ref $X, refs/heads/$X and 
> no other refs/remotes/$OTHER/$X.

The similar suggestion that is less magical is to say something like
"there is no $X; maybe you meant $REMOTE/$X?".  Is there a reason not to
phase in the behavior, to make sure it is not doing unexpected things?
In other words:

  1. In v1.6.6, find all error-correcting candidates and print them as
     a suggestion (similar to what we do with "git foo").

  2. Then, if we all agree that it seems to be producing sane results,
     the next step is to turn the unambiguous cases into a DWIM (and
     leave the ambiguous ones with the "did you mean?" message).

Because right now I think there are a lot of hypothetical "maybe it
would be less convenient or more confusing in this instance", but we
don't have any data on how often those instances occur, or how actual
users might react. So doing step (1) would be a way of collecting some
of that data (will users say "stupid git, if you knew what I wanted, why
didn't you just do it?" or "stupid git, your suggestion is just
confusing me!").

-Peff
