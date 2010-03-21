From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 16:51:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1003211643470.21433@narbuckle.genericorp.net>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>  <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>  <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>
 <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 00:51:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtUvg-0002qe-RT
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 00:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab0CUXvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 19:51:32 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:33939 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753064Ab0CUXvb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 19:51:31 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o2LNpSfZ003693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Mar 2010 18:51:28 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142875>

On Fri, 19 Mar 2010, Avery Pennarun wrote:

> For example, I'd be very happy to learn that your new design would
> allow two people to independently pull from svn://, do work in their
> respective copies of the git repositories, branch and merge all day
> long, pull from each other, and then push back to svn without a)
> making a mess of the svn repo and causing zillions of conflicts, or b)
> linearizing history and losing git's complex DAG.
>
> In the current version of git-svn this is very hard. 'git svn dcommit'
> generates entirely new git commit objects corresponding to the ones
> that were created in svn... but which nevertheless have your merge
> history included, which is awesome.  But if a new person clones the
> svn repo from scratch, he will end up with git commits corresponding
> to those same ones from svn, but *without* the merge history, and
> therefore with different commit ids, and which therefore prevent
> push/pulling between other people who have cloned the repo.

I've been working on a script that does 2-way integration with an
upstream CVS repo, using git-cvsimport and git-cvsexportcommit to do the
difficult parts.

I solved this problem you mention by rebasing in both directions onto
detached HEADs and exporting the result, meaning that the history is
permanently diverged from a DAG standpoint.  Of course, over time, the
rebase would become increasingly messy and horrible, so I created a
couple of placeholder refs which are updated after the import/export is
finished.  These mark the last time it was done, and allow you only to
attempt to apply the commits which are new on each side.

It's still very green and I've already worked though a number of pretty
hairy problems, so I'm not going to say it's a bulletproof solution.
But it does work.

     Dave
