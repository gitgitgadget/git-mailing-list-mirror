From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 2/7] add tests for rebasing with patch-equivalence present
Date: Wed, 29 May 2013 23:46:08 -0700
Message-ID: <CANiSa6jfXSygcPVnW_6t4mbXG=5Lt0W0NPsspXs4mF4TUETqpA@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-3-git-send-email-martinvonz@gmail.com>
	<51A5A992.306@viscovery.net>
	<CANiSa6joMXeh7HoGAFXskdXaPZjN+0uHrtN7V85FyQHTGCwZMQ@mail.gmail.com>
	<CAMP44s0x8e2xpycOEswnYDBM5WKn=fCp7hcUEniARGVZUw1XkQ@mail.gmail.com>
	<CANiSa6hxhiFYn1atdh+zA76H=XsiAHown8Ndn0T6fXRPJEaWEw@mail.gmail.com>
	<CAMP44s0eUWRXcXFeKyUrMwKDWcpn7dMX0km10Zpe0ZALW6T6LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 08:46:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhwco-0001Wt-Vl
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 08:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967627Ab3E3GqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 02:46:11 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:48625 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967601Ab3E3GqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 02:46:09 -0400
Received: by mail-we0-f173.google.com with SMTP id p57so7065169wes.32
        for <git@vger.kernel.org>; Wed, 29 May 2013 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OycrVuHLi5suyABkpmhkz6HtZjGVBeFp+EYHTklU5C0=;
        b=b1FrQr3TI0Aew1dzwKIdFSsqJrd3uHgxE3J7S1SL7odYLfH55lG618nRidG8a/nbTY
         jB3Pd5wHWu/Il1uMPKim3Qp9NR/2mtyrYwGYJnWg8FJcYrfvj2Xv4qgVetrySum1WguM
         WNfSV4D+iPeC0a9GlA6Ez3MYbdCmQfLlEW+oNWBEPreqpZ4pDxgqFhoOIBt6BMt9xJkO
         uphrI/8wKJjDZGAG+eltZ+Twd0T+xfoDExnv2wTeJWtiGgD+oLr8WBTTqCTxIH2n+B2u
         KxOq9COIeYXmrebRnxAiBvdjXpTJGtNZH/o2iCgxhCq/7LRDcoHU5Aakn1n6rozeXHfp
         xF7A==
X-Received: by 10.194.9.70 with SMTP id x6mr3156288wja.19.1369896368245; Wed,
 29 May 2013 23:46:08 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Wed, 29 May 2013 23:46:08 -0700 (PDT)
In-Reply-To: <CAMP44s0eUWRXcXFeKyUrMwKDWcpn7dMX0km10Zpe0ZALW6T6LA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225933>

On Wed, May 29, 2013 at 11:40 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, May 30, 2013 at 1:14 AM, Martin von Zweigbergk
> <martinvonz@gmail.com> wrote:
>> On Wed, May 29, 2013 at 10:41 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Thu, May 30, 2013 at 12:30 AM, Martin von Zweigbergk
>>> <martinvonz@gmail.com> wrote:
>>>> On Wed, May 29, 2013 at 12:09 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>>>> Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
>>>>>> +#       f
>>>>>> +#      /
>>>>>> +# a---b---c---g---h
>>>>>> +#      \
>>>>>> +#       d---G---i
>>>>> ...
>>>>>> +test_run_rebase () {
>>>>>> +     result=$1
>>>>>> +     shift
>>>>>> +     test_expect_$result "rebase $* --onto drops patches in onto" "
>>>>>> +             reset_rebase &&
>>>>>> +             git rebase $* --onto h f i &&
>>>>>> +             test_cmp_rev h HEAD~2 &&
>>>>>> +             test_linear_range 'd i' h..
>>>>>
>>>>> Isn't this expectation wrong? The upstream of the rebased branch is f, and
>>>>> it does not contain G. Hence, G should be replayed. Since h is the
>>>>> reversal of g, the state at h is the same as at c, and applying G should
>>>>> succeed (it is the same change as g). Therefore, I think the correct
>>>>> expectation is:
>>>>>
>>>>>                 test_linear_range 'd G i' h..
>>>>
>>>> Good question! It is really not obvious what the right answer is. Some
>>>> arguments in favor of dropping 'G':
>>>
>>> I think the answer is obvious; G should not be dropped. Maybe it made
>>> sense to drop g in upstream, but d fixes an issue, and it makes sense
>>> to apply G on upstream.
>>
>> Well, maybe I was wrong in thinking that dropping 'G' in 'git rebase
>> --onto f h i' is bad. It seems to complicate things a lot, so maybe we
>> should just decide that it's fine to do that (to drop 'G' in that
>> case). Since that's mostly how it has worked forever and no one seems
>> to have reported a problem with it, I'm probably just being paranoid.
>> Thoughts?
>
> Huh? I said the opposite; G should *not* be dropped.

I suspect you missed that I said 'git rebase --onto f h i', not 'git
rebase --onto h f i'. Sorry, I should have pointed that out.
