From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Wed, 4 Feb 2009 10:18:33 -0500
Message-ID: <20090204151833.GA6896@sigill.intra.peff.net>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com> <20090204145317.GA5712@sigill.intra.peff.net> <94a0d4530902040703u53a9082fsfa7203b6203bd118@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:20:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjXo-0003DN-ML
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbZBDPSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 10:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbZBDPSi
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:18:38 -0500
Received: from peff.net ([208.65.91.99]:45095 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbZBDPSh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:18:37 -0500
Received: (qmail 29512 invoked by uid 107); 4 Feb 2009 15:18:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 04 Feb 2009 10:18:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Feb 2009 10:18:33 -0500
Content-Disposition: inline
In-Reply-To: <94a0d4530902040703u53a9082fsfa7203b6203bd118@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108375>

On Wed, Feb 04, 2009 at 05:03:22PM +0200, Felipe Contreras wrote:

> > With this patch, won't I get different behavior from:
> >
> >  git config -e --global
> >
> > versus
> >
> >  git config --global -e
> 
> Just like you get different behavior from:
> 
> git config -l --global
> 
> and
> 
> git config --global -l

Ugh. Personally I consider such interfaces poorly designed. I understand
that the general way "git config" works is to have "git config [options]
[action]". And when "[action]" is a variable name, or a variable name
with a value, it is easy to see what's going on. But when the action
looks like an option, it is just confusing that their ordering is
important.

However, the interface to "git config" is not going to change, so I
think your following existing practice is reasonable here.

_But_ there is one important difference between your "-e" and "-l". In
the "-l" case, we detect that there is extra trailing cruft that will be
ignored and give a usage message.  So "git config -l --global"
complains, but "git config -e --global" silently ignores the second
argument. I think you just need to add

  if (argc != 2)
    usage(git_config_set_usage);

as the "-l" code does.

-Peff
