From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Sun, 27 Nov 2005 17:46:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511271742520.13959@g5.osdl.org>
References: <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy83cdu7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
 <7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net> <7vpson4tqi.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511260855560.13959@g5.osdl.org> <7vr792fnta.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511270949540.13959@g5.osdl.org> <20051127182244.GK22159@pasky.or.cz>
 <Pine.LNX.4.64.0511271049090.13959@g5.osdl.org> <7vveyd37ic.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 28 02:47:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgY6U-0005qZ-Pp
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 02:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVK1Bqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 20:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVK1Bqq
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 20:46:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751212AbVK1Bqp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 20:46:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAS1kYnO008622
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 27 Nov 2005 17:46:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAS1kXgq010075;
	Sun, 27 Nov 2005 17:46:34 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vveyd37ic.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12843>



On Sun, 27 Nov 2005, Junio C Hamano wrote:
> 
> Without pathspec, ls-tree is a pretty-printing version of
> "git-cat-file tree", and that is how the command is used by the
> git browsers like gitweb.  I have never looked at qgit source,
> but I'd be surprised if it did not depend on the single-level
> behaviour of ls-tree for that purpose.

You're right, we need to keep the "-r" behaviour. 

> Having said all of the above, I do understand why we would
> _also_ want the behaviour parallel to ls-files, not /bin/ls
> behaviour.  Maybe we should have both?  Either rename the
> current ls-tree to browse-tree, and make the one that parallels
> ls-files the new ls-tree?

If you take my last patch and make "ls_flags" default to 0 again, it 
should work correctly.

The way to traverse into directories (a la qgit/webgit) is to just give 
the SHA1 name of the directory. Ie

	git-ls-tree HEAD

gives us a single level, we see:

	...
	040000 tree b2d1264f85148d18c5ae9864d73d65737b0a1734    t
	...

and then we can just do

	git-ls-tree b2d1264f85148d18c5ae9864d73d65737b0a1734

to get that level. I assume that that is what qgit/webgit already does (I 
sure hope so, otherwise they're just wasting time, making the tools 
re-parse the trees over and over again for no gain).

			Linus
