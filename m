From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: How to make git diff-* ignore some patterns?
Date: Sat, 21 Nov 2009 17:40:14 +0100
Message-ID: <4B0817EE.1040000@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 21 17:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBt0g-0005TQ-RN
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 17:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbZKUQkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 11:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806AbZKUQkQ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 11:40:16 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:36853 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbZKUQkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 11:40:15 -0500
Received: from [84.176.112.153] (helo=[192.168.2.100])
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1NBt0S-0004Hp-0J
	for git@vger.kernel.org; Sat, 21 Nov 2009 17:40:16 +0100
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133398>

Hi list,

is there a way to tell "git diff-index" to ignore some special patterns, 
such that /^-- Dump completed on .*$/ is NOT recognized as a difference 
and "git diff-index" returns 0 if that's the only difference?

     -- Dirk

<Background>
I have a mySQL database which I backup daily using mysqldump (cronjob).
The result is a text file (*.sql) with all the "create" and "insert"
statements and some metadata.
I used to use tar and gzip to backup these files and got a huge
collection of backups in the last tree years (500+ MB).
Then I switched to Git and recorded only the diffs between day X and day
X-1. My repository shrunk to 16 MB for the very same data, which was great!

My database doesn't change every day, but I backup it anway and store 
the backup files with Git and a cronjob. It does:

---------------
mysqldump ... -r <backupfile> # that's the output file ;-)
git add <backupfile>
if ! git diff-index --quiet HEAD --; then
     git commit -m "Backup of <database> at <timestamp>"
fi
---------------

This way, a new commit is only done when the backupfile has changed. So 
far, so perfect.
A few days ago my web hoster (where the database actually resides) 
changed the mySQL version.
mysqldump now writes "-- Dump completed on <timestamp>" to the file and 
Git correctly recognizes this as a change and my script creates a new 
commit. Every day, even if only that line has changed.

I'd like to skip these commits if only the "Dump completed" line has 
changed.
</Background>
