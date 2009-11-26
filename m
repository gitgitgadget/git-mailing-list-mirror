From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Octopus merge
Date: Thu, 26 Nov 2009 17:52:39 +0100
Message-ID: <4B0EB257.8080002@drmicha.warpmail.net>
References: <4B0EA512.1050001@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Claudia.Ignat@loria.fr
X-From: git-owner@vger.kernel.org Thu Nov 26 17:54:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDhbS-0006hJ-FL
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 17:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbZKZQxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 11:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbZKZQxq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 11:53:46 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54230 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755859AbZKZQxp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 11:53:45 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 07DC5C2ABF;
	Thu, 26 Nov 2009 11:53:50 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 26 Nov 2009 11:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=TMYSfm8am2H9tBc+ud6JczNwktM=; b=tjx5Hf6IcACTIXPTdfbYKXxa+N5DmVTzUfV6iCu8JS5Z9rCtLMJ4yVN0HI7ncQ2dRJ9Yxuk/4XpzJ940aPY5ScqFjNCwJSKWj5xVy6ZcJswejVmBX7JCX7iPGGG8fPGW8LZfCWQg8i/xq19dD7CsLdwyKeZ8Vj0K/WuxQd7IzXM=
X-Sasl-enc: c1GVa8rrlSniHcGH3UuCF5NXvUN3hOxgkfBZ2uNbSnLT 1259254429
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2CDE728437E;
	Thu, 26 Nov 2009 11:53:49 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <4B0EA512.1050001@loria.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133811>

Claudia.Ignat@loria.fr venit, vidit, dixit 26.11.2009 16:56:
> # !/bin/bash
> TEST_NAME="TP1" # name of the working directory
> rm -rf ${TEST_NAME} # cleaning working directory
> mkdir -p ${TEST_NAME}
> cd ${TEST_NAME}
> 
> # initialising initial git workspace
> mkdir ws1
> cd ws1
> git init
> 
> # adding a file to ws1
> # commit changes
> echo -e -n "1\n2\n3\n4\n5\n" > file.txt
> git add file.txt
> git commit -m "ws1 | add 12345"
> cd ..
> 
> # cloning three times ws1 (as ws2, ws3 and ws4)
> git clone ws1 ws2
> git clone ws1 ws3
> git clone ws1 ws4
> git clone ws1 ws5
> 
> # updating file.txt in ws2 (insert X at line 3, then write and quit 'ed')
> # commit changes
> cd ws2
> echo -e "3i\nX\n.\nw\nq\n" | ed file.txt
> git add file.txt
> git commit -m "ws2 | insert 12X345"
> cd ..
> 
> 
> # updating file.txt in ws3 (insert Y at line 3, then write and quit 'ed')
> # commit changes
> cd ws3
> echo -e "3i\nY\n.\nw\nq\n" | ed file.txt
> git add file.txt
> git commit -m "ws3 | insert 12Y345"
> cd ..
> 
> cd ws4
> echo -e -n "U1\n2\n3\n4\n5\n" >  u.txt
> git add u.txt
> git commit -m "ws4 | add u.txt"
> cd ..
> 
> cd ws5
> echo -e -n "W1\n2\n3\n4\n5\n" > w.txt
> git add w.txt
> git commit -m "ws5 | add w.txt"
> cd ..
> 
> # ws3 pull from ws2 ws4 ws5
> cd ws3
> git remote add bws2 ../ws2
> git remote add bws4 ../ws4
> git remote add bws5 ../ws5
> git fetch bws2
> git fetch bws4
> git fetch bws5
> git merge bws4/master bws2/master bws5/master
> cd ..
> 
> # resolve conflict in ws3
> cd ws3

First of all, thanks for the clear description and test case!

The octopus strategy cannot do merges which need manual resolution. Or
so the doc says. After trying the merge with 4 2 5, Git tells you:

Trying simple merge with 7ff9b5bd514cb600bac935ebd40eae366bba7d19
Trying simple merge with 6872cd350154743d59cb4d313cbdb122ac43e537
Simple merge did not work, trying automatic merge.
Auto-merging file.txt
ERROR: content conflict in file.txt
fatal: merge program failed
Automated merge did not work.
Should not be doing an Octopus.
Merge with strategy octopus failed.

That is, it aborts the merge completely. If you "resolve" it and commit
it's simply a commit that you make.

If, instead, you merge 4 5 2, Git tells you:

Trying simple merge with e4f78f6905bed39bcd96790a4f63e138a455a445
Trying simple merge with 14c1f2a70767334df5d6d3120631752564094699
Trying simple merge with 8540a039d3fc964d097d4f037357668441d1d4f5
Simple merge did not work, trying automatic merge.
Auto-merging file.txt
ERROR: content conflict in file.txt
fatal: merge program failed
Automatic merge failed; fix conflicts and then commit the result.

Admittedly this looks fatal also, but the last line tells you that the
actual merge process is not aborted yet. If you resolve the conflict and
commit without -m you even see the prepared commit message.

So, octopus can deal with manual conflict resolution if the conflicts
appear in the last step only. That is the difference between the two cases.

Now, in the first case the aborted merge leaves some traces in the index
as well as in the worktree. I'm not sure that is how it's supposed to be.

Cheers,
Michael
