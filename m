From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/4] t4203: test mailmap functionality directly rather
 than indirectly
Date: Thu, 11 Jul 2013 22:37:15 -0400
Message-ID: <CAPig+cRtX=DHGK0D8zK2V9vZyS5-sGKmvEysLcG99De7RLGBOw@mail.gmail.com>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-4-git-send-email-sunshine@sunshineco.com>
	<7vhag0rk3u.fsf@alter.siamese.dyndns.org>
	<CAPig+cS7rxFzY8Q3gfTtJkggp-K62SVqsjCotbM3Bkm47L44gg@mail.gmail.com>
	<20130712005517.GA8482@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 04:37:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxTEn-0008F9-SK
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 04:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551Ab3GLChT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 22:37:19 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:58789 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab3GLChS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 22:37:18 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so7369615lbc.17
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 19:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=OnVZ6V7ERa99/Ge2Qs4R45kItCUxON3Wix+R2qG5LUY=;
        b=EAEAmgWx9TUCEIg9/47Tc4Eeqvoke9Qbg50KaFeKM+yYiV8lhOHKNPnVvZw0YhB3/A
         VYpsnOAcJsW6YwEaSpxaVI8p459AEbObuHGvxpo+i655qgF5TJmoEsegmZWK1ga1do9+
         xRa7YvvSZNMLvByX7U1TTLOD0y14z9DvuE8+t/XU3eTYHrS92hkJN8HzwBEwyn8mGWem
         6t3eqTFS+HSev8dBbijfxrBh/kkjs18oujzgJptyLbu8bbRQ4sv8Wqz8FTFmguqyAI2Z
         Y2sOhTwvJs9WtR+MSkrsR9G7hm8XDoZ/40/+huOCkQhy3pI1gF+DUAOUgG0e/FpznXwA
         8pEw==
X-Received: by 10.152.44.225 with SMTP id h1mr17986965lam.90.1373596636190;
 Thu, 11 Jul 2013 19:37:16 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 11 Jul 2013 19:37:15 -0700 (PDT)
In-Reply-To: <20130712005517.GA8482@google.com>
X-Google-Sender-Auth: cmHv2-E9phbwNst7fGqsyc81XrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230157>

On Thu, Jul 11, 2013 at 8:55 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Sunshine wrote:
>> On Thu, Jul 11, 2013 at 3:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>>> With the introduction of check-mailmap, it is now possible to check
>>>> .mailmap functionality directly rather than indirectly as a side-effect
>>>> of other commands (such as git-shortlog), therefore, do so.
>>>
>>> Does this patch mean that we will now ignore future breakages in
>>> shortlog and blame if their mailmap integration becomes buggy?
>>>
>>> I am not convinced it is a good idea if that is what is going on.
>>
>> I meant to mention in the cover letter that this patch was open for
>> debate, however, it does not eliminate all testing of these other
>> commands.
>>
>> The tests in which git-check-mailmap is substituted for git-shortlog
>> all worked against a simplistic two-commit repository. Those tests
>> were checking the low-level mailmap functionality under various
>> conditions and configurations; they were not especially checking any
>> particular behavior of git-shortlog.
>>
>> There still remain a final eight tests which cover git-shortlog,
>> git-log, and git-blame. These tests do check mailmap-related behavior
>> of those commands, and they do so using a more involved seven-commit
>> repository with "complex" mappings, so we have not necessarily lost
>> any checks of mailmap integration for those commands.
>>
>> Would this patch become more palatable if I stated the above in the
>> commit message?
>
> My current thinking is "no" --- the patch has as a justification "Now
> we can test these aspects of .mailmap handling directly with a
> low-level tool instead of using the tool most people will use, so do
> so", which sounds an awful lot like "Reduce test coverage of commonly
> used tools, because we can".
>
> But I imagine the actual motivation was something other than "because
> we can".

The motivation is as stated in the subject: Direct rather than
indirect testing of mailmap functionality. The tests in question are
properly crafted to check only low-level mailmap (not git-shortlog)
functionality under various conditions and configurations, yet the
mental load on the reader is high because he has to keep in mind the
authors and commits in the repository underlying git-shortlog's
output. When testing via git-check-mailmap, mental load is low: there
is a direct correlation between the "Name <email@address>" which goes
in and that which comes out. What is being tested is the same, but
it's easier to reason about and understand the the tests when done
directly.

When converting the tests, I also discovered an additional, perhaps
more important motivation. Most of the tests check only that name
remapping functions correctly, however, a couple also attempt to check
address remapping (bugs@company.xx => bugs@company.xy). Even though
the tests succeed, they don't actually prove that address remapping
was correct (or occurred at all) since git-shortlog does not display
the email address. git-check-mailmap always displays the email
address, thus the check actually tests the intended email address
remapping.

> For example, maybe the idea is that after this patch, it
> should be easier to make cosmetic improvements to the shortlog, log,
> and blame output and only have to change those final 8 tests that are
> adequately covering the output?  If you have such plans and this patch
> makes them easier, it could sound like a good patch as a stepping
> stone toward that.
