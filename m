From: Phillip Susi <psusi@cfl.rr.com>
Subject: log -p hides changes in merge commit
Date: Thu, 06 Jan 2011 12:07:10 -0500
Message-ID: <4D25F6BE.7010300@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 18:02:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PatET-0005pL-F3
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 18:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab1AFRCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 12:02:31 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:33967 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab1AFRCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 12:02:30 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=Inhw+Jdt7z1D3BivGPfn2aw54OvUEJw5lAn/booRZkE= c=1 sm=0 a=qjtE1AqrqaAA:10 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=SCNhSqmx-buy6JJbC8sA:9 a=uEXf4jpHdigjlRENOuAA:7 a=TihdqA9JT9YPJWJrG3BaIl50cOcA:4 a=wPNLvfGTeEIA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:2768] helo=[10.1.1.235])
	by cdptpa-oedge04.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id 10/85-13137-4A5F52D4; Thu, 06 Jan 2011 17:02:29 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164642>

git log -p never shows a diff for merge commits.  It is nice that it
does not show a giant diff that is the sum of all of the changes being
merged, but any manual changes made on top of the merge are also lost
from view, and this is not good.  Here is a reproduction recipe:

git init
echo foo > a
git add a
git commit -m "added a"
git branch other
git checkout other
echo bar > b
git add b
git commit -m "added b"
git checkout master
git merge other
git log -p

At this point there is no diff shown in the log output.  This is fine
since there were no changes needed to complete the merge, and the
addition of b is already documented in the merged commit.  The problem
is that if you add --no-merge to the git merge, and then:

echo bart > a
git add a
git commit

Now in addition to merging b, you have modified a, but git log -p still
shows no diff, effectively hiding the fact that you snuck in a
modification to a during the merge.

It seems that adding -c or --cc to the log correctly shows the change to
a, but why is this not shown by default?
