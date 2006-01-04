From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Strange unable to unlink error with git-prune-packed
Date: Wed, 4 Jan 2006 08:34:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601040828590.3668@g5.osdl.org>
References: <46a038f90601032046l31f51742k93f3f9f5a826bef1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 04 17:34:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuBam-00076l-Qs
	for gcvg-git@gmane.org; Wed, 04 Jan 2006 17:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWADQeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jan 2006 11:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWADQeY
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jan 2006 11:34:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751252AbWADQeX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2006 11:34:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k04GYJDZ010146
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 Jan 2006 08:34:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k04GYIxK003502;
	Wed, 4 Jan 2006 08:34:18 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601032046l31f51742k93f3f9f5a826bef1@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.58__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14178>



On Wed, 4 Jan 2006, Martin Langhoff wrote:
> 
> When I invoke git-prune-packed I am greeted by (3-line sample):
> 
> error: unable to unlink .git/objects/43/2251e8488dc3c72d94d698ed69003137c47244
> error: unable to unlink .git/objects/43/6bc8b274ab96944a6f8c3cf5e3fbeef422042b
> error: unable to unlink .git/objects/43/fe47e9508289ad4eca71613a9f20d7f3323602

Does it happen for all your files? All your repositories? Or just one 
repo? Or just one subdirectory in that repo?

The code is _literally_ just doing a

	if (unlink(pathname) < 0)
		error("unable to unlink %s", pathname);

but maybe you could just make it print out the reason too. So add a "(%s)" 
and a "strerror(errno)" to that error line..

> $ ls -la .git/objects/43
> total 24
> drwxr-xr-x    5 martin  martin   170  4 Jan 17:37 .

I don't see why you couldn't unlink those files. Maybe it's some strange 
HFS issue and you can't just unlink() things that have attributes or 
something? Maybe some crazy file manager has added a default icon 
attribute to your files if you happened to look at the .git objects 
directory?

		Linus
