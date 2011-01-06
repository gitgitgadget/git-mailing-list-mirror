From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git checkout branch behaves differently from what specified in
 man page
Date: Thu, 6 Jan 2011 11:35:22 -0600
Message-ID: <20110106173522.GB11346@burratino>
References: <20110106154418.3348.29438.reportbug@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "r.ductor" <r.ductor@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 18:35:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PatkS-0000hx-GX
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 18:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057Ab1AFRff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 12:35:35 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40416 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab1AFRfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 12:35:34 -0500
Received: by qyj19 with SMTP id 19so19590869qyj.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 09:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=t/e9qClmfp5oYehMOIg2X/8qnJTUF80T1CZiJDh9M6g=;
        b=gHHZoMy/gm4rtWKY2BCQ2mU0y9sUl646NIGAb4cR/6Us8AhCgqnXGcG/SqJ9gcTAk0
         8B/65oA0+sFh51szz/L6puuYr0Z78gaAhRvlpAMppcBv8+SBBGm2NskW4xkaGU3nHyZO
         WmNYHiULXTodshInqgsSfzFlipTrPWOgAMsiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZZAMHhSFrl7cLJ9+kBYxGnCVMm3wuUAHpKyjDVZZE5rjT8Gmrn+Lrt9Est80T6Y0kv
         wtED7+fENvFJxi39LstsI+0e2ilctNSxocSckVhIzql9oMtzyKl9uZnMh528f02g0fn+
         BW31zmT1+dtqg18xlCW0U9FTRiUFSi7lHONZE=
Received: by 10.229.183.147 with SMTP id cg19mr21849062qcb.37.1294335332998;
        Thu, 06 Jan 2011 09:35:32 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id y17sm14519239qci.45.2011.01.06.09.35.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 09:35:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110106154418.3348.29438.reportbug@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164647>

Hi,

r. ductor wrote[1]:

>  git checkout [<branch>], git checkout -b <new branch> [<start point>] 
>	This form switches branches by updating the index, working tree,
>	and HEAD to reflect the specified branch. "
>
> The key is the meaning of "to reflect": a normal (?) human being
> like me understands that git  checkout branch will reset the
> contents of working directory, and index exactly equal to that of
> the head of the branch.  As you might know this is not true (see
> example below).
[example with both unregistered and staged local modifications]

Yes, I agree that this could be a lot clearer.  For reference, here's
the current description section:

 Updates files in the working tree to match the version in the index
 or the specified tree. If no paths are given, git checkout will also
 update HEAD to set the specified branch as the current branch.

 git checkout [<branch>], git checkout -b|-B <new_branch> [<start point>]
	This form switches branches by updating the index, working tree,
	and HEAD to reflect the specified branch.

	If -b is given,
[... description of -b and -B ...]

 git checkout [--patch] [<tree-ish>] [--] <pathspec>...
	When <paths> or --patch are given, git checkout does not switch
	branches. It updates the named paths in the working tree from
	the index file or from a named <tree-ish> (most often a commit).
	In this case, the -b and --track options are meaningless and
	giving either of them results in an error. The <tree-ish>
	argument can be used to specify a specific tree-ish (i.e.
	commit, tag or tree) to update the index for the given paths
	before updating the working tree.

	The index may contain unmerged entries because of a previous
	failed merge.
[... more details about the unmerged entries case ...]

Proposed clearer text would be welcome, especially if in the form of
a patch to Documentation/git-checkout.txt (see Documentation/SubmittingPatches).

Currently I think the examples section explains it better.  The
details are something like this:

 - git checkout <branch> --

	tries to change the current branch to <branch>, dragging other
	state kicking and screaming along with it.

	- if a file does _not_ differ between the current commit and
	  <branch>, it does not need to be touched.  Any local changes
	  in that file will be preserved.

	- if a file that _does_ differ between the current commit and
	  <branch> has local changes, git gives up --- the operation is
	  cancelled and all state is preserved.
	  This behavior can be tweaked with the --merge option.

 - git checkout <tree> -- <path specifiers>

	keeping the current branch the same, grabs some files from <tree>
	to replace the current versions in the index and work tree

	- no matter what, the local state of the specified paths is
	  forgotten and both the index and worktree made to match <tree>

	- paths not specified are left alone.

If you just want to reset the worktree and index to match some
branch, then you can use

	git reset --hard <branch>

or

	git checkout <tree> -- .

.  The former even forgets what branch you were on (well, it is
remembered in the reflog).  The latter adopts the content of <tree>
as content registered for the next commit on the current branch.

Hope that helps,
Jonathan

[1] http://bugs.debian.org/609128
