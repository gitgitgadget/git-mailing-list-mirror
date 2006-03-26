From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 08:33:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603260829550.15714@g5.osdl.org>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
 <44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz>
 <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <20060326100717.GD18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 18:33:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNYBH-0001D0-UT
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 18:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWCZQd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 11:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWCZQd3
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 11:33:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751452AbWCZQd2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 11:33:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2QGXEDZ024044
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Mar 2006 08:33:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2QGXEw0010404;
	Sun, 26 Mar 2006 08:33:14 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060326100717.GD18185@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18044>



On Sun, 26 Mar 2006, Petr Baudis wrote:
> 
> Huh? I don't see that now (and caps don't help me see it better). That's
> certainly not what is in [1], and I don't see _how_ to detect the
> renames in this case, and what would I be actually doing git-ls-tree for
> when I've already detected the rename. Based on [1], I'd be doing
> git-ls-tree merely to detect that a file _disappeared_ in the first
> place, I have to do other stuff to detect the renames themselves.

No, the point is that "git-rev-list" already does all of [1] in the core.

If you do

	git-rev-list --parents --remove-empty $REV -- $filename

then you'll get the whole history for that filename. When it ends, you 
know the file went away, and then you do basically _one_ "where the hell 
did it go" thing.

And yes, it's not git-ls-tree (unless you only want to follow pure 
renames), it's actually one "git-diff-tree -M $lastrev". Then you just 
continue with the new filename (and do another "git-rev-list" until you 
hit the next rename).

		Linus
