From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 21:46:23 +0100
Message-ID: <20071218204623.GC2875@steel.home>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:47:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jL3-0003cl-12
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbXLRUq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbXLRUq0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:46:26 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:27078 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXLRUqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:46:25 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsGSh4=
Received: from tigra.home (Fcb97.f.strato-dslnet.de [195.4.203.151])
	by post.webmailer.de (mrclete mo44) (RZmta 14.6)
	with ESMTP id j06a38jBIFsHRx ; Tue, 18 Dec 2007 21:46:23 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 83950277AE;
	Tue, 18 Dec 2007 21:46:23 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 6AA4F56D22; Tue, 18 Dec 2007 21:46:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3d4t3q4e5.fsf@roke.D-201>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68809>

Jakub Narebski, Tue, Dec 18, 2007 18:50:20 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Noticed by a collegue of mine. Consider:
> > 
> >     $ cd $GIT/t
> >     $ git show 570f32266:t/test-lib.sh    # works
> >     $ git show 570f32266:test-lib.sh      # does not work
> >     $ git show 570f32266:./test-lib.sh    # does not work
> >     $ git show 570f32266:/t/test-lib.sh   # does not work
> > 
> > Considering that the relative path names work as filters (and many
> > agreed on that being useful), it would be nice to allow relative
> > pathnames in blob specifications for git-show and git-cat-file.
> > 
> > (besides the colon is a good delimiter, even tab-completion works with it)
> 
> If you think about it a bit, relative path names nor absolute
> path names does and should not work.  570f32266:t/test-lib.sh
> means path t/test-lib.sh staring from 570f32266^{tree}.  Where
> you are in the filesystem is not important and matters not for
> this syntax.  Besides if you access other branch file might be
> not in filesystem (deleted file, or disjoint branch with separate
> contents like 'todo' or 'html' branch in git.git repository).

Not convinced. It is *not* the plumbing problem I was trying to
describe. They discussion, metaphorically, should not have left the
command-line parser.

I think that we have parsing of the blob locators at the wrong level:
so that git-show, git-log and git-diff can handle its pathnames as
they handle path filters (relative to cwd), and git-cat-file,
git-diff-tree, git-rev-list, etc can handle theirs always relative to
the project root.

I actually do not see any problem for git-show (being porcelain-level
program) to treat *each and every* path anywhere relatively to the
current directory. It is just more comfortable.

Please consider the following patches.
