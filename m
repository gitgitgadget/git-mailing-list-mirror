From: Pete Wyckoff <pw@padd.com>
Subject: Re: git p4: bug - branch detection broken on empty branches
Date: Sat, 26 Apr 2014 08:40:00 -0400
Message-ID: <20140426124000.GA4767@padd.com>
References: <CADtnS+zAnnpaU59-rAwMHF7Z4SNjcYWASqpKdEq+GVs8mVSb3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan Porter <dpreid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 14:40:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We1uZ-0004Qk-UI
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 14:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbaDZMkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 08:40:07 -0400
Received: from honk.padd.com ([74.3.171.149]:34499 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbaDZMkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 08:40:06 -0400
Received: from arf.padd.com (unknown [50.105.4.164])
	by honk.padd.com (Postfix) with ESMTPSA id 399565B16;
	Sat, 26 Apr 2014 05:40:03 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5FBD7201D1; Sat, 26 Apr 2014 08:40:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CADtnS+zAnnpaU59-rAwMHF7Z4SNjcYWASqpKdEq+GVs8mVSb3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247156>

dpreid@gmail.com wrote on Tue, 22 Apr 2014 10:20 +0100:
> As part of my work to help get git-p4 close to bug-free before Git
> 2.0, I'm posting all bugs and patches to this mailing list. Please
> direct me elsewhere if this is incorrect.
> 
> When trying to clone a particular directory from a depot, that
> contains one or more branches that contain no commits for that
> directory, branch detection is broken and results in a failed clone.
> 
> fatal: ambiguous argument
> 'refs/remotes/p4/silly_project_branch/trunk': unknown revision or path
> not in the working tree.
[..]
>   File "/home/dreid/bin/git-p4", line 2678, in importChanges
>     blob = self.searchParent(parent, branch, tempBranch)
>   File "/home/dreid/bin/git-p4", line 2600, in searchParent
>     for blob in read_pipe_lines(["git", "rev-list", "--reverse",
>   File "/home/dreid/bin/git-p4", line 155, in read_pipe_lines
>     die('Command failed: %s' % str(c))
>   File "/home/dreid/bin/git-p4", line 106, in die
>     raise Exception(msg)
> Exception: Command failed: ['git', 'rev-list', '--reverse',
> '--no-merges', 'refs/remotes/p4/silly_project_branch/trunk']
> 
> Original command:
> $ git-p4 clone //insane_depot/projects/Exchange/CompanyName/silly_project_branch@all
> silly-project --detect-branches -v

Yes, this is a good bug.  You could do "git rev-parse -q --verify"
on parent before trying to read the rev-list.

But then what should happen?  I suspect git-p4 will just create
that ref when it commits the change it is considering.

		-- Pete
