From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: deprecating more
Date: Fri, 16 Sep 2005 19:50:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161938580.26803@g5.osdl.org>
References: <7vd5n8fqso.fsf@assigned-by-dhcp.cox.net> <7vzmqceayd.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509161856260.26803@g5.osdl.org> <7vr7boe8a8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 04:52:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGSmy-0000ns-Vv
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 04:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVIQCul (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 22:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVIQCul
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 22:50:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750834AbVIQCuk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 22:50:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8H2oaBo003652
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 19:50:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8H2oZEN025956;
	Fri, 16 Sep 2005 19:50:35 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7boe8a8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8752>



On Fri, 16 Sep 2005, Junio C Hamano wrote:
> 
> I'm happy to hear an argument to drop it, but I would like to
> make sure that you do realize that git-whatchanged is not a
> convenient way to truly "export" for later recreation of
> identical repository, due to its indentation and truncation
> behaviour.  Not that *I* think that matters.

Well, the thing is, a true exporter probably doesn't want to use patches 
at all.

A truly good exporter would likely use

	git-diff-tree -M -r

or something to generate the list of filenames and versions, and then work 
on that. You really _have_ to, in order to get things like binary files 
right.

Anything that is based on diffs would suck.

Also, I suspect that to get the list of commits to export, a real exporter
is likely to first just do something like

	git-rev-list --parents --topo-order prev..

and generate the commit topology from there. Then just either use the C
library interfaces to suck in the commit messages, or just use
git-cat-file. And then git-diff-tree -M (or perhaps -C, if the
repo-to-be-exported-to knows about copies) to actually generate the 
revision info.

> What do you think about the other commands I mentioned?

I think they can all go. I think some old scripts migth still use 
git-rev-tree, but it really is clearly inferior in every way to 
git-rev-list that such scripts should be fixed anyway. Fixing them should 
be pretty easy.

(The packed format actually makes git-rev-tree at least ok from a 
performance angle, even if it has to walk all the way to the root. But I 
_seriously_ doube you want to use it on any big repo anyway, and 
definitely not with an unpacked one).

		Linus
