From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 4 Jun 2009 14:57:48 -0700
Message-ID: <20090604215748.GS3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com> <200906022339.08639.jnareb@gmail.com> <200906042255.43952.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:57:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKwg-0005w3-9w
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbZFDV5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 17:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbZFDV5q
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:57:46 -0400
Received: from george.spearce.org ([209.20.77.23]:50611 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbZFDV5q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 17:57:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9225E381D1; Thu,  4 Jun 2009 21:57:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906042255.43952.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120723>

Jakub Narebski <jnareb@gmail.com> wrote:
> 
> By the way, is there some publicly accessible JGit (Java) and Dulwich
> (Python) git-daemon one can test against?

There is a public JGit SSH based daemon running at
review.source.android.com, on port 29418.  But no
public git-daemon that I know of.

You can easily set up a JGit daemon yourself, assuming you have a
'javac' available:

  git clone git://repo.or.cz/egit.git jgit
  cd jgit
  ./make_jgit.sh
  ./jgit daemon --export-all . &
  git ls-remote git://localhost/.git
 
> Actually both git.kernel.org and github.com failed (deadlocked / hung)
> when I tried to add extra key=value parameter at the end of request:
> 
>   003bgit-upload-pack /project.git\0host=myserver.com\0user=me\0

JGit does it fine.  I retested locally with this:

 perl -e '$s="git-upload-pack $ARGV[0]\0hosterver.com\0user=me\0";
   printf "%4.4x%s",4+length $s,$s
   ' /.git | nc localhost 9418

But yea, repo.or.cz hung.  I see the bug in git daemon, I'll post
a patch in a second.  Don't do that test anymore, anywhere.

-- 
Shawn.
