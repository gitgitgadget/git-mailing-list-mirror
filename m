From: Jeff King <peff@peff.net>
Subject: Re: "malloc failed"
Date: Wed, 28 Jan 2009 00:02:25 -0500
Message-ID: <20090128050225.GA18546@coredump.intra.peff.net>
References: <878wow7pth.fsf@mcbain.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 06:04:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS2af-0001fT-IC
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 06:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbZA1FC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 00:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbZA1FC2
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 00:02:28 -0500
Received: from peff.net ([208.65.91.99]:40899 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbZA1FC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 00:02:28 -0500
Received: (qmail 18802 invoked by uid 107); 28 Jan 2009 05:02:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 00:02:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 00:02:25 -0500
Content-Disposition: inline
In-Reply-To: <878wow7pth.fsf@mcbain.luannocracy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107478>

On Tue, Jan 27, 2009 at 10:04:42AM -0500, David Abrahams wrote:

> I've been abusing Git for a purpose it wasn't intended to serve:
> archiving a large number of files with many duplicates and
> near-duplicates.  Every once in a while, when trying to do something
> really big, it tells me "malloc failed" and bails out (I think it's
> during "git add" but because of the way I issued the commands I can't
> tell: it could have been a commit or a gc).  This is on a 64-bit linux
> machine with 8G of ram and plenty of swap space, so I'm surprised.
> 
> Git is doing an amazing job at archiving and compressing all this stuff
> I'm putting in it, but I have to do it a wee bit at a time or it craps
> out.  Bug?

How big is the repository? How big are the biggest files? I have a
3.5G repo with files ranging from a few bytes to about 180M. I've never
run into malloc problems or gone into swap on my measly 1G box.
How does your dataset compare?

As others have mentioned, git wasn't really designed specifically for
those sorts of numbers, but in the interests of performance, I find git
is usually pretty careful about not keeping too much useless stuff in
memory at one time.  And the fact that you can perform the same
operation a little bit at a time and achieve success implies to me there
might be a leak or some silly behavior that can be fixed.

It would help a lot if we knew the operation that was causing the
problem. Can you try to isolate the failed command next time it happens?

-Peff
