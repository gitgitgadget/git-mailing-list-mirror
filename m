From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 06/10] strbuf: introduce strbuf_split_str_without_term()
Date: Thu, 3 Dec 2015 23:42:40 +0530
Message-ID: <CAOLa=ZQz-NE3uKtU72NUyR23QaJE4jf=UqiMptnM+hOmAE9GRw@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-7-git-send-email-Karthik.188@gmail.com> <CAPig+cSxWybzunt_KWT+prZ=wXMi1wqM44jQZbp1pcz+spJW6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 19:13:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4YNY-00014k-G2
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 19:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbbLCSNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 13:13:11 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34707 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbbLCSNK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 13:13:10 -0500
Received: by vkbs1 with SMTP id s1so50626153vkb.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 10:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Qycxk3OU9zEGL9KH0FDzQw0fairFSIGc+6ugz4/iep4=;
        b=OxqAAeVpuZuOj6ZB2KiZVR37SYbgGHE7Rd1xLMD/Iof5HYevKM4t+6RgWduZcl79SX
         BgsT95obVWDenvJ4Svsp+UogQIO8K6C5bVsNY/LuK9Ykg50lFSvy4SN9OZw8sDQqBX+8
         CDyXIJaelcPQ5If5NPOiLe38X4Riyiicr6+vUgpWcatIduNcXHtGPHS18ujfmQ6vcllU
         egepj1T0KMVWiUnO6h7622jSU0AeOP3xnBxGSqAtw/MUmgz+c9UpBLE7dXCQAQBLEBr9
         CXKsBtYlpGcLiEdduRTyNYlp81KQXBP6UK/ujpM4A5/HP36maiazsT+kph227eKUSbQk
         4QMw==
X-Received: by 10.31.155.23 with SMTP id d23mr5930786vke.146.1449166389484;
 Thu, 03 Dec 2015 10:13:09 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Thu, 3 Dec 2015 10:12:40 -0800 (PST)
In-Reply-To: <CAPig+cSxWybzunt_KWT+prZ=wXMi1wqM44jQZbp1pcz+spJW6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281959>

On Wed, Dec 2, 2015 at 1:34 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> The current implementation of 'strbuf_split_buf()' includes the
>> terminator at the end of each strbuf post splitting. Include an option
>
> s/Include an/Add an/
>
>> wherein we can drop the terminator if required. In this context
>
> s/required/desired/
>

will change.

>> introduce a wrapper function 'strbuf_split_str_without_term()' which
>> splits a given string into strbufs without including the terminator.
>>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -892,14 +892,11 @@ static void populate_value(struct ref_array_item *ref)
>>                          * TODO: Implement a function similar to strbuf_split_str()
>>                          * which would omit the separator from the end of each value.
>>                          */
>> -                       s = to_free = strbuf_split_str(valp, ',', 0);
>> +                       s = to_free = strbuf_split_str_without_term(valp, ',', 0);
>>
>>                         align->position = ALIGN_LEFT;
>>
>>                         while (*s) {
>> -                               /*  Strip trailing comma */
>> -                               if (s[1])
>> -                                       strbuf_setlen(s[0], s[0]->len - 1);
>
> I'd prefer to see this ref-filter.c change split out as a separate
> patch so as not to pollute the otherwise single-purpose change
> introduced by this patch (i.e. capability to omit the terminator).
>
> Also, it might make sense to move this patch to the head of the
> series, since it's conceptually distinct from the rest of the patches,
> and could conceivably prove useful on its own, regardless of how the
> rest of the series fares.
>

I guess it makes sense to split this into two separate patches. I'll do that and
push it to the top of the series.

>>                                 if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
>>                                         ;
>>                                 else if (!strcmp(s[0]->buf, "left"))
>> diff --git a/strbuf.c b/strbuf.c
>> @@ -115,7 +115,7 @@ void strbuf_tolower(struct strbuf *sb)
>>  }
>>
>>  struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>> -                                int terminator, int max)
>> +                                int terminator, int max, int with_term)
>
> "with_term" might undesirably be interpreted as meaning "use this
> particular term". Perhaps a different name, such as "include_term",
> "drop_term", or "omit_term" would be a bit less ambiguous. (I think I
> prefer "omit_term".)
>

