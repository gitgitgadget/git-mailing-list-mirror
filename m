From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: [feature request] 2) Remove many tags at once and 1) Prune tags on
 old-branch-before-rebase
Date: Thu, 07 Mar 2013 17:01:39 -0500
Message-ID: <51390E43.60704@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 07 23:02:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDitA-0003XP-0t
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 23:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895Ab3CGWBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 17:01:46 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:55271 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932847Ab3CGWBp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 17:01:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 5258310121D
	for <git@vger.kernel.org>; Thu,  7 Mar 2013 17:01:40 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WCCmTt2V5Y8c for <git@vger.kernel.org>;
	Thu,  7 Mar 2013 17:01:39 -0500 (EST)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 7075A101106
	for <git@vger.kernel.org>; Thu,  7 Mar 2013 17:01:39 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217620>

Hi,

============================
Short story:
============================
we are now using *annotated* tags in a way that we would need to manage 
(remove) them easily. It would be usefull to have one of the folowing in 
"git tag":

1) git tag --delete-tags-to-danglings-and-unnamed-banches

This would be able to remove all tags that refers to commits which are 
on branches that are no more referenced by any branch name.  This is 
happening when you tag something, then "git rebase".  Your tag will 
still be there on the old-and-before-rebase branch and won't be "pruned" 
by any git command... (that I know of...)

Then you will end up to delete all of them "by hand"...

to do so you would like to have:

2) git tag -d "TOKEN*"

This would be able to delete all tags referred by the name.
Ok ok, I can do this like this:

rm .git/refs/tags/TOKEN*

but why have the git users "play" into the .git...?

============================


----------------------------------------
Long story:
----------------------------------------

We started using annotated tags to hold information about the code 
"status", ie the results of our regression tests are stored in annotated 
tags each time you do a "make test" in the distribution.  We can 
retrieve the information by "git show" which we aliased to parse the 
output, extract the ".html" that we stored in the tag message  (about 
67kb) and then display the "make test" results as a web page in a 
browser... ;-)

We also "resume" the information on the number of "(P)assed" and 
"(F)ailed" tests in the tag name to quickly view the overall status of 
the code in the local clone.  For example, we end up with tags name like 
these:

SQA_ericc_ad76kj78_P_155_F_0

as a result of: SQA_${USER}_${SHA}_P_${PASSED}_F_${FAILED}

However, the number of tags increases as you do many "make test" to 
validate your developments and see the progressions you do.

Moreover, when you "git fetch" from colleagues, you retrieve their 
annotated tags too, which is nice, since you can view the results of the 
regression tests they have done, which can contain useful information to 
share...

BUT, when your colleagues delete their old tags because they rebased, 
you don't have the possibility to "git fetch --prune-tags", so you are 
left with all those "old" tags hanging all around and would like to 
easily remove them...

Because you know that no more branches are associated with the tip 
commit of all those "old-before-rebased-branches", you would like 
something like feature request #1 to automagically do the job you do by 
hand in feature request #2... ;-)

Ok, we shall not rebase but merge, but this is another long story... ;-)

Hope all this might be useful to other, so if other people start using 
tags like this, more will hope to have these features... ;-)
----------------------------------------


thanks,

Eric
