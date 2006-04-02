From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Solaris cloning woes partly diagnosed
Date: Sun, 2 Apr 2006 12:22:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021218490.3050@g5.osdl.org>
References: <29336.1144005022@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 21:22:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ89I-0003iv-2H
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 21:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWDBTWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 15:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWDBTWE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 15:22:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751479AbWDBTWD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 15:22:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k32JM2EX015682
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 12:22:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k32JM1Wq019483;
	Sun, 2 Apr 2006 12:22:01 -0700
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <29336.1144005022@lotus.CS.Berkeley.EDU>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18279>



On Sun, 2 Apr 2006, Jason Riedy wrote:

> And Linus Torvalds writes:
>  - 
>  - I'd be willing to bet that it's the fact that we take signals.
> 
> Unfortunately, I'm too busy to check into this, but I've
> run into similar problems in the past.  Just takes a busy 
> file server.
> 
>  - We do, for example, expect that regular file writing not do that. At least 
>  - "write_sha1_from_fd()" will just do a "write()" without testing the error 
>  - return, [...]
> 
> There is an xwrite in git-compat-util.h...

Well, git itself is actually fairly good about these things. Right now I'm 
seriously suspecting Solaris stdio as being just horribly impolite.

git tends to not just use xwrite() in most places, but check the return 
value for partial sizes etc. I tried to grep for places where we were 
lazy, and there really seems to be just a very small handful, and they 
shouldn't impact this case at all (you have to have a seriously broken 
setup for them to matter, but we should fix them nonetheless.

		Linus
