From: Jeff King <peff@peff.net>
Subject: Re: error: git-remote-https died of signal 13
Date: Sun, 24 Nov 2013 01:54:01 -0500
Message-ID: <20131124065400.GB5535@sigill.intra.peff.net>
References: <5290D994.9040505@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Nov 24 07:54:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkTaN-0003l5-DV
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 07:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab3KXGyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 01:54:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:44663 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751916Ab3KXGyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 01:54:03 -0500
Received: (qmail 18617 invoked by uid 102); 24 Nov 2013 06:54:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Nov 2013 00:54:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Nov 2013 01:54:01 -0500
Content-Disposition: inline
In-Reply-To: <5290D994.9040505@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238250>

On Sat, Nov 23, 2013 at 05:36:36PM +0100, Stefan Beller wrote:

> sb@sb:/tmp$ git clone https://github.com/Bertram25/ValyriaTear.git
> Cloning into 'ValyriaTear'...
> remote: Counting objects: 21346, done.
> remote: Compressing objects: 100% (6307/6307), done.
> remote: Total 21346 (delta 16463), reused 19820 (delta 15000)
> Receiving objects: 100% (21346/21346), 176.39 MiB | 445.00 KiB/s, done.
> Resolving deltas: 100% (16463/16463), done.
> Checking connectivity... done.
> error: git-remote-https died of signal 13
> 
> However the repository seems to be cloned fine.
> I can clone different repos from github and they are working fine
> without the error.
> Would that be an issue on my side or on githubs side?

Almost certainly on your side. 13 is SIGPIPE, so git-remote-https is
trying to write something but the other side of the pipe has hung up.
This might be a race condition in the transport-helper protocol, where
we've had similar problems before.

It doesn't reproduce here for me. Can you reproduce it consistently on
this repo? I would not be at all surprised if it is intermittent.

If you can reproduce, it would be interesting to see the output with
GIT_TRANSPORT_HELPER_DEBUG=1, or even with "strace -f". That could at
least tell us what it was trying to write (and to where) when it got the
SIGPIPE.

-Peff
