From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] ref-filter.c: don't stomp on memory
Date: Sun, 7 Feb 2016 10:20:21 +0530
Message-ID: <CAOLa=ZQN1WJPQzyZE2jOQj43+_6oS-jzxshKqzdn9Rw0Bb1c_A@mail.gmail.com>
References: <56B68E73.2050303@ramsayjones.plus.com> <CAPig+cT=h49xNTb=nu7+xvbOXAFoC0gyOW8R5tb-oosapN2eiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 05:51:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSHJr-0006eU-9Q
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 05:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbcBGEuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 23:50:52 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34325 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbcBGEuv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 23:50:51 -0500
Received: by mail-vk0-f45.google.com with SMTP id e185so78291322vkb.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 20:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xRjccMQ3iI9/dJ+VQOWgYxzbNo06Z2TMnyOjd/ZNGRM=;
        b=aSXkDYuRXae63wsOCJNMxIqoy51dzKJgxsiukWpR8Vds30uESRfx79nbB3w6+7HUsm
         7FeGZ8/NDe87+6PUc8mqoM9bgRgFYdaxkB+orjS/xQLXJnE3RhBV8lxjYoNMI+Dw9Tin
         kJogVgoGpdcCAAcoMFydeuNdKoJLeXlZMFWf2nmJ2+hVkNmHpwmPny2y7GJUzK97lIH+
         TA8nk640RLlgwzdTX92wSz6cl4Z2mT9RATHfkPD+fAqCLT3h6mH2rXlZH9O9fAjvNr4Q
         zzjf/yntclrDc28a1cEAxVuSdHvccz9BcIphMq1PQTkXKyJgsqg4hacB/coX5llw7nzy
         8nXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=xRjccMQ3iI9/dJ+VQOWgYxzbNo06Z2TMnyOjd/ZNGRM=;
        b=J3xcOlEGm/wfJEp4kaPocwcJJNf35gHdlWSeTZU+zEFlrjd8JPjCdqy/OJFPm7eCVV
         x3jOXBcQ5VB5yL1S6TK6brCXYTEQdsKy8YoB+oILqW8Sd8QOa/t+bsXe6+PanUY/QuZi
         mNvftrgF8vLDd/BFUt9gHhABKimzeHE/ZBvPcoz+6wNcuSHgUgiMGwFyGo4cIfbgXoLO
         TtZzXAaM2PWgANJKjRcLbv2Do1rYQLXafbVVA5SeRcSJjN2tYczh/nontoe6RGPsXJEE
         AKpJvXY9Nx8ao8UZMumJzbD9pLs1SVMw28mHjf3n07OYvzgBpg+Dzmsl65AZLmQOl/tX
         eM7w==
X-Gm-Message-State: AG10YOQBNnnf4cEFNKSenHhbGQhQOOq6dZvVMauI/rAxFgByeHkCuWx27d/SSMYwyaY7Py22JABj94v2Nh411Q==
X-Received: by 10.31.54.75 with SMTP id d72mr14838639vka.30.1454820650352;
 Sat, 06 Feb 2016 20:50:50 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Sat, 6 Feb 2016 20:50:21 -0800 (PST)
In-Reply-To: <CAPig+cT=h49xNTb=nu7+xvbOXAFoC0gyOW8R5tb-oosapN2eiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285711>

On Sun, Feb 7, 2016 at 8:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Feb 6, 2016 at 7:23 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>> If you need to re-roll your 'kn/ref-filter-atom-parsing' branch, could
>> you please squash this (or something like it) into the relevant patch
>> (commit 6613d5f1, "ref-filter: introduce parsing functions for each valid
>> atom", 31-01-2016).
>>
>> This evening, (by mistake!) I built the pu branch with -fsanitize=address
>> in my CFLAGS. This resulted in many test failures, which were all caused
>> by the memcmp() call below stomping all over memory.
>>
>> Hmm, as I was writing this email, I had a vague recollection of another
>> email on the list recently mentioning this code. So, if this has already
>> been reported, sorry for the noise!
>

Thanks for reporting, I stumbled upon the same problem myself.

> You're probably thinking of [1]. Interestingly, the two proposed fixes
> differ... (more below)
>
> [1]: http://git.661346.n2.nabble.com/PATCH-v4-00-12-ref-filter-use-parsing-functions-td7646877i20.html#a7647418
>
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -260,7 +260,8 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>                  * table.
>>                  */
>>                 arg = memchr(sp, ':', ep - sp);
>> -               if ((!arg || len == arg - sp) &&
>> +               if ((( arg && len == arg - sp)  ||
>> +                    (!arg && len == ep - sp )) &&
>>                     !memcmp(valid_atom[i].name, sp, len))
>>                         break;
>>         }
>
> Your fix is pretty easy to to read and seems correct. Karthik's fix
> required several re-reads, and I *think* it may be correct, however,
> it's difficult to grok due to its logic inversion.
>

True, its not so easy to comprehend at first.

> Aside from the two proposed fixes, a fix patterned after the original
> code which patch 5/12 replaced would be even easier to understand.
> That is, something like this:
>
>     arg = memchr(...);
>     if (!arg)
>         arg = ep;
>     if (len == arg - sp && !memcmp(...))
>         ...

This seems good, will change, Thanks to both of you

-- 
Regards,
Karthik Nayak
