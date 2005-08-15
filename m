From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: symlinked directories in refs are now unreachable
Date: Sun, 14 Aug 2005 20:12:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508142007440.3553@g5.osdl.org>
References: <1124073677.27393.15.camel@della.draisey.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 05:13:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4VOq-0006xR-96
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 05:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbVHODM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 23:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbVHODM1
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 23:12:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932649AbVHODM0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 23:12:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7F3COjA017678
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 Aug 2005 20:12:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7F3CMRT030610;
	Sun, 14 Aug 2005 20:12:23 -0700
To: Matt Draisey <mattdraisey@sympatico.ca>
In-Reply-To: <1124073677.27393.15.camel@della.draisey.ca>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 15 Aug 2005, Matt Draisey wrote:
>
> The behaviour of the symlinked in ref directories has changed from
> earlier versions of git.

Hmm.. There used to be a mix of lstat() (in receive-pack) and stat() (in 
fsck-cache.c, and it got standardized in one function which used lstat.

The reason for the lstat is really to try to avoid having especially the 
remote protocols follow symlinks, but I guess it's not a very good reason, 
so I don't think it would be wrong to just standardize refs.c to use 
"stat()" instead.

You might sent a patch to Junio..

HOWEVER: symlinks for references really are pretty dangerous. We do things 
like "echo new-id > .git/HEAD" and links (symlinks _or_ hardlinks) thus 
really aren't safe. You're much better off copying those small files.

		Linus
