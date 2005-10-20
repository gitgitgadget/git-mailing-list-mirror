From: David Brown <git@davidb.org>
Subject: Re: The git protocol and DoS
Date: Wed, 19 Oct 2005 17:20:41 -0700
Message-ID: <20051020002040.GA30232@old.davidb.org>
References: <4356A5C5.5080905@zytor.com> <20051019222044.GP30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 20 02:21:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESOB8-0008KB-EY
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 02:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVJTAUr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 20:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbVJTAUr
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 20:20:47 -0400
Received: from adsl-64-172-240-129.dsl.sndg02.pacbell.net ([64.172.240.129]:15250
	"EHLO mail.davidb.org") by vger.kernel.org with ESMTP
	id S1750879AbVJTAUq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 20:20:46 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.50 #1 (Debian))
	id 1ESOAj-0007wx-5Y; Wed, 19 Oct 2005 17:20:41 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051019222044.GP30889@pasky.or.cz>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10328>

On Thu, Oct 20, 2005 at 12:20:44AM +0200, Petr Baudis wrote:

>   If (well, it sounds like a good idea, so rather "when") you do this,
> it would be a good idea to do in a way that makes it easy to later add
> support for some kind of authentication (really, not everyone wants to
> give away ssh accounts). Let's say it works like:
> 
> [client]	git-upload-pack <path>
> [server]	challenge somethingnonsensical
> [client]	challenge-response <username>:sha1(somethingnonsensical<password>)
> [server]	All right, the pack goes like this...
> 
>   Suddenly you have support for hopefully secure authentication, and at
> the same time you have the cookie implemented in backwards-compatible
> fashion (in the sense that new client will be able to talk to old
> server) - just assume the username and password empty. This might be
> even hardcoded for now, just leave a room for its addition (in an
> elegant and compatible way) in the protocol, please.

This kind of password authentication has several problems that make it
fairly unpractical.  It is prone to easy dictionary attacks for one thing.
It also for a spoofed server to do replays, and the likes.  It also
requires the server to store plaintext passwords.

There are other, much better, authentication algorithms, but short of doing
signatures, none are really much more secure.  The closest you'll get to
secure remote passwords is SRP <http://srp.stanford.edu/>, which is quite
good, and doesn't even require plaintext passwords to be stored.  It might
just be easier at that point to use signatures, though.

Dave
