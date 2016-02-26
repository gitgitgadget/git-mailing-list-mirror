From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git clone does not respect command line options
Date: Fri, 26 Feb 2016 02:34:44 -0500
Message-ID: <20160226073444.GA26340@sigill.intra.peff.net>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
 <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 08:34:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZCvL-000525-V4
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 08:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbcBZHer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 02:34:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:49858 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750935AbcBZHer (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 02:34:47 -0500
Received: (qmail 26424 invoked by uid 102); 26 Feb 2016 07:34:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 02:34:47 -0500
Received: (qmail 32264 invoked by uid 107); 26 Feb 2016 07:34:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 02:34:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 02:34:44 -0500
Content-Disposition: inline
In-Reply-To: <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287542>

On Fri, Feb 26, 2016 at 12:17:49PM +0530, Guilherme wrote:

> I'm trying to use git in an integration test and i'm having trouble
> with configuration options.
> 
> On windows developer machines we use wincred as our credenital helper
> and thus have it set in ~/.gitconfig
> 
> For the integration test that is no use as it will make testing
> unauthorized logging in impossible.
> 
> Since there is no way of disabling configuration options on the
> command line i tried setting it to store with a file I could delete.
> So in front of every command we insert `-c credential.helper="store
> --file=creds.txt"`. In the end the command line looks like:
> 
> git -c credential.helper="store --file=creds.txt" clone
> http://admin:admin@oururl@20000/TestRepo.git
> 
> I see the file creds.txt being created containing only
> http://admin:admin@oururl@20000/TestRepo.git but the credenital at the
> same time appears in the windows credential store.
> 
> Can anybody else confirm this?

That's behaving as expected. Unfortunately, you cannot currently do what
you want easily; there is no way to "unset" a multi-valued config
variable (like credential.helper) with a later one. Git will ask both
configured helpers for the password, and will store a successful result
in both.

The simplest way I can think of to work around it is to point your $HOME
elsewhere[1] during the integration test, so that it does not read your
regular ~/gitconfig.

-Peff

[1] Actually, that is what I would do on a Unix system. I have no idea
    how the home directory is determined on Windows.
