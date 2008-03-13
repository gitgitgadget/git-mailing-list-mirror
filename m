From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: optimized checkout+rebase?
Date: Thu, 13 Mar 2008 08:20:24 +0100
Message-ID: <47D8D5B8.70809@viscovery.net>
References: <20080312191041.GF3198@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 08:21:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZhkb-00048B-FO
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 08:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbYCMHUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 03:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbYCMHU3
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 03:20:29 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15206 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbYCMHU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 03:20:27 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZhj2-0002j0-F6; Thu, 13 Mar 2008 08:19:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BBD8F6B7; Thu, 13 Mar 2008 08:20:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080312191041.GF3198@ins.uni-bonn.de>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77042>

Ralf Wildenhues schrieb:
> this is a common work pattern:
> 
>   git checkout master
>   git pull
>   for branch in $my_topic_branches; do
>     git checkout $branch
>     git rebase master
>     # occasional fixups here...
>   done
> 
> Now, it looks to me that one of the first operations of rebase just
> undoes part of the work that the checkout of the branch did.  Well,
> "undoes" is the wrong word, what I mean is that it looks like work
> may be saved by combining the two checkout and the rewinding step.

Well, what you could do is:

   for branch in $my_topic_branches; do
     git rebase master $branch
     # occasional fixups here...
   done

But it seems that even then rebase first does the checkout $branch, and
then the checkout master right after that. At least the first checkout
should be unnecessary because all the revision range computations and
patch formating should be possible to do without the checkout. (The second
checkout is indispensable, of course.)

This has annoyed me, too, but not so much that I started looking at a fix,
though...

-- Hannes
