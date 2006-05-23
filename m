From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: irc usage..
Date: Tue, 23 May 2006 22:19:33 +0200
Organization: At home
Message-ID: <e4vqob$apj$1@sea.gmane.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> <446F95A2.6040909@gentoo.org> <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org> <446FA262.7080900@gentoo.org> <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org> <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org> <44713BE4.9040505@gentoo.org> <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org> <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> <Pine.LNX.4.64.0605221013020.3697@g5.osdl.org> <e4stna$o1g$1@sea.gmane.org> <Pine.LNX.4.64.0605221055270.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue May 23 22:20:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FidMn-0001gn-QV
	for gcvg-git@gmane.org; Tue, 23 May 2006 22:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWEWUUb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 16:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWEWUUb
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 16:20:31 -0400
Received: from main.gmane.org ([80.91.229.2]:15025 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932107AbWEWUUa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 16:20:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FidMS-0001bt-Px
	for git@vger.kernel.org; Tue, 23 May 2006 22:20:12 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 May 2006 22:20:12 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 May 2006 22:20:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20630>

Linus Torvalds wrote:
 
> [...] people _should_ realize that removing objects is very very special. 
> Whether it's done by "git prune-packed" or "git prune", that's a very 
> dangerous operations. "git prune" a lot more so than "git prune-packed", 
> of course (in fact, you should _never_ run "git prune" on a repository 
> that is active - you _will_ corrupt it)-

Would it be possible to make 'git prune' command repository corruption safe,
even if some information might be lost (like 'git add')? Or do _corruption_
mean some recoverable only information is lost? Not always one can use "one
repository per developer" workflow.


One of the solution would be to to use reader/writer lock (filesystem
semaphore), with each command modyfying repository performing locking, and
git-prune waiting on lock until noone is accessing repository. Of course
the problem is with OS and filesystems which does not support locking, and
with stale locks...

Second solution would be to [optionally] wait until no process is accessing
repository, copy repository in some safe place, [optionally] calculate
checksum, prune, [optionally] check if the repository was modified
meanwhile and either abort or repeat, and finally copy pruned repository
back.

-- 
Jakub Narebski
Warsaw, Poland
