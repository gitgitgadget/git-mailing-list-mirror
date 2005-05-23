From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree -z HEAD | git-diff-helper -z fails for me
Date: Mon, 23 May 2005 16:47:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505231644560.2307@ppc970.osdl.org>
References: <20050523090206.GJ23388@cip.informatik.uni-erlangen.de>
 <7vwtpp6goy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505231119570.2307@ppc970.osdl.org>
 <7vpsvh3hp0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 02:11:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaN0K-00065j-U0
	for gcvg-git@gmane.org; Tue, 24 May 2005 02:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVEXABt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 20:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEWX5l
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 19:57:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:28298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261240AbVEWXpN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 19:45:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4NNiwjA030891
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 16:44:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4NNivQn027400;
	Mon, 23 May 2005 16:44:57 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsvh3hp0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Junio C Hamano wrote:
> 
> LT> How about instead making sure that any "extra" text be NUL-terminated and
> LT> never start with ':' after a NUL (which will automatically be true, since
> LT> it's either "diff-tree " + ascii for the verbose case, or just the tree
> LT> name).
> 
> Makes much more sense although it has certain amount of Yuck
> factor ;-).

Actually, your solution is the yucky one.

You didn't realize that your whole DIFF_FORMAT_MACHINE case really can be 
written as just

	printf("%s%c", header, 0);

ie you print the header as _one_ long line, instead of splitting it up 
into many. It's still a perfectly valid line, and perfectly unrecognizable 
as such.

Now, maybe diff-helper is unhappy about such long lines, but that should 
be solvable..

		Linus
