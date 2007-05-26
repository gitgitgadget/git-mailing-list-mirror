From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sat, 26 May 2007 16:41:22 -0300
Message-ID: <f3a2ke$9s7$1@sea.gmane.org>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 21:43:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs2Au-0005s6-PH
	for gcvg-git@gmane.org; Sat, 26 May 2007 21:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759542AbXEZTnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 15:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758373AbXEZTnd
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 15:43:33 -0400
Received: from main.gmane.org ([80.91.229.2]:42339 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758200AbXEZTnb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 15:43:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hs2Ah-00025C-HL
	for git@vger.kernel.org; Sat, 26 May 2007 21:43:27 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 May 2007 21:43:27 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 May 2007 21:43:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <4656A304.AF39A0B6@eudaptics.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48487>

Johannes Sixt escreveu:
>>
>> http://lilypond.org/git/binaries/mingw/git-1.5.1-2.mingw.exe
>>
>> it should also set $PATH.
> 
> I gave this some more testing and it turns out to be a well working
> toolset. Thank you very much!
> 
> There were still some issues remaining. These are the ones that should
> be fixable easily:
> 
> * git version reports just:
> 
> 	git version -dirty
> 
> Since git-gui parses the output of git version, but does not expect it
> to be of this format, and fails with an error message that it cannot
> parse the version.

My biggest problem is that the makefiles of git are an unmitigated
disaster, and there seems to be little interest in solving this
problem. For example, my suggestion to introduce autoconf was met with
derision.  Most of the effort was patching out makefile parts that
made my life harder. I may have patched the version part out as well.

In this, part of the pain is that Git tries to guess the version number
by itself in a complicated way.  It would be easiest if I could just 
specify the version number externally. In that case I can sync the installer
version number (1.5.1-2 in this case) and the version that git reports.


> * git without an correct git subcommand should list 20 or so commands,
> but it doesn't. The list is just empty.


there was a problem in generate cmd list,  (I have sort in /bin/ ). I
recommend to add

  set -u -v   

to all shell scripts so this doesn't go unnoticed.

> * I personally think that the files should go into
> 
> 	$PROGRAMFILES/Git/{bin,share,lib}
> instead of
> 	$PROGRAMFILES/Git/usr/{bin,share,lib}
> 
> The more difficult to solve problems are:

I understand, but it makes my life a lot more difficult.

> * git-gui and gitk don't work out of the box because they have the path
> to wish hardcoded. They can't be started from CMD at all. I have written
> wrappers gitk.cmd and git-gui.cmd with these 2 lines:
> 
> @echo off
> start wish84 D:/MSYS/1.0/git/bin/gitk %*
> 
> But as you can see, the path is still hard-coded (but it is good enough
> for me for the moment).

The only solution is to x-compile wish and include it as well.  I need several 
strong drinks to start trying this.  Is there a MinGW wish port?

> * perl scripts like git-remote contain a hard-coded path to the
> installation directory and don't work for this reason.

I actually commented out most perl stuff because the Makefile is just
too spaghetti-ish. I seem to have forgotten commenting out git-remote.

I thought the policy was to abandon Perl scripts for git commands?

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
