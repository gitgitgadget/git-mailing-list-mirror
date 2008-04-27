From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RESEND] [PATCH] Fix tree mode of the file list for files
	containing curly brackets
Date: Sun, 27 Apr 2008 18:51:56 +0200
Message-ID: <20080427165156.GA3828@steel.home>
References: <20080314214904.GA5914@steel.home> <20080427105700.GA28896@steel.home> <18452.26961.14738.430774@cargo.ozlabs.ibm.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 18:52:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqA7L-0002Rh-Cf
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 18:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbYD0Qv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 12:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbYD0Qv7
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 12:51:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:57296 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbYD0Qv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 12:51:58 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarZw4lh2bA==
Received: from tigra.home (Faeb6.f.strato-dslnet.de [195.4.174.182])
	by post.webmailer.de (klopstock mo12) (RZmta 16.27)
	with ESMTP id N0625ek3RC0jpc ; Sun, 27 Apr 2008 18:51:56 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C2F67277BD;
	Sun, 27 Apr 2008 18:51:56 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B10EC56D28; Sun, 27 Apr 2008 18:51:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <18452.26961.14738.430774@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80455>

Paul Mackerras, Sun, Apr 27, 2008 13:53:53 +0200:
> Alex Riesen writes:
> 
> > As far as I could understand the online documentation the [lindex ...]
> > thing expects an array, which a string produced by git-ls-tree is not.
> > So [split ...] it first, to get a real Tcl string-array.
> 
> Unfortunately that will do the wrong thing if the filename contains a
> tab character.  I think the right thing is to split the line textually
> at the tab, then treat the first part as a list (which will be OK
> since it consists of words without special characters, separated by
> spaces), and the second part as the filename.  That is what I was
> trying to do anyway, but I forgot to strip off the part after the tab,
> which is why lindex got unhappy with it.  Here's the patch I'm about
> to commit.
> 

FWIW, it does the right thing for me:

    $ git init
    Initialized empty Git repository in .git/
    $ >a
    $ git add .
    $ gci -m.
    Created initial commit 86ee2fa: .
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 a
    $ git mv a ' { b } '
    $ gci -m.
    Created commit 2a90dc5: .
     1 files changed, 0 insertions(+), 0 deletions(-)
     rename a =>  { b }  (100%)
    $ gitk
    $ happy
    The program 'happy' is currently not installed.  You can install it by typing:
    sudo apt-get install happy
    bash: happy: command not found
