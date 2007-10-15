From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-svn and submodules
Date: Mon, 15 Oct 2007 18:27:01 +0200
Message-ID: <471394D5.3070509@op5.se>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr> <86lka4ofb8.fsf@lola.quinscape.zz> <AA453A15-BBF1-4EA6-B1AC-1C4E00E89FB2@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Oct 15 19:14:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhSmk-0005KS-GR
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 18:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244AbXJOQ1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 12:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755811AbXJOQ1H
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 12:27:07 -0400
Received: from mail.op5.se ([193.201.96.20]:48542 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbXJOQ1G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 12:27:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8EFB61730727;
	Mon, 15 Oct 2007 18:26:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gIsPvqDYMvUA; Mon, 15 Oct 2007 18:26:34 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 429821730716;
	Mon, 15 Oct 2007 18:26:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <AA453A15-BBF1-4EA6-B1AC-1C4E00E89FB2@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61013>

Benoit SIGOURE wrote:
> On Oct 15, 2007, at 12:14 PM, David Kastrup wrote:
> 
>> Benoit SIGOURE <tsuna@lrde.epita.fr> writes:
>>
>>> This week I'm probably going to start to dive in git-svn by
>>> implementing simpler things first:
>>>   - git svn create-ignore (to create one .gitignore per directory
>>> from the svn:ignore properties.  This has the disadvantage of
>>> committing the .gitignore during the next dcommit, but when you
>>> import a repo with tons of ignores (>1000), using git svn show-ignore
>>> to build .git/info/exclude is *not* a good idea, because things like
>>> git-status will end up doing >1000 fnmatch *per file* in the repo,
>>> which leads to git-status taking more than 4s on my Core2Duo 2Ghz 2G
>>> RAM)
>>
>> Well, then this should be fixed in git general, by sorting the ignores
>> (wildcards in the first place where they can match), and then just
>> moving those patterns that can actually match according to sort order
>> to the list of fnmatch candidates (and moving those files that can't
>> match anymore die to the sort order out again).
>>
>> I don't think that the final "solution" for avoiding a lousy global
>> O(n^2) algorithm is to replace it with lousy local O(n^2) algorithms
>> and just hope for smaller values of n.
> 
> That's entirely true, it's more of a workaround than a real solution.  
> Anyways, there could be other situations in which someone would like to 
> generate the .gitignore instead of using .git/info/exclude, so this 
> feature could be useful anyways.
> 
> I can try to address this issue later, if I have enough free time in my 
> hands to do so.
> 

Ah, finally found the thread. I sent a core.ignorefile patch to the list
(Let users decide the name of the ignore file) a while ago, but didn't
find this mail to respond to. My apologies.

It's one way of solving it, which I'm currently using, although not so
fitting for when you're importing svn repos permanently.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
