From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] p5310: Fix broken && chain in performance test
Date: Fri, 26 Jun 2015 15:34:19 -0700
Message-ID: <CAGZ79kYCcexkdcF4D4GhUydh=0u0UOZGb0QGbtg6gbKWeO2M_Q@mail.gmail.com>
References: <1435354020-11675-1-git-send-email-sbeller@google.com>
	<xmqq616artpz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 00:34:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8cCX-0003c0-B8
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 00:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbbFZWeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 18:34:21 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34808 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbbFZWeU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 18:34:20 -0400
Received: by ykfy125 with SMTP id y125so71237811ykf.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZyLXUOIqTZRRVK/7B12MLe5Y2+TWavPFcf3oxDa6PHg=;
        b=XyaZj2sQ6ZhdWaYtkfGUy+UrqYACDirlJpsTT6nlOM53BE70PYHIAp+tTziYWRgeV2
         DUsKa4szUolSbvoX3y28Ed2S+1dPmUKmXoysJV8zTgaiLba6lUYrOgqVxIlJfhPv/PnU
         rfjAgbozFBj2c7D9t9NR1n5xjota8QKMbJ1NhyRvqBtiLsJ28cxo6ki/N8xSn72x1OlA
         UESg/QNxEngB9VsXM/u4Iqb+4W0m5Vdt7KQCl9buc5nQA+Qs4u7N679ZE6FQkWwDKtXM
         bYUR9srHC+MMjHHWywk27BBBNnMEIEltiYXGA8QvjJlzFToACpRp+ziIPzk1BZwHW2pt
         oYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZyLXUOIqTZRRVK/7B12MLe5Y2+TWavPFcf3oxDa6PHg=;
        b=RmeAm6cL4xTFm3ikQjL/5vMM4R8taZ0X4hCTGDFJYyFfxkSxQ9OrwiL42es+BRzwAE
         VIb0JjQSaWK9TwKNUuyuWU1o+mVwgnqCsQZpaZquQIG95vO/DStyiQf3ocnd7cDzX6Os
         vrp/GSLQouUAtYtBbg6gDPuPwf6VyTXsyUEtbC2xncfi9bM3Zrbwc6ih69T6xHHThn5c
         fFlH8TIHr/GcroVmxAC1WJ1KHbc82DIVLeUz6zJKrVZWB/IH+fUyCn5omE97vmy7sru5
         RFKRhuQXA/uJ012YKCwW5tOFBUbUbJP9O4MwifQ2fEDHxL9GPr/zqVZ4ooZqoLdKnoA5
         Wk0w==
X-Gm-Message-State: ALoCoQmO9JMLP1lRxzwKkM3sYA5pLGw0GjvKmD9I6poY9PT0KXhF+yj5/QVgQ2DdQpKHJeWvAjSW
X-Received: by 10.170.82.131 with SMTP id y125mr4716031yky.115.1435358059191;
 Fri, 26 Jun 2015 15:34:19 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Fri, 26 Jun 2015 15:34:19 -0700 (PDT)
In-Reply-To: <xmqq616artpz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272839>

On Fri, Jun 26, 2015 at 3:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> Thanks.  How did you find this (does the auto &&-chain test apply to
> t/perf stuff as well)?

Apparently the &&-chain tests for it as I got a warning for it while
benchmarking some changes in ALLOC_GROW. (which originally
should have fixed the coverity false positives, but I was side tracked
wondering about performance)

>
> Will queue.
>
>> ---
>>  t/perf/p5310-pack-bitmaps.sh | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
>> index f8ed857..de2a224 100755
>> --- a/t/perf/p5310-pack-bitmaps.sh
>> +++ b/t/perf/p5310-pack-bitmaps.sh
>> @@ -39,14 +39,14 @@ test_expect_success 'create partial bitmap state' '
>>
>>       # now kill off all of the refs and pretend we had
>>       # just the one tip
>> -     rm -rf .git/logs .git/refs/* .git/packed-refs
>> -     git update-ref HEAD $cutoff
>> +     rm -rf .git/logs .git/refs/* .git/packed-refs &&
>> +     git update-ref HEAD $cutoff &&
>>
>>       # and then repack, which will leave us with a nice
>>       # big bitmap pack of the "old" history, and all of
>>       # the new history will be loose, as if it had been pushed
>>       # up incrementally and exploded via unpack-objects
>> -     git repack -Ad
>> +     git repack -Ad &&
>>
>>       # and now restore our original tip, as if the pushes
>>       # had happened
