From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 4 May 2016 10:54:20 +0200
Message-ID: <CAP8UFD38MJNrx8fAbAXU7H0XxJmvF9SwS1mxYyESCJfQ-hK09g@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
	<CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
	<CAPig+cQn4iRCqquUE-g4879mTS7UJkHr7ANvH9HB2+087qCV7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:54:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axsZh-0004ti-KJ
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656AbcEDIyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:54:24 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37655 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757582AbcEDIyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:54:21 -0400
Received: by mail-wm0-f54.google.com with SMTP id a17so81105573wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=RJc8cSx0kzqQqanLkyRTcbb4VwTlXdTr6GMY/SLsxcU=;
        b=gnzy8I+CBNgQhHY+T1GELZU1slaVlWeDb2tiNZ8KsoKldphpwm7bYNjZJjBMYh05B5
         TlMR24srkkbWHmeVBnydV21M52KE3vcOTYEY9HRZKu/+40Ft3y9B0j19od33OrJ9+VCL
         NYg6IUTd2oGDcZfXsGFBhUyRTtyDkoKo6EDUysViTx99dzKAAylTxl06lgqMkyWPrAcL
         lQREnlSyMxECZKh/LAkww4435bhJoRd2eiMHFbeQWrWQgbxqmQNBUbYAyPJ4Z16lm1pd
         L5GpcT6o8SwlhahiDnq3u2Vu5TBhHjci2qi5OVMXsObYc0sBIk8GT/zkQC77kWVkiFHL
         LQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RJc8cSx0kzqQqanLkyRTcbb4VwTlXdTr6GMY/SLsxcU=;
        b=gnWJ2KJWIM6aqz01mduesUGwgeKJI7q9Ter/797doaFmtuujhoz4/nJ6/ILwem+Wb7
         UvtfcRakwB3tN/ZEC6rQ5FVk+Nbegwo3Ripzg+LdFALf1nKey9D8SRj4SNmPyS5d+tXG
         wWHdnLPdBXAnBDWg/c7SGJqcI/sc2eI5XY/6WX6CuHYWU4tC5yiVSYI0NRcSwka7TQYj
         XzUS3GkpwJWPc663oBt7T6lW6hMLaMMMlhpFXXbtm1dPNcGcuKKzscji65qpMJaovF1Z
         +S03bZF6c/LIDMbU18QgUgwswdE7g4c5BEgg5T9hlqg5w/3whPuI22Q50JGpq73gdC3+
         JnHw==
X-Gm-Message-State: AOPr4FUCPr7i+PtPolqvQk2VanaTM62hDMWTj87lLf7wpgLPlMuHt6nxWcJm3vJlAoLwNon6fmRJhL8uYUA6qw==
X-Received: by 10.28.158.79 with SMTP id h76mr28119548wme.79.1462352060165;
 Wed, 04 May 2016 01:54:20 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Wed, 4 May 2016 01:54:20 -0700 (PDT)
In-Reply-To: <CAPig+cQn4iRCqquUE-g4879mTS7UJkHr7ANvH9HB2+087qCV7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293525>

On Wed, May 4, 2016 at 10:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
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

Yeah, I agree it could be improved in this regard.

>> Yes, I agree that making it a subcommand increases unnecessary
>> complexity. As a part of complete rewrite of git-bisect.sh, I am
>> converting one function individually to C. The functionality of
>> subcommand is useful so that I can use the existing test suite to
>> verify whether I have done the conversion properly. As more functions
>> get ported (which I intend to finish this summers), previously
>> existing subcommands will be removed. For eg. After this patch, I will
>> now convert the function write_terms(). So in that patch, I will
>> remove the subcommand for check-term-format and instead use the
>> check_term_format() method and then introduce a new subcommand for
>> write_terms(). Verifying the function conversion was suggested by
>> Stefan Beller[1] and Christian Couder[2] gave a hint of how to go
>> about with using the existing test suite. As for the current
>> situation, git-bisect.sh calls `--next-all` in a similar way which was
>> the hint for me of how to go about with this project.
>
> You're taking an inverted bottom-up approach which repeatedly adds and
> removes unnecessary complexity rather than a more straight-forward
> top-down approach. For instance, with a top-down approach, as a first
> step, you could instead add a skeleton, do-nothing "git-bisect--helper
> set-terms" and flesh it out in subsequent patches until fully
> implemented,

I am not sure this is the best approach. If for some reason the GSoC
project is not finished, we will end up with a badly named
"git-bisect--helper --set-terms" command and a badly named
write_term() shell functions. They will be badly named because they
will not do all what the name suggests.

> at which point drop all the "terms" code from
> git-bisect.sh and have it invoke the helper instead. You get the same
> benefit of being able to use the existing test suite without the
> unnecessary complexity.
>
> In fact, git-bisect.sh could start invoking "git-bisect--helper"
> before it's fully fleshed out. For instance, a partially fleshed out C
> write_terms(), might just verify that the two terms are not the same
> and then write them out to BISECT_TERMS, and the shell script would
> invoke its own check_term_format() before calling the helper.
>
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

Yeah, I agree with that and the rest of your comments. Thanks.
