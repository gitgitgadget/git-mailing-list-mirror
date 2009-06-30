From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: correct workflow with bare repo and pull?
Date: Tue, 30 Jun 2009 10:14:46 +0200
Message-ID: <200906301014.46540.robin.rosenberg.lists@dewire.com>
References: <583913.73865.qm@web52205.mail.re2.yahoo.com> <4A49B086.30000@op5.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Tim <opensourcetim@yahoo.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jun 30 10:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLYUZ-0003fW-JZ
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 10:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbZF3IOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 04:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbZF3IOv
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 04:14:51 -0400
Received: from mail.dewire.com ([83.140.172.130]:13913 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbZF3IOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 04:14:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 64846139CC88;
	Tue, 30 Jun 2009 10:14:48 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EOnWM1KDSxTI; Tue, 30 Jun 2009 10:14:47 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id AA41F139CC83;
	Tue, 30 Jun 2009 10:14:47 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <4A49B086.30000@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122500>

tisdag 30 juni 2009 08:28:22 skrev Andreas Ericsson <ae@op5.se>:
> Tim wrote:
> > Myself and the other developer on the team have private repos, and we
> > push to a bare repo (which we use for Hudson builds).  For now we only
> > use the master branch.  No other remote repos.  When another developer
> > pushes changes to the bare repo, and I pull them, all of the files they
> > pushed show up as modified on my box when I do "git status" (even
> > though I had not modified them).  How to avoid this?
> 
> Make sure neither of you modify the executable bit on the files, and make
> sure your editors work the same in both ends wrt the last line and white-
> space at the ends of lines.
> 
> Also make sure you have compatible crlf settings in your git configs.
> 
> If your editors are what's causing the problem, you should only see the
> files you've actually opened in your editor as being different. If it's
> your git configuration, "git pull && git status" should show differences
> immediately. "git help config" and searching for core.autocrlf should
> point you in the right direction to what might be causing the error.
> If it's modechanges that's the problem. core.filemode may also be a
> possible source of errors (it has to be "false" on windows but can be
> "true" on systems with posix permissions).
> 
> >   Also, one
> > developer saw really strange results when they did a "git pull origin
> > master" and "git status" -- the paths shown below do not exist in the
> > local work area.  These files have always lived under a-core/.... so it
> > is really odd that they show up under a-web
> > # On branch master
> > # Changes to be committed:
> > #   (use "git reset HEAD <file>..." to unstage)
> > #
> > #    new file:   a-web/src/main/java/com/blah/account/Account.java
> > #    new file:   a-web/src/main/java/com/blah/account/AccountType.java
> > #
> > # Changed but not updated:
> > #   (use "git add/rm <file>..." to update what will be committed)
> > #   (use "git checkout -- <file>..." to discard changes in working directory)
> > #
> > #    deleted:    a-web/src/main/java/com/blah/account/Account.java
> > #    deleted:    a-web/src/main/java/com/blah/account/AccountType.java
> > 
> > What are we doing wrong?  
> > 
> 
> Hard to tell without knowing what the repository looks like. Is this
> a repo you can share with us?

"Changes to be committed" is the index
"Changed but not updated" is the workdir.

So modify the files, update the index (git add -u) and then rm (not git rm) the files
and you get this. But from a pull/merge only you should not get this state.

A possible way,is if you had non-ascii filenames and one of the trees was produced using the Eclipse plugin. 
For non-ascii names you could get corrupt (wrong order) trees and that would fool git when merging into
producing "interesting" results.  See http://egit.googlecode.com for instructions for upgrading to the latest
pre-built plugin.

-- robin
