From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Locking the repository
Date: Fri, 6 May 2005 09:15:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505060913460.2233@ppc970.osdl.org>
References: <20050506123122.GF11506@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 18:07:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5Lv-00013G-FC
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVEFQNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVEFQNp
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:13:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:47258 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261186AbVEFQNo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 12:13:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j46GDdU3032446
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 09:13:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j46GDcpB016180;
	Fri, 6 May 2005 09:13:38 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050506123122.GF11506@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 6 May 2005, Thomas Glanzmann wrote:
>
> I need a way to lock a repository for certain actions.

Nope - if you want to serialize something, you'll need to write your own 
serialization scripts. git doesn't care, because all the git operations 
should be totally lockless already. There just isn't any reason to lock as 
far as git is concerned, since the objects are immutable.

The only exception is the "index" file, where we don't want concurrect 
index updates. So that is handled by writers creating the new "index.lock" 
file first, and then when they are done, they rename it to "index".

		Linus
