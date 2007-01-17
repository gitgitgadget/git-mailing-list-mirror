From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [RFC] Replace rebase with filtering
Date: Wed, 17 Jan 2007 14:21:19 -0800
Message-ID: <45AEA15F.70001@midwinter.com>
References: <45AC3B5D.6080700@midwinter.com> <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD2568.4040408@midwinter.com> <45AD2AE7.2010908@midwinter.com> <Pine.LNX.4.63.0701162131130.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD383E.50105@midwinter.com> <Pine.LNX.4.63.0701162218070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 23:21:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7J9k-0005wf-Kz
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 23:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbXAQWVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 17:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbXAQWVS
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 17:21:18 -0500
Received: from tater.midwinter.com ([216.32.86.90]:44811 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751850AbXAQWVR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 17:21:17 -0500
Received: (qmail 6185 invoked from network); 17 Jan 2007 22:21:16 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=kMTHpoer1z0Nh627HTx6FgbdWZXbznJCSrtenFXaOCdbgOMUriVdEGqSjGdjx83J  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 17 Jan 2007 22:21:16 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701162218070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37044>

  Johannes Schindelin wrote:
>> Okay, great, that is certainly an improvement over what I thought was
>> happening. But it won't work if you had to manually resolve a conflict during
>> the rebase, yes? In that case the diffs would presumably not match.
>>     
> Correct. There is no automatic way any program could verify that such a 
> patch is indeed what is already in upstream.
>   

Well, yes there is, in fact: don't forget the existing history like 
rebase currently does. Merge doesn't have the same problem. That's kind 
of the crux of what I'm proposing here: if you change the implementation 
of git's "Don't clutter my history with meaningless merges" feature from 
a history-lossy operation (rebase as it stands today) to a display-time 
filter (regular merge with an added "I'm just an update" marker) then 
this problem evaporates and it becomes safe to clone *any* repository 
and pull updates from it, not just ones where the owner is being careful 
never to run rebase when there are pending changes.

I think filtering is consistent with the way git does other things. 
Renames would be the big example; they are detected after the fact and 
dealt with at the point where they're actually relevant to what the user 
is doing (merging, etc.) rather than appearing as an explicit part of 
the repository's history. Why shouldn't no-op "sync with upstream" 
changes work the same way?

> Usually, however, this results in a conflict which you have to resolve. 
> And _you_ do not have a hard time verifying that the patch already went 
> in, and you just say "git rebase --skip" and the rebasing will continue 
> _without_ having committed the now obsolete patch.
>   

True enough, but if the computer can retain the information it needs to 
do that for me (which it does if I merge instead of rebase) then why 
shouldn't it?

-Steve
