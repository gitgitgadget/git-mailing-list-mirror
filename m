From: John Keeping <john@keeping.me.uk>
Subject: Re: Merging after directory got turned into submodule
Date: Tue, 11 Aug 2015 14:25:31 +0100
Message-ID: <20150811132530.GG30507@serenity.lan>
References: <55C9F271.30008@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Gagern <Martin.vGagern@gmx.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 15:31:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP9eO-0007bR-99
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 15:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbbHKNa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 09:30:59 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:54799 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964921AbbHKNa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 09:30:58 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2015 09:30:58 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 23B1027D28;
	Tue, 11 Aug 2015 14:25:39 +0100 (BST)
X-Quarantine-ID: <vI4qr9ysEkiV>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vI4qr9ysEkiV; Tue, 11 Aug 2015 14:25:36 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 695A7290C7;
	Tue, 11 Aug 2015 14:25:32 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <55C9F271.30008@gmx.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275690>

On Tue, Aug 11, 2015 at 03:02:41PM +0200, Martin von Gagern wrote:
> I've noticed that if I turn a subdirectory into a submodule, I'm having
> severe trouble merging branches from before that change, even if they
> don't modify that subdirectory at all.
> 
> I've posted this problem on Stack Overflow and started a bounty for it.
> See http://stackoverflow.com/q/31821219/1468366. So far I haven't
> received an answer, so I decided to ask here as well.
> 
> Here is an example.
> 
> # Create one project, to be used as a subproject later on
> git init a
> cd a
> echo aaa > aa
> git add -A
> git commit -m a1
> cd ..
> 
> # Create a second project, containing a as a normal directory initially
> git init b
> cd b
> mkdir a b
> echo aaa > a/aa
> echo bbb > b/bb
> git add -A
> git commit -m b1
> 
> # Replace directory with submodule
> git rm -r a
> git submodule add ../a a
> git commit -m b2
> 
> # Create feature brach starting at version without submodule
> git submodule deinit .  # will error if I don't do this
> git checkout -b branch HEAD^
> echo abc > b/bb
> git commit -a -m b3
> 
> # Try to merge the feature branch
> git checkout master
> git merge branch
> 
> This prints an error message:
> 
> > CONFLICT (file/directory): There is a directory with name a in branch.
> > Adding a as a~HEAD
> > Automatic merge failed; fix conflicts and then commit the result.
> 
> I get the same error if I do a git submodule update --init before the
> git merge branch. I don't see any a~HEAD anywhere, neither in my
> directory tree nor in the output from git status, which reads like this:
> 
> > On branch master
> > You have unmerged paths.
> >   (fix conflicts and run "git commit")
> >
> > Changes to be committed:
> >
> >     modified:   b/bb
> >
> > Unmerged paths:
> >   (use "git add <file>..." to mark resolution)
> >
> >     added by us:     a
> 
> If I do git add a as suggested, I get another error:

"git reset a" works for me (i.e. set a to what it was before merging).
If you then commit and check "git ls-tree HEAD" it shows "a" is still a
submodule.
