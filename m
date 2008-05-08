From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking
 branches
Date: Wed, 7 May 2008 23:48:17 -0700 (PDT)
Message-ID: <alpine.DEB.1.00.0805072332300.6948@swallowtail>
References: <20080508013956.GA24956@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu May 08 08:49:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtzwI-0007Jd-RV
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 08:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757127AbYEHGsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 02:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757087AbYEHGsZ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 02:48:25 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:40912 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756264AbYEHGsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 02:48:24 -0400
Received: from swallowtail (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id 1E95BA011F;
	Thu,  8 May 2008 02:48:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by swallowtail (Postfix) with ESMTPS id C3BDC3F5C6;
	Wed,  7 May 2008 23:48:17 -0700 (PDT)
X-X-Sender: paulproteus@swallowtail
In-Reply-To: <20080508013956.GA24956@midwinter.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81508>

On Wed, 7 May 2008, Steven Grimm wrote:

> In environments where a lot of people are sharing an svn repository using
> git-svn, everyone has identical, but individually maintained, tracking
> branches.

To further muddy the waters, let me talk about my setup, also one with a 
"central git repository" from which all developers clone, and also one 
based on a Subversion tree.

The way I handle it is that, hidden somewhere, I have an account with a 
cron job that does this:

$ git svn fetch
$ git push origin refs/remotes/*:refs/heads/*
$ git push origin refs/remotes/trunk:refs/heads/master

The first push synchronizes "origin" to have the same branches as this 
git-svn copy of the git repository, and the second updates "origin" so 
that it has a "master"; without that second step, "git clone" will error 
out when it get to its checkout phase.

Note that in .git/config, the [remote "origin"] section has no "fetch" 
parameter.  If it did have one, a would end up creating the branch 
origin/master on the second push, and origin/origin/master on the third, 
and so on.

After the push, "origin" ends up being a git repository that looks just 
like the svn repository we're cloning.  When you "git clone" it, the 
remote has all the tags and branches of the upstream svn repository; and 
as the upstream svn repository updates its branches, the git branches get 
those updates.

I'm not saying this patch shouldn't be accepted; I have no comment on it. 
I just want to see what others think of my approach to this workflow.

-- Asheesh.

-- 
What happened last night can happen again.
