From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Support for packs in HTTP
Date: Sun, 10 Jul 2005 20:37:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507102034460.17536@g5.osdl.org>
References: <Pine.LNX.4.21.0507102253270.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 05:38:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Drp7a-00079s-F6
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 05:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVGKDhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 23:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVGKDhX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 23:37:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262210AbVGKDhV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 23:37:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6B3bDjA010630
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Jul 2005 20:37:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6B3bCVY016204;
	Sun, 10 Jul 2005 20:37:12 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507102253270.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 10 Jul 2005, Daniel Barkalow wrote:
> 
> Perhaps git-pack-objects should have the base as a optional argument,
> with a default of the filename in $GIT_DIR/objects/pack and an option
> for sending just the pack file to stdout?

You really _mustn't_ try to create the pack directly to the
$GIT_DIR/objects/pack subdirectory - that would make git itself start
possibly using that pack before the index is all done, and that would be
just wrong and nasty.

So you really should _always_ generate the pack somewhere else, and then 
move it (pack file first, index file second).

Which is, btw, exactly what "git repack" does, so the solution to the 
problem is to just never use git-pack-objects directly if you don't like 
the semantics..

			Linus
