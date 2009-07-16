From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: how to fetch a new svn branch after clone?
Date: Thu, 16 Jul 2009 16:26:02 -0400
Message-ID: <4A5F8CDA.5080202@xiplink.com>
References: <eafc0afe0907160830m29e2f3d3jf5c0e9db29cace54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Changsheng Jiang <jiangzuoyan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 22:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRXYd-0002dw-Gx
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 22:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933303AbZGPU1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 16:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933248AbZGPU1m
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 16:27:42 -0400
Received: from smtp122.dfw.emailsrvr.com ([67.192.241.122]:52778 "EHLO
	smtp122.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933298AbZGPU1m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 16:27:42 -0400
Received: from relay2.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay2.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 65E80E20385;
	Thu, 16 Jul 2009 16:27:41 -0400 (EDT)
Received: by relay2.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 23E1EE202F9;
	Thu, 16 Jul 2009 16:27:41 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <eafc0afe0907160830m29e2f3d3jf5c0e9db29cace54@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123419>

The latest 1.6.4-rc1 contains patches to git-svn for it to support more than one branch URL in an svn repository.

However, before I describe that, can you confirm whether your new branch is in fact named

	http://svn.example.com/project/test

or is it really

	http://svn.example.com/project/test/<branchname>

Because if it's the former then I'm not sure if git-svn can handle your new branch.  The problem is that even though the branch is named 'test' it's a sibling to the 'branches' 'tags' and 'trunk' paths in the repository.  For git-svn to pick up branches, you point it at the path *containing* the branch names.  In the former case, to pick up project/test as the 'test' branch you'd have to point git-svn at the project directory, and that would cause it to also pick up project/tags, project/branches, and project/trunk as other branches (named 'tags', 'branches' and 'trunk').

However, in the latter (test/<branchname>) case, with 1.6.4, I *think* git-svn will pick up the new branches under test if you add a new 'branches' line to the svn-remote's section in your .git/config file.  Something like

	branches = test/*:refs/remotes/*

might let you see the new branches.  The reason I can't be more certain is that if you've done a 'git svn fetch' since the branch was created then git-svn might not pick up the branch-creation commits later.  Unfortunately I don't know git-svn well enough to say for certain.

		M.


Changsheng Jiang wrote:
> Hi list,
> 
> I know how to clone a svn repository with all branches and tags at the
> initial step, but I find no answers of how to fetch a new svn branch
> after clone.
> 
> For example, this
> 
> git svn clone http://svn.example.com/project -T trunk -b branches -t tags
> 
> will clone all branches. but that clone, the svn repository has a new
> branch test with url http://svn.example.com/project/test, how to clone
> it as the initial step?
> 
> Thanks.
> 
>                                                      Changsheng Jiang
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
