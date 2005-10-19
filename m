From: Petr Baudis <pasky@suse.cz>
Subject: Re: The git protocol and DoS
Date: Thu, 20 Oct 2005 00:20:44 +0200
Message-ID: <20051019222044.GP30889@pasky.or.cz>
References: <4356A5C5.5080905@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 20 00:23:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESMIm-0001H5-Dh
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 00:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbVJSWUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 18:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbVJSWUs
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 18:20:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64747 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751603AbVJSWUr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 18:20:47 -0400
Received: (qmail 8280 invoked by uid 2001); 20 Oct 2005 00:20:44 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <4356A5C5.5080905@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10319>

Dear diary, on Wed, Oct 19, 2005 at 10:00:05PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> One way to do this would be to start the transaction by having the 
> server transmit a cookie to the client, and to require the client to 
> send a SHA1 of the (cookie + request) together with the request.  This 
> would be done with a fairly short timeout.

  If (well, it sounds like a good idea, so rather "when") you do this,
it would be a good idea to do in a way that makes it easy to later add
support for some kind of authentication (really, not everyone wants to
give away ssh accounts). Let's say it works like:

[client]	git-upload-pack <path>
[server]	challenge somethingnonsensical
[client]	challenge-response <username>:sha1(somethingnonsensical<password>)
[server]	All right, the pack goes like this...

  Suddenly you have support for hopefully secure authentication, and at
the same time you have the cookie implemented in backwards-compatible
fashion (in the sense that new client will be able to talk to old
server) - just assume the username and password empty. This might be
even hardcoded for now, just leave a room for its addition (in an
elegant and compatible way) in the protocol, please.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
