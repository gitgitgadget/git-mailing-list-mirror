From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Fri, 21 Sep 2012 17:12:17 -0400
Message-ID: <20120921211217.GA24134@sigill.intra.peff.net>
References: <505CCA55.6030609@gmail.com>
 <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net>
 <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 23:12:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFAWT-0003tV-5K
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 23:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758081Ab2IUVMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 17:12:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53730 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758078Ab2IUVMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 17:12:20 -0400
Received: (qmail 7495 invoked by uid 107); 21 Sep 2012 21:12:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 17:12:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 17:12:17 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206169>

On Sat, Sep 22, 2012 at 02:37:38AM +0530, Ramkumar Ramachandra wrote:

> > I don't think that is the right thing to do. The point of SHELL is to
> > point at a bourne-compatible shell. On some systems, the main reason to
> > set it is that /bin/sh is _broken_, and we are trying to avoid it.
> 
> But you're only avoiding it in the --tee/ --va* codepath.  In the
> normal codepath, you're stuck with /bin/sh anyway.

No, the #!-header is only information. When you run "make test" we
actually invoke the shell ourselves using $SHELL_PATH.

> > A bigger question is: why are you setting SHELL=zsh in the first place?
> 
> I use ZSH as my primary shell, so SHELL is set to zsh when I run
> tests.  How can we trust $SHELL to be a bourne-compatible shell?

Ah, my fault. I was thinking we overrode $SHELL along with $SHELL_PATH,
but we do not.

The correct patch is to stop using $SHELL, but not to switch to a manual
/bin/sh. It should use $SHELL_PATH instead, which is how you tell git
your path to a sane bourne shell.

-Peff
