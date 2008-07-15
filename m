From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: git-rebase eats empty commits
Date: Tue, 15 Jul 2008 22:19:02 +0200
Message-ID: <20080715201902.GC6244@leksak.fem-net>
References: <g4vrrm$g35$1@ger.gmane.org> <20080712221207.GB22323@leksak.fem-net> <g5fpnm$3jb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Jul 15 22:20:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIr0R-0000kC-5o
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 22:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758636AbYGOUTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 16:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757554AbYGOUTK
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 16:19:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:51954 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756161AbYGOUTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 16:19:09 -0400
Received: (qmail invoked by alias); 15 Jul 2008 20:19:05 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp046) with SMTP; 15 Jul 2008 22:19:05 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/QzXtjLGrQQVO6IJdGehs8Z6O6AI1/RFUNW8lwaF
	+EanBxfoDKsebq
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KIqzG-0004Rq-FI; Tue, 15 Jul 2008 22:19:02 +0200
Content-Disposition: inline
In-Reply-To: <g5fpnm$3jb$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88592>

Hi,

Michael J Gruber wrote:
> Stephan Beyer venit, vidit, dixit 13.07.2008 00:12:
>> To sum up, use rebase -i and when it's pausing, do "git commit --allow-empty"
>> and then "git rebase --continue" and you have what you want.
>
> I assume this is with git from master? With git 1.5.6.2 rebase -i  
> doesn't stop there, not even when I change "pick" to "edit"!

Hmm, in fact this is with my git from Debian, from master and my
sequencer-based one:

	$ /usr/bin/git --version
	git version 1.5.6
	$ ./git --version
	git version 1.5.6.3.350.g6c11a
	$ git --version
	git version 1.5.6.3.506.g902dd

And, btw, the reason of this behavior is no special case in rebase-i,
it's just that git-cherry-pick fails (exit status != 0), if you pick an
empty commit (and then rebase-i will pause because of conflict). And
*this* is because builtin-revert.c runs git-commit without --allow-empty.
This has never changed, so I cannot believe that the behavior changed in
any version of git. Or I am missing a point.

	$ git cherry-pick empty		# empty is an empty commit tagged as "empty"
	Already uptodate!
	Finished one cherry-pick.
	# Not currently on any branch.
	# Untracked files:
	[...]
	nothing added to commit but untracked files present (use "git add" to track)
	$ echo $?
	1
	$ EDITOR=touch git commit --allow-empty
	Created commit 145f1d0: empty

The same happens when doing rebase -i instead of cherry-pick.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
