From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/7] submodule foreach: correct path computation in
 recursive submodules
Date: Tue, 29 Mar 2016 12:26:30 -0700
Message-ID: <CAGZ79kbaSNt9UViQQ2ro48Dqhe3c-k+CDvfppjb3Y=nOmnJs4A@mail.gmail.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
	<1459207703-1635-3-git-send-email-sbeller@google.com>
	<xmqq60w525yd.fsf@gitster.mtv.corp.google.com>
	<xmqqk2klxg6b.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka5_C0HcWGyYThT7O2ts-B1dTkBWEt1MUsbEN-AciE15g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:26:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzHn-0002Xm-ID
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbcC2T0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:26:34 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35191 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965AbcC2T0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:26:31 -0400
Received: by mail-io0-f181.google.com with SMTP id g185so37838265ioa.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Mhk1xHF8TPyFg5BgnEBHQvCZ++ocwd9fJshziJfZ/M0=;
        b=IZu5RqMzRp7PVV9cb14R1qpV9eIJ9qtH0AB4ovClV0iVdDENXdRzbzqYwRZ4ZXVwxE
         rwx0UIHI+01yCakCpeOe2hB9HvvDLXjyISRqjRhGJZ/JtYymU6hr28bvbjdXU02D8P/2
         aWvdlqa11lx8W3r/0SpiKIi6Sjars1KWdUAiOSO7weXDACa+LiS8szWyjRTpijtcguut
         8t19HReYZe1uEpvBu5asc40QlEhVZor2V0imeRXHZbZh999YN1SBKnW6WY1c4wHj8NL6
         RnBLzws5XMFNBfQtCkM4JmtT/r0WMkweFiXfL306GB37xSEkBXDq5c6wJQXUSL5yiMTT
         eG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Mhk1xHF8TPyFg5BgnEBHQvCZ++ocwd9fJshziJfZ/M0=;
        b=DUfTJ0Zkv9fsATxi3hBfZciq5xEThkCrL4pYNxhQpHGlmFCuv4ej13zdUunZy3xCdD
         yvwoPCrqAhzbaQ5eaDSaqwnDcwYGMUD32C8yPehoYC1iHiSmotGP1R3iCUw+pL5NO2YZ
         GUwt3dz2c+/NAR918RatBwsP0IQEynLWBeCfsaf3G1e7Yuxz3ZaeYiAULKYO02Ya/9fy
         y1zeh8HzQtQydduRF8PD1XgnVB7JgSIwbs/LBt8kwWDBDGya60BSWaWnAFHiEE+nvRXv
         Jeci43A/vGHjfhAKcJYR5KdrPD9cWHn/xAoFfM1M94V3jP7v92avSK/ADM4KYTU/x90Q
         f9AQ==
X-Gm-Message-State: AD7BkJK81fOntYhSLbh229wONGFs0a2CGy+3vwX0HXxZrukW9prcLCNZudauys3U5kBH/7Lo/FOZm0MU+MA6Vc56
X-Received: by 10.107.161.68 with SMTP id k65mr5632629ioe.110.1459279590878;
 Tue, 29 Mar 2016 12:26:30 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 29 Mar 2016 12:26:30 -0700 (PDT)
In-Reply-To: <CAGZ79ka5_C0HcWGyYThT7O2ts-B1dTkBWEt1MUsbEN-AciE15g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290170>

On Tue, Mar 29, 2016 at 12:21 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Mar 29, 2016 at 12:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> The test which is fixed by this patch would report
>>>>     Entering 'nested1/nested2/../nested3'
>>>> instead of the expected
>>>>     Entering '../nested1/nested2/nested3'
>>>>
>>>> because the prefix is put unconditionally in front and after that a
>>>> computed display path with is affected by `wt_prefix`. This is wrong as
>>>> any relative path computation would need to be at the front. By emptying
>>>> the `wt_prefix` in recursive submodules and adding the information of any
>>>> relative path into the `prefix` this is fixed.
>>>>
>>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>>> ---
>>>
>>> Nicely explained and executed.
>>
>> Interestingly, this breakage, as 1/7 shows, only affects the
>> "Entering $there" message--I somehow expected from reading the
>> description above that the command given to "foreach" is run
>> in a wrong submodule directory, but there is no such bug that
>> is fixed by this change, as far as "foreach" is concerned.
>
> foreach is a special beast as it is the only submodule command that
> ignores the current directory, i.e.
>     cd repo/plugins && git submodule foreach ...
> also affects submodules in repo/other-submodules.

I missspoke.

It actually respects the sub directory, but no further path spec. :(
