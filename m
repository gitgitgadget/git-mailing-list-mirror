From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Converting from svn to git
Date: Fri, 15 Aug 2008 15:58:11 +0200
Message-ID: <g8421k$qcs$1@ger.gmane.org>
References: <e0b44a890808100611t27ddfcb6v21eecea89484c90b@mail.gmail.com>	 <20080810132409.GE18960@genesis.frugalware.org>	 <e0b44a890808100754l536bc4f3kfd953b52044f6e59@mail.gmail.com>	 <g7n1mk$67t$1@ger.gmane.org>	 <e0b44a890808100848p367f5c66qfa21cba1b3ba12a0@mail.gmail.com> <e0b44a890808111046q2626defdnab31b0d7b1c4578@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 15:59:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTzpx-0003J4-84
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 15:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbYHON60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 09:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753794AbYHON60
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 09:58:26 -0400
Received: from main.gmane.org ([80.91.229.2]:56395 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694AbYHON6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 09:58:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KTzoq-0002MQ-1a
	for git@vger.kernel.org; Fri, 15 Aug 2008 13:58:20 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 13:58:20 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 13:58:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <e0b44a890808111046q2626defdnab31b0d7b1c4578@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92472>

David Neu venit, vidit, dixit 11.08.2008 19:46:
> OK, I did
> 
> $ git-filter-branch --tree-filter 'rm -rf subdir1/ subdir2/ subdir3/' -- --all
> 
> which looks good, except when I open gitk, I still see "empty" commits
> that correspond to subdir1/, subdir2/ and subdir3/.
> 
> Is there anyway to remove those?

A while ago I "complained" that rebase would skip empty commits. You 
might experiment with that. Alternatively, the following works for me:

git filter-branch --commit-filter 'cmd="git commit-tree"; test `git show 
--pretty=oneline $GIT_COMMIT|wc -l` = 1 && cmd="skip_commit"; $cmd "$@"' 
-- --all

This skips all commits which introduce no diff. It will not remove 
branches or tags which are related only to those subdirs.

I am sure there will be more elegant ways to do that (esp. the test with 
wc).

Michael
