From: Andreas Ericsson <ae@op5.se>
Subject: Re: Trying to use git-filter-branch to compress history by removing
 large, obsolete binary files
Date: Mon, 08 Oct 2007 11:27:33 +0200
Message-ID: <4709F805.8050704@op5.se>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <20071007221920.GF2765@steel.home> <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com> <20071007234346.GA29433@potapov> <51419b2c0710071722k576c06d9i2f4dce730eae2059@mail.gmail.com> <20071008010648.GB29433@potapov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>, Alex Riesen <raa.lkml@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 11:28:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ieou8-0000et-Dw
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 11:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbXJHJ1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 05:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbXJHJ1n
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 05:27:43 -0400
Received: from mail.op5.se ([193.201.96.20]:52824 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020AbXJHJ1m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 05:27:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9710F173064D;
	Mon,  8 Oct 2007 11:26:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rYhRwRnl8o7p; Mon,  8 Oct 2007 11:26:55 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 1DEB51730569;
	Mon,  8 Oct 2007 11:26:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071008010648.GB29433@potapov>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60310>

Dmitry Potapov wrote:
> On Sun, Oct 07, 2007 at 06:22:28PM -0600, Elijah Newren wrote:
>> git-filter-branch --tree-filter 'rm -f testme.txt' HEAD
>> git reset --hard
>> rm -rf .git/refs/original/
>> vi .git/packed-refs
>> # Use vi to remove the line referring to refs/original...
>> git reflog expire --all --expire-unreachable=0
>> git gc --prune
>>
>> Seems like a wrapper is needed.  :-)
> 
> Actually, I would rather not, because you rarely need to remove anything
> immediately, and 30 days delay is reasonable time to give you a chance
> to recover that you removed accidentally. You can reduce it by setting
> appropriate value for gc.reflogExpireUnreachable in your configuration.
> The only thing you need to do is to remove .git/refs/original/heads/something
> after you are sure that git-filter-branch did exactly what you wanted.
> 
>>> Warning: all unreachable references will be removed!
>> What other scenarios could lead to unreachable references?
> 
> Any re-writing of history leads to that.
> 

git-rebase being the most common culprit, right alongside 'git commit --amend'.

>> I don't
>> know how to determine whether this is safe or not (except that these
>> were test repositories anyway, so I don't care what happens to them).
> 
> Git logs all your action, so even re-writing history would not be
> so disastrous if you suddenly realized that you did something wrong.
> The history is stored for 30 days by default. Usually, you do not
> need to mess with Git internals like you did above. Your useless
> files still will disappear after being unreachable for 30 days.
> 
> OTOH, if you want to have a clean repository immediately, I believe
> 'git clone' is a better option. After you made a local clone using
> it, 'git gc' should remove old garbage.
> 

A clone only fetches revs reachable from a ref, so pruning immediately
after a clone is completely pointless.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
