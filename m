From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 02 Mar 2009 13:03:58 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903021256200.17877@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
 <49ABB529.1080500@viscovery.net>
 <alpine.DEB.2.00.0903021137110.17877@perkele.intern.softwolves.pp.se>
 <alpine.DEB.1.00.0903021153520.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 02 13:06:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le6uo-00067H-9y
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 13:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbZCBMEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 07:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbZCBMEx
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 07:04:53 -0500
Received: from smtp.getmail.no ([84.208.20.33]:47330 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbZCBMEx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 07:04:53 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFV00A1NO82X300@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 13:04:50 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFV00MWOO6NJ200@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 13:03:59 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFV00FMMO6M6910@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 13:03:59 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id B27EE2FC03; Mon,
 02 Mar 2009 13:03:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id AF40F2FC02; Mon, 02 Mar 2009 13:03:58 +0100 (CET)
In-reply-to: <alpine.DEB.1.00.0903021153520.10279@pacific.mpi-cbg.de>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111930>

Johannes Schindelin:

> No.  As far as Git is concerned, the file names are just as much blobs as 
> the file contents.

I've struggled with the same problems on Linux before, since its file 
systems doesn't have the concept of characters, either. I guess it's just 
design principles, but as far as I am concerned, having file names be 
constructed from characters makes a lot more sense than having them 
constructed from bytes.

Git does the right thing in assuming commit messages and user names be UTF-8 
characters, though, it would have been nice to have file names covered by 
the same constraints.

> The fact that Windows messes with this notion just as it messes with the 
> file contents (think the endless story whose name is CR/LF) shows only how 
> "well" designed the concepts in Windows are.

In this case, yes, Windows' way of doing does make more sense, at least to 
me. And as far as text files are concerned, treating text as sequences of 
bytes are in most cases not a very smart thing to do, either, but it's hard 
not to given how most computers are constructed.

> And as it stands, we have at least two issues on the msysGit issue tracker 
> that complain that Git does not work with localized file names properly.
>
> So no, file names are not UTF-8 at all, especially not on Windows.

I am not trying to make file names *on Windows* to be UTF-8. I am trying to 
make file names on Windows be Windows file names, i.e UTF-16 Unicode. It's 
just that since Git internally uses the char* APIs, and from what I have 
seen in most other cases assume that char* text is UTF-8, I am trying to 
convert from Windows' view of path names to Git's (UTF-16 to UTF-8) and back.

The other way would be to keep the char* APIs but convert to the Windows 
locale encoding ("ANSI codepage"), but that will break horribly as not all 
file names that can be used on a file system can be represented as such. 
Plus, all calls to a Windows API using a char* path name *is* converted into 
UTF-16 anyway, since that is what is used internally in the Windows NT 
subsystems.

> Do not get me wrong, I really welcome you taking care of the issue, but I a
> do not think that forcing UTF-8 is a solution.

Some kind of handling of Git repositories where file names are not UTF-8 
would probably need to be added, yes.

-- 
\\// Peter - http://www.softwolves.pp.se/
