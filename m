From: Stephen Bash <bash@genarts.com>
Subject: "Already up-to-date!" merge isn't a no-op?
Date: Wed, 6 Mar 2013 16:48:07 -0500 (EST)
Message-ID: <142915274.2151729.1362606487755.JavaMail.root@genarts.com>
References: <1826064298.2151517.1362605175796.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 06 22:59:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDMMf-0001mO-9s
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 22:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab3CFV6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 16:58:43 -0500
Received: from hq.genarts.com ([173.9.65.1]:60421 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754154Ab3CFV6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 16:58:43 -0500
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Mar 2013 16:58:33 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 686A6BE2F06
	for <git@vger.kernel.org>; Wed,  6 Mar 2013 16:48:13 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NyTrPRZwIWCu for <git@vger.kernel.org>;
	Wed,  6 Mar 2013 16:48:07 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id C47F0BE33FE
	for <git@vger.kernel.org>; Wed,  6 Mar 2013 16:48:07 -0500 (EST)
In-Reply-To: <1826064298.2151517.1362605175796.JavaMail.root@genarts.com>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC25 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217556>

Hi all-

I have a branch history that looks like this:

 ----------M-----M-- master
  \       /     /
   x---------------- feature
    \             \
     x-------------A- maint

In other words we had a new feature that was "so cool" that after testing on master was back-ported to maint (luckily we knew ahead of time this was likely).  When it came time to merge feature into maint the process looked something like this:

Yesterday (not shown above):
 $ git checkout master
 $ git merge maint

Today:
 $ git checkout maint
 $ git merge feature
 Merge made by the 'recursive' strategy.
 $ git checkout master
 $ git merge maint
 Already up-to-date!
 Merge made by the 'recursive' strategy.
 $ git --version
 git version 1.8.1.5

In the past, I've only seen "Already up-to-date!" when there is literally nothing to do (all commits are reachable from HEAD).  In this case, the merge of feature into maint (commit A) is the only commit not reachable from HEAD, and Git does create a merge commit (though the new commit and the first parent point to the same tree).  The fact that a commit is created makes me call this something more than a no-op, even though no content changed.

So what is the actual meaning of "Already up-to-date!"?  Is it based on the tree, the reachable commits, or something more complicated?

Thanks,
Stephen
