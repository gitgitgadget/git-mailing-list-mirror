From: Armin Ronacher <armin.ronacher@active-4.com>
Subject: Experience with Recovering From User Error (And suggestions for improvements)
Date: Mon, 16 Feb 2015 11:41:49 +0100
Message-ID: <54E1C96D.2080109@active-4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 11:47:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNJDN-0002J3-5U
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 11:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbbBPKrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 05:47:37 -0500
Received: from mail.architekten-ronacher.at ([178.188.250.58]:36340 "EHLO
	[192.168.6.11]" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752517AbbBPKrh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 05:47:37 -0500
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Feb 2015 05:47:36 EST
Received: from localhost (localhost.localhost [127.0.0.1])
	by GateDefender.ronacher (Postfix) with ESMTP id 08E47EDC003
	for <git@vger.kernel.org>; Mon, 16 Feb 2015 11:41:50 +0100 (CET)
X-Virus-Scanned: by Panda GateDefender
X-Spam-CTCH-RefID: str=0001.0A0B0209.54E1C96D.016F,ss=1,fgs=0
Received: from herzog.local (unknown [192.168.6.133])
	by GateDefender.ronacher (Postfix) with ESMTPS id 8E702EDC002
	for <git@vger.kernel.org>; Mon, 16 Feb 2015 11:41:49 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263893>

Hi,

Long story short: I failed big time yesterday with accidentally 
executing git reset hard in the wrong terminal window but managed to 
recover my changes from the staging area by manually examining blobs 
touched recently.

After that however I figured I might want to add a precaution for myself 
that would have helped there.  git fsck is quite nice, but unfortunately 
it does not help if you do not have a commit.  So I figured it might be 
nice to create a dangling backup commit before a reset which would have 
helped me.  Unfortunately there is currently no good way to hook into 
git reset.

Things I noticed in the process:

*   for recovering blobs, going through the objects itself was more
     useful because they were all recent changes and as such I could
     order by timestamp.  git fsck will not provide any timestamps
     (which generally makes sense, but made it quite useless for me)
*   Recovering from blobs is painful, it would be nice if git reset
     --hard made a dangling dummy commit before :)
*   There is no pre-commit hook which could be used to implement the
     previous suggestion.

Would it make sense to introduce a `pre-commit` hook for this sort of 
thing or even create a dummy commit by default?  I did a quick googling 
around and it looks like I was not the first person who made this 
mistake.  Github's windows client even creates dangling backup commits 
in what appears to be fixed time intervals.

I understand that ultimately this was a user error on my part, but it 
seems like a small change that could save a lot of frustration.


Regards,
Armin
