From: Chris Rorvick <chris@rorvick.com>
Subject: Re: What's cooking in git.git (Oct 2012, #09; Mon, 29)
Date: Thu, 1 Nov 2012 20:12:20 -0500
Message-ID: <CAEUsAPb7hUViLn7V7v65r6mOqRHr+180ynRX8K9t3nuJVyePfg@mail.gmail.com>
References: <20121029102114.GA14497@sigill.intra.peff.net>
	<5092C234.9000307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 02 02:12:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU5oV-0003sM-KX
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 02:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759140Ab2KBBMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 21:12:24 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41191 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759527Ab2KBBMW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 21:12:22 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so2305861lbo.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 18:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=z6nCm8GdCLnj6t5CCMyqKd1jVZ6oitxm+hL7dS7bohI=;
        b=NMzeeKT3XtYzxOlsg9UA6/697cPVFu8jhlvQKPGhaDsV3NFw5Z0ocURnw5rTxaAFGp
         EVYlv1v5bFypk5UcL1Xb+NDYtrhTvzk2ZRcyRsF81P6xw2TlA4Y1rb8IClEfuxXgTVBz
         JSizP/1MwWQl6UFHI1rQUCBC0XBqrwNQTnV6BCvhYFdp8z42JFk7J4/8UuGebmBbaNaJ
         csDCQ0SULgAJONHeRqfXFgwb7L1I5juZZqLlQXKLzmoktQ/1Q70sg2H8g8yIJiuBbj0B
         1jH9PsiJFK2+U80bI9EoGvTHBUmuqteI12NqVJXM/AC+Gg9rkacwFW02woAQI/rY0hhp
         ZNHw==
Received: by 10.112.102.10 with SMTP id fk10mr138779lbb.40.1351818740527; Thu,
 01 Nov 2012 18:12:20 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Thu, 1 Nov 2012 18:12:20 -0700 (PDT)
In-Reply-To: <5092C234.9000307@ramsay1.demon.co.uk>
X-Google-Sender-Auth: slxhAbFlNhjV2xKA9DWb__1I_vM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208894>

On Thu, Nov 1, 2012 at 1:40 PM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> Jeff King wrote:
>> What's cooking in git.git (Oct 2012, #09; Mon, 29)
>> --------------------------------------------------
>>
>
> [snip]
>
>> * cr/cvsimport-local-zone (2012-10-16) 1 commit
>>  - git-cvsimport: allow author-specific timezones
>>
>>  Allows "cvsimport" to read per-author timezone from the author info
>>  file.
>>
>>  Will merge to 'next'.
>
> Just FYI, t9604-cvsimport-timestamps.sh is still failing for me.
>
> I haven't spent too long on this yet, but I had hoped that setting
> TZ would sidestep any DST issues. (I have downloaded new tzdata, but
> have yet to install - actually I don't really want to!). It is not
> clear from the tzset manpage what happens if you use the DST format
> for TZ, but you don't provide the start/end date for DST, which is
> what this test is doing.
>
> Perhaps the test should use the non-DST format? e.g. "TZ=CST6 git ..."
> Does the test really care about DST? (*if* that is indeed the problem).

It actually looks like your TZ database is fine and the problem is
with the conversion to a struct tm.  In each case, the time is
localized to the previous TZ value while the offset for the current TZ
value.  For example, look at the first commit in the first test.  It
converted the timestamp to 18:00 (CST6) while all the rest came
through as expected.    I suspect the previous version of cvsimport
would exhibit similar behavior with the first imported commit.  What
is your platform?

> Also: Note that the first test calls git-cvsimport twice, first *with*
> TZ set then again without; I suspect a cut/paste editing error.

Oops.  The second invocation should have no effect on the repo so the
unit test is still valid, but that was a mistake for sure.  Thanks.

Chris
