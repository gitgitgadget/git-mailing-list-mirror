From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 clone @all error
Date: Sat, 3 Nov 2012 19:13:05 -0400
Message-ID: <20121103231305.GB11267@padd.com>
References: <1351593879401-7570219.post@n2.nabble.com>
 <CABYiQp=1HEW=53U2Rck5vckhq0PB3C9iuanoXeVvNG6Xv5+oHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arthur <a.foulon@amesys.fr>, git@vger.kernel.org
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 00:13:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUmu3-00089F-GI
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 00:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699Ab2KCXNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 19:13:12 -0400
Received: from honk.padd.com ([74.3.171.149]:45618 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782Ab2KCXNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 19:13:09 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 104A3D27;
	Sat,  3 Nov 2012 16:13:08 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id CF25624301; Sat,  3 Nov 2012 19:13:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABYiQp=1HEW=53U2Rck5vckhq0PB3C9iuanoXeVvNG6Xv5+oHg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208987>

merlin66b@gmail.com wrote on Wed, 31 Oct 2012 15:01 +0100:
> On Tue, Oct 30, 2012 at 11:44 AM, Arthur <a.foulon@amesys.fr> wrote:
> > The problem :
> >
> > Importing revision 7727 (100%)Traceback (most recent call last):
> >   File "/usr/bin/git-p4", line 3183, in <module>
> >     main()
> >   File "/usr/bin/git-p4", line 3177, in main
> >     if not cmd.run(args):
> >   File "/usr/bin/git-p4", line 3048, in run
> >     if not P4Sync.run(self, depotPaths):
> >   File "/usr/bin/git-p4", line 2911, in run
> >     self.importChanges(changes)
> >   File "/usr/bin/git-p4", line 2618, in importChanges
> >     self.initialParent)
> >   File "/usr/bin/git-p4", line 2198, in commit
> >     epoch = details["time"]
> > KeyError: 'time'
> 
> Are you permanently converting a project, or are you planning to
> continue submitting to perforce with git-p4?
> 
> I have seen similar bugs myself when using the --detect-branches
> option.

I hope --detect-branches is unrelated to any problems related to
p4 describe, because it is used identically both with and without
the option.  But you never know.

> The branch detection in git-p4 is flaky anyway: it is limited
> what it can handle, and it used to require correct perforce branch
> specs at least, so I would recommend not using it unless you know what
> it is doing under the hood.

It relies on heuristics because the git idea of branches doesn't
have a direct analog in p4, even though p4 users will organize
their files and directories in ways that suggest branches.  The
way it works is described in the BRANCH DETECTION part of the
git-p4.1 man page.

The man page also explains how you can use a config variable
to explicitly define the branch relationships.  This might help:

git-p4.branchList::
        List of branches to be imported when branch detection is
        enabled.  Each entry should be a pair of branch names separated
        by a colon (:).  This example declares that both branchA and
        branchB were created from main:

	git config       git-p4.branchList main:branchA
	git config --add git-p4.branchList main:branchB

It still only works for branches at the same "level" of the
depot path.

> Instead I would just clone a single branch at a time (drop the
> --detect-branches) and work on that.
> 
> I do this even in the rare cases when I need more than one perforce
> branch in the same git repo - there are other ways to achieve the same
> thing.

Yep, that should alway works.

		-- Pete
