From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating diff from 2.6.16 from cryptodev-2.6 git tree
Date: Thu, 29 Jun 2006 23:20:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606292316070.12404@g5.osdl.org>
References: <44A47BE0.9060504@logix.cz> <20060630013627.GA27527@gondor.apana.org.au>
 <Pine.LNX.4.64.0606291904250.12404@g5.osdl.org> <20060630023228.GA28850@gondor.apana.org.au>
 <Pine.LNX.4.64.0606291943010.12404@g5.osdl.org> <44A4BA6D.5010006@logix.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 08:21:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwCMi-0002Rw-8K
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 08:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWF3GU3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 02:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWF3GU3
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 02:20:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751154AbWF3GU2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 02:20:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5U6KLnW020912
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Jun 2006 23:20:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5U6KKKU028494;
	Thu, 29 Jun 2006 23:20:21 -0700
To: Michal Ludvig <michal@logix.cz>
In-Reply-To: <44A4BA6D.5010006@logix.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22959>



On Fri, 30 Jun 2006, Michal Ludvig wrote:
>
> Linus Torvalds wrote:
> 
> > 	git log -p --full-diff v2.6.16.. crypto/
> 
> Can I somehow get the result in a reverse order, i.e. oldest commits first?

Not that way, no. "git log" generates the data on-the-fly, so a simple 
"git log" will always give most recent first.

However, you can do this

	git log --pretty=oneline v2.6.16.. crypto/

to generate a list of commits, one per line. Then, reverse that list 
("tac" is your friend), and feed it back to "git-diff-tree --stdin 
--pretty -p" to get the diffs.

So

	git log --pretty=oneline v2.6.16.. crypto/ |
		tac |
		git-diff-tree --stdin --pretty -p

should do what you want.

Of course, the patches (to other files than the crypt/ subdirectory) may 
still clash due to changes that are unrelated to the crypto changes. That 
is unavoidable, and you'll just have to fix that up by hand.

			Linus
