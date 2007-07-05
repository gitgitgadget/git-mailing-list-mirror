From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Embedded Linux development with GIT
Date: Thu, 05 Jul 2007 09:10:35 +0200
Organization: eudaptics software gmbh
Message-ID: <468C996B.7FEFEB29@eudaptics.com>
References: <a2e879e50707042250w22fe570cp4dda316e6b0f4cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 09:10:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6LTo-00049h-AC
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 09:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904AbXGEHKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 03:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756838AbXGEHKO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 03:10:14 -0400
Received: from main.gmane.org ([80.91.229.2]:46679 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756563AbXGEHKN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 03:10:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I6LTb-0000we-Rm
	for git@vger.kernel.org; Thu, 05 Jul 2007 09:10:07 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Jul 2007 09:10:07 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Jul 2007 09:10:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51661>

Sean Kelley wrote:
> 
> Hi,
> 
> I have a situation where we have a local GIT repository that is based
> on v2.6.17.  We initially added the source tarball to an empty
> repository and then started applying changes to it.  Looking back,
> that might not have been the best idea 400 commits later.
> 
> My goal is to eventually bring our repository closer to mainline
> revisions so as to make it easier to actually contribute back to the
> community.  So how can I fix my repository so as to give it visibility
> to Linus' kernel?
> 
> Here is my initial thoughts:
> 
> 1) Clone kernel.org kernel and it is Master
> 2) Create a local Head based on 2.6.17 and call it Local
> 3) Pull my existing heavily patched repository into the Local branch and merge
> 
> Is it possible then to see our 400 odd commits then in the Local
> branch on top of 2.6.17 so that we can see not only our history but
> also the history that came before?  Then as Master advances we can see
> about backporting and bringing our code close enough to mainline
> kernel to actually be able to contribute back to the community and
> submit patches.  Is this realistic approach.  I am unsure of the GIT
> commands that I need to do this?

That is possible using a graft:

  $ echo "$x $(git rev-parse v2.6.17^0)" >> .git/info/grafts

where $x is the SHA1 of the first commit you made on top of the imported
tarball. This way you have spliced your history with Linus's history.
(This is a strictly _local_ matter! Every clone of your history must
repeat the game!)

Now, Linus will not be able to pull from your faked history because he
doesn't know about the graft. In order to fix that, you can run
git-filter-branch from current git's master branch to rewrite your
history:

  $ git filter-branch new-master v2.6.17..master

Read the man page of git-filter-branch, and understand the implications
before you publish the result.

-- Hannes
