From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Thu, 16 May 2013 21:00:36 -0500
Message-ID: <CAMP44s1J6xvxTKhf79QvLGxDWUWKYe+et=g3RTA_a5_UaymKEw@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
	<CAMP44s1atVbN6CXAud4XzkKjAJOwoobF5uiXX12pBut0Becydw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 04:00:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud9yO-0002zU-Vu
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 04:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab3EQCAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 22:00:40 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:46859 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab3EQCAj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 22:00:39 -0400
Received: by mail-la0-f51.google.com with SMTP id lx15so1763775lab.38
        for <git@vger.kernel.org>; Thu, 16 May 2013 19:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=JyOANrcv2w6VE+9sDodQGHBaEXA7u5CxeVqtWNJaios=;
        b=saCqwSKVA/IT4V/8xl/pcE3iBrtL2+vEj4gVDLZNNtDRh+hcaDd/MPvi4IhkN8QkSc
         QfsfqYPIFq3Bh7SGc9Y+eaOu3+wOH4346hqalXsUubBCZDS6WJrfV7WsRZ9M54KlaC5F
         Oe1qAmryTVGxUzgpDibJh9BpEMEvEfGsh3znFQPtr4HFzbS2c1kTU5yw7RHUls9/uVM0
         UbHXlisCu8naqsYpWsKpyr5VRARqWIomZA1EHOTiQvElg5lkJnLzD7s0qnbCZ7p6Zt0V
         wA2yEb4AAhqp4E05Myjp34YAJ2eBjOf3VUo+lZR13ODgtdxTRKFoBjyJ2hyX1qBXykKs
         Fgig==
X-Received: by 10.112.172.40 with SMTP id az8mr10296452lbc.88.1368756036659;
 Thu, 16 May 2013 19:00:36 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 19:00:36 -0700 (PDT)
In-Reply-To: <CAMP44s1atVbN6CXAud4XzkKjAJOwoobF5uiXX12pBut0Becydw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224648>

On Thu, May 16, 2013 at 8:59 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, May 16, 2013 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> What happens if I want to push to 'refs/heads/topics/frotz-for-juno'?
>>>
>>> You would weigh pros-and-cons of supporting such a "single branch
>>> only" special case, and add a branch level override, and if the
>>> benefit outweighs the cost of complexity, design and implement it.
>>>
>>> The push.default setting is to make sure we have a simple mechanism
>>> to cover more common cases, and my suspicion is what 'current' gives
>>> us is already there without the need for 'single'.
>>
>> Actually, I suspect that you shouldn't even need to do that
>> pros-and-cons analysis, because the 'single' thing should cover as a
>> natural extension of the existing infrastructure.  You should only
>> need to have something like this:
>>
>>         [remote "there"]
>>                 url = ... were you push ...
>>                 push = refs/heads/frotz:refs/heads/topics/frotz-for-juno
>>                 push = refs/heads/*:refs/heads/topics/*
>>
>> Without the 'single', your 'frotz' will be pushed to update
>> heads/topics/frotz-for-juno, not heads/topics/frotz, because the
>> exact refspec match will prevent it from matched twice by the
>> wildcarded one.  The imagined 'single' mode would just limit the
>> push to the current branch, so it would end up pushing to the branch
>> you want to update, without sending an extra copy to the same name.
>
> And would 'git branch --set-downstream-to github/frotz-for-juno' do
> that? If not it's basically useless for 99% of the users who never
> fiddle with push refspecs.

And 'git branch -vv' would not show that either. Nor can the user do
'@{downstream}'.

-- 
Felipe Contreras
