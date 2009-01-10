From: <4jxDQ6FQee2H@dyweni.com>
Subject: Re: Git - Pushing to a production website
Date: Fri, 9 Jan 2009 22:46:18 -0600
Message-ID: <20090109224618.5d8c461c@family.dyweni.com>
References: <20090109222344.3539138a@family.dyweni.com>
	<200901092238.06968.bss@iguanasuicide.net>
Reply-To: 4jxDQ6FQee2H@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 05:49:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLVnG-0007XO-1h
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 05:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbZAJEqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 23:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbZAJEqW
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 23:46:22 -0500
Received: from pl1.haspere.com ([208.111.35.220]:39954 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbZAJEqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 23:46:21 -0500
Received: from family.dyweni.com (173-23-155-27.client.mchsi.com [173.23.155.27])
	by pl1.haspere.com (Postfix) with ESMTPSA id 90C22C800E;
	Fri,  9 Jan 2009 22:46:20 -0600 (CST)
In-Reply-To: <200901092238.06968.bss@iguanasuicide.net>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.11; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105074>


> You could simply commit after running the perl script.  You could
> even commit to a branch so that it's (a little) less likely those
> changes get integrated into master.

How about this, ran by the post-update hook:


For the first update:

 - Do a git pull
 - Then create a new branch 'working' and checkout
 - Apply the patches to 'working' and commit

This leaves 'working' == 'master^'

For subsequent updates:
 - Compare the SHA1 hashes for 'working' and 'master^'.
   - If they don't match, throw an error and exit
 - Assuming they match, checkout 'master' and delete 'working'
 - Do a git pull
 - Then create a new branch 'working' and checkout
 - Apply the patches to 'working' and commit


This would keep the working directory clean and allow future updates to
occur, if no one commits anything to git 'working'.  If they did, the
script would exit and prevent the update requiring the developer to
review the commit logs and cherry-pick where necessary.
