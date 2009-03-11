From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Help understanding "rebase"
Date: Wed, 11 Mar 2009 10:24:47 +0100
Message-ID: <49B7835F.4020503@drmicha.warpmail.net>
References: <gp6kqj$tkb$1@ger.gmane.org> <KVXTFwpJn-0uEQYfgfg9YwrrimNYx6hbxe73y6qLYxfHYZH9eE4N4g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "John M. Dlugosz" <ngnr63q02@sneakemail.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 11 10:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhKi5-0002Zs-Q6
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 10:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbZCKJZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 05:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbZCKJZJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 05:25:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45439 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752329AbZCKJZH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 05:25:07 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6DCD32EDA07;
	Wed, 11 Mar 2009 05:24:59 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 11 Mar 2009 05:24:59 -0400
X-Sasl-enc: SKOxylHAro8Z3Mj33q2KCBOKRlyrJSS+wVhxrkMqfuWW 1236763499
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B4C30518F0;
	Wed, 11 Mar 2009 05:24:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090311 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <KVXTFwpJn-0uEQYfgfg9YwrrimNYx6hbxe73y6qLYxfHYZH9eE4N4g@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112897>

Brandon Casey venit, vidit, dixit 10.03.2009 22:30:
> John M. Dlugosz wrote:
>> Here is the situation:  An old topic branch containing 3 commits.  A dev
>> branch that has recently been merged.  To catch up the topic's work
>> before adding it to dev, I expected that rebase would do what I ended up
>> doing manually, detailed below.
>>
>> Instead, it crunched away for a long time and gave errors applying patches.
>>
>> So I did it manually by checking out dev, then cherry-picking each of
>> the three commits. Actually, this left it on top of dev, but suppose I
>> had created a new branch at dev, cherry-picked the stuff from the old
>> topic branch, and then deleted the old topic branch.  Now I have a new
>> topic branch with the rebased changes, albeit with a different branch
>> name.  Point is, there were no conflicts and the changes were simple, so
>> cherry-picking each node was clean.
>>
>> So, what did the rebase command try to do?  I think it may have
>> something to do with finding a common root between the topic and dev,
>> which, due to the merge, was a long way back.  Something like this:
>>
>>       o--o--   ...  --o
>>      /                 \
>>     A--...--B--   ... --C--D <== dev
>>              \
>>                   q--r--s  <== topic
>>
>>
>> I was able to cherry-pick q,r,s on top of D without any issues.  So why
>> did rebase get in such a tizzy?
> It may help those who know the internals of git-rebase if you supplied the
> commands you used and your git version.
> 
> So, you're saying you did
> 
>    git checkout topic
>    git rebase dev
> 
> or the equivalent
> 
>    git rebase dev topic
> 
> ?  Are you sure you didn't get the arguments to rebase reversed?
> 
> -brandon
> 

That happens very easily: You want to rewrite dev using rebase, so you
check out dev. You want to rebase the topic branch, so you run "git
rebase topic". Very logical, but the wrong way round... The doc is
clear, though.

A useful mnemonic is that git rebase A B is about the commits A..B (B
defaulting to the current branch), and that the new B after rebasing will be

B' = C + (A..B)

where C is the value of --onto, which defaults to A. The point of rebase
is that A + (A..B) does not equal B in general, even though A..B=^A B ;)

git rebase A does not rewrite/rebase A! I'll think about a concise first
paragraph for git-rebase.txt.

Michael
