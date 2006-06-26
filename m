From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of
 some adhocery
Date: Tue, 27 Jun 2006 11:15:25 +1200
Message-ID: <44A06A8D.7080202@catalyst.net.nz>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>  <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>  <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>  <Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de> <46a038f90606261550p145b20a6gbe960e0abc16e8a4@mail.gmail.com> <Pine.LNX.4.63.0606270057260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 27 01:17:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv0KI-0002jQ-Qr
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 01:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933267AbWFZXQA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 19:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933287AbWFZXP6
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 19:15:58 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:13996 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S933248AbWFZXPa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 19:15:30 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Fv0Ib-0003x3-42; Tue, 27 Jun 2006 11:15:21 +1200
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606270057260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22692>

Johannes Schindelin wrote:
> The funny thing is: I did something to account for the old syntax, but 
> only if you specified _one_ ref, not _two_. It would be easy, but is it 
> needed? (I.e. are your fingers so trained on it?)

My fingers are retrainable ;-)

>>There is something strange though. I have a repo with ~150 pending 
>>patches to push, of which git-cherry spots ~100 as already merged 
>>upstream. So the old git-format-patch.sh would spit 50 patches, and the 
>>initial C version would do 150.
>>
>>Now this version gives me 50 patches, regardless of
>>--ignore-if-in-upstream. Is that expected?
> 
> 
> Hell, no! Something is really wrong there.
> 
> What does "git-rev-list their..my | wc" say?

Ok, I cooked the numbers up a bit, it was 60 total, with 10 merged 
upstream. Here's what I have today:

   $ git-cherry svnhead..master | grep -c '+'
   52
   $ git-rev-list svnhead..master  | wc -l
   61

   $ ~/local/git/git-format-patch.sh  -o .patchesold svnhead master
   ...
   $ ls .patchesold | wc -l
   52

   $ ~/local/git/git format-patch  -o .patchesnewall svnhead..master
   ...
   $ ls .patchesnewall/ | wc -l
   53

   $ ~/local/git/git format-patch --ignore-if-in-upstream -o 
.patchesnewignore svnhead..master
   ...
   $ ls .patchesnewignore | wc -l
   52

This is a public repo --

master tracks origin which is
http://git.catalyst.net.nz/git/elgg-r2.git#nzvleportfolio

svnhead is
http://git.catalyst.net.nz/git/elgg-r2.git#svnhead

cheers,


m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
