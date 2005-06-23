From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 08:29:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506230822370.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
 <42B9FF3A.4010700@pobox.com> <Pine.LNX.4.58.0506221850030.11175@ppc970.osdl.org>
 <42BA5F6F.9090406@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 17:23:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlTWE-00029e-Ff
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 17:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVFWP1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 11:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVFWP1T
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 11:27:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262563AbVFWP1K (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 11:27:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5NFR2jA004401
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Jun 2005 08:27:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5NFR106024962;
	Thu, 23 Jun 2005 08:27:01 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BA5F6F.9090406@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 23 Jun 2005, Jeff Garzik wrote:
>
> Linus Torvalds wrote:
> > (Of course, since the rsync protocol doesn't know anything about git
> > consistency, if the mirroring is half-way, you'll end up with something
> > less than wonderful, and confusing. Details, details)
> 
> Would it make sense to add an fsck step to git-clone-script?

Well, it's going to be slow. Of course, it's not as slow as pulling the 
stuff over a DSL line or whatever, but still..

I think I need to make something that just verifies the top <n> commits or
whatever - I need that for "pull" anyway, so that you can do a 

	git fsck ORIG_HEAD..

and it will fsck only the new stuff that arrived as a result of the pull.

And we need to improve the git-ssh-pull/git-http-pull scripts so that they
do pipelined requests: right now it's usually a lot faster to do "rsync"  
than it is to do git-ssh-pull (unless you do a small pull), because even
though the rsync ends up needing to compare the full directory contents,
it then transfers the data much faster.

		Linus
