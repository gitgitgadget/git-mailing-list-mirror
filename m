From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 01:47:19 +0200
Organization: At home
Message-ID: <f3agkk$bhn$1@sea.gmane.org>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <Pine.LNX.4.64.0705262318190.4648@racer.site> <4658BA64.2050904@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 01:55:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs66Y-0007O6-71
	for gcvg-git@gmane.org; Sun, 27 May 2007 01:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbXEZXzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 19:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbXEZXzV
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 19:55:21 -0400
Received: from main.gmane.org ([80.91.229.2]:53163 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbXEZXzU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 19:55:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hs64e-0004Mn-0b
	for git@vger.kernel.org; Sun, 27 May 2007 01:53:28 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 01:53:27 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 01:53:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48510>

Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:

>>>> * git version reports just:
>>>>
>>>>    git version -dirty
>>>>
>>>> Since git-gui parses the output of git version, but does not expect it
>>>> to be of this format, and fails with an error message that it cannot
>>>> parse the version.
>>> My biggest problem is that the makefiles of git are an unmitigated
>>> disaster, and there seems to be little interest in solving this
>>> problem. For example, my suggestion to introduce autoconf was met with
>>> derision.
>> 
>> Well, I would not call it derision. But many people have had bad 
>> experience with that big mess which is autoconf, so we were more than 
>> reluctant to do it.
> 
> autoconf is not that big a mess, but it is a macrolanguage, which does
> come with its pitfalls.  Automake and libtool are the messy things,
> and I prefer to stay away from them as far as possible.
> 
> The point of autoconf is to generate a hyper-portable script that
> deals with all the different flavors of shell breakage.  For the user
> it simplifies compiling packages enormously, which IMO should be the
> guiding concern if you like to have users.
> 
> For a pretty run-of-the-mill tool like git (dependency wise), it
> should be easy to write a working configure.in.
> 
> My favorite approach is: use autoconf to generate
> 
>  - config.h
>  
>  - config.make
> 
> All settings that force recompile should be in config.h, and standard
> C methods to track dependencies will take care of the recompilation
> when anything changes.  The main Makefile includes config.make, and
> contains all configurable settings. The Makefile only needs to be
> edited by developers. Require GNU Make so you can write sane
> makefiles.

Actually we do have configure.ac script; ./configure (result of
"make configure") is not distributed in the tarball I think.
It generates file named not config.make, but config.mak.autogen.
By the way, the .autogen suffix is to distinguish ./configure generated file
from handmade user configureation, but I have no idea why it is config.mak
not config.make. But there is no config.h -- we do not rely on automake and
autoheader.

If you are well wersed in autoconf, feel free to improve our configure.ac
script.
 
> Instead, we have a Makefile that relies on an esoteric combination of
> perl and shell scripting inside Makefiles.

The idea is to be able to get reasonable defaults (depending on system of
course) without needing autoconf, and running quite long on some
platform ./configure script detection...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
