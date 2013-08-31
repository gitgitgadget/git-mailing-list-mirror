From: Jeff King <peff@peff.net>
Subject: Re: Authentication with e-mail address as user name for HTTPS remote
Date: Sat, 31 Aug 2013 04:09:46 -0400
Message-ID: <20130831080946.GB21744@sigill.intra.peff.net>
References: <CADZGgi9-nLpcaHQOevBnY9HZtkLD6Zn=gCZq8u5yefPV7gYaTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Patrick Atoon <patrick.atoon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 10:10:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFgFt-0003o4-Rs
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 10:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597Ab3HaIJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 04:09:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:53703 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745Ab3HaIJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 04:09:49 -0400
Received: (qmail 16097 invoked by uid 102); 31 Aug 2013 08:09:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 31 Aug 2013 03:09:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Aug 2013 04:09:46 -0400
Content-Disposition: inline
In-Reply-To: <CADZGgi9-nLpcaHQOevBnY9HZtkLD6Zn=gCZq8u5yefPV7gYaTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233509>

On Sat, Aug 31, 2013 at 08:52:06AM +0200, Patrick Atoon wrote:

> Here is what happens. First try cloning without specifying the user name:
> 
> ---8<-------------------------------------------------------
> $ git clone https://git.server.com/git/test.git
> Initialized empty Git repository in /tmp/git/test/.git/
> error: The requested URL returned error: 401 Authorization Required
> while accessing
> https://git.server.com/git/test.git/nfo/refs
> 
> fatal: HTTP request failed

That should be prompting you. What version of git are you using?

> I couldn't find a "--username" flag or something similar for the git
> command, so my next try was to incorporate the user name in the URL,
> basic auth style.

Yes, that's the correct way to do it from the command line.

If you are running v1.7.9 and later, you can also put this in your
config:

  [credential "https://git.server.com"]
    username = user.email@emaildomain.com

to automatically use that username for the particular domain.

> https://user.email@emaildomain.com@git.server.com/git/test.git
> 
> Note the double "@" there, it is bound to cause trouble.

Yes. You probably want to escape it like:

  https://user.email%40emaildomain.com@git.server.com/git/test.git

In theory we could parse from the right-hand side of the hostname and
realize that only the right-most "@" is the username separator (under
the assumption that hostnames can never contain an "@"). I don't know if
that would violate the standard or not. However, it is not even git that
does the actual parsing in this case, but rather libcurl.

-Peff
