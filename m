From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [bug?] git-format-patch produces a 0-byte long patch for the
 first commit
Date: Mon, 23 Mar 2009 17:46:46 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0903231732150.6370@axis700.grange>
References: <Pine.LNX.4.64.0903231119110.4871@axis700.grange>
 <200903231729.08216.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 23 17:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlnJt-0007Os-9p
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 17:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213AbZCWQqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 12:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753536AbZCWQqg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 12:46:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:43080 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755213AbZCWQqf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 12:46:35 -0400
Received: (qmail invoked by alias); 23 Mar 2009 16:46:31 -0000
Received: from p57BD2C84.dip0.t-ipconnect.de (EHLO axis700.grange) [87.189.44.132]
  by mail.gmx.net (mp053) with SMTP; 23 Mar 2009 17:46:31 +0100
X-Authenticated: #20450766
X-Provags-ID: V01U2FsdGVkX1/BZEp0MlvBPLeq6AB1l9TIEm+QeXu1NNYtMYZ0GJ
	8EgYxk8f+sb9uI
Received: from lyakh (helo=localhost)
	by axis700.grange with local-esmtp (Exim 4.63)
	(envelope-from <g.liakhovetski@gmx.de>)
	id 1LlnIU-00028Q-A3; Mon, 23 Mar 2009 17:46:46 +0100
In-Reply-To: <200903231729.08216.trast@student.ethz.ch>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114335>

On Mon, 23 Mar 2009, Thomas Rast wrote:

> Guennadi Liakhovetski wrote:
> > mkdir x
> > cd x
> > git-init
> > echo hi > greating
> > git-commit -a
> [...]
> > git-format-patch HEAD^ produces an error, 
> 
> There is no HEAD^ in this case.  HEAD is always the currently checked
> out commit.  Since it has a root commit, it has no parent, so you
> cannot apply ^ ("the first parent of") to it.  Similarly, HEAD~2 will
> not work if HEAD~1 has no parent, etc.

Yes, I can understand this, still from the high-level PoV, this looks 
inconsistent:

git-format-patch HEAD

never produces anything, which means for me, I'm trying to extract commits 
for a 0-length range.

git-format-patch HEAD^

Usually produces the "current" or the "last" commit - except if you're 
currently on the first commit... But I'm not insisting on this one - maybe 
you're right, it just _does_ look weird.

Just try to forget about the meaning of the command. You are somewhere on 
the commit timeline. You enter "some" command, which usually produces 
exactly one - the most recent commit. So, I would expect this to work 
always when there is at least one commit in the tree.

So, maybe it would make sense to refer to the point before-the-root-commit 
every time root's parent is requested?

> > git-format-patch -1 produces a 0-byte long patch.
> 
> That is admittedly weird and probably deserves a fix and/or suggestion
> to use --root.
> 
> I'm not sure what else I can add to the explanations I gave on IRC.

Thanks for answering again, I just wanted to make sure this "weirdness" 
doesn't get lost, and possibly gets fixed. I think, you suggested yourself 
to post to the list, so I did.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
