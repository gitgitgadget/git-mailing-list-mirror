From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] git-init: set core.worktree if GIT_WORK_TREE is specified
Date: Wed, 04 Jul 2007 12:41:01 +0200
Organization: eudaptics software gmbh
Message-ID: <468B793D.53661D60@eudaptics.com>
References: <20070703224919.GA22578@moooo.ath.cx> <20070704092915.GA18597@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 12:40:46 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I62Hu-0005UJ-3y
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 12:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757710AbXGDKkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 06:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757567AbXGDKkn
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 06:40:43 -0400
Received: from main.gmane.org ([80.91.229.2]:42898 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757266AbXGDKkm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 06:40:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I62Hi-0006XI-9p
	for git@vger.kernel.org; Wed, 04 Jul 2007 12:40:34 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 12:40:34 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 12:40:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51588>

Matthias Lederhofer wrote:
> 
> > +     if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
> > +             die("Unable to read current working directory");
> 
> Dscho just pointed out that this causes problems on windows.  The same
> is also in setup_git_directory_gently and was there before I touched
> it, introduced by Linus in d288a700.  What was the original reason to
> do this?  Are there implementations of getcwd which return a relative
> path?
> 
> Additionally there are other places which need to check if some user
> supplied path is absolute.  Should we have a macro/function for that
> which depends on the os and checks for path[0] = '/' on unix and
> perhaps path[1] = ':' on windows?

I've modified some places (that check for an absolute path) in the MinGW
port to read (path[0] == '/' || path[1] == ':'). I don't think that it's
necessary that you cater for this case in your code - I'll take care of
it in the MinGW port. Of course, a hint that there is another place to
watch out for, or even better a test case in t/, is most appreciated.

I still hope to find some time to rework the MinGW port. Then such
details will be hidden behind a is_path_absolute() function. Or maybe
getcwd_or_die() ;)

-- Hannes
