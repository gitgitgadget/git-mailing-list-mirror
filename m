From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Mon, 21 Jul 2008 13:37:34 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 22:38:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL29W-0003FG-Jk
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 22:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbYGUUhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 16:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbYGUUhi
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 16:37:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47982 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750836AbYGUUhh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jul 2008 16:37:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6LKbYls025627
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jul 2008 13:37:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6LKbYLt023063;
	Mon, 21 Jul 2008 13:37:34 -0700
In-Reply-To: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.403 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89401>



On Mon, 21 Jul 2008, Tim Harper wrote:
> 
> Anyone run into this before?  Any idea what might have caused it?  We're a bit
> concerned about this because if we don't know how to avoid this, we no longer
> can feel certain that when something is committed, it will make it out in our
> release.

Read up on '--full-history'.

By default, git simplifies the history for logs that have path 
simplification: only walking down the side of a merge that all the data 
came from (ie the unchanged side). So it only leaves merges around if 
there was changes from _all_ parents.

So without --full-history, if any parent matches the state, it just 
removes the merge and picks that parent that contained all the state. 
Obviously, any changes to that file can be sufficiently explained by 
walking just that limited history, because they must have changed in 
_that_ history too!

That default behaviour leads to a *much* simpler history, and is usually 
what you want - it avoids unnecessary duplication when something was 
changed trivially the same way in both branches - 'git log' will just pick 
the first branch.

So, if you had two (or more) commits that both fixed the same bug in 
different branches, and thus both branches actually ended up with the same 
contents, it does mean that "git log <filename>" will only show _one_ of 
the fixes.

In this case, it apparently showed another version than the one you were 
looking for.

				Linus
