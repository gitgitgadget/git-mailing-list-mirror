From: Jeff King <peff@peff.net>
Subject: Re: Recovering from missing objects?
Date: Thu, 19 Feb 2009 21:58:10 -0500
Message-ID: <20090220025810.GB22419@coredump.intra.peff.net>
References: <alpine.LRH.2.00.0902191447040.16988@vixen.sonytel.be> <7vvdr6j6hz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 03:59:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaLc6-0000EE-FN
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 03:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZBTC6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 21:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbZBTC6O
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 21:58:14 -0500
Received: from peff.net ([208.65.91.99]:42292 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbZBTC6N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 21:58:13 -0500
Received: (qmail 31062 invoked by uid 107); 20 Feb 2009 02:58:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Feb 2009 21:58:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2009 21:58:10 -0500
Content-Disposition: inline
In-Reply-To: <7vvdr6j6hz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110782>

On Thu, Feb 19, 2009 at 04:29:12PM -0800, Junio C Hamano wrote:

> > If I clone the remote repository, I have the object in the new clone.
> > However, how do I get the missing object back into the .git directory of my
> > working repository?
> [...]
> In the new clone:
> 
> 	$ IT=c406ab0be69c912ea59233595a071478103cdad8
> 	$ H=$(git rev-list --objects $IT | git pack-objects mine)
>         $ mv mine-$H.pack /var/tmp
> 
> Go to the repository that lacks the object and then
> 
> 	$ git unpack-objects </var/tmp/mine-$H.pack

Might it not be simpler to just copy or hardlink the pack from the new
clone into the old directory's .git/objects/pack? That will get more
than you need, but things should start working, at which point a "git
repack -a -d" will make it small again.

Or am I misunderstanding something?

-Peff
