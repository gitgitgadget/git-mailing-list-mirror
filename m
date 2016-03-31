From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/4] Fix relative path issues in recursive submodules.
Date: Thu, 31 Mar 2016 10:20:21 -0700
Message-ID: <CAGZ79kYyVJcOsWvkK=Qm0rE0hd-xTq=TPi8groynJ4Vokft74g@mail.gmail.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
	<xmqq7fgipojj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Norio Nomura <norio.nomura@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:20:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algGh-00075F-D6
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbcCaRUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:20:23 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33841 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbcCaRUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:20:23 -0400
Received: by mail-io0-f176.google.com with SMTP id e3so122327573ioa.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=q1FwdgkvJKBVQc/9nsW013yMfHaKiCLO9n60iEOx17A=;
        b=gwqTcUybkEm8oBd5WI/7/0MQ3h7d4kx728NvJen7j6MbO6nmRiLbjEmWDqxsvXJ9Qo
         D66zil/TakeRqCi44FKGPMaA9C6/wK351Jzng5sRSraXop07zyYPma6bLJdrsJGb4eX3
         0TFY758kgAslhO2/EEWygpiBYJAzCV2r7KBRhhJ6HRq8rWgjB9uXMqlBfNUA9JoC853Y
         Un8RP7599ci68x+ZmvYlzlymztQsPrIErskyZy6xyYF9Zs0NF6Ugz5mldf+pEtA+r4jU
         ulnUfyoEe751OcaexXlWaG+P1KM2fDRxMmcj9yR/ivNKzyVSqt0BRAOthJnMlGhRSRGw
         d14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=q1FwdgkvJKBVQc/9nsW013yMfHaKiCLO9n60iEOx17A=;
        b=gnIGgYQhK8OiXaq4kesdndksQI69r5Ve1oahEMFXNunxWg3RCLEQwOn6BDH12pB7Ek
         L4FvV8DaDe3AyteOoW3DmcM11Ukwnfspq5vJ7d+9qlSo34U5ugBkNz//huAyZdT5oxdU
         fJ1W3UJ02F3JWmnidP7ZVksPp+7LI+i0S4uFcmttnAKnyaRKs+Fote8nxgBpcYJ/dlwC
         JtflKjeG8zDBuNo4SAKShs4qkNrdq4gn5NULm/nSLvhdGYpsgrJXB6Oc/vNEqSFnoNWd
         bqgdq3h77Kjfs6958A+BM7zBdwLtRzzQV65VgTnmU2nPfvoYmJfYynAhwkzLlnqgptqe
         STDw==
X-Gm-Message-State: AD7BkJIlQ6UESfgfIvcsnQX8RG67RN+cb4jk795i+6QBvjHVfc7oDm01dtw86POCqEnm9gyJyK+w2R57GMbjon4V
X-Received: by 10.107.184.8 with SMTP id i8mr81036iof.96.1459444821866; Thu,
 31 Mar 2016 10:20:21 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 31 Mar 2016 10:20:21 -0700 (PDT)
In-Reply-To: <xmqq7fgipojj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290424>

On Thu, Mar 31, 2016 at 10:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> It took me longer than expected to fix this bug.
>>
>> It comes with a test and minor refactoring and applies on top of
>> origin/sb/submodule-helper, such that it can be merged into 2.7, 2.8 as well
>> as master.
>>
>> Patch 1 is a test which fails; it has a similar layout as the
>> real failing repository Norio Nomura pointed out, but simplified to the
>> bare essentials for reproduction of the bug.
>>
>> Patch 2&3 are not strictly necessary for fixing the isseu, but it removes
>> stupid code I wrote, so the resulting code looks a little better.
>>
>> Patch 4 fixes the issue by giving more information to relative_path,
>> such that a relative path can be found in all cases.
>
> There were some minor nits, but I saw nothing glaringly wrong to
> break the topic.  Thanks for working on this.

Thanks for review and discussion, I plan on resending this series.

Currently I have the opinion to drop 2&3 (the path assumption and
double safe_create_leading_dir) and send patch 1 and 4 combined as
a bugfix only as that is more the spirit what we want to see for
an eventual merge to maint?

The refactoring patches 2&3 can be sent later as separate patches
for master, I would think.
