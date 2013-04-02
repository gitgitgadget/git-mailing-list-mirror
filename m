From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: git https transport and wrong password
Date: Tue, 2 Apr 2013 23:20:54 +0300
Message-ID: <20130402202054.GX30514@lakka.kapsi.fi>
References: <20130402155440.GT30514@lakka.kapsi.fi>
 <20130402192845.GC17784@sigill.intra.peff.net>
 <20130402194751.GV30514@lakka.kapsi.fi>
 <20130402200551.GA535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:21:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7ht-0007vA-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933201Ab3DBUU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:20:57 -0400
Received: from mail.kapsi.fi ([217.30.184.167]:43431 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593Ab3DBUU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:20:56 -0400
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UN7hO-0007ge-D5; Tue, 02 Apr 2013 23:20:54 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UN7hO-0003mC-Al; Tue, 02 Apr 2013 23:20:54 +0300
Content-Disposition: inline
In-Reply-To: <20130402200551.GA535@sigill.intra.peff.net>
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mikko.rapeli@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219878>

On Tue, Apr 02, 2013 at 04:05:51PM -0400, Jeff King wrote:
> On Tue, Apr 02, 2013 at 10:47:51PM +0300, Mikko Rapeli wrote:
> 
> > Don't know anything about curl but maybe git could parse the url for a
> > username and prompt for the password before the first 401 failure roundtrip
> > that's now in place. I guess most of this logic is in http.c.
> 
> We used to do that but stopped, as curl might also be able to retrieve
> the password from .netrc; the extra prompt was an annoyance to users
> in this situation.

Ok, I think I've seen this before and ended up storing passwords in .netrc.

> Now that we have the credential subsystem, I would recommend dropping
> usernames from all git-over-http URLs, and either:
> 
>   1. Using a credential helper that supports secure long-term storage
>      (osxkeychain, wincred, etc).
> 
>   2. Specifying the username to the credential subsystem explicitly, by
>      putting something like:
> 
>        [credential "https://yourhost/"]
>               username = yourusername
> 
>      in your git config.
> 
> Obviously (1) is nicer, but you may have corporate policies against
> storing credentials. Or you may have a complicated single sign-on
> procedure, where the password changes. In that case, I would still say
> it is worth writing a custom helper script that can feed the temporary
> credential to git.

Thanks, I'll have a look at these helpers. Policies we may have but in
practice I think many just store plaintext passwords in giturls, which
is obviously the worst case, but it works against accidental typos in
the password prompt (though blows up when the mandatory password change
comes along).

-Mikko
