From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to merge branches except for one commit
Date: Thu, 29 May 2008 17:13:17 +0200
Message-ID: <483EC80D.309@op5.se>
References: <216e54900805281932v1397fd30sad91f767175ba95e@mail.gmail.com>	 <32541b130805281942g2550cad9k7ba530c59e050aa4@mail.gmail.com> <216e54900805282001x299055c3r6cfffcebc61fa955@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 17:20:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1jpb-0004L5-OG
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 17:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbYE2PNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 11:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbYE2PNW
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 11:13:22 -0400
Received: from mail.op5.se ([193.201.96.20]:44820 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbYE2PNV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 11:13:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7A8711B800AE;
	Thu, 29 May 2008 17:08:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.33
X-Spam-Level: 
X-Spam-Status: No, score=-3.33 tagged_above=-10 required=6.6
	tests=[AWL=-0.831, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HfMkK3nEUHmf; Thu, 29 May 2008 17:08:19 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id A6A991B80079;
	Thu, 29 May 2008 17:08:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <216e54900805282001x299055c3r6cfffcebc61fa955@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83210>

Andrew Arnott wrote:
> Interesting.  I think working in the maintenance branch and merging
> back into master should work... except when I'm in master when I find
> the bug and just fix it there without thinking.
> 

That's when you cherry-pick and reset. While having your maintenance
branch checked out (after having committed on master), do

	git cherry-pick master
	git checkout master
	git reset --hard HEAD^

Later, when you merge in the maintenance branch again, you get the
bugfix you cherry-picked onto maint.

On the subject of your workflow though, I think you could definitely
benefit from using topic branches (short-lived branches with a few
commits to implement one particular feature/bugfix/whatever) so that
when you later decide to use a release-branch, you simply merge the
topics you want. For preference, bugfix topics should go into your
maintenance branch (branch v1.0 in your case), and then the entire
maintenance branch should be merged into master, so that master gets
all the true and tested bugfixes without you having to verify them
twice (assuming clean merges, ofcourse).

> The merge and revert idea is interesting.  I may try that out in this
> case since I'm already stuck with lots of commits in master.
> 
> Regarding why I am porting more than just *some* commits to the
> maintenance branches, well, these are also stabilization branches
> before an initial vX.0 release, so in the month or so of stabilization
> there could be potentially be a great deal of work in master that I
> decide is worth releasing sooner rather than later.

Why though? Don't you go into feature-freeze when you cut the branch?
If you don't, then where do you?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
