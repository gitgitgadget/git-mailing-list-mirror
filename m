From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: check-ref-format question
Date: Thu, 14 May 2009 09:24:07 +0200
Message-ID: <4A0BC717.1060900@drmicha.warpmail.net>
References: <93c3eada0905121709k73a47bddu60def6b5fbc1b15e@mail.gmail.com>	 <4A0AD5A2.2090103@drmicha.warpmail.net> <93c3eada0905131726p3afe8e68j160bd3931886093d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu May 14 09:24:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4VIt-0002iA-2q
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979AbZENHYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 03:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758364AbZENHYT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:24:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:32893 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755815AbZENHYS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 03:24:18 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 97E05345FED;
	Thu, 14 May 2009 03:24:16 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 14 May 2009 03:24:16 -0400
X-Sasl-enc: 8QN0cA6/4XGtEwgcskKGljJcCv/cY4yavF6Oi/7K0/U5 1242285856
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BB15B2812F;
	Thu, 14 May 2009 03:24:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <93c3eada0905131726p3afe8e68j160bd3931886093d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Geoff Russell venit, vidit, dixit 14.05.2009 02:26:
> On Wed, May 13, 2009 at 11:43 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Geoff Russell venit, vidit, dixit 13.05.2009 02:09:
>>> 1 $ git --version
>>> git version 1.6.2.3
>>> 2 $ git check-ref-format xxxx && echo OK
>>> 3 $ git-check-ref-format --branch xxxx && echo OK
>>> xxxx
>>> OK
>>> 4 $ git check-ref-format --branch xxxx && echo OK
>>> usage: git check-ref-format refname
>>>
>>>
>>> 2 seems wrong,
>>> I tried 3 after looking at  builtin-check-ref-format.c
>>> I couldn't find any test cases in the git/t directory
>>>
>>> From the documenation, I expect "git check-ref-format xxx" to return 0 if xxx is
>>> a valid branch or ref name.  git version 1.6.3 gives the same results.
>>
>> There are several things going on:
>>
>> A) In 3 you use a different git than in 1,2,4. You told us the latter is
>> 1.6.2.3, and I'm telling you the former contains v1.6.2.1-310-ga31dca0
>> (which has the new --branch option).
>> This simply checks whether refs/heads/xxxx is sane. (It also resolves
>> @{-1} and such, which is what makes it useful at all.)
> 
> Sorry, my mistake I was running in 2 windows on 2 machine and got
> confused. Ignore
> line 3 in my example.
> 
>>
>> B) "master" certainly looks like a valid refname, the doc seems to imply
>> that it should pass the check.
> 
> $ git --version
> git version 1.6.2.3
> $ git check-ref-format xxxx && echo OK
> $ git check-ref-format master && echo OK
> $ git check-ref-format master/xxxx && echo OK
> OK
> 
> I'm confused.
> 
> Geoff.

Please read on to my item C), and check the documentation patch which I
submitted. If you're still confused after that I need to revise my patch ;)

> 
> 
>>
>> C) Looking at the code, check-ref-format checks explicitly for the
>> presence of at least 2 levels: foo/bar is good, foo is bad. So, master
>> always had been bad, as well (or bad) as full sha1s!
>>
>> The code has always behaved like C since its inception but I don't know
>> the rationale behind the 2 level requirement. Daniel, Junio?
>>
>> Michael
>>
