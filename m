From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/5] checkout --orphan: respect -l option always
Date: Thu, 27 May 2010 09:50:57 +0200
Message-ID: <4BFE2461.5080501@drmicha.warpmail.net>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com> 	<1274488119-6989-4-git-send-email-erick.mattos@gmail.com> 	<7vzkznqmir.fsf@alter.siamese.dyndns.org> <AANLkTimT3sI3yuM8RZai-eWDk8Z5Rmc28RLGOx_i-RXa@mail.gmail.com> 	<4BFD3ED3.3000709@drmicha.warpmail.net> <AANLkTiksYeRzqNTdOMxb3oliuVna6kAxbHM8nxx6gNCO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 09:51:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHXs9-00087L-46
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 09:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251Ab0E0HvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 03:51:14 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49323 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753774Ab0E0HvO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 03:51:14 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2B31EF77EB;
	Thu, 27 May 2010 03:51:13 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 27 May 2010 03:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=OI9eETPDy4sL1Myr0d14MELK8qE=; b=BpKAg3gOLRflGwlgfqZYibRn8vl59aQ2pu+POhNWoRHtdoq9G6xRe0cw09wrlYCY8B6weZHrOWdveimP4zIwMbqs+pKWNLOLzbXIT97pVy06fNKDlihEPzaOOvQSUfQ0vE41dqrsjLmrp5cxt849GSra8C9OtLXSrwDiY1OsJCE=
X-Sasl-enc: 7lVSm0hp5H7McohRk2DEFwVGkTCnozF0xPA3HImFMvel 1274946672
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 313AE396C3C;
	Thu, 27 May 2010 03:51:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTiksYeRzqNTdOMxb3oliuVna6kAxbHM8nxx6gNCO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147831>

Erick Mattos venit, vidit, dixit 26.05.2010 20:04:
> Hi,
> 
> 2010/5/26 Michael J Gruber <git@drmicha.warpmail.net>:
>>> But that is not a fix.
>>
>> There's a "-" line with "cannot" and a "+" line with "should not". So
>> you certainly changed what was there before.
> 
> Everybody know what a minus or a plus sign means in a diff. ;-)
> 
> What I have meant was that I had typed the whole line myself after
> some previous removal while I was making the changes during
> "deletion/moving lines" actions.  No big deal, just a mistake.
> 
> The real message change here is from blocking -t an -l to blocking
> only -t.  As I had told I have not realized the 'should not/cannot'
> issue.
> 
>>>>> +     git checkout master &&
>>>>> +     git checkout -l --orphan eta &&
>>>>> +     test -f .git/logs/refs/heads/eta &&
>>>>> +     test_must_fail PAGER= git reflog show eta &&
>>>>> +     git checkout master &&
>>>>> +     ! test -f .git/logs/refs/heads/eta &&
>>>>> +     test_must_fail PAGER= git reflog show eta
>>>>> +'
>>>>
>>>> I don't quite understand the title of this test, nor am I convinced that
>>>> testing for .git/logs/refs/heads/eta is necessarily a good thing to do
>>>> here.  "eta" branch is first prepared in an unborn state with the working
>>>> tree and the index prepared to commit what is in 'master', and the first
>>>> "git reflog" would fail because there is no eta branch at that point yet.
>>>> Moving to 'master' from that state would still leave "eta" branch unborn
>>>> and we will not see "git reflog" for that branch (we will fail "git log
>>>> eta" too for that matter).  Perhaps two "test -f .git/logs/refs/heads/eta"
>>>> shouldn't be there?  It feels that it is testing a bit too low level an
>>>> implementation detail.
>>>
>>> So I need to explain the solution:
>>>
>>> When config core.logAllRefUpdates is set to false what really happens
>>> is that the reflog is not created and any reflog change is saved only
>>> when you have an existent reflog.
>>>
>>> What I did was to make a "touch reflog".  Creating it, when the new
>>
>> You mean checkout -l --orphan does that touch? There is none in the
>> test. Does ordinary checkout with -l does that, too?
> 
> This is not done by a test.  It is part of the whole implementation.
> It is done only when needed: on that special corner case.
> 
> Please read the patches mainly the 2/5 and 3/5.
> 
>>> branch get eventually saved then the reflog would be written normally.
>>>  But in case somebody give up this new branch before the first save,
>>> moving back to a regular branch would leave a ghost reflog.
>>
>> The touched entry (is left), not a reflog, I assume, otherwise the
>> reflog command should not fail.
>>
>>>
>>> I have coded the cleaning commands for that and the test is just a
>>> check of this behavior.
>>
>> Which command does the cleaning? "reflog show" or "checkout master"?
>>
>>>
>>> The first "test -f .git/logs/refs/heads/eta" tests if reflog was
>>> created and the second if it was deleted.  No big deal.
>>>
>>> Regards
>>
>> I haven't followed this series due to earlier worries about --orphan but
>> I'm wondering about this cleaning up behind the back. Maybe it's just a
>> matter of explanations, though.
>>
>> Michael
>>
> 
> Your questions are too unaware of the code.  ;-)  As I don't think you
> are asking me to explain each single line then I imagine you have not
> read the patches, just the chat.  Please read the patch series.  I
> will be very glad to answer any further questions then.

I'm not asking you to explain your code but your intentions: What is it
supposed to do? If I have to read the code to figure that out then your
commit messages and on-list explanations (or my understanding thereof)
are suboptimal. You're cleaning up some files in logs/refs and I'm wondering

- which command does that automatically (after your series) and
- in which circumstances (only --orphan or more) superfluous files were
left there before.

If you're not willing to answer that I'm simply not reading the code.
One reviewer less.

Michael
