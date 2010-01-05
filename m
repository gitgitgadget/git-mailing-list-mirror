From: Sam Vilain <sam@vilain.net>
Subject: Re: git-cherry-pick problem - directory not touched by commit is
 marked  "added by us"
Date: Wed, 06 Jan 2010 10:37:14 +1300
Message-ID: <1262727434.22597.8.camel@denix>
References: <82cfa8031001050433r6d705222qf905c929ad6395c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hakim Cassimally <hakim.cassimally@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 22:37:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSH5l-0004y9-Pw
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 22:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183Ab0AEVhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 16:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174Ab0AEVhY
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 16:37:24 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:49305 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932098Ab0AEVhX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 16:37:23 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id EC9D721C469; Wed,  6 Jan 2010 10:37:17 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [192.168.69.234] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 0CB5121C400;
	Wed,  6 Jan 2010 10:37:12 +1300 (NZDT)
In-Reply-To: <82cfa8031001050433r6d705222qf905c929ad6395c4@mail.gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136212>

On Tue, 2010-01-05 at 12:33 +0000, Hakim Cassimally wrote:
> I got into a bit of trouble with a git-cherry-pick last night, and
> though mugwump
> and others on #git helped me as far as a workaround, I'm still very confused,
> and would like to make sure it doesn't happen again

Yes, that was me.  I'm very confused by the bug, too.

 [...]
> WHAT HAPPENS
> ============
> 
> When I'm in (stable), and try to cherry-pick the change from (experimental),
> git thinks that I'm making a massive number of changes in a directory that
> wasn't touched by the relevant commit.
 [...]
>     (stable) $ git --version
>     git version 1.6.6
>     # I tried previously on 1.6.0.4 but upgraded in case it helped
> 
>     (stable) $ git status
>     # On branch stable
>     # nothing to commit (working directory clean)
> 
>     (stable) $ git show --stat 301afce1
>     commit 301afce1c78380276d208077ef4ec76b469c1024
>     Author: osfameron <...>
>     Date:   Wed Dec 23 23:45:20 2009 +0000
> 
>         Proof of concept for import module (parse Excel)
> 
>      bin/upload_module.pl |  142
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>      1 files changed, 142 insertions(+), 0 deletions(-)
> 
>     (stable) $ git whatchanged -1 301afce1
>     commit 301afce1c78380276d208077ef4ec76b469c1024
>     Author: osfameron <...>
>     Date:   Wed Dec 23 23:45:20 2009 +0000
> 
>         Proof of concept for import module (parse Excel)
> 
>     :000000 100644 0000000... c90e261... A  bin/upload_module.pl

So by here, we know that the commit only affects that single file.  No
funny stuff like mode changes of other files.

>     (stable) $ git cherry-pick 301afce1
>     Finished one cherry-pick.
>     www/client/css/admin-clean.css: needs merge
>     www/client/css/admin.css: needs merge
>     www/client/css/error.css: needs merge
>     www/client/css/public.css: needs merge
>     www/client/css/user-clean.css: needs merge
>         <...snip>
>     www/client/css/admin-clean.css: unmerged
> (832c41e99d19f2dd39c9cf3709f14619ffab24b8)
>     www/client/css/admin.css: unmerged
> (8e7cd850bf40d1a921b1f62ce0945abd374fa55d)
>     www/client/css/error.css: unmerged
> (88945d05640c0820c9cf68922392573d4ac07b2c)
>         <...snip>
>     ...
>     error: Error building trees

Then, wham, these files want to be changed.  What is the diff-tree
inside revert/cherry-pick doing differently to the one in log?

>     (stable) $ git status
>     # On branch stable
>     # Changes to be committed:
>     #   (use "git reset HEAD <file>..." to unstage)
>     #
>     #       new file:   bin/upload_module.pl
>     #
>     # Unmerged paths:
>     #   (use "git reset HEAD <file>..." to unstage)
>     #   (use "git add <file>..." to mark resolution)
>     #
>     #       added by us:        www/client/css/admin-clean.css
>     #       added by us:        www/client/css/admin.css
>     #       added by us:        www/client/css/error.css
>     #       added by us:        www/client/css/public.css
>         <...snip>

Hakim, one more useful thing in this situation would be to show the
state of these files in the index;

 git ls-files -s -u

Also take the 'git ls-tree -r HEAD', 'git ls-tree -r 301afce1' and 'git
ls-tree -r 301afce1^' output, and grep for the files in question.  The
answer (or at least a bug triage) should be in the output of those
commands.

You can reproduce exactly the merge by making a new branch at the
position where you were attempting to land the cherry pick before, and
checking that branch out.

One last test, would be to check that it happens on a clean clone of the
repository.  I don't think that you're hitting any repository-local
behaviour (eg, the ability to mark certain files as "always ignore") but
you never know.  These commands are all being run on the same working
copy, right?

Thanks for your persistence,
Sam
