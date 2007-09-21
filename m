From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: cvsimport bug on branches [was: conversion to git]
Date: Fri, 21 Sep 2007 07:18:50 +0200
Message-ID: <8D5EA3F4-9642-4604-963E-838D03650FBC@zib.de>
References: <loom.20070920T010842-272@post.gmane.org> <46F31BBB.1040901@byu.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: m4-patches@gnu.org, Jim Meyering <jim@meyering.net>,
	git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 08:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYbro-0000dA-GY
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 08:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbXIUGTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 02:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbXIUGTv
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 02:19:51 -0400
Received: from mailer.zib.de ([130.73.108.11]:33182 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbXIUGTu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 02:19:50 -0400
X-Greylist: delayed 3429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2007 02:19:50 EDT
Received: from mailsrv2.zib.de (sc1.zib.de [130.73.108.21])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8L5MCHQ006846;
	Fri, 21 Sep 2007 07:22:12 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db109f9.pool.einsundeins.de [77.177.9.249])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8L5MAYu015758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 21 Sep 2007 07:22:11 +0200 (CEST)
In-Reply-To: <46F31BBB.1040901@byu.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58828>


On Sep 21, 2007, at 3:17 AM, Eric Blake wrote:

> According to Eric Blake on 9/19/2007 5:13 PM:
>> I'm working on converting M4 to git.
>>
>> The initial git conversion is complete.  Feel free to check it out:
>>
>> http://git.savannah.gnu.org/gitweb/?p=m4.git
>
> Unfortunately, after publishing this repository, I noticed that  
> there is a
> bug in git-cvsimport, when a vendor branch is created that contains  
> fewer
> files than the point it branched from.  Those files were not  
> removed from
> the commit on the new branch, which means the git repository  
> contains too
> many files compared to what the CVS repository had for any checkout  
> along
> the branch.
>
> [...]

git-cvsimport may have more problems, see e.g.

http://marc.info/?l=git&m=118385565913953&w=2
http://marc.info/?l=git&m=118260312708709&w=2


> Now that the repository is published, what's the best way to  
> correct the
> history for the git m4-1.4.1 tag, to correctly pick the m4-1.4  
> commit as
> its parent, and to omit the files that were intentionally omitted  
> from the
> CVS branch it was imported from?

Hard to say. The best is to avoid git-cvsimport if you need
to import branches correctly.

And you should do validate the result of any import by comparing
a working copy checked out from CVS with a working copy checked
out from git.

Never trust the cvs to git importers.


> What needs to be done to git-cvsimport to make it recognize files that
> were omitted from CVS branch creation points, to avoid this problem  
> in the
> first place?

I'd recommend not to use git-cvsimport but better use
a different converter.

For me parsecvs [1] works.

I'd also give cvs2svn's git support [2] a try.

cvs2svn strives much harder to report errors and handle complex
history correctly. parsecvs for example just crashes on corrupted
RCS files, while cvs2svn reports the problem. But if your CVS
repository is good parsecvs is much faster.

fromcvs/togit was also mentioned a couple of times on the list.
It worked for me the last time I tried it. But I did no in depth
validation of the result.

I still believe it would be good to add a warning to the
documentation of git-cvsimport and provide links to alternatives.

	Steffen

[1] http://gitweb.freedesktop.org/?p=users/keithp/parsecvs.git
[2] http://marc.info/?l=git&m=118592701426175&w=2
