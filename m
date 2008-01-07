From: "Peter Klavins" <klavins@netspace.net.au>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 11:13:31 +0100
Message-ID: <flsu0r$m9p$1@ger.gmane.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 11:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBozy-0006QH-Ar
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 11:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYAGKN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 05:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbYAGKN7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 05:13:59 -0500
Received: from main.gmane.org ([80.91.229.2]:57440 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116AbYAGKN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 05:13:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JBozU-0005rB-4U
	for git@vger.kernel.org; Mon, 07 Jan 2008 10:13:56 +0000
Received: from host74-244-static.104-82-b.business.telecomitalia.it ([82.104.244.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 10:13:56 +0000
Received: from klavins by host74-244-static.104-82-b.business.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 10:13:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: host74-244-static.104-82-b.business.telecomitalia.it
In-Reply-To: <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de>
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16545
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69779>

I use an alternate workaround that clones the repository, removes the 
checked out files, sets autocrlf, then checks out the files again:

$ git clone git://git.debian.org/git/turqstat/turqstat.git
$ cd turqstat
$ git config --add core.autocrlf true
$ rm -rf * .gitignore
$ git reset --hard

The result should now be the same as using Steffen's system.

However, there is still an unresolved problem with git's way of treating 
cr/lf as an attribute only of the checkout and not the repository itself:

$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   visualc/.gitignore
#       modified:   visualc/turqstat.sln
#       modified:   visualc/turqstat.vcproj
#
no changes added to commit (use "git add" and/or "git commit -a")

So, checking out the repository with cr/lf true has now caused misalignment 
of files that were originally checked in with existing cr/lf's in place. 
Visual Studio in fact happily works with files that only have lf endings, 
_except_ *.sln and *.vcproj files, which it much prefers to have with cr/lf 
endings.

The _real_ solution to this problem for the moment is _not_ to mix files 
with both lf and cr/lf endings in the repository.

So, the original author of the repository should _also_ have used 
core.autocrlf true, thus causing the *sln and *vcproj to have their cr's 
stripped on checkin, but replaced on checkout when checking out with 
autocrlf true.

------------------------------------------------------------------------
 Peter Klavins 
