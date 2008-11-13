From: "Paul E. Rybski" <prybski@cs.cmu.edu>
Subject: Re: running out of memory when doing a clone of a large repository?
Date: Thu, 13 Nov 2008 15:09:00 -0500
Message-ID: <491C895C.5010409@cs.cmu.edu>
References: <491B2550.1050005@cs.cmu.edu> <alpine.LFD.2.00.0811122206550.27509@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 21:10:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0iWO-0003De-4E
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 21:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbYKMUJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 15:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbYKMUJR
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 15:09:17 -0500
Received: from SMTP.andrew.cmu.edu ([128.2.10.85]:39494 "EHLO
	smtp.andrew.cmu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYKMUJP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 15:09:15 -0500
Received: from [192.168.1.4] (HAMMERHEAD.CORAL.CS.CMU.EDU [128.2.195.176])
	(user=prybski mech=PLAIN (0 bits))
	by smtp.andrew.cmu.edu (8.13.8/8.13.8) with ESMTP id mADK90Ev020395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Nov 2008 15:09:00 -0500
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <alpine.LFD.2.00.0811122206550.27509@xanadu.home>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang 2.60 on 128.2.10.85
X-Scanned-By: MIMEDefang 2.60 on 128.2.10.85
X-PMX-Version: 5.4.6.353000, Antispam-Engine: 2.6.1.350677, Antispam-Data: 2008.11.13.194626
X-SMTP-Spam-Clean: 8% (BODY_SIZE_3000_3999 0, BODY_SIZE_5000_LESS 0, __BOUNCE_CHALLENGE_SUBJ 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0)
X-SMTP-Spam-Score: 8%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100906>

Hi,
	Thanks for the great suggestions.  It turns out that running the command:

git repack -a -f -d

on the newly converted git repository seemed to fix my immediate
crashing-while-cloning problem.  I was able to clone via ssh from the
older Ubuntu machine with 1G of RAM using git version 1.5.4.3 (the
packaged version in Hardy Heron).

I also downloaded what seems to be the latest of the 1.5 series,
1.5.6.5, installed that from source, and successfully tested that out.
I'll try using that to avoid some of the memory problems of the previous
versions.  As I'm still comparatively a complete newbie when it comes to
git, I don't have a clue yet as to what's in the 1.6 codebase but
hopefully I'll be able to determine which version I want to work with soon.

Thanks again for the help!  I really appreciate it.

-Paul

Nicolas Pitre wrote:
> On Wed, 12 Nov 2008, Paul E. Rybski wrote:
> 
>> Hi,
>> 	I've recently started evaluating git for use on one of my projects.  I
>> used git-svn to convert a fairly large subversion repository and one of
>> its branches into two separate git repositories following the
>> instructions found here:
>>
>> http://www.simplisticcomplexity.com/2008/03/05/cleanly-migrate-your-subversion-repository-to-a-git-repository/
>>
>> From that, I created a 1.5G repository from the trunk of the subversion
>> repo and a 1.1G repository from one of the branches.  I then tried to
>> clone the repositories from one machine to another via ssh and the
>> smaller 1.1G repository of the subversion branch (with 1932 commits)
>> came over just fine but the larger 1.5G repository of the subversion
>> trunk (5865 commits) died with the following error:
>>
>> remote: Counting objects: 48415, done.
>> remote: warning: suboptimal pack - out of memory
>> error: git-upload-pack: git-pack-objects died with error.
>> fatal: git-upload-pack: aborting due to possible repository corruption
>> on the remote side.
>> remote: aborting due to possible repository corruption on the remote side.
>> fatal: early EOF
>> fatal: index-pack failed
>>
>> Is this simply because the git repository is too large for the machine
>> that's trying to send it over ssh?
> 
> Possibly.
> 
>> Is there a way to restrict the memory usage of git or do I need to get 
>> more RAM or somehow not import the full subversion history of my 
>> original trunk?
> 
> It is possible that the inport from svn didn't produce a fully packed 
> repository.  Try a "git repack -a -f -d" on the server machine. If you 
> get the same out-of-memory problem then ideally you should copy the 
> whole directory to a bigger machine and run 'git repack -a -f -d" there.  
> Then you may copy it back to the small machine and subsequent clone 
> requests should be just fine.
> 
> You could also investigate the pack.windowMemory configuration variable 
> on the server side.  If you have lots of big files then setting this to 
> 64m for example may help.
> 
>> I'm using Ubuntu 8.04.1 on both machines and using the Ubuntu packages
>> of git version 1.5.4.3.
> 
> There was a bug in versions prior to v1.5.6.4 affecting memory usage.  
> Upgrading to this version or later on the server machine might help too.
> 
>> The machine holding the repository is a 5-year
>> old AthlonXP 3200 with 1G RAM and 32-bit Ubuntu.  The machine I'm
>> cloning the repository on is a more recent Intel Dual Core Quad Q6600
>> with 4GRAM and 64-bit Ubuntu.
>>
>> Any advice would be greatly appreciated.
>>
>> Thanks!
>>
>> -Paul
