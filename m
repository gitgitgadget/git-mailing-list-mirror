From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] tagger id
Date: Tue, 12 Jul 2005 16:15:36 -0600
Message-ID: <m1pstnzn5j.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
	<m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507111815180.17536@g5.osdl.org>
	<m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com>
	<m18y0c1prv.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507121152260.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 13 00:19:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsT4t-0005To-DU
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 00:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVGLWRa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 18:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVGLWRN
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 18:17:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9887 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262434AbVGLWPv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 18:15:51 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6CMFdJ3013106;
	Tue, 12 Jul 2005 16:15:39 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6CMFa8K013105;
	Tue, 12 Jul 2005 16:15:36 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507121152260.17536@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 12 Jul 2005 11:54:05 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Eric,
>  I ended up coding the ident stuff a bit differently, and I didn't do done
> the tag/git-id part yet. Can you check out my latest commit (pushed out, 
> but it will probably take a few minutes to mirror out), and do the final 
> tag stuff based on that? 

For the most part it looks sane.   I'm not really thrilled that
setup_ident() calls die, and when complaining about the user
name we should probably complain that their sysadmin hated
then if it is over a 1000 characters not their parents :)

I'm also not at all thrilled with global variables.  Globals aren't
the source of all evil but they have a lot better claim than goto.
At least real_email and friends are file local.  If you like
it and the code works git is you project and I won't complain again.

Since we are still looking at this there is one change in the user
interface I would like to make to simplify things for the end user.
The only time when GIT_COMMITTER != GIT_AUTHOR is in git_commit_script
when we you are making a new commit based on an old commit. Can
we add a command line option to git-commit-write, --author
that will allow the author field to be overridden.  Allowing us
to get down to a single set of GIT variables for specifying who
the user is?

That also simplifies the tagging case and answers the question 
which environment variables tags should look at, to see who the
user is. 

Eric
