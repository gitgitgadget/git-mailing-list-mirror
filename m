From: kazuki saitoh <ksaitoh560@gmail.com>
Subject: Re: [PATCH v2] git-p4: Ask "p4" to interpret View setting
Date: Tue, 27 Aug 2013 11:43:38 +0900
Message-ID: <CACGba4wqSYf+qg21C7-0Y1r+ZafvggEVQrPu3nMdTr5PdtEOXQ@mail.gmail.com>
References: <CACGba4zdA=3tBE9UR=i9P9kNAL1HUc3UwSHbYeq4s9fwaN4=Mw@mail.gmail.com>
	<20130810201123.GA31706@padd.com>
	<CACGba4wbqyHzXDCQxG31EKawfc-D4jpVYqbB4GdmK4hM=Oi4mw@mail.gmail.com>
	<20130816012420.GA20985@padd.com>
	<20130825022944.GA16027@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 04:43:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE9Fx-0001dc-Jm
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 04:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab3H0Cnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 22:43:41 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:57201 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab3H0Cnk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 22:43:40 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so3072329lab.10
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 19:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gitw03sepF7zHj566DbwPGN/MsgPysoWrWIqWF+VU4s=;
        b=c8vRxjr2Rwmx1iyxDTqV3PewSFL5i9SeFt/qjVQaxV9fYEk5ajNo+Ci+HRSvRWbDqT
         ou0AHeGlshEiqYmi0rWVnoV9bKYDlfuVpXag9ZE30UvaVMI4eaVM4xCO6C7F9ycxEpTg
         VZzitzbexd1kDDB9ERx+k4KNJ+C7rbMYk/eM6vmPMjjekmrZgq6W3gV7TvjmrCo5MqJ1
         URbwcIaj+eWsMd/AHdVSZQdchosHhj68CoDbAy5JAVJAiDt6MK5B7WyjavgqGZ/5lAE5
         kbwb6kJGpuWVwrySJ0Mb1ucC9rToHEXPE5LEpfQtQdXbH8dnD+pv0MQ4mnQ7OQRkP6Ga
         IxwA==
X-Received: by 10.152.120.73 with SMTP id la9mr16434147lab.3.1377571418974;
 Mon, 26 Aug 2013 19:43:38 -0700 (PDT)
Received: by 10.114.176.232 with HTTP; Mon, 26 Aug 2013 19:43:38 -0700 (PDT)
In-Reply-To: <20130825022944.GA16027@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233041>

> Do you have an updated patch?  Want to take some time to clean up and
> resubmit the entire series?  The batching should be incorporated with
> the last 2/2 that I sent out.

I don't have other update.
I'm satisfied because able to want to do and it became better than my
original modification thanks to your cooperation.
(> a few-hundred-thousand file repo
I didn't think that it work with so HUGE repo.)

How should I do?
Should I create one patch mail that incorporated your sent one?
Or nothing to do?


2013/8/25 Pete Wyckoff <pw@padd.com>:
> pw@padd.com wrote on Thu, 15 Aug 2013 21:24 -0400:
>> ksaitoh560@gmail.com wrote on Wed, 14 Aug 2013 09:59 +0900:
>> > > My only concern is in the commit message, about performance.  A
>> > > change that has lots of files in it will cause many roundtrips to
>> > > p4d to do "p4 where" on each.  When the files don't have much
>> > > edited content, this new approach will make the import take twice
>> > > as long, I'll guess.  Do you have a big repository where you
>> > > could test that?
>> >
>> > I measured performance of "git p4 clone  --use-client-spec" with a
>> > repository it has 1925 files, 50MB.
>> >   Original:    8.05s user 32.02s system 15% cpu 4:25.34 total
>> >   Apply patch:    9.02s user 53.19s system 14% cpu 6:56.41 total
>> >
>> > It is acceptable in my situation, but looks quite slow...
>> >
>> > Then I implemented one batch query version
>> >    7.92s user 33.03s system 15% cpu 4:25.59 total
>> >
>> > It is same as original
>> >
>> > My additional patch is below.
>> > I investigate call graph (attached rough sketch) and
>> > implement batch query in "commit()" and "splitFilesIntoBranches()".
>> > In addition, modified "map_in_client" to just search cache value.
>> >
>> > Could you accept?
>>
>> This looks good.  I've started my own performance testing
>> on a few-hundred-thousand file repo to confirm your findings.
>>
>> If it seems to work out, we can clean up the patch.  Otherwise
>> maybe need to think about having both implementations and use
>> the by-hand one for "...".  I don't like that approach.  Let's
>> hope it's not needed.
>
> I tried with a few repos:
>
> Small repo, single-commit clone:
>
>     Current:     0m0.35s user 0m0.30s sys 0m11.52s elapsed 5.69 %CPU
>     No batching: 0m0.66s user 0m0.77s sys 0m34.42s elapsed 4.17 %CPU
>     Batching:    0m0.28s user 0m0.29s sys 0m10.85s elapsed 5.27 %CPU
>
> Big repo, single-commit clone:
>
>     Current:     6m21.38s user 1m35.36s sys 19m44.83s elapsed 40.23 %CPU
>     No batching: 1m53.13s user 24m34.35s sys 146m13.80s elapsed 18.09 %CPU (*)
>     Batching:    6m22.01s user 1m44.23s sys 21m19.73s elapsed 37.99 %CPU
>
>     The "no batching" run died with an unrelated p4 timeout.
>
> Big repo, 1000 incremental changes:
>
>     Current:     0m13.43s user 0m19.82s sys 11m12.58s elapsed 4.94 %CPU
>     No batching: 0m20.29s user 0m39.94s sys 38m44.69s elapsed 2.59 %CPU (*)
>     Batching:    0m16.15s user 0m26.60s sys 13m55.69s elapsed 5.11 %CPU
>
>     The "no batching" run died at 28% of the way through.
>
> There is probably a 20%-ish slowdown in my environment with this
> approach.  But given that the timescale for these operations is
> measured in the tens of minutes, I don't think a couple more matters
> too much to anybody.
>
> The attractiveness of the simplicity and increased client spec feature
> coverage weighs in its favor.  Let's go ahead and inflict this on the
> world and see what they think.
>
> Do you have an updated patch?  Want to take some time to clean up and
> resubmit the entire series?  The batching should be incorporated with
> the last 2/2 that I sent out.
>
>                 -- Pete
