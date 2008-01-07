From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 13:58:21 +0100
Message-ID: <4228FF68-2C9A-49A4-B9E5-406D2FB09EB9@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de> <flsu0r$m9p$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Klavins <klavins@netspace.net.au>
X-From: git-owner@vger.kernel.org Mon Jan 07 13:58:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBrYQ-0001nV-K1
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 13:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbYAGM5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 07:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755380AbYAGM5k
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 07:57:40 -0500
Received: from mailer.zib.de ([130.73.108.11]:53588 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754735AbYAGM5j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 07:57:39 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m07CvGoK022359;
	Mon, 7 Jan 2008 13:57:17 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m07CvEf6026662
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 7 Jan 2008 13:57:15 +0100 (MET)
In-Reply-To: <flsu0r$m9p$1@ger.gmane.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69789>


On Jan 7, 2008, at 11:13 AM, Peter Klavins wrote:

> I use an alternate workaround that clones the repository, removes  
> the checked out files, sets autocrlf, then checks out the files again:
>
> $ git clone git://git.debian.org/git/turqstat/turqstat.git
> $ cd turqstat
> $ git config --add core.autocrlf true
> $ rm -rf * .gitignore
> $ git reset --hard
>
> The result should now be the same as using Steffen's system.

Yes, this should yield the same.


> However, there is still an unresolved problem with git's way of  
> treating cr/lf as an attribute only of the checkout and not the  
> repository itself:
>
> $ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   visualc/.gitignore
> #       modified:   visualc/turqstat.sln
> #       modified:   visualc/turqstat.vcproj
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> So, checking out the repository with cr/lf true has now caused  
> misalignment of files that were originally checked in with existing  
> cr/lf's in place. Visual Studio in fact happily works with files  
> that only have lf endings, _except_ *.sln and *.vcproj files, which  
> it much prefers to have with cr/lf endings.

You could try .gitattributes to exclude files from crlf
conversion.  But I'd not recommend this, because the mechanism
has some deficiencies, as discussed in

http://thread.gmane.org/gmane.comp.version-control.git/61888


> The _real_ solution to this problem for the moment is _not_ to mix  
> files with both lf and cr/lf endings in the repository.

This is the way to go.


> So, the original author of the repository should _also_ have used  
> core.autocrlf true, thus causing the *sln and *vcproj to have their  
> cr's stripped on checkin, but replaced on checkout when checking  
> out with autocrlf true.

For cross-platform projects, I recommend to explicitly configure
autocrlf on Windows and Unix.  On Windows set

    git config core.autocrlf true  # on Windows

and on Unix set

    git config core.autocrlf input # on Unix

This ensures that the repository only contains LF.  Even if someone
emails source code from Windows to Unix and commits it there.

	Steffen
