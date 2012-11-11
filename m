From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sun, 11 Nov 2012 13:16:26 -0500
Message-ID: <509FEB7A.2050006@gmail.com>
References: <5093DC0C.5000603@drmicha.warpmail.net> <20121108200919.GP15560@sigill.intra.peff.net> <509CCCBC.8010102@drmicha.warpmail.net> <CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com> <509E8EB2.7040509@drmicha.warpmail.net> <CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com> <509EAA45.8020005@gmail.com> <CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com> <509FD9BC.7050204@gmail.com> <20121111171518.GA20115@sigill.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:16:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXc5K-0003ow-0K
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 19:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab2KKSQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 13:16:29 -0500
Received: from mail-gh0-f174.google.com ([209.85.160.174]:45389 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab2KKSQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 13:16:28 -0500
Received: by mail-gh0-f174.google.com with SMTP id g15so1090757ghb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 10:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=uGaJyH644UbKHpn24Pt5OqL+4iJF4ZA6sAnhJ3ywt9M=;
        b=yyELqxFFrEGgBAMH8Ox1dc5hvHmtOJQzbs3Op4J/xa6v5HyOniGi/MAGHpZ8yOHkLr
         FvZeGu/mLCw0hN6LSRAp0ffLrlyZi4cM2w8aTrlxmlBEnkLKXZE15v54XhXeuEr5eUkD
         udqLPLx8kPZK5aRLYrnqiqq+Tujk+eWdVlq5o0Y8zB5hFG6DnMxYnI8a1HM2IDQo4iO9
         8bi4VXnON9hhAkG2Kc7gz4F7phGMFUDLR/mbm6pA1crE0sNXSrT21Wv88SRKt4tCZVYk
         g/kQvLnMciCQOYsxRijQBy0iJru2RzB+H/miNpTLbC5R/SAs21QsWoPgNWZT9PIEk5/+
         gSyA==
Received: by 10.236.73.198 with SMTP id v46mr17777544yhd.80.1352657787917;
        Sun, 11 Nov 2012 10:16:27 -0800 (PST)
Received: from [10.0.1.132] ([97.104.180.2])
        by mx.google.com with ESMTPS id u11sm3998739ane.11.2012.11.11.10.16.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 10:16:27 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
In-Reply-To: <20121111171518.GA20115@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209435>

On 11/11/2012 12:15 PM, Jeff King wrote:
> On Sun, Nov 11, 2012 at 12:00:44PM -0500, A Large Angry SCM wrote:
>
>>>>> a) Leave the name conversion to the export tools, and when they miss
>>>>> some weird corner case, like 'Author<email', let the user face the
>>>>> consequences, perhaps after an hour of the process.
>> [...]
>>>>> b) Do the name conversion in fast-import itself, perhaps optionally,
>>>>> so if a tool missed some weird corner case, the user does not have to
>>>>> face the consequences.
>> [...]
>>>> c) Do the name conversion, and whatever other cleanup and manipulations
>>>> you're interesting in, in a filter between the exporter and git-fast-import.
>>>
>>> Such a filter would probably be quite complicated, and would decrease
>>> performance.
>>>
>>
>> Really?
>>
>> The fast import stream protocol is pretty simple. All the filter
>> really needs to do is pass through everything that isn't a 'commit'
>> command. And for the 'commit' command, it only needs to do something
>> with the 'author' and 'committer' lines; passing through everything
>> else.
>>
>> I agree that an additional filter _may_ decrease performance somewhat
>> if you are already CPU constrained. But I suspect that the effect
>> would be negligible compared to the all of the SHA-1 calculations.
>
> It might be measurable, as you are passing every byte of every version
> of every file in the repo through an extra pipe. But more importantly, I
> don't think it helps.
>
> If there is not a standard filter for fixing up names, we do not need to
> care. The user can use "sed" or whatever and pay the performance penalty
> (and deal with the possibility of errors from being lazy about parsing
> the fast-import stream).
>
> If there is a standard filter, then what is the advantage in doing it as
> a pipe? Why not just teach fast-import the same trick (and possibly make
> it optional)? That would be simpler, more efficient, and it would make
> it easier for remote helpers to turn it on (they use a command-line
> switch rather than setting up an extra process).
>
> But what I don't understand is: what would such a standard filter look
> like? Fast-import (or a filter) would already receive the exporter's
> best attempt at a git-like ident string. We can clean up and normalize
> things like whitespace (and we probably should if we do not do so
> already). But beyond that, we have no context about the name; only the
> exporter has that.
>
> So if we receive:
>
>    Foo Bar<foo.bar@example.com>  <none@none>
>
> or:
>
>    Foo Bar<foo.bar@example.com<none@none>
>
> or:
>
>    Foo Bar<foo.bar@example.com
>
> what do we do with it? Is the first part a malformed name/email pair,
> and the second part is crap added by a lazy exporter? Or does the
> exporter want to keep the angle brackets as part of the name field? Is
> there a malformed email in the last one, or no email at all?
>
> The exporter is the only program that actually knows where the data came
> from, how it should be broken down, and what is appropriate for pulling
> data out of its particular source system. For that reason, the exporter
> has to be the place where we come up with a syntactically correct and
> unambiguous ident.
>
> I am not opposed to adding a mailmap-like feature to fast-import to map
> identities, but it has to start with sane, unambiguous output from the
> exporter.

I don't think that there is or can be a standard filter. Cleaning up 
after a broken exporter is likely to always be a repository unique 
situation. The example here is about names and email addresses but it 
could easily be about other things (dates, history, content, etc.). Some 
of which that could possible be fixed using git-filter-branch; some 
possibly not.

Fixing the exporter is always the most desirable option, but it may not 
be the best option for the particular situation. Locally modifying 
git-fast-import is another option; again, possibly not the best option. 
Convincing the git maintainers to handle your specific situation, though 
a good option for you, is not likely to be scalable. A filter in front 
of git-fast-import is always _an_ option and can tailored to the 
particular situation.

My preference is to follow the "Unix philosophy": the tools are focused 
on what they need to do and can be composed with other tools/scripts to 
accomplish the desired result.

d) Another (bad) option is to make git-fast-import very permissive and 
warn the user to fix things via git-filter-branch before distributing 
the repository or git's standard repository checks find the problems.

This isn't my itch so I think I may have exhausted my $0.02 on this subject.
