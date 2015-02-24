From: Jeff King <peff@peff.net>
Subject: Re: assistance with git error
Date: Tue, 24 Feb 2015 16:11:36 -0500
Message-ID: <20150224211136.GA32217@peff.net>
References: <loom.20150224T213812-434@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tom <tdmoretto@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 22:11:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQMlc-00079N-Ct
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 22:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbbBXVLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 16:11:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:52852 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752544AbbBXVLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 16:11:39 -0500
Received: (qmail 6264 invoked by uid 102); 24 Feb 2015 21:11:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Feb 2015 15:11:38 -0600
Received: (qmail 9054 invoked by uid 107); 24 Feb 2015 21:11:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Feb 2015 16:11:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2015 16:11:36 -0500
Content-Disposition: inline
In-Reply-To: <loom.20150224T213812-434@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264348>

On Tue, Feb 24, 2015 at 08:40:56PM +0000, Tom wrote:

> Could someone provide me some assistance with troubleshooting the following:
> 
> remote: Counting objects: 31654, done.
> error: pack-objects died of signal 99568/19585)   

The output is smushed here due to the use of "\r" for the progress
reporting, but the interesting message is:

  error: pack-objects died of signal 9

which probably overwrote something like:

  remote: Compressing objects:  XXX% (9568/19585)

The rest of the messages are just the error propagating through the
various programs on the remote and local sides. So something killed
pack-objects with signal 9 (SIGKILL). Just a guess, but it may have been
killed for using too much memory.

Do you have control of the server? Is it running Linux? If so, check
your system logs to see if the OOM-killer killed it.

If the server is multi-core, setting:

  git config pack.threads 1

in the repository in question may reduce the peak memory usage.

-Peff
