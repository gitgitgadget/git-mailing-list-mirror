From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: [msysGit] Windows & executable bit for newly created files
Date: Thu, 15 Dec 2011 21:07:35 +0100
Message-ID: <4EEA5387.5020808@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 21:07:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbHai-00066X-9P
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 21:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab1LOUHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 15:07:40 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:54398 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab1LOUHj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 15:07:39 -0500
Received: from [84.176.39.18] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1RbHaa-0003LU-HS
	for git@vger.kernel.org; Thu, 15 Dec 2011 21:07:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187228>

Hi,

I sometimes write new (shell/perl) scripts under Windows whithin
msysGit's bash. An "ls -l" shows them as executable:

$ ls -l

    -rwxr-xr-x  ...  11 Dec 15 20:33 test.sh

Ok, "ls" just *pretends* they have the bit set (I think it just peeks
for the she-bang line).

Adding the file and looking at the patch gives:

$ git add test.sh
$ git diff --cached

    diff --git a/test.sh b/test.sh
    new file mode 100644
    index 0000000..13f4793
    --- /dev/null
    +++ b/test.sh
    @@ -0,0 +1,2 @@
    +#!/bin/sh
    +

Is there a way to convince git that the new mode is 755 instead of 644,
even with core.filemode set to false? So that the mode is correct when I
checkout the file under Linux later on?

My impression is that when git once knows the file has 755, it remembers
that. I'd like to avoid those commits (made under Linux) with "chmod +x
for scripts newly created under Windows".

Sometimes I create a script under Windows, add and commit it, create a
patch (git-format-patch), edit the patch (644 -> 755), reset the branch,
and finally git-am the patch. It works but is not particularly convenient.

Is there sth. like

$ git add --filemode=755 <filepattern>   ?


Cheers,
    Dirk