True. I too prefer "omit_term" from what you mentioned I'll stick to that.

>>  {
>>         struct strbuf **ret = NULL;
>>         size_t nr = 0, alloc = 0;
>> @@ -123,18 +123,27 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>>
>>         while (slen) {
>>                 int len = slen;
>> +               int term = with_term;
>
> "term" is not a great variable name, and is easily confused with the
> existing "terminator" input argument. This is really being used as a
> length adjustment, so perhaps a name such as 'term_adjust' or
> 'len_adjust' or something better would be preferable.

'len_adjust' seems better, will change.

>
> Also, since the value of 'with_term' never changes, then 'term' will
> have the same value each time through the loop, thus you could
> (should) hoist the declaration and initialization of 'term' outside of
> the loop.
>

True, will move it out of the loop.

> Due to the way you're using this variable ('term'), you want its value
> always to be 0 or 1 but you don't do anything to ensure that. What if
> the user passes in 42 rather than 0 or 1? That would mess up your
> (below) calculations. Worse, what if the user passes in -42? That
> would be particularly alarming. To turn this into a boolean value (0
> or 1), do this instead:
>
>     int term = !!with_term;

Makes sense, will change.

>
>>                 if (max <= 0 || nr + 1 < max) {
>>                         const char *end = memchr(str, terminator, slen);
>>                         if (end)
>> -                               len = end - str + 1;
>> +                               len = end - str + term;
>> +                       else
>> +                               /*  When no terminator present, we must add the last character */
>> +                               term = 1;
>>                 }
>>                 t = xmalloc(sizeof(struct strbuf));
>>                 strbuf_init(t, len);
>>                 strbuf_add(t, str, len);
>>                 ALLOC_GROW(ret, nr + 2, alloc);
>>                 ret[nr++] = t;
>> -               str += len;
>> -               slen -= len;
>> +               if (!term) {
>> +                       str += len + 1;
>> +                       slen -= len + 1;
>> +               } else {
>> +                       str += len;
>> +                       slen -= len;
>> +               }
>
> This new logic is complex and confusing, thus difficult to review for
> correctness. Rather than messing with 'len' and the existing logic,
> how about instead, just adjusting the amount you store in the strbuf?
> That is, instead of all the above changes, you might be able to get by
> with one little change, something like this (untested):
>
>     - strbuf_add(t, str, len);
>     + strbuf_add(t, str, len - !!end * !!with_term);
>

That seems about right, this should be easier to understand.

>>         }
>>         ALLOC_GROW(ret, nr + 1, alloc); /* In case string was empty */
>>         ret[nr] = NULL;
>> diff --git a/strbuf.h b/strbuf.h
>> @@ -465,19 +465,25 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
>>   * For lighter-weight alternatives, see string_list_split() and
>>   * string_list_split_in_place().
>>   */
>> -extern struct strbuf **strbuf_split_buf(const char *, size_t,
>> -                                       int terminator, int max);
>> +extern struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>> +                                       int terminator, int max, int with_term);
>
> You also need to update the comment block above this declaration since
> it still says that each substring includes the terminator. It also
> fails to mention the new 'with_term' argument added by this patch.
>

Will do :)

>> +static inline struct strbuf **strbuf_split_str_without_term(const char *str,
>> +                                                           int terminator, int max)
>
> This is an uncomfortably long function name. Unfortunately, short and
> sweet strbuf_split() is already taken. Perhaps
> strbuf_split_str_drop_term()? strbuf_split_str_omit_term()?
> strbuf_split_str_no_term()? strbuf_split_noterm()?
>

strbuf_split_str_omit_term() would be nice keeping it consistent with the
variable name omit_term.

-- 
Regards,
Karthik Nayak
