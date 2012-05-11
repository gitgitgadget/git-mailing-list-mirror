From: Sebastian Kuzminsky <seb@highlab.com>
Subject: surprising behavior from merge
Date: Fri, 11 May 2012 16:25:29 -0600
Message-ID: <9A9AD20F-B316-4DC1-8C6A-E0FC6ED80A61@highlab.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 00:33:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSyOm-0003gv-Ds
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 00:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab2EKWdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 18:33:16 -0400
Received: from smtp.quartz.synacor.com ([205.169.121.111]:58914 "EHLO
	smtp.q.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659Ab2EKWdP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2012 18:33:15 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 May 2012 18:33:15 EDT
X_CMAE_Category: 0,0 Undefined,Undefined
X-CNFS-Analysis: v=1.1 cv=0ABQra+cUGCZLl+TLSZldWKxL9vllrlB+YjuiJekF0k= c=1 sm=0 a=OYrCpO3b4-wA:10 a=8D6UOEW8R_kA:10 a=kj9zAlcOel0A:10 a=NEAV23lmAAAA:8 a=DaRqKj6CVue6UHgjQcwA:9 a=CjuIK1q_8ugA:10 a=TMBAGMHkG2eaw9KJSPgtzw==:117
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: smtp01.quartz.synacor.com header.from=seb@highlab.com; sender-id=neutral
Authentication-Results: smtp01.quartz.synacor.com smtp.mail=seb@highlab.com; spf=neutral; sender-id=neutral
Authentication-Results: smtp01.quartz.synacor.com smtp.user=highlab@q.com; auth=pass (LOGIN)
Received-SPF: neutral (smtp01.quartz.synacor.com: 184.96.169.202 is neither permitted nor denied by domain of highlab.com)
Received: from [184.96.169.202] ([184.96.169.202:59397] helo=highlab.com)
	by smtp.q.com (envelope-from <seb@highlab.com>)
	(ecelerity 2.2.2.40 r(29895/29896)) with ESMTPA
	id 08/1C-03665-7E19DAF4; Fri, 11 May 2012 18:25:43 -0400
Received: from [67.51.249.130] (helo=[10.126.1.197])
	by highlab.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <seb@highlab.com>)
	id 1SSyHO-0008Kd-Gu
	for git@vger.kernel.org; Fri, 11 May 2012 16:25:42 -0600
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197702>

Hi folks, I just ran in to a strange behavior with git merge.

Things start out with two branches (let's call them 'master' and 'other') pointing at a particular commit.  In master I commit a small one-line change, then make a second commit that adds some stuff just after the line changed in the previous commit.  In the other branch, i cherry-pick the second commit from master (the one that adds the new stuff).  The cherry-pick succeeds, despite the fuzzy context.  So far, so good.

Next I try to merge other into master.  I expected it to notice there was nothing to do and leave the master tree unchanged, but it applied the "add new stuff" patch to master (even though that patch is already in master) and made a commit from that.  So it silently did the wrong thing, and now the file contains two copies of stuff I added.

That is a simplified version of what happened, in my real repo there were several (unrelated and unimportant) commits on both master and the other branch.  When the surprising double-add happened, i simplified the repo to remove distractions.  The simplified repo is here if anyone wants to inspect it:  https://github.com/SebKuzminsky/merge-problem


-- 
Sebastian Kuzminsky
