From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Could this be done simpler?
Date: Wed, 24 Jun 2009 14:35:13 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 23:35:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJa88-0007mA-Ns
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 23:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759257AbZFXVf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 17:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758615AbZFXVf2
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 17:35:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42373 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757589AbZFXVf2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2009 17:35:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5OLZEQ2020807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 24 Jun 2009 14:35:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5OLZDB1003407;
	Wed, 24 Jun 2009 14:35:13 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.469 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122160>


Ok, so I have a practice of occasionally doing octopus merges when I have 
two branches with trivial fixes from the same person.

That all works fine when they use the "multiple branches in the same 
repository" approach (eg x86 "tip" tree), but other people tend to prefer 
to use multiple repositories for different features, rather than branches. 
And git generally lets you do things either way with no real difference.

But for the octopus case, it does make a difference. You can easily make 
octopus merges only from one repository.

Which is kind of sad. 

So I did kernel commit c6223048259006759237d826219f0fa4f312fb47 by 
basically doing the 'git pull" logic by hand, and while this was just a 
trial and maybe I'll never feel the urge to do it again, I'm wondering it 
maybe we should make it easier to do.

Right now the "git pull" syntax is

	git pull <repo> <branch>*

and you cannot specify multiple repositories, only multiple branches.

But at the same time, it should be pretty unambiguous whether an argument 
is a repository or a branch (':' in a remote repository, or "/" or ".." at 
the beginning of a local one - all invalid in branch names).

So it _should_ be syntactically unambiguous to allow

	git pull (<repo> <branch>*)+

for the octopus case. Hmm?

		Linus
