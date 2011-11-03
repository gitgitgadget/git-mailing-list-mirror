From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git svn dcommit COMMIT silently checks in everything if COMMIT is not a complete revision
Date: Thu, 3 Nov 2011 17:28:05 +0100
Message-ID: <201111031728.05121.trast@student.ethz.ch>
References: <CAOnWdoj1eUipRd8M=jsAPdDTNcgEbT7adWR78iU5Oac9DvODkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Reuben Thomas <rrt@sc3d.org>
X-From: git-owner@vger.kernel.org Thu Nov 03 17:28:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM09J-00088b-7k
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 17:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933967Ab1KCQ2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 12:28:12 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:14984 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933454Ab1KCQ2M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 12:28:12 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Thu, 3 Nov
 2011 17:28:05 +0100
Received: from thomas.inf.ethz.ch (188.155.176.28) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.339.1; Thu, 3 Nov
 2011 17:28:05 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-46-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CAOnWdoj1eUipRd8M=jsAPdDTNcgEbT7adWR78iU5Oac9DvODkQ@mail.gmail.com>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184728>

Reuben Thomas wrote:
> If I run
> 
> git svn dcommit COMMIT
> 
> with COMMIT being an unambiguous, but partial revision string, it
> behaves like git svn dcommit, i.e. commits everything.

In what git version?  How do I reproduce?  I just ran a simple test
and can't:

  svnadmin create svnrepo
  svn co file://$(pwd)/svnrepo svnwt
  cd svnwt
  echo a > a
  svn add a
  svn ci -m'do a'
  cd ..
  git svn clone file://$(pwd)/svnrepo gitwt
  cd gitwt
  echo b > a
  git add a
  git commit -mb
  echo c>a
  git add a
  git commit -mc
  git log --oneline
  git svn dcommit 1b4c4e1

where 1b4c4e1 was the abbreviated hash of the parent commit (i.e., the
commit 'b').  As expected, it commits everything *up to* 1b4c4e1 from
a detached HEAD, not affecting the current branch.

Note that this is different from what you describe:

> (If I remember to copy and paste the whole nine yards of the
> revision string, it works as expected, i.e. commits just that
> revision.)

It was never designed to commit "just that revision".

By "it" I mean 5eec27e (git-svn: let 'dcommit $rev' work on $rev
instead of HEAD, 2009-05-29), which changed it to the current
semantics and went into 1.6.4.  Before that, 'git svn dcommit <foo>'
did something weird and you should avoid giving it arguments.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
