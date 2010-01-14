From: Soham Mehta <soham@box.net>
Subject: git checkout -f: What am I missing?
Date: Thu, 14 Jan 2010 13:16:12 -0800
Message-ID: <4B4F899C.7070800@box.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 22:45:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVXVa-0000DN-Sb
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 22:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab0ANVp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 16:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754206Ab0ANVp1
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 16:45:27 -0500
Received: from corpmail.ve.box.net ([209.249.140.137]:37011 "EHLO
	corpmail.ve.box.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab0ANVp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 16:45:27 -0500
X-Greylist: delayed 1747 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2010 16:45:27 EST
Received: from [10.8.30.42] (unknown [66.151.150.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by corpmail.ve.box.net (Postfix) with ESMTP id 7202814DC89
	for <git@vger.kernel.org>; Thu, 14 Jan 2010 13:16:20 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137029>

Hi,

I have a situation with git that I'm trying to understand:

Description:
1) GIT_DIR is set to /path/to/repo/.git
2) Repository is /not /a bare repo, and all files are nicely checked-out 
in /path/to/repo/
3) Somebody pushes to that repo using ssh (any branch, checked-out or not)
4) Default post-receive hook runs (it is the only one +x) which sends 
out an email 
(http://repo.or.cz/w/git.git/blob/HEAD:/contrib/hooks/post-receive-email)
5) After it is done sending the email, I put "git checkout -f", at the 
end in the same file, in case someone pushes to a checked-out branch

Problem:
It runs "checkout -f" as if inside .git directory, instead of on the 
parent. i.e. it gets all files from the parent and writes them inside 
.git. Parent is left untouched.

Some more info:
0) We don't have GIT_DIR set in the environment. The hook does a 
rev-parse to find it.
1) echo of $GIT_DIR right before the checkout -f line gives a "." .
2) It works as expected if I do this:  cd /path/to/repo && git 
--git-dir=/path/to/repo/.git/ checkout -f

What I do know:
1) Pushing to a checked-out branch is not a git best-practice, and some 
git behavior is undefined in that case. We already have plans to go away 
from that.
2) Git tends to like full path names instead of relative ones

Can someone help me understand this behavior?

Thanks.
-Soham
