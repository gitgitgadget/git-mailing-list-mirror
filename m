From: Christoph Duelli <duelli@melosgmbh.de>
Subject: git mv + git pull issue
Date: Fri, 06 Jun 2008 09:57:19 +0200
Message-ID: <4848EDDF.7090906@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 10:01:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4WtF-0000SA-Ub
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 10:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764609AbYFFIA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 04:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764652AbYFFIA0
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 04:00:26 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:45146 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764589AbYFFIAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 04:00:25 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi1LqfccsoS0yxp1bU6IJpbRdTLsu3mhpkbx1+7KOeRow==
Received: from mail.melosgmbh.de (p5B07BA1F.dip0.t-ipconnect.de [91.7.186.31])
	by post.webmailer.de (mrclete mo27) (RZmta 16.41)
	with ESMTP id k0377dk566xtNe for <git@vger.kernel.org>;
	Fri, 6 Jun 2008 09:59:10 +0200 (MEST)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.033,BAYES_00: -1.665,TOTAL_SCORE: -1.632
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1)
	for git@vger.kernel.org;
	Fri, 6 Jun 2008 09:59:09 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84037>

"git mv" followed by a git pull (before commiting) the move, loses the 
"remove" part of the move. This can lead to dupes in the repository.


Consider the following steps:

# create a new repo with a file in it
mkdir gitmv
cd gitmv/
git init
touch afile
git add afile
git commit -a -m"first"

# clone it
cd ..
git clone gitmv/ gitmv-clone
cd gitmv-clone/
touch other
git add other
git commit -a -m"other"

cd ../gitmv
git mv afile newname
# do not commit
# now: afile is not in the directory anymore
# oh, I need those changes my colleague made...
git pull ../gitmv-clone/
# now: both(!) afile and newname are in the directory

If I commit now (and overlook this) I will have 2 copies of this file in 
my repository which is not usually what I want.


Suggestion:
+ if the file was not touched in the pulled commits, leave it (missing)
+ if it was touched: this should be a conflict

Best regards
-- 
Christoph Duelli
