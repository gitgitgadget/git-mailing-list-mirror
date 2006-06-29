From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: rebasing trouble
Date: Thu, 29 Jun 2006 17:57:25 -0400
Message-ID: <20060629215725.GI14287@fieldses.org>
References: <20060629194723.GD14287@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 29 23:58:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4X5-00048b-Q7
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963AbWF2V5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbWF2V5b
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:57:31 -0400
Received: from mail.fieldses.org ([66.93.2.214]:12728 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932903AbWF2V51
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 17:57:27 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1Fw4Vp-0001AJ-Qj
	for git@vger.kernel.org; Thu, 29 Jun 2006 17:57:25 -0400
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060629194723.GD14287@fieldses.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22916>

On Thu, Jun 29, 2006 at 03:47:23PM -0400, J. Bruce Fields wrote:
> I must be missing something obvious:
> 
> bfields@puzzle:linux-2.6$ git checkout -b TMP nfs-client-stable^^^
> bfields@puzzle:linux-2.6$ git-describe
> v2.6.17-rc6-g28df955
> bfields@puzzle:linux-2.6$ git-rebase --onto v2.6.17 origin
> Nothing to do.
> bfields@puzzle:linux-2.6$ git-describe
> v2.6.17
> 
> So the git-rebase just reset TMP to v2.6.17.  But I know that nfs-client-stable
> isn't a subset of origin, so this doesn't make sense to me.

Oops, sorry, I lied; nfs-client-stable *is* a subset of origin, since Linus
merged it.

But it *isn't* a subset of v2.6.17.

So the semantics of git-rebase just aren't quite what I expected.  It first
removes anything that isn't in the given upstream branch, *then* rebases to the
commit given after --onto.  Which may mean it throws out some stuff that is in
the upstream branch even though it isn't yet included as of the given commit.

So what I really meant to do was just

	git-rebase v2.6.17

And rereading the man page, I see that git-rebase was working exactly as
advertised.  So I'm an idiot.  In my defense, it is a little confusing: none of
the examples in the man page that use --onto actually need it, and the
"upstream" argument probably should be described as a commit or something
instead of a branch.

(What is --onto actually useful for?)

--b.
