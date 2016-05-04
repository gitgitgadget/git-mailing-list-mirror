From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 4 May 2016 17:28:28 +0530
Message-ID: <CAFZEwPNdmJdt=4Hg7KpfGS51sDeKyAPWgApESf564kt_eaP3Rg@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
	<CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
	<CAPig+cQn4iRCqquUE-g4879mTS7UJkHr7ANvH9HB2+087qCV7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 04 13:58:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axvRr-0002lY-S8
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbcEDL6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:58:32 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36283 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbcEDL6a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:58:30 -0400
Received: by mail-yw0-f170.google.com with SMTP id o66so84029637ywc.3
        for <git@vger.kernel.org>; Wed, 04 May 2016 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=B8yocaYB0RTaGgtaRY0KGtSVblemfLsBjL6gdUbavRM=;
        b=iyTqwOSC7R7ZGQLisvAmXAYMoHYgXKxtYDADqwPQBae5zzEgeInafh9oiuNY0nW7Wn
         7Vu+9+Lbuq1L3P8pTAJty8Qh0JMyF0V4u06awsvAOO6rPkDwBsR3JQvo0TgO+JQl1HzZ
         nBqRcgbPzafh5Bo2OlAkNTnvz12rOlYzAZ1DFKRpeGEFedrf7IvCgcC9KKv1SbeswW3+
         jpIFNFZr50LB/Ni6lYMiIqTbV/SGN7bmVCyidEKkTd3JAQcKQJt1ihltY6tEvvWX2zBP
         ISc+whPQ7xlwx4QArx0Tvh7IPSSqaMZR3dHgvTv12iJ1/c2Ej9RSy+A4edw13yhKl2wJ
         eUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=B8yocaYB0RTaGgtaRY0KGtSVblemfLsBjL6gdUbavRM=;
        b=WiucXrGt1XRkI3gU1YpOZZPeJjm6rWlNAGE6utMd0AgnKCj6LHZfUzJ00qVNzrrWtu
         3W1aQmTUWvDhQeokmt9m7rs0yPmM0L2YtmFAy9q9uKNB1Y5ayvIpbHSep2AQV/w/xOq0
         0dWDaCys7nKRd/fZKLzJW1oI/k8DyxW+m7fUbM6SLXnsGS6FxJvlLRaDsJMFhwC5nokz
         MpmIRk9uk+1aQRZz2HuzFv+k+xFMEfWNYl+4nBW7Mt5vI1Gvih24I/IEa9TiojjTrpAo
         bHqHykeLJ5LgZC+G5C+B21oDoWT5E1AKSgR2fXkS5M4c7P04gstFeO/wZKdBtlTSk+tp
         BxFg==
X-Gm-Message-State: AOPr4FWW9aX4i+hUOiX4yBX5ytsjIKJMiU9YVsJebfM9NttVrSfztN7+eSqRvn4fAlhe65/k885Io6+mN01k9A==
X-Received: by 10.129.41.8 with SMTP id p8mr4500837ywp.154.1462363108936; Wed,
 04 May 2016 04:58:28 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Wed, 4 May 2016 04:58:28 -0700 (PDT)
In-Reply-To: <CAPig+cQn4iRCqquUE-g4879mTS7UJkHr7ANvH9HB2+087qCV7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293541>

On Wed, May 4, 2016 at 1:58 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, May 4, 2016 at 3:36 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Wed, May 4, 2016 at 12:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> Okay, I'll bite: Why is this a good idea? What does it buy you?
>>>
>>> It's not as if the rewrite is especially faster or more easily
>>> expressed in C; quite the contrary, the shell code is more concise and
>>> probably about equally as fast (not that execution speed matters in
>>> this case).
>>>
>>> I could understand this functionality being ported to C in the form of
>>> a static function as a minor part of porting "git bisect terms" in its
>>> entirety to C, but I'm not imaginative enough to see why this
>>> functionality is useful as a standalone git-bisect--helper subcommand,
>>> and the commit message doesn't enlighten. Consequently, it seems like
>>> unnecessary complexity.
>>
>> It is important to understand that the subcommand is just a
>> **temporary** measure.
>
> The commit message seems to be lacking this information and any other rationale.

