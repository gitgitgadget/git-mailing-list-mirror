From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git log can not show history before rename
Date: Fri, 30 Jan 2009 09:23:38 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901300918010.3150@localhost.localdomain>
References: <1976ea660901300323n384d3650s3bb5a575accb65d1@mail.gmail.com>  <adf1fd3d0901300329y53e46d91xda75799ce1244ddd@mail.gmail.com> <1976ea660901300429i6d9b3594m91222314c284d184@mail.gmail.com>
 <alpine.LFD.2.00.0901300910580.3150@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 18:25:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSx7Z-0001od-Pn
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 18:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbZA3RYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 12:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbZA3RYL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 12:24:11 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57369 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752309AbZA3RYK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 12:24:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0UHNcHN022935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Jan 2009 09:23:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0UHNcgj019215;
	Fri, 30 Jan 2009 09:23:38 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0901300910580.3150@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107856>



On Fri, 30 Jan 2009, Linus Torvalds wrote:
> 
> If somebody wants to do a more intelligent --follow, I can only applaud, 
> but I'm personally not likely to look into it.

Side note: you can probably get a _limited_ form of parent rewriting on 
top of --follow by adding some more hacks. IOW, I think you can make 
--parents --follow work better in practice even with the hacky thing by 
adding some more hacks on top. But you'll never get the _true_ answer (ie 
get things right across renames in different branches) without totally 
ripping out the current --follow logic.

Interestingly, I suspect that doing --follow "right" is really quite 
complicated, but one sign of doing it right would be to allow multiple 
files to be tracked at the same time.

Because in a "correct" implementation of --follow you'd literally have to 
attach different filenames to different commits (rather than have one 
global filename that you follow and then switch for everybody when you see 
a rename), and also have the ability to track multiple files per commit 
when you reach the same commit under two filenames.

I really never wanted the pain, and never cared enough for it, which is 
why --follow is such a hack. It literally was designed as a "SVN noob" 
pleaser, not as a "real git functionality" thing. The idea was that you'd 
get away from the (broken) mindset of thinking that renames matter in the 
big picture.

			Linus
