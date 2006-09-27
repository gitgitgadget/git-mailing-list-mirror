From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 16:14:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609271606050.3952@g5.osdl.org>
References: <20060927222854.82278.qmail@web51014.mail.yahoo.com>
 <Pine.LNX.4.64.0609271545140.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 01:14:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSiby-0001BF-5A
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 01:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031234AbWI0XOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 19:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031235AbWI0XOi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 19:14:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47551 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031234AbWI0XOg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 19:14:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8RNEPnW004018
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Sep 2006 16:14:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8RNEO3o021000;
	Wed, 27 Sep 2006 16:14:25 -0700
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <Pine.LNX.4.64.0609271545140.3952@g5.osdl.org>
X-Spam-Status: No, hits=-0.466 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27945>



On Wed, 27 Sep 2006, Linus Torvalds wrote:
> 
> No, it's actually much deeper than that.
> 
> To git, pure replication simply isn't an action at all, so trying to track 
> it would be like trying to track all the voices in my head - something 
> that doesn't exist. It wouldn't be "truth", it would be insanity.

Another reason it's not an action at all: git in many ways does not 
actually care at all about the difference of a "local branch" and a 
"remote branch on another host".

Of course there _is_ a difference, in that the remote branch has to be 
fetched from that other repository, but it's possible (and some of the 
original design came from this) to share the repository data between 
multiple separate repositories. They can even be on different machines, if 
there is a networked filesystem in between (and, unlike most systems, the 
git database format should even be happy about _disconnected_ networked 
filesystems).

So git from the ground up is designed so that there is no real difference 
between "remote branch" and "local branch", other than simply physically 
where the data might be.

By that token, "cloning" a repository is pretty much by definition a 
no-op as far as the repository contents is concerned. In fact, if you use 
"git clone -l -s", all the cost is just checking out the new copy (so if 
you add "-n" to avoid checking out the new state, you basically have a 
zero-cost clone).

	[torvalds@g5 ~]$ time git clone -n -l -s v2.6/linux empty-clone

	real    0m0.129s
	user    0m0.084s
	sys     0m0.048s

That's it. I created a "clone" of the whole kernel repo in 0.129 seconds.

Exactly because cloning doesn't actually _do_ something (of course, 0.129 
seconds in git speak is pretty slow, so I suspect we are doing something 
stupid here with shell-script).

		Linus
