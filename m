From: Eric Wong <e@80x24.org>
Subject: Re: git svn clone cannot go beyond a specific rev on codeplex
Date: Fri, 13 May 2016 10:34:55 +0000
Message-ID: <20160513103455.GA6061@dcvr.yhbt.net>
References: <1755662347.2265534.1463089085574.JavaMail.yahoo.ref@mail.yahoo.com>
 <1755662347.2265534.1463089085574.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri May 13 12:35:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1AQv-0007tJ-Js
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 12:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbcEMKe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 06:34:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40350 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbcEMKe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 06:34:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B1F20D59;
	Fri, 13 May 2016 10:34:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1755662347.2265534.1463089085574.JavaMail.yahoo@mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294521>

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> I tried bin-wrappers/ from current git HEAD.
> 
> $ git describe
> v2.8.2-396-g5fe494c

Which SVN version?	`git svn --version`

> bin-wrappers/git svn clone https://ironpython.svn.codeplex.com/svn ironpython-old-codeplex
> 
> always fails at this rev:
> 
> 	M	Src/Tests/test_re.py
> r7605 = e581bc66eda2b86bf46681191034844c4ba7d7a5 (refs/remotes/git-svn)
> Connection reset by peer: Error running context: Connection reset by peer at /home/Nobak-Hin-Tak/tmp-git/git/perl/blib/lib/Git/SVN/Ra.pm line 312.

Can you resume with "git svn fetch" ?

I suspect it's too big a change to the next revision (r8870)
since they rearranged the repo (*sigh*):

	svn log -r 7604:HEAD -v https://ironpython.svn.codeplex.com/svn

I don't think I've seen the "Error running context:" error
message before, so it could be something (either the server or
client) running out of memory, hitting a timeout or CPU limit
of some sort...

This gave me a 7MB diff, but seems to have gone through without
error after taking a long time:

	svn diff -r7604:8870 https://ironpython.svn.codeplex.com/svn

> I am sure there are later revs, as the web front end says so,
> but git svn clone/fetch does not seem to be able to get at it.

When in doubt, reach for "svn log" and see how strange things get :)

> (vger.kernel did not seem to like my posts a while ago - I
> hope situation has improved and this can go through...)

This was fine; but feel free to Cc: me and you can always check
http://dir.gmane.org/gmane.comp.version-control.git
or other archives.
