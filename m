From: Andrew Cameron <andrew@worksmartlabs.com>
Subject: Re: git checkout running very slowly (>12s)
Date: Wed, 15 Jun 2011 23:16:03 +0000 (UTC)
Message-ID: <loom.20110616T010709-333@post.gmane.org>
References: <loom.20110615T213016-856@post.gmane.org> <4DF9363F.6080009@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 01:16:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWzJv-000224-6Q
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 01:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab1FOXQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 19:16:18 -0400
Received: from lo.gmane.org ([80.91.229.12]:57040 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab1FOXQR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 19:16:17 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QWzJn-0001zc-Hk
	for git@vger.kernel.org; Thu, 16 Jun 2011 01:16:15 +0200
Received: from rrcs-208-105-82-160.nyc.biz.rr.com ([208.105.82.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 01:16:15 +0200
Received: from andrew by rrcs-208-105-82-160.nyc.biz.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 01:16:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 208.105.82.160 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.91 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175868>

Andreas Ericsson <ae <at> op5.se> writes:

> 
> On 06/15/2011 09:30 PM, Andrew Cameron wrote:
> > Some git operations (notably checkouts) are taking a very long time to 
execute.
> > Here is a shell session which illustrates the problem.
> > 
> > $ time git branch foo
> > git branch foo  0.01s user 0.00s system 77% cpu 0.016 total
> 
> Creating a branch is just a matter of creating a new ref. In this
> case, you're doing it on the currently checked out ref. That's a
> constant-time operation that is always very quick.
> 
> > $ time git checkout foo
> > Switched to branch 'foo'
> > git checkout foo  11.73s user 0.18s system 99% cpu 11.937 total
> 
> If this sequence of commands is accurate, that's a bit weird. If
> you've got another branch checked out first and then switch it
> would be understandable, considering the size of the repository.
> We should probably still do a tree-by-tree comparison to see
> which files are changed though, but I thought that's already
> done to avoid superfluous work and allow worktree changes to
> carry over to other branches. What version of git are you using?

I suppose I forgot to illustrate that, when I created "foo" I was on "master".  
The order branch checkouts was master -> foo -> master, and both transitions 
took ~12s despite pointing to the same commit and using a clean working tree.  I 
imagine you inferred all of that, but if not, now you know.

$ git --version
git version 1.7.0.4

> > $ time git checkout master
> > Switched to branch 'master'
> > git checkout master  11.62s user 0.18s system 99% cpu 11.813 total
> > $ git count-objects -v
> > count: 953
> > size: 527012
> > in-pack: 153432
> > packs: 7
> > size-pack: 1986072
> > prune-packable: 0
> > garbage: 0
> > 
> 
> These figures are nowhere near as interesting as those from
>   git ls-files | wc -l
> after the checkout is completed.
> 

$ git checkout master
Switched to branch 'master'
$ git ls-files | wc -l
90831
