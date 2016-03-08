From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 02/15] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Tue, 8 Mar 2016 11:11:50 +0530
Message-ID: <CAOLa=ZSFD39HXSw8jo1=ehiKpeqjLUSfc0NkRJD0BSbqAvDwuQ@mail.gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
 <1457265902-7949-3-git-send-email-Karthik.188@gmail.com> <xmqq7fhdoqd3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 06:42:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adAPb-0005k0-Bu
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 06:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbcCHFmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 00:42:22 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35156 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbcCHFmV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 00:42:21 -0500
Received: by mail-vk0-f67.google.com with SMTP id e185so448848vkb.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 21:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x/Z9HoEa46h6ffyPU4Qon0dM/R7P6AQJl3O/2/wxNeI=;
        b=i0i/ym9Zd83iUeAubEGQyIqcPblwm5UXf4mwRCJ4/fLkcUJJb0fg1YGMbZ9UY0cyZI
         EDbNA3HgwrX8fVwARZLdy2qNEoGcA7lombJRKNE87OGsu9vTlmr0rxlvslv6VCcGub0s
         tJrd+3JA1djFTwjFNjB8FZITzgCiw7d/mOCPN1vc1lCY5pWUZruBTr6krrdFypS50Uyj
         HmnIhHFiedxfSiiA5Ar4VETZ5RSQ6llhx0C/+ic4GBgGEDxngBMzcega7p0YCcO7XP5r
         eGwrGcHEuqkWeKUdUFvJOU3q6XOwscHxogDpAQ800laE2QV9yDT97w6HmwON3Dg0TP0v
         4AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x/Z9HoEa46h6ffyPU4Qon0dM/R7P6AQJl3O/2/wxNeI=;
        b=AO6N/IieXfIfwQE6uBRZMe5ppqoqKAohpJH+i6jIFdhoHJphj7U9+PaSPDtPR3EIKF
         EGrdvmAnL5EuBS1i4Xq2nXg1Kjckmn4G4h7nb8WcAsMC/Qk+feND3gm2pz6PqgAI1Nwk
         w248rgqN0BqG4TKn9jdcIO48yfh0zLVzbvygkM/X5NZdUxQlb2ytG1ytE22vw5v8VTVh
         fSVVvm/5QPCe7kHB+Grqgzat81uy0Umugj0vIx3v8LloBp3w62b1KtpJFD8TVukWy4j5
         xa5hx29+47c9OnrE7Op4QGrB3DE1bzgQkdb64RaROX4sym/TfaBk5DNsJm7XGzj0mefK
         751g==
X-Gm-Message-State: AD7BkJLgTqRT2wpOZlBM6/YHpwfa8U7FfRH5LYIlQmFnNNpxys/e5U41xXLt3vGcyIwxvA0N/iKsm49I9XXrxw==
X-Received: by 10.31.6.130 with SMTP id 124mr19826075vkg.106.1457415740310;
 Mon, 07 Mar 2016 21:42:20 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Mon, 7 Mar 2016 21:41:50 -0800 (PST)
In-Reply-To: <xmqq7fhdoqd3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288417>

On Tue, Mar 8, 2016 at 4:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 41e73f0..440e270 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -22,6 +22,8 @@ struct align {
>>  };
>>
>>  struct if_then_else {
>> +     const char *if_equals,
>> +             *not_equals;
>>       unsigned int then_atom_seen : 1,
>>               else_atom_seen : 1,
>>               condition_satisfied : 1;
>> @@ -411,6 +413,14 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
>>  {
>>       struct ref_formatting_stack *new;
>>       struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
>> +     const char *valp;
>> +
>> +     if (skip_prefix(atomv->s, "equals=", &valp))
>> +             if_then_else->if_equals = valp;
>> +     else if (skip_prefix(atomv->s, "notequals=", &valp))
>> +             if_then_else->not_equals = valp;
>> +     else if (atomv->s[0])
>> +             die(_("format: unknown format if:%s"), atomv->s);
>>
>>       push_stack_element(&state->stack);
>>       new = state->stack;
>
> The fact that you are pushing stack element here tells me that this
> "handler" is run once for each 'ref' that we prepare output for
> (i.e. unlike the helper functions called "parser" that are called
> only once while preparing used_atom[] array).
>
> It somehow feels that this goes against the overall design you did
> in the earlier topic to pre-parse as much as possible when you
> prepare the used_atom array and avoid parsing at the runtime.  Am I
> misreading the patch?

You're correct, the "handler" functions run once for each "ref". But WRT
to the %(if)...%(then)...%(else)...%(end) atoms, it needs to be. Because
each outcome of these atoms depend on the current outcome of the fields
used between then WRT to the current ref.

Although we could somehow go about parsing the "equals=" / " notequals="
part of the %(if) atom beforehand to ensure that we do not end up repeating
that each time for every atom.

This could be done by parsing the %(if) atom before hand, probably with a
if_atom_parser, storing the "equals=" / " notequals=" value into used_atom[i]
and providing this used_atom[i] to the if_atom_handler. This would require
extending the prototype of the 'handler' functions to also pass used_atom[i].
Which seems like a good thing, considering that this may enable future 'handler'
functions to follow the same route and parse whatever can be parsed beforehand.

-- 
Regards,
Karthik Nayak
