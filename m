From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Wed, 25 Jul 2007 02:09:46 +0200
Organization: At home
Message-ID: <f864c6$bg5$1@sea.gmane.org>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site> <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222223460.14781@racer.site> <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222255010.14781@racer.site> <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org> <7v1wezohi4.fsf@assigned-by-dhcp.cox.net> <46A5B5F5.6000202@trolltech.com> <Pine.LNX.4.64.0707241002410.14781@racer.site> <7vd4yigmla.fsf@assigned-by-dhcp.cox.net> <46A5DF1F.2030307@trolltech.com> <Pine.LNX.4.64.0707241252040.28577@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 02:10:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDUS1-0003mM-17
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 02:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889AbXGYAJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 20:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757467AbXGYAJ6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 20:09:58 -0400
Received: from main.gmane.org ([80.91.229.2]:43822 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757837AbXGYAJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 20:09:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IDURq-0006zv-I2
	for git@vger.kernel.org; Wed, 25 Jul 2007 02:09:50 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 02:09:50 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 02:09:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53662>

Julian Phillips wrote:

> On Tue, 24 Jul 2007, Marius Storm-Olsen wrote:
> 
>>>  I do not know this is an appropriate itch to scratch for a Windows
>>>  developer to begin with.  The new-workdir setting *is* about
>>>  symlinked .git/ metainfo space.  If somebody wants to work on a
>>>  filesystem without symlink, he should not be using new-workdir but
>>>  something else.  E.g. GIT_DIR + GIT_WORK_TREE, or perhaps GIT_DIR +
>>>  core.worktree comes to mind.
>>
>> That's is definitely an option, though it seems to me that its more like 
>> giving up than a finding a proper solution. In any case, it would result in 
>> two completely different workflows on systems with and without symlink 
>> support. I work on both, and would like my workflow to be consistent. Of 
>> course I could easily add my own scripts on top to achieve this, but then 
>> we're going back into h4x0r land and not making Git more 'available'.
>>
>> The new-workdir feature doesn't *have* to be about symlinked .git/ metainfo 
>> space, but could also be about symref'ed .git/ metainfo.
>> (A discussion was done in 2005s "Getting rid of symlinks in .git?", but the 
>> conclusion was that it would slow it down too much? *ponder*)
> 
> Symref'ed isn't really the right term ... we're not talking about refs 
> here.  You would have to basically implement symlinks _inside_ git ...
> 
> New-workdir really _is_ all about symlinks.  It already exists as a 
> contrib feature - and moving it into core is (as I understand it) really 
> just moving it, not redesigning.
> 
> If you were going to avoid symlinks, then probably the cleanest way would 
> be to have an explict way to point at the actual repo - rather than making 
> the working look like a repo if you squint hard enough.  Which sounds 
> rather like it would be an extension to GIT_DIR + GIT_WORK_TREE.  I 
> haven't looked at it, but it shouldn't be too hard to have a mechanism 
> that automatically does GIT_DIR=<there> GIT_WORK_TREE==<here> when the 
> appropriate setup is in place?  Though you would have to get it into all 
> the appropriate places ...

I think it could be best solved by having in "worktree" .git/config with
core.gitdir which functions like lower layer in UnionFS like manner. It
means that if git cannot find a file or directory in .git, then it tries
to find it in core.gitdir.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