I will modify the commit message in order to reflect this.

>>>> +static int one_of(const char *term, ...)
>>>> +{
>>>> +       va_list matches;
>>>> +       const char *match;
>>>> +
>>>> +       va_start(matches, term);
>>>> +       while ((match = va_arg(matches, const char *)) != NULL)
>>>> +               if (!strcmp(term, match))
>>>> +                       return 1;
>>>
>>> Is it wise to return here without invoking va_end()?
>>
>> I guess since it already checks for NULL, invoking va_end() will make
>> it redundant[3].
>
> Sorry, your response does not compute. Each va_start() *must* be
> balanced with a va_end(). (While it's true that you may encounters
> platforms/compilers for which a missing va_end() does no harm, such
> code is not portable.)

I am sorry for my misunderstanding. I had very little idea about
variable arguments. I have searched on this now. I will update by
according to Johannes which seems nice to me.

>>>> +       va_end(matches);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int check_term_format(const char *term, const char *orig_term,
>>>> +                            int flag)
>>>
>>> What is 'flag' for? The single caller only ever passes 0, so why is this needed?
>>
>> Well, currently the subcommand does not use this flag but this flag is
>> present in the method check_refname_format() so it would be better to
>> use it. This flag might be useful in further parts of conversion since
>> as I previously mentioned check-term-format isn't a permanent
>> solution.
>
> Sorry, again this does not compute. Certainly, you must pass *some*
> flags argument to check_refname_format() as 'flags' is part of its
> signature, but that doesn't explain why check_term_format() accepts a
> 'flag' argument. Moreover, check_term_format() is not a general
> purpose function like check_refname_format(), so this sort of
> *apparent* flexibility adds complexity with no obvious benefit.

I check the future functions and it does not require the flag argument
so I will remove it.

>>>> +       strbuf_addf(&new_term, "refs/bisect/%s", term);
>>>> +
>>>> +       if (check_refname_format(new_term.buf, flag))
>>>> +               die(_("'%s' is not a valid term\n"), term);
>>>
>>> Why does this die() while the other "invalid" cases merely return
>>> error()? What makes this special?
>>
>> This is because I felt that if check_refname_format() fails then its a
>> fatal error while in other cases, it is not as fatal.
>
> The name of the command is "check-term-format" and that is precisely
> its purpose so, from the perspective of the caller, *all* problems
> with the term are fatal. It's black-and-white, there is no grey:
> either a term is acceptable, or it isn't; that's all the caller wants
> to know. Consequently, all problems detected by this function should
> be reported the same way (preferably via 'return error()').

Sure. I will use 'return error()'. Any particular reason why this
instead of die() ?

>>>> +       else if (one_of(term, "help", "start", "skip", "next", "reset",
>>>
>>> s/else //
>>
>> Agree since it would be a part of the switch which is not included
>> with the check_refname_format().
>>
>>>> +       else if ((one_of(term, "bad", "new", NULL) && strcmp(orig_term, "bad")) ||
>>>
>>> s/else //
>>
>> In the shell script a switch was used, thus `else if` would be a more
>> appropriate choice over `if`. Also if the first if statement fails
>> then it is unnecessary to go further.
>
> Whether this was a 'switch' statement in the shell script is
> immaterial. The body of each of these 'if' statements exits the
> function, so no following code will be executed anyhow when the
> condition is true. This makes the 'else' pure noise which is why
> 's/else //' is suggested and good style. The less the reader's brain
> has to process, the easier the code is to comprehend.

Okay. I get it. Will drop off the else.

>>>> +               OPT_CMDMODE(0, "check-term-format", &sub_command,
>>>> +                        N_("check format of the ref"), CHECK_TERM_FMT),
>>>
>>> What "ref"?
>>
>> The ref here means that ref (like HEAD).
>
> Sorry, does not compute. To what HEAD or other ref are you referring?
> This command is about checking the name of a bisection term. Where
> does 'ref' come into it (other than as an implementation detail)?

I guess it would be more appropriate to use term.

Thanks,
Pranit Bauva
