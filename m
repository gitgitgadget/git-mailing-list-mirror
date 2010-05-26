From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/5] checkout --orphan: respect -l option always
Date: Wed, 26 May 2010 17:31:31 +0200
Message-ID: <4BFD3ED3.3000709@drmicha.warpmail.net>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com> 	<1274488119-6989-4-git-send-email-erick.mattos@gmail.com> 	<7vzkznqmir.fsf@alter.siamese.dyndns.org> <AANLkTimT3sI3yuM8RZai-eWDk8Z5Rmc28RLGOx_i-RXa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 17:32:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHIap-00005B-5N
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 17:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546Ab0EZPcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 11:32:18 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43390 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755538Ab0EZPcR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 11:32:17 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C8C62F81C6;
	Wed, 26 May 2010 11:31:45 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 26 May 2010 11:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5kUI5XJPu6jWXlzfr4LIanGQ6rE=; b=YPxkAp/e10+YCVg/KhqUimpO1RpH1jYnBkGkODMC9mS6jPnhugKDGj7vyQTrbvbZYJ2W+o1tisXQdxDHMXQmUZ82hb1k5sDBGq+aV3kmBL0aIxHIX9ygidwZpMrUXvcrgdEwq4Z98VQPwc4rLLsNjkuoex5nX7FQqG2p6ifORCI=
X-Sasl-enc: N4Flujrd3y+ttAq+pScXmfUMxFcCzZT0q0LBXyyIW5QB 1274887905
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B2BB54D7BAC;
	Wed, 26 May 2010 11:31:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTimT3sI3yuM8RZai-eWDk8Z5Rmc28RLGOx_i-RXa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147805>

Erick Mattos venit, vidit, dixit 26.05.2010 16:52:
> Hi,
> 
> 2010/5/26 Junio C Hamano <gitster@pobox.com>
>>
>> Erick Mattos <erick.mattos@gmail.com> writes:
>>> @@ -684,8 +709,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>>>       if (opts.new_orphan_branch) {
>>>               if (opts.new_branch)
>>>                       die("--orphan and -b are mutually exclusive");
>>> -             if (opts.track > 0 || opts.new_branch_log)
>>> -                     die("--orphan cannot be used with -t or -l");
>>> +             if (opts.track > 0)
>>> +                     die("--orphan should not be used with -t");
>>
>> Why s/cannot/should not/?  Just being curious.
> 
> I have typed that text, not changed the original so this is not a fix
> to your text.  Anyway for me "should not" is more polite, like "you
> should not yell" meaning you really can not do it.  Or "you should not
> disrespect the captain".

"should not" means you can but you should not. "die" certainly means you
cannot. This is not a matter of politeness but of correctness.

> 
> But that is not a fix.

There's a "-" line with "cannot" and a "+" line with "should not". So
you certainly changed what was there before.

> 
>>> +test_expect_success 'giving up --orphan not committed when -l and core.logAllRefUpdates = false deletes reflog' '

Really long line here ;)

>>> +     git checkout master &&
>>> +     git checkout -l --orphan eta &&
>>> +     test -f .git/logs/refs/heads/eta &&
>>> +     test_must_fail PAGER= git reflog show eta &&
>>> +     git checkout master &&
>>> +     ! test -f .git/logs/refs/heads/eta &&
>>> +     test_must_fail PAGER= git reflog show eta
>>> +'
>>
>> I don't quite understand the title of this test, nor am I convinced that
>> testing for .git/logs/refs/heads/eta is necessarily a good thing to do
>> here.  "eta" branch is first prepared in an unborn state with the working
>> tree and the index prepared to commit what is in 'master', and the first
>> "git reflog" would fail because there is no eta branch at that point yet.
>> Moving to 'master' from that state would still leave "eta" branch unborn
>> and we will not see "git reflog" for that branch (we will fail "git log
>> eta" too for that matter).  Perhaps two "test -f .git/logs/refs/heads/eta"
>> shouldn't be there?  It feels that it is testing a bit too low level an
>> implementation detail.
> 
> So I need to explain the solution:
> 
> When config core.logAllRefUpdates is set to false what really happens
> is that the reflog is not created and any reflog change is saved only
> when you have an existent reflog.
> 
> What I did was to make a "touch reflog".  Creating it, when the new

You mean checkout -l --orphan does that touch? There is none in the
test. Does ordinary checkout with -l does that, too?

> branch get eventually saved then the reflog would be written normally.
>  But in case somebody give up this new branch before the first save,
> moving back to a regular branch would leave a ghost reflog.

The touched entry (is left), not a reflog, I assume, otherwise the
reflog command should not fail.

> 
> I have coded the cleaning commands for that and the test is just a
> check of this behavior.

Which command does the cleaning? "reflog show" or "checkout master"?

> 
> The first "test -f .git/logs/refs/heads/eta" tests if reflog was
> created and the second if it was deleted.  No big deal.
> 
> Regards

I haven't followed this series due to earlier worries about --orphan but
I'm wondering about this cleaning up behind the back. Maybe it's just a
matter of explanations, though.

Michael
