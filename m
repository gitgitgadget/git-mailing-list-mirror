From: Andreas Ericsson <ae@op5.se>
Subject: Re: Branches and all commits
Date: Mon, 19 Dec 2005 17:15:12 +0100
Message-ID: <43A6DC90.3040403@op5.se>
References: <Pine.LNX.4.63.0512190908140.6812@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 17:20:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoNfS-0006RJ-On
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 17:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVLSQPP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 11:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVLSQPO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 11:15:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:25304 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964798AbVLSQPN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 11:15:13 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 7D2576BD06; Mon, 19 Dec 2005 17:15:12 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jon Nelson <jnelson-git@jamponi.net>
In-Reply-To: <Pine.LNX.4.63.0512190908140.6812@gheavc.wnzcbav.cig>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13825>

Jon Nelson wrote:
> Should *all* commits be reachable via at least one branch? I ran into a 
> situation this weekend that has me a little confused. I had performed a 
> number of commits and such and I noticed that the author and committer 
> info had suboptimal values. A bit of searching led me to a comment made 
> by Linus that basically said "go hack git-convert-objects", which I did. 
> After performing git-convert-objects on every commit object in 
> .git/refs/heads and the requisite pruning, etc... just about everything 
> looked fine. However, I still had a long series of commits that 
> contained the wrong information. Further inspection makes it appear as 
> though these commits are not reachable via any branch, although they are 
> /all/ reachable via a series of tags. I worked around the problem by 
> further modifying git-convert-objects to also understand tags (at least 
> the basic ones I've got) and that's all taken care of, but the question 
> remains: should *all* commit objects be reachable by at least one 
> branch?
> 

AFAIU, yes.

For future reference, what you should have done is this;

$ git format-patch --mbox <first-unscrewed-commit-ish>
# edit commit-messages in generated patches
$ git reset --hard <first-unscrewed-commit-ish>
$ for i in 00*.txt; do git apply < $i; done
$ git prune;# to get rid of the unreachable objects AFTER you've checked 
everything's all right

If things fail, do

$ git reset --hard ORIG_HEAD

and ask again.

I'm afraid I can't help you fix up your repository from the state it's 
in now. AFAIK, there's no tool to do it automagically.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
