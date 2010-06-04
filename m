From: Warren Harris <warrensomebody@gmail.com>
Subject: git-svn: local commits going to svn/trunk
Date: Fri, 4 Jun 2010 09:16:57 -0700
Message-ID: <F2265BC9-B023-46F9-BA72-ECEE62F23F8D@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 04 18:17:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKZa2-0002ga-Ah
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 18:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab0FDQRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 12:17:04 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38052 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0FDQRD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 12:17:03 -0400
Received: by pwj5 with SMTP id 5so70761pwj.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=vUXrFvlgHgVkmwtEEgeoYTIg+I37PnQ5eirU8uc2xZA=;
        b=IsmzsyF807gbJX6IE1B0hP0f6Oxxxkraio7V47oKm++G0MSwgaqkMQ/AM+qZI+KArN
         kduJHZVZ7QhElXfdKcrV2hkbZRU0k0p1s/q9TGZdRaWWQAPfmP149vRkV6v7g2SlAltG
         6rs8/SrTraw6P1kVEW4AHMJkVAicX852Wcw90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=GuuAZSvRSeTDctRijMgd2PI61VqRltykxT92ZrNoKtngy/MqPmSis73746XfHEp9Qd
         b3GTKC0QXmKVJiF+HiTzzQZYkNb7c1kxhUhLJOynKpVzBI9w5piYUyM3y1yVGRkt6s3+
         7ZQzDsP5jh/rM0egBtiRonuVicE0CnK66+EbU=
Received: by 10.141.101.21 with SMTP id d21mr9190270rvm.95.1275668221847;
        Fri, 04 Jun 2010 09:17:01 -0700 (PDT)
Received: from [192.168.0.34] (c-24-5-88-93.hsd1.ca.comcast.net [24.5.88.93])
        by mx.google.com with ESMTPS id b10sm2519766rvn.15.2010.06.04.09.16.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 09:17:00 -0700 (PDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148426>

I seem to have gotten off the beaten path in my usage of git-svn and could use some advice. I routinely use git-svn to land my personal git repo into a shared svn repo (usually doing a 'git svn rebase', 'git svn dcommit')... but apparently forgot to rebase before a commit a few days ago. My dcommit got a merge conflict so I then rebased and dcommitted again. Now, several days and several dcommits later I realize that I've been working on my svn branch (git stat says "Not currently on any branch.") and the view in gitx shows:

--A--B--C--D'--E... svn/trunk  (where my checkins seem to be going)
  \
    C--D  master

where: 
A is the common root
B is the svn commit that caused my merge problem, 
C is part of the changes I was trying to land (went cleanly into svn)
D is the master commit that had the merge conflict,
D' is the commit I made after fixing the conflict (I didn't realize this was going onto the svn branch, not identical to D)
E is the beginning of all the checkins I've made after hitting this problem

I believe the steps that got me here were (reconstructing from my history):

-- at D on master
git svn dcommit -- forgot to rebase first
-- merge problem with B
-- accidentally left on the svn branch?
git svn rebase  -- trying again with a rebase first, but maybe I wasn't on master here?
git svn dcommit
-- fixed merge conflicts
git commit -- created D' locally
git svn dcommit -- pushed D' to svn repo
-- subsequent checkins to my svn branch instead of master...

Anyway, after realizing this problem last night, I tried to 'git co master', 'git svn rebase' but got massive conflicts. I aborted this, but now I'm wondering how to fix this mess. Maybe 'git co svn/trunk', 'git branch -M master'?... but I don't want to make problems worse.

Warren