From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Change git-cvsimport to handle slashes in CVS tags
Date: Fri, 28 Oct 2005 12:10:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510281151450.4664@g5.osdl.org>
References: <59a6e5830510281146s7b25da76l8bf97287522b89f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 28 21:11:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVZco-0007BT-9e
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 21:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbVJ1TKq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 15:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbVJ1TKq
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 15:10:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751661AbVJ1TKp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2005 15:10:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9SJAYFC026907
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Oct 2005 12:10:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9SJAU9g013174;
	Fri, 28 Oct 2005 12:10:32 -0700
To: Wayne Scott <wsc9tt@gmail.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <59a6e5830510281146s7b25da76l8bf97287522b89f2@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10772>


Hmm.. git can certainly handle slashes in tags, but you'd need to 
basically "mkdir" the path up to there before creating them. 

That's probably not the right thing to do for a tag that comes from the 
outside, since in git, the slashes work like in a filesystem, and should 
imply grouping (ie you might have a family of tags that is named by 
usage, and be called something like "release/xyz" or whatever).

Is "_" the right thing to replace it with, though? To me, "_" replaces 
either a space or a dash, while a slash could be replaced by something 
more like a special character.

Maybe it's just me, but your example "dev-stubs-merge-8-1-3/9/99" might
look nicer either of these ways:

 - dev-stubs-merge-8-1-3|9|99 (but "|" is hard to use with shell)
 - dev-stubs-merge-8-1-3.9.99 (CVS tags can't contain '.', right?)
 - dev-stubs-merge-8-1-3:9:99 (confuse with time?)
 - dev-stubs-merge-8-1-3+9+99 (one arithmetic op replaced by another)
 - dev-stubs-merge-8-1-3#9#99 (that's pretty ugly)
 - dev-stubs-merge-8-1-3?9?99 (Wayne might be right after all)
 - dev-stubs-merge-8-1-3_9_99 (maybe Wayne _is_ right?)

I dunno. But maybe we do want the option of just keeping it as a slash, 
and teach git-cvsimport to create the proper subdirectory prefixes.

I have no idea how to do that in perl, though. Right now it just does

	open(C,">$git_dir/refs/tags/$xtag")

how would you do "create file with all path components"?

		Linus
