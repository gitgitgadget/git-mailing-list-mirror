From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Careful object writing..
Date: Tue, 3 May 2005 16:22:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031618360.26698@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
 <81b0412b05050316045fa31c2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 01:15:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT6bh-0005Vw-Pa
	for gcvg-git@gmane.org; Wed, 04 May 2005 01:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVECXVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 19:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVECXVH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 19:21:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:58826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261911AbVECXUy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 19:20:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43NKks4031144
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 16:20:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43NKiGi024639;
	Tue, 3 May 2005 16:20:45 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b05050316045fa31c2a@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 4 May 2005, Alex Riesen wrote:
>
> On 5/3/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > I also change the permission to 0444 before it gets its final name.
> 
> Maybe umask it first? Just in case.

I considered it, but it's not worth it.

If you don't want somebody else to see your objects, you should just 
disable execute permission on your .git directory. "umask" is actually a 
fairly nasty interface, since it takes effect on create(), and we do want 
to fchmod _after_ the create (some filesystems don't like it when you 
create a non-writable object and then write to it, but more importantly, 
since we use "mkstemp()" for the temp-file handling, we don't even have 
control of the initial umask.

So to make it (0444 & umask) git would actually have to jump through silly
hoops. Without actually buying you anything new, since the access
permissions for git objects really are about the _directory_ anyway.

		Linus
