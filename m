From: Jan Hudec <bulb@ucw.cz>
Subject: Re: which git commands is  correponding to "svnlook diff -t" and
 "svnlook log -t"?
Date: Thu, 11 Nov 2010 09:47:23 +0100
Message-ID: <20101111084723.GD30870@efreet.light.src>
References: <30111518.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: samilkarahan <samilkarahan@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 09:47:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGSod-0000pO-Sx
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 09:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757863Ab0KKIr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 03:47:26 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:48057 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757834Ab0KKIr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 03:47:26 -0500
X-ASG-Debug-ID: 1289465242-0702472d0001-QuoKaX
Received: from efreet.light.src (152-31-80-78.praha.adsl.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id D7xwGR57wFZUe7mN; Thu, 11 Nov 2010 09:47:22 +0100 (CET)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1PGSoV-0006Od-Jb; Thu, 11 Nov 2010 09:47:23 +0100
X-ASG-Orig-Subj: Re: which git commands is  correponding to "svnlook diff -t" and
 "svnlook log -t"?
Content-Disposition: inline
In-Reply-To: <30111518.post@talk.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.praha.adsl.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1289465242
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5010 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.46307
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161219>

On Tue, Nov 02, 2010 at 00:03:31 -0700, samilkarahan wrote:
> I have developed pre-commit hook, but it only run for svn hook. 
> 
> I want to run it for git hook,But I don't know git well like svn ,so 

Git works fundamentally differently from subversion. It's not possible to
give you good advice unless you explain what you want to do in the hook.

Where subversion has one commit operation to create the changeset and publish
it, git has two operations. Commit to create it and push to publish it. Each
comes with it's own set of hooks. Moreover the operations are done on
different repositories, so they run hooks from different places!

Commit has 'pre-commit', 'prepare-commit-msg', 'commit-msg' and 'post-commit'
run on the developers local repositories, where they must be manually
installed and can be easily disabled (with --no-verify option to commit).
The prepare-commit-msg gives you some extra flexibility in that you can
prepare template of the commit message here.

Push has 'pre-receive', 'update', 'post-receive' and 'post-update' run on the
central repository and there is no way around them. It is, however, kind of
late. The commits are already done, perhaps even for quite a long time, so if
they are rejected, developers will have to go back and amend them.

Remember, that multiple commits will be pushed at once, so you have to
inspect all of them (git log $oldsha..$newsha), not just the latest.

> I haven't found corresponding git command to svn commands which are "svnlook
> diff -t"

Depends on which git hook you want that in. And that depends on what you want
to do. For pre-commit hook, it's 'git diff --cached', for pre-receive or
update hook you get the commit ID and inspect it with 'git log' and 'git
show'.

> and "svnlook log -t".

Again, depends on which git hook you want that in. And that depends on what
you want to do. For pre-commit hook there is none, since it's called
*before* the message is created. For commit-msg hook you get name of file
with the message as argument (and you can edit it from there). For
pre-receive hook or update hook you use 'git log' and 'git show' again.

> is there anybody know these git commands??

Everybody knows them plus they are quite obvious from the documentation (man
git-hooks) and the samples (installed by 'git init' in every repository). But
nobody knows the subversion commands and there is no simple mapping anyway.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
