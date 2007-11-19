From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current
 branch
Date: Mon, 19 Nov 2007 10:24:46 +0100
Message-ID: <4741565E.1020500@op5.se>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site> <11954023881802-git-send-email-prohaska@zib.de> <119540238994-git-send-email-prohaska@zib.de> <7vwssfqb0w.fsf@gitster.siamese.dyndns.org> <EA5C3227-12E1-43C4-96E8-43BABF26792B@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Nov 19 10:25:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu2sR-0002JW-Ch
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 10:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbXKSJYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 04:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbXKSJYy
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 04:24:54 -0500
Received: from mail.op5.se ([193.201.96.20]:54380 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504AbXKSJYx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 04:24:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C62001F08755;
	Mon, 19 Nov 2007 10:24:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GFe-U9mLbr7M; Mon, 19 Nov 2007 10:24:50 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 570171F08754;
	Mon, 19 Nov 2007 10:24:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <EA5C3227-12E1-43C4-96E8-43BABF26792B@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65418>

Steffen Prohaska wrote:
> 
> On Nov 19, 2007, at 2:28 AM, Junio C Hamano wrote:
> 
> 
> 
>> I do not think it is "Often you want" that makes it awkward.
>>
>> Instead, the awkward case is if you do the "only the current"
>> push NOT often enough.  If it is often enough, you set the
>> configuration once and the awkwardness is behind you.
>>
>> If however it is not often enough, you cannot afford to have the
>> configuration above, because that would force you to tell from
>> the command line which branches, not just the current one, to
>> push, and that is inconvenient because it is not rare enough.
> 
> Will try to rephrase the commit message.
> 
> 
>> Together with your [PATCH 1/2], I like the general direction
>> these patckes are taking us, but it feels a bit too hasty.  I
>> personally am not convinced that switching to --current for
>> everybody is a good move.
>>
>>> ...
>>> Maybe in two years (that's twice an eternity in git time scales):
>>>
>>> 4) make "git push --current" the default.
>>
>> If these, both the uncertainly expressed by "Maybe" and "twice
>> an eternity" are true, which they are, the new warning in the
>> current patch are inappropriate.  Many people's settings depend
>> on a working "push the matching refs" behaviour, and we need a
>> very good excuse to annoy the existing happy users with such a
>> warning.
> 
> I think 3) is the interesting case.  "git push" should do
> nothing by default.  Either you can configure "git push" to do
> something by setting a remote.$remote.push line or you need
> to provide a command line switch.  But if you do not tell
> explicitly what you want, "git push" will not do anything
> for you.
> 

I'd really, really hate that. I often have changes on several branches
when I push. I like the behaviour as it is today.

> 
>> Remember, how much vocal the dissenters might have been on the
>> list in the recent discussions, we need to consider the needs of
>> the silent majority that has been content with the current
>> behaviour for a long time.
>>
>> The "warning" to annoy them may be a way to get their attention
>> and get them involved in a discussion to decide what the default
>> should be.  But changing the default without giving the people
>> who do not like the _new_ default a way to avoid inconvenience
>> of always typing --matching or --current is not nice.  And
>> honestly, I do not think there is one single default that is
>> good for everybody.
> 
> Personally, I'd switch to the do-nothing default immediately.
> But you are right.  More work is needed to have a smooth transition.
> 
> 
>> We should be doing better.
>>
>> A smoother transition route would be:
>>
>>  - Keep "matching" the built-in default for now;
>>
>>  - Take your patches (but drop "warning" bits at this point) to
>>    introduce 'matching' and 'current' behaviours, and a way to
>>    override the built-in default from the command line;
>>
>>  - Introduce a configuration 'push.defaultRefs' ('matching' or
>>    'current') to override that built-in default, so people who
>>    prefer 'current' can override the built-in default, without
>>    having to type --current every time.
> 
> Sounds like a plan.
> 
> If we have the configuration variable, maybe we could switch
> off the default behaviour immediately.  Setting a single global
> config variable once would be sufficient to get it back.  So,
> we could change the default and print a recommendation to run
> 'git config --global push.defaultRefs matching' to get it back.
> 

Ugh. People who neither know nor care about git development will
wonder why the hell they now have to tell git something in order
for it to do something it's always done anyway. The majority of
git users never read release-notes. They just do "yum update" and
then go about their business the same way they've always done.

Newcomers that obviously have no such configuration will wonder
why they're getting warnings from using the standard command-set.

> ...
> 
>> After all that happens, we can start discussing what the
>> built-in default should be.  When it is changed after the
>> discussion concludes (which may never happen), people who want
>> to keep 'matching' behaviour would have had the configuration
>> mechanism to override that built-in default for some time during
>> the discussion period.  So the beginning of that discussion
>> period is when we should start talking about "We might change
>> the default soon; set the configuration to your liking if you do
>> not want to get affected" in the warning.
> 
> ... And we'd not even start the discussion.  Because there's no
> need to.  Every user should make a choice, once.  We do not
> provide a default (which obviously will trigger another discussion ;)
> 

If the default's to be changed, making it default to no-op is really
the only sensible thing to do. Otherwise I'm guessing a lot of people
that actually count on the current behaviour will get quite vexed, and
--current is definitely not the universally correct default thing to do.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
