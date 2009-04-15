From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Fix buffer overflow in config parser
Date: Wed, 15 Apr 2009 03:50:35 -0400
Message-ID: <20090415075035.GA23332@coredump.intra.peff.net>
References: <49E50003.2040907@intra2net.com> <alpine.DEB.1.00.0904142340350.10279@pacific.mpi-cbg.de> <49E50480.5060005@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 09:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltzv9-0004HP-1e
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 09:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbZDOHul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 03:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbZDOHul
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 03:50:41 -0400
Received: from peff.net ([208.65.91.99]:42664 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754881AbZDOHul (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 03:50:41 -0400
Received: (qmail 14654 invoked by uid 107); 15 Apr 2009 07:50:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Apr 2009 03:50:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2009 03:50:35 -0400
Content-Disposition: inline
In-Reply-To: <49E50480.5060005@intra2net.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116593>

On Tue, Apr 14, 2009 at 11:47:44PM +0200, Thomas Jarosch wrote:

> Johannes Schindelin wrote:
> >> +LONG_VALUE=`perl -e 'print "x" x 1023," a"'`
> > 
> > But should it not be guarded against NO_PERL?
> 
> Hmm, lots of other tests like "t4200-rerere.sh" use perl
> and it don't see any special guard around the perl usage.

Right.  There are really two types of perl usage in the tests:

  1. Testing git programs which use perl.

  2. Tests which happen to require perl as part of the testing.

Right now, only instances of (1) are marked with NO_PERL. This means
that you can build with NO_PERL, test and install the result, and then
uninstall perl (or make a binary package for perl-less people), and have
it work fine. But you can't currently run the full test suite without
any perl.

Your usage falls into (2), none of which are marked (and if they are to
be marked, then all of them should be, since there is otherwise no
point).

-Peff
