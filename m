From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 5/5] refs.c: enable large transactions
Date: Thu, 22 Jan 2015 11:24:57 -0800
Message-ID: <CAGZ79kbrnu7ZH7T6WR5j0_nhS+Ann0LcEmXfQYMRqdSzK0xW9Q@mail.gmail.com>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>
	<1421893929-7447-6-git-send-email-sbeller@google.com>
	<54C0DDE7.8030708@alum.mit.edu>
	<20150122131018.GE19681@peff.net>
	<54C12644.1000406@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Loic Dachary <loic@dachary.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 22 20:25:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YENNH-0002Gy-Ho
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 20:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbbAVTY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 14:24:59 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:61913 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbbAVTY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 14:24:58 -0500
Received: by mail-ie0-f173.google.com with SMTP id tr6so3251606ieb.4
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 11:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rAZ6CE16V/M2YyDqC+bco0a1UJk6ZMNIIMLPLhz94z8=;
        b=JvSQnESJBQQLbzVnb6LuCngIgs0yc3oihjA2sduqS95gkjsHQnGTfJS0jUsnydwUF5
         8RFqkv+SU/CBDUwlP0HGjR8+TYOhg09tFiq/l9zC/Za+0Hy25UcOBMuzysfFgv+SkuvI
         sEgDEPwZPY92ur3vpgshwf+glwzpUx205bdnOYDkYsnZV9p6wxIQNJPkZEW0JPtgtoVd
         ZI9K1f4xE++xhFDrih/4sw034tDRLwmMFRTk73/+8X/U6F7qSDBB6jM5RRzKW9e/FrEn
         tF15xV1fWgyY0ho9JfEmOaVTlrvM1rT3Kx2ggsF3x9VvISeduuWRZJyZV95Xu8bL1NcH
         tWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rAZ6CE16V/M2YyDqC+bco0a1UJk6ZMNIIMLPLhz94z8=;
        b=I4z429xbYJXY7C92lZ6h1VFTN2CW9Koa4vHP0FxVb05vrcc9fU7TaJvuEbHLlZRv4Y
         fucb3nBJeBO35arNYZiYn6dlAApmMdgREUQ+dIh4iYUjzejxBFZIupL6g49ELS3EuI5z
         ZaNQ4c1y/D1fKA5EMSs5prDee7gUkDM3mHLx5YlbeUw4VwO7ykPQBMqPYKpT0aQJ8gTd
         ezBEzq6J6ljuyGAB/jbZ1AmTNdFFIfOSP+VY/M470sV0x8fGDzpMk0tsbSS0eGv/nkCz
         M+11gGLYzoYY1+1ucQNcVpog5NYR61zRx4H2ldenYAzsDy6nlYbiXwbePZUBnRgYsgLQ
         uxjA==
X-Gm-Message-State: ALoCoQkuHy8T0z+CpYITRZJz6ms0/EqR2OIW/1L4sw4dlvY3nBI2nX0lJtSukqkxwwk3mboA/z4e
X-Received: by 10.50.85.44 with SMTP id e12mr6320399igz.48.1421954697744; Thu,
 22 Jan 2015 11:24:57 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 22 Jan 2015 11:24:57 -0800 (PST)
In-Reply-To: <54C12644.1000406@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262858>

On Thu, Jan 22, 2015 at 8:33 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 01/22/2015 02:10 PM, Jeff King wrote:
>> On Thu, Jan 22, 2015 at 12:24:23PM +0100, Michael Haggerty wrote:
>>
>>> I can't figure out where to apply this series or where to fetch it from,
>>> so I can't see these changes in context, so maybe I'm misunderstanding
>>> something. It looks like this code is doing
>>>
>>>     open(), close(), open(), fdopen(), write(), fclose(), rename()
>>>
>>> on each lockfile. But don't we have enough information to write the
>>> SHA-1 into the lockfile the first time we touch it? I.e., couldn't we
>>> reduce this to
>>>
>>>     open(), fdopen(), write(), fclose(), rename()
>>>
>>> , where the first four calls all happen in the initial loop? If a
>>> problem is discovered when writing a later reference, we would roll back
>>> the transaction anyway.
>>>
>>> I understand that this would require a bigger rewrite, so maybe it is
>>> not worth it.
>>
>> I had a nagging feeling on the multiple-open thing, too, and would much
>> prefer to just write out the contents early (since we know what they
>> are). It looks like we would just need to split write_ref_sha1() into
>> its two halves:
>>
>>   1. Write out the lockfile
>>
>>   2. Commit the change
>>
>> And then call them at the appropriate spots from ref_transaction_commit().
>>
>> I guess that is maybe a step backwards for abstracted ref backends,
>> though.
>
> Nah, the implementation of ref_transaction_commit() will have to differ
> between backends anyway. I don't think this would be a step backwards.
>
> Michael
>

I also dislike the double open/close thing, but I just wanted to come up with
a quick and unobtrusive fix which doesn't rewrite the whole refs backend as
we have some code churn in the refs lately.

Michael, I forgot your short term intentions on the refs backend, so I tried to
be shy with that bug fix. What huge changes are you planning in the next few
weeks w.r.t. the refs handling? I would look more into that if there are no code
conflicts likely to arise.

Thanks,
Stefan
