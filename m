From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] errors: "strict subset" -> "ancestor"
Date: Sat, 3 Nov 2007 08:51:29 +0100
Message-ID: <3F4A5458-AB2F-40C7-AA0E-9D26981BCE9D@zib.de>
References: <20071103023944.GA15379@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 08:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoDm6-0008Td-EQ
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 08:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbXKCHuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 03:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbXKCHuQ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 03:50:16 -0400
Received: from mailer.zib.de ([130.73.108.11]:43661 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788AbXKCHuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 03:50:14 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA37o9O9018594;
	Sat, 3 Nov 2007 08:50:09 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1075c.pool.einsundeins.de [77.177.7.92])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA37o7B0003464
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 3 Nov 2007 08:50:08 +0100 (MET)
In-Reply-To: <20071103023944.GA15379@fieldses.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63213>


On Nov 3, 2007, at 3:39 AM, J. Bruce Fields wrote:

> From: J. Bruce Fields <bfields@citi.umich.edu>
>
> The term "ancestor" is a bit more intuitive (and more consistent with
> the documentation) than the term "strict subset".
>
> Also, remove superfluous "ref", capitalize, and add some carriage
> returns, changing:
>
> 	error: remote 'refs/heads/master' is not a strict subset of local  
> ref 'refs/heads/master'. maybe you are not up-to-date and need to  
> pull first?
> 	error: failed to push to 'ssh://linux-nfs.org/~bfields/exports/ 
> git.git'
>
> to:
>
> 	error: remote 'refs/heads/master' is not an ancestor of
> 	 local 'refs/heads/master'.
> 	 Maybe you are not up-to-date and need to pull first?
> 	error: failed to push to 'ssh://linux-nfs.org/~bfields/exports/ 
> git.git'


Junio suggested in [1] (see also earlier messages in that
thread) to replace the recommendation to pull with a hint
where to look in the user manual.

[1] http://marc.info/?l=git&m=119398999317677&w=2


The point is, there are various ways to resolve the problem.
pull is not necessarily the right solution. At least, you should
consider to rebase. Or maybe just something else went wrong.

Nonetheless I think it could be a good idea to keep the most
likely cases. So, how about

"Are you up-to-date? Did you forget to pull or rebase? See User's  
Manual for details."

I put it as questions to avoid making a suggestion. The questions
should give sufficient hints for searching in the User's Manual.
I haven't found the single section that would explain exactly
the situation we're dealing with.

I attached the commit that originally introduced the suggestion.

	Steffen


commit 69310a34cb6dcca32b08cf3ea9e91ab19354a874
Author: Junio C Hamano <junkio@cox.net>
Date:   Thu Dec 22 12:39:39 2005 -0800

     send-pack: reword non-fast-forward error message.

     Wnen refusing to push a head, we said cryptic "remote 'branch'
     object X does not exist on local" or "remote ref 'branch' is not
     a strict subset of local ref 'branch'".  That was gittish.

     Since the most likely reason this happens is because the pushed
     head was not up-to-date, clarify the error message to say that
     straight, and suggest pulling first.

     First noticed by Johannes and seconded by Andreas.

     Signed-off-by: Junio C Hamano <junkio@cox.net>
