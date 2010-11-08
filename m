From: Maaartin-1 <grajcar1@seznam.cz>
Subject: Re: Rebase problems
Date: Mon, 08 Nov 2010 20:59:52 +0100
Message-ID: <4CD856B8.7030305@seznam.cz>
References: <loom.20101108T190513-206@post.gmane.org> <FA37BC66-64CF-4A62-80E9-EC45EAE392C4@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 21:00:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFXsy-0004eS-Ap
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 21:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab0KHT77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 14:59:59 -0500
Received: from smtp.seznam.cz ([77.75.72.43]:55315 "EHLO smtp.seznam.cz"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754407Ab0KHT77 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 14:59:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=X-Seznam-DomainKeys:X-Seznam-SPF:X-Virus-Info:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-QM-Mark;
	b=RD3Bxgj9IZC0da4kaj8aDIqDGbz1mrwzJTDD7XL8te9MfVFhK18Ek2JjCvoNVt6XP
	6IaUHQvXR7ldv0Qiq+1bDByeu5s5xrTNfk0LQN3z1eLM2dl7xEd0AwVdOaRWDJtMNUR
	HOWvHxGSY+qlGInKKOYsu7gU6lNFIQBqL1Vhd+s=
X-Seznam-DomainKeys: unknown
X-Seznam-SPF: neutral
X-Virus-Info: clean
Received: from [10.0.3.100] (188-120-198-113.luckynet.cz [188.120.198.113])
	by email-relay2.go.seznam.cz (Seznam SMTPD 1.2.14@16206) with ESMTP;
	Mon, 08 Nov 2010 20:59:53 +0100 (CET)  
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <FA37BC66-64CF-4A62-80E9-EC45EAE392C4@wincent.com>
X-Smtpd: 1.2.14@16206
X-Seznam-User: grajcar1@seznam.cz
X-Session: 5770
X-Country: CZ
X-QM-Mark: email-qm4<565926969>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160979>

On 10-11-08 19:33, Wincent Colaiuta wrote:
> On 08/11/2010, at 19:19, Maaartin wrote:
> 
>> I'm using git for a project I'm working on alone (and I really like it), so I 
>> could rebase a lot, if I hadn't the following problems.
>>
>> There's a file containing the timestamp which gets compiled in, so the 
>> executable can show it's version. Sometimes, I need to set it couple of times a 
>> day, sometimes only once a week. For each such timestamp I create a tag, so I 
>> can track it to the source easily. The timestamp is an important piece of 
>> information, so I put the containing file under version control. The downside is 
>> that I often get a conflict in this file halting my rebase. Is there a way how 
>> to ignore or automatically resolve all conflicts in this file (any resolution 
>> strategy is fine, as it will be overwritten anyway).
> 
> Rhetorical questions follow; no need for you to answer:

However, I will. I've asked myself some of them already.

Addendum: It looks like your question were the right ones, the problem
seems to be solved now in a very easy way.

> - Why is the timestamp an "important" piece of information?

I need the timestamp (or something else) in order to match the
problematic version to the source.

> - Have you considered that, for versioning purposes (ie. knowing _what_ source code was compiled to produce the product), the commit hash or the output of "git describe" may be much more useful than a disconnected timestamp?

Sure, I have considered it and I haven't ruled it out (I'm quite new to
git). The timestamp is something the customer can understand better and
has got used to during the past 5 yeas. It gets also stored in some
database columns, whose type I had to change. Using tags I can relate
the timestamp to the commit.

In any case I need to embed the information in the executable, which was
impossible for a hash in a committed file. However, I don't want to
commit it, anyway... so probably it's the way to go.

The output of git describe is quite unusable for this purpose, since the
customer would happily drop the hash which can lead to ambiguities.
Giving him only the SHA-1 would be safer.

> - Regardless of whether you use a timestamp, a commit hash, or the output of "git describe", why can't it be inserted at compile time rather than stored in the repo?

I could do it using an untracked file, which would eliminate my problem.
The downside is that then--assuming using the timestamp--I'd have to
rely on the tags or some logfile. No, there's no downside as I see after
having read your next line.

> - If you are really enamored of timestamps, would extracting the latest commit timestamp out of the repo be enough?

Sure it would, I was mostly ignoring the commit timestamp until now, and
didn't notice that I'm using a different timestamp for the executable
without any reason. Now I need just trivial changes.

> - Do these repeated merge conflicts set off "code smell" alarm bells for you (really, "process smell"), and make you suspect that there might be something wrong with what you are trying to do?

Partly, starting using the timestamp was a huge improvement many years
ago and I was quite happy with it until now. OTOH, git is new to me so I
was thinking about changing what I'm doing with git or finding some new
option there instead.

Now, I can have my timestamp and eat it, thank you.
