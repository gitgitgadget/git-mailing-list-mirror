From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] t: branch: improve test rollback
Date: Sat, 7 Sep 2013 22:02:59 -0500
Message-ID: <CAMP44s2PFVAKRUkEyN8BAH8C5UUMn21ou9hNkcOXaCsXscywHQ@mail.gmail.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
	<1377923511-20787-5-git-send-email-felipe.contreras@gmail.com>
	<xmqqwqmxr9a7.fsf@gitster.dls.corp.google.com>
	<CAMP44s2BU86zZ_KE78BPYpsjBZJ7Mj0MJqM4Lj28AKxYfeLVDQ@mail.gmail.com>
	<xmqqtxi1o6kf.fsf@gitster.dls.corp.google.com>
	<CAMP44s1Q6YjVnVz3OnT=cE+ozUddBxFzM1r_WT5QoR7sP6-9Sg@mail.gmail.com>
	<xmqq61ugo67v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 05:03:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIVHG-0006hi-VI
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 05:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab3IHDDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 23:03:01 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:63891 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab3IHDDA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 23:03:00 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so3998108lab.27
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 20:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aV3sJvG7InhpMv17Crm/b/ohxut60HFc4OYL3NnuivI=;
        b=Gt0BYlmzvvVtE+xEcnyyymwXqAwelk8mT+WWjprsjE6omXNNFhmBYUwc0LKjHRcRf/
         mYdMZTT+PTMzkIp8cNClGqp8hoxnsTDLlLRSOuujZEgJr/UixuosTprd66TWbbWjhXdr
         XA1f+nZ6pBCPMLsNAw61F7BjYd1g7lwnR0KM9rF9auHBNrI+VKE7Nmvx7LR+8haUHSdO
         LRbvYE/r6SXO/dByu/eyotLngCzaLEmdeQ+H/knH16RgFExsIwdWpTI9M9xOmergUAE3
         jeeUmtBfqCV7t1N4Fcmfcbgmftt7HP9Xp++IoL3oQ0+mSEEVgsZ3ttqWgzt7JOG7WYhe
         mYdw==
X-Received: by 10.152.45.106 with SMTP id l10mr9871785lam.12.1378609379153;
 Sat, 07 Sep 2013 20:02:59 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 20:02:59 -0700 (PDT)
In-Reply-To: <xmqq61ugo67v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234167>

On Wed, Sep 4, 2013 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Sep 3, 2013 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> On Tue, Sep 3, 2013 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>>>  test_expect_success 'refuse --edit-description on unborn branch for now' '
>>>>>> +     test_when_finished "git checkout -" &&
>>>>>
>>>>> I am not sure if this is a good change.  Depending on the outcome of
>>>>> the "git checkout" in the test (it may succeed and set @{-1} to the
>>>>> branch we were on when we entered the test, or it may fail and leave
>>>>> @{-1} to the branch before we were on when we entered the test),
>>>>> this will take us to a different place, no?
>>>>
>>>> It is better than leaving Git in an unborn branch.
>>>
>>> True, but it falls short of "After every test the environment should
>>> be as close as to how it was before as possible.", doesn't it?
>>
>> No it doesn't. Closer is closer.
>
> Closer is not "as close as ... possible".

Yes it is, because there are no better alternatives within our
ability, capacity, or realization.

http://www.merriam-webster.com/dictionary/possible

> I think the fix is just to use the name of a concrete branch we want
> the next test to start on, instead of "-", which could be far
> quickly done than making excuses like that.

No, what if that test is skipped for some reason? Ideally each test
case should do 'git checkout $branch_i_need', not rely on the previous
tests to checkout the branch they need, but that requires too much
work to fix.

'git checkout -' works perfectly fine, and it's the closest we have to
my suggested test_checkout() which I think would be ideal, but I'm not
going to work on.

-- 
Felipe Contreras
