From: Brian Dessent <brian@dessent.net>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 13:05:51 -0700
Organization: My own little world...
Message-ID: <4713C81F.A75FEFC2@dessent.net>
References: <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net> <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home> <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site> <4713BA89.633B86F2@dessent.net> <20071015194214.GC15541@steel.home>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Eli Zaretskii <eliz@gnu.org>, ae@op5.se,
	tsuna@lrde.epita.fr
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 22:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhWCo-0004aT-1i
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 22:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947AbXJOUGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 16:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933479AbXJOUGJ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 16:06:09 -0400
Received: from dessent.net ([69.60.119.225]:44259 "EHLO dessent.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756733AbXJOUGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 16:06:07 -0400
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1IhWCI-0001ML-Hc; Mon, 15 Oct 2007 20:05:54 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61037>

Alex Riesen wrote:

> Hmm... Could the allocation of large contiguous blocks also lock the
> system hard? For instance, I avoid starting the test suite on my XP
> workstation at work: it locks up hard every time. W2k works.
> The system has nothing unusual in it. Well, it has an antivirus
> program (which hopefully stopped working after a series of crashes,
> which is just as well), an NVidia card with native driver (which is
> broken in its own usual ways). Maybe that's enough

In terms of the MSYS/Cygwin style of fork emulation, large memory
allocations shouldn't pose any real problem, but they will be slow as
the fork emulation has to manually replicate the state of the parent in
the child and this means copying memory extents.  (Yes, horribly ugly,
no doubt about it, but it allows for porting.)

This emulation code is sensitive enough that the Cygwin list has begun
to maintain a list of software whose hooks/interference can cause Cygwin
apps to fail: <http://cygwin.com/ml/cygwin-talk/2007-q3/msg00174.html>. 
Since MSYS is derived from the same code I see no reason why the list
wouldn't also implicate potential problems with binaries linked to the
MSYS runtime.

Johannes Schindelin wrote:

> We never had the problem in git itself, since we never used fork() on
> Windows.  The problem lies in our usage of bash and perl.
> 
> Bash we can fix in the long run (this goes under the keyword
> "builtinification" on the git list), but I do not see our reliance on Perl
> going away, not for git {send-email,cvsimport,cvsexportcommit,svn}.
> These are not too common operations, so common users will be able to do
> without them.
> 
> However, if you rely on the CVS/SVN connectors, or send-email, and in any
> case in the short run, you better run Git on Windows only when that funny
> Logitech driver is disabled ;-)

Well, instead of using an MSYS build of Perl there's always ActiveState
Perl.  I think you may be stuck on the shell though -- I don't know of
any ports of bash that aren't MSYS or Cygwin based.  However I do think
there's a native port of zsh out there by the GnuWin32 project, which
when renamed as just "/bin/sh" might be suitable, but only if these
scripts don't use bash-isms.  I have not tried this zsh myself and
speed/compatibility wise I'm not sure it's up to snuff.

Brian
