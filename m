From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Thu, 03 May 2007 01:48:26 +0200
Organization: At home
Message-ID: <f1b806$nc7$1@sea.gmane.org>
References: <loom.20070502T111026-882@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 01:48:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjOYo-0006nO-5g
	for gcvg-git@gmane.org; Thu, 03 May 2007 01:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767255AbXEBXsf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 19:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767261AbXEBXsf
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 19:48:35 -0400
Received: from main.gmane.org ([80.91.229.2]:42210 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767255AbXEBXsd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 19:48:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HjOYe-0008OB-7k
	for git@vger.kernel.org; Thu, 03 May 2007 01:48:28 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 May 2007 01:48:28 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 May 2007 01:48:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46054>

Panagiotis Issaris wrote:

> Some of the people of the FFmpeg project are looking at both GIT and Mercurial
> as possible replacements for the current Subversion repository. They have some
> questions regarding the possibility of doing certain things, which I prefer not
> to answer as I am not sure my answer would be correct :) Which is why I am
> posting here...
> 
> The questions are stated in this e-mail [1]. One of the things that are being
> discussed is the following action on a publicly mirrored repository:
> git branch -m master dead_end
> git branch -m last_good master
> 
> I'd think this would fail as people could have pulled from the repository while
> the "dead_end" commit was already available, right?
> 
> There are some other things the FFmpeg maintainer mentions, namely:
> * He wants to be able to revert a commit in some way without "wiping" history.
> That is without committing a patch which reverses the broken commit, as this
> would pollute "git blame". The maintainer sees this as critical feature for
> switching to git as it apparently can be doing using Subversion:
> "in svn we can do this with svn cp from a specific
> revission git and mercurial lack proper copy support"

About removing a commit: assume that you have the following history

  A---B---C---D---E          <---  branch

Now you have noticed that commit C is wrong, and it should not be there.
One solution, which is used usually if the history was published, is to
revert a commit, resulting in the following history:

  A---B---C---D---E---C^-1   <--- branch

(which is what git-revert does).

Now if you didn't publish this history, or you don't care that you are
rewriting history, it is fairly easy to remove commit C (for example
using "git rebase --onto B D E" command), resulting in the following
history:

  A---B---C---D---E
       \
        \
         \----D'--E'          <--- branch

(which after pruning would result in A---B---D'--E' history).

The problem exists _only_ if somebody based his/her work on commit
C or its descendant, i.e. original D, E commits. He/she would have
to rebase his/her work on top of _changed_ (moved) commits D' and E'.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
