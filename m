From: Mark Levedahl <mlevedahl@verizon.net>
Subject: mingw, windows, crlf/lf, and git
Date: Sun, 11 Feb 2007 18:13:16 -0500
Message-ID: <45CFA30C.6030202@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:13:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGNtC-0000I6-F4
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbXBKXNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbXBKXNV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:13:21 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:54125 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbXBKXNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:13:20 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDB00KSKN6132V4@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 11 Feb 2007 17:13:16 -0600 (CST)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39325>

I am NOT intending to start a flamewar O:-) , so please don't turn this 
into one.

The recent threads on a mingw git port are explicit in the intent to 
provide a Windows native git. I believe there is a fundamental conflict 
here with the position, clearly stated by Linus, that git does not alter 
content in any way. Windows suffers the curse of DOS line endings (\r\n 
vs \n), and a true port to Windows *must* allow for \r\n and \n to be 
semantically the same thing as most large projects end up with a mixture 
of such files and/or are targeting cross-platform capabilities. The 
major competing solutions git seeks to supplant (cvs, cvsnt, svn, hg) 
have capability to recognize "text" files and transparently replace \r\n 
with \n on input, the reverse on output, and ignore all such differences 
on diff operations. To be relevant on native Windows, git must do the 
same. Otherwise, git will be deemed "too wierd" and dismissed in favor 
of a tool "that works."

There is no use to debating the technical merits of \r\n vs \n vs \r vs 
whatever, nor of not converting. Really. Just accept that there is a 
fundamental requirement that any version control tool on Windows be able 
to silently convert between \r\n and \n. To believe otherwise is to 
expect that the conversion be pushed elsewhere into the tool chain in 
use, and that won't happen as the competition already provide this 
conversion capability.

So, I think the git project needs to come to an explicit position on 
this, basically being:

1) git is a POSIX only tool (i.e., there will be no \r\n munging), or
2) a Windows port of git will handle and mung \r\n and \n line endings.

If the answer is 1, the mingw port is a waste of time as it simply won't 
be usable by its target audience. If the answer is 2, then I think a 
very careful design of this capability is in order.

Comments?

BTW, I have addressed this in my own world using a pre-commit script 
that converts textfile line endings into \n, recognizing that our 
Windows tool chain handles such files perfectly well, while our Linux 
toolchain requires it.

Mark Levedahl
