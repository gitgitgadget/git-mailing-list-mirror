From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: git-cherry doesn't detect a "copied" commit
Date: Thu, 29 Oct 2015 15:44:54 +0100
Message-ID: <CAC9WiBhwAMH6axJqexhdfM-0j2AQ=+mvxjKQOJu5TLVrCCn8Fg@mail.gmail.com>
References: <CAC9WiBhM4edBFCYx35xZJB79AZWo49mkO-Pxnb1q4aLDmBufWQ@mail.gmail.com>
	<20151023105756.GB12622@ikke.info>
	<CAC9WiBjub2oBBaM7KxcE2Jv7QgGyvmPzEBU7WcSEk5huGzx+zg@mail.gmail.com>
	<xmqq37x1nr6e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Daudt <me@ikke.info>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 15:45:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZroRn-0007Al-VL
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 15:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757242AbbJ2Oo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 10:44:56 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35815 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbbJ2Ooz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 10:44:55 -0400
Received: by iofz202 with SMTP id z202so47848329iof.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gDwyXcq+XwFcOiB4RXrOQ0A0K8HdnXQ9SM2PmAuplLU=;
        b=e0bq/eHhMWbaxwGQF0oAc0eXYjfnmS69edPeDCO7nGWOVHlTZSbe6qYHOON/49CU4V
         eduTn3ieKDkXgDJY1oHpDBnqazSRrCs4YQ+DYrtO8B6HNAM9Oa+pOKGz1O9mz1dX25HZ
         J6RSw8YPgw1g+VjQBOlw208fRYgVIuqGWLqNj1hCPtU9VgFxBWtfIglZJB6yShJJ5TQO
         nkxMU4mk8gcg6PCFS9Wnp8Hzo3Sunw4V4WTiNtjX8AOzJz7q5o8uc0tHvHEs37dlLQ90
         hVio8971Sq75x+19u5kEByiCN0UG8g7Q+ezSeUrZpdlYVfep9coWu7hEaVp/QV33dfdT
         jvew==
X-Received: by 10.107.46.142 with SMTP id u14mr3788227iou.165.1446129894671;
 Thu, 29 Oct 2015 07:44:54 -0700 (PDT)
Received: by 10.79.77.1 with HTTP; Thu, 29 Oct 2015 07:44:54 -0700 (PDT)
In-Reply-To: <xmqq37x1nr6e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280441>

Hello Junio,

On Sat, Oct 24, 2015 at 12:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Francis Moreau <francis.moro@gmail.com> writes:
>
>> I was mislead by the git-cherry manpage somehow which says:
>>
>>     "git-cherry therefore
>>      detects when commits have been "copied" by means of git-cherry-pick(1),
>>
>> which is not exactly true.
>
> Yeah, I agree; the sentence is merely giving a description from
> layperson's point of view, and it should have expressed it as such,
> e.g. "roughly speaking, you can think of it like so", not sounding
> as if it is giving a strictly correct and authoritative statement.
>
>> Would it make sense to add a "--fuzz" option which would reduce the
>> diff context area used to generate the hash ?
>
> There could be situations where such fuzzing might be useful, but I
> do not think this particular use case of yours is one of them.
>
> I'd imagine that you had two branches A (with "Unkown") and B (with
> "Unknown"), and wanted to apply changes in them to your integration
> branch (let's call that 'master').  You ask cherry "what commits in
> A are missing in my 'master'?" and apply them.  Next you ask cherry
> "what commits in B are missing in my 'master' now?" and apply them.
>
> Because "Unkown" and "Unknown" are not considered the "same" patches
> (one is most likely an update to the other), you get conflict when
> applying the second copy, and that is how you can notice that one of
> them is a stale and buggy one.  If you haven't made your interim
> integration result available to others after processing branch A,
> you even have a chance to replace the "Unkown" one you already
> applied with the corrected "Unknown" one before continuing.  Even if
> you choose not to bother and skip the "Unknown" one from branch B,
> at least you know that in the end result you have a typo that would
> eventually need to be fixed from "Unkown" into "Unknown".
>
> If you did a fuzzy version and ignored s/Unkown/Unknown/ typofix
> between the "same" patches, you can avoid the conflict and all
> patches from branch B may apply cleanly and automatically on top of
> applying changes from branch A.  But depending on the order you
> processed A and B, you have a 50% chance of keeping the buggy
> version without even realizing.
>
> So erring on the safe side and judging "Unkown" and "Unknown" are
> different changes, inducing one extra conflict you had to look at,
> is actively a good thing in this case.
>

In this case, ie where code modification happens, I agree that we
should play in the safe side.

But in my case I was more using git-cherry as a tool to help me
compare my integration branch and the master one. I'm interested to
know which commits have been picked up from upstream and which ones
are specific to my branch.

And when backporting (cherry-picking) commits from upstream, it's
quite frequent that the context is slightly different.

I think in this case and not the one you describe, such 'fuzz' option
might make sense. Fuzzy match could be reported with a different tag,
'~' for example.

> One thing that helps to know while learning Git is that we try to
> avoid being overly clever and outsmarting human users.  Instead, we
> err on the safe side to avoid silently doing a wrong thing.
>
> This is because a tool that automates 100% of cases with 2% chance
> of producing wrong result cannot be trusted---you have to manually
> inspect all 100% cases it automatically handled to make sure it did
> the right thing.  We instead automate 98% of simple cases where it
> is obvious what the right result is, and ask the human user for help
> on the remaining 2%.
>
> And this design principle is not limited to cherry.  The design of
> our merge algorithms is the same way, for example.

I fully agree with this principle.

Thanks
-- 
Francis
