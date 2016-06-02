From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] pathspec: allow escaped query values
Date: Thu, 2 Jun 2016 15:10:32 -0700
Message-ID: <CAGZ79kaxqK=kL3=NdaHk+qo94fyiDE0LZOrKVVHtDJisKmABfQ@mail.gmail.com>
References: <20160602213015.21712-1-sbeller@google.com> <xmqqr3cfs1dp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 00:10:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8ap5-0008Ia-Ht
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 00:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843AbcFBWKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 18:10:34 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34144 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253AbcFBWKd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 18:10:33 -0400
Received: by mail-qk0-f180.google.com with SMTP id s186so13706906qkc.1
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U9gOwTEj6Fx1yb9RegQUymcZHKEAaoBCSrO42U3n2T4=;
        b=J3dGn8Fi7vleBfCnN3jyo5/Q93OXJqpv6u+DZp2FlCuMqG0hYpK9ulGOR0QqPb/cCb
         6w3Dj6WrECqxzcfUuC2CcEYITCzOyEH89j0YUFr5R9EvsJteztsCV1XttN/hqW8cySgN
         caihXbvVQaNNizppcBHLCgzQe92cKhKKjAC0crYBB9FKrkT+4LtdoHeiWmcCeHI11XZD
         2Cb+ObyVB1k4EHv3GBvHc8RayE5bhbRmrwxlVEWTS+SgvVDUlh0cDpzU2+ghqG6TjeuW
         kDwz3Db5UJUF9GRbQ4wQQ7+Dq5jDGlQNU1g+agmjuR5JbO5pIT6k7JV38TgKbcWwfsYC
         hxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U9gOwTEj6Fx1yb9RegQUymcZHKEAaoBCSrO42U3n2T4=;
        b=DmswexM9dkBjxufQ6jSxoVg6y+raw11wQmnTS2E2/reSDia5MNG+jXBy1AN6xwyE5G
         MIHpHtdo/2oGAMoQPiLKLPZ5XbRGZFUhIyuZ0DefHXA7+XP19nzNQKaMwRZ5z9l6Co6Q
         TGqa/FidjGYbACEf07AxzdlepM6dEfX5UBS4WKkVvuC5rQEUUbzgDyPAenlV8ImDfHkM
         X4KrqSnEPsvfZBtgFIqHcYeXs9K3j/LzIHu8eMJ9hJrb1l0pdAgWAkiDWucM0z0K/JDe
         3BjaPRqioxY1pV4SbSlPYqGJVm4SDW3w6CLwBHBD4zAkyXZys/e8+wQeGlWvJIsnjujR
         EuDQ==
X-Gm-Message-State: ALyK8tLX5psQ8efYRrGc/eni1uSigpHvK8wQZm4uYCxnGl8oG9VqKF7nTCmbrbuohW+GEGozv8aFsUQZLWstggY4
X-Received: by 10.233.237.14 with SMTP id c14mr433671qkg.88.1464905432538;
 Thu, 02 Jun 2016 15:10:32 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Thu, 2 Jun 2016 15:10:32 -0700 (PDT)
In-Reply-To: <xmqqr3cfs1dp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296248>

On Thu, Jun 2, 2016 at 2:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In our own .gitattributes file we have attributes such as:
>>
>>     *.[ch] whitespace=indent,trail,space
>>
>> When querying for attributes we want to be able to ask for the exact
>> value, i.e.
>>
>>     git ls-files :(attr:whitespace=indent,trail,space)
>>
>> should work, but the commas are used in the attr magic to introduce
>> the next attr, ...
>> ...
>> So here is the "escaping only, but escaping done right" version.
>> (It goes on top of sb/pathspec-label)
>
> The phrase "should work" is probably a bit too strong (I'd have said
> "it would be nice if this worked"), as we do not have to even
> support comma for our immediately expected use cases.  Allowing it
> merely makes a casual test using our own .gitattributes easier.
>
>> +static size_t strcspn_escaped(const char *s, const char *reject)
>
> Perhaps s/reject/stop/?

I took the signature from the strcspn man page, and my version of the
man page has `reject` there, `stop` certainly works too

>
>> +{
>> +     const char *i, *j;
>> +
>> +     for (i = s; *i; i++) {
>> +             /* skip escaped the character */
>> +             if (i[0] == '\\' && i[1]) {
>> +                     i++;
>> +                     continue;
>> +             }
>> +             /* see if any of the chars matches the current character */
>> +             for (j = reject; *j; j++)
>> +                     if (!*i || *i == *j)
>> +                             return i - s;
>
> I somehow doubt that *i can be NUL here.  In any case, this looks
> more like
>
>         /* is *i is one of the stop codon? */
>         if (strchr(stop, *i))
>                 break;

right, that seems easier.


>
>> +     }
>> +     return i - s;
>> +}
>
>> +static char *attr_value_unescape(const char *value)
>> +{
>> +     char *i, *ret = xstrdup(value);
>> +
>> +     for (i = ret; *i; i++) {
>> +             if (i[0] == '\\') {
>> +                     if (!i[1])
>> +                             die(_("Escape character '\\' not allowed as "
>> +                                   "last character in attr value"));
>> +
>> +                     /* remove the backslash */
>> +                     memmove(i, i + 1, strlen(i));
>> +                     /* and ignore the character after that */
>> +                     i++;
>> +             }
>> +     }
>> +     return ret;
>> +}
>> +
>
> Repeated memmove() and strlen() somehow bothers me.  Would there be
> a more efficient and straight-forward way to do this, perhaps along
> the lines of this instead?
>
>         const char *src;
>         char *dst, *ret;
>
>         ret = xmalloc(strlen(value));
>         for (src = value, dst = ret; *src; src++, dst++) {
>                 if (*src == '\\') {
>                         if (!src[1])
>                                 die();
>                         src++;
>                 }
>                 if (*src && invalid_value_char(*src))
>                         die("cannot use '%c' for value matching", *src)
>                 *dst = *src;
>         }
>         *dst = '\0'
>         return ret;
>
> Even though I earlier said "Now we have an unquote mechanism, we can
> open the floodgate by lifting the "no backslash in value" check, I
> now realize that we do want to keep some escape hatch for us to
> extend the quoting syntax even more later, so perhaps with something
> like this:
>
>         static inline int invalid_value_char(const char ch)
>         {
>                 if (isalnum(ch) || strchr(",-_", ch))
>                         return 0;
>                 return -1;
>         }

Makes sense.

Later on we could have : or ; for an and/or of the values and
parens and such, so the invalid_value_char makes sense.

>
> Thanks.

Thanks,
Stefan
