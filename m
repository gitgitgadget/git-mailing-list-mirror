From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 4 May 2016 04:28:42 -0400
Message-ID: <CAPig+cQn4iRCqquUE-g4879mTS7UJkHr7ANvH9HB2+087qCV7A@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
	<CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:28:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axsAt-0002Xk-8i
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757602AbcEDI2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:28:46 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33049 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757579AbcEDI2o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:28:44 -0400
Received: by mail-ig0-f193.google.com with SMTP id rc4so5203083igc.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Lc6z18HczjeyBdQ1Q4oulGtapxbjDxbdcirMOEsNNRw=;
        b=mJE8JtzCQSnJqmK66sxd4esKnM9BMZ6y5OWco+agogluuudvnVF4gCk7Vjee2IBPBB
         jHnwUPndxN4ShUruLq9Lfw4sqcozWmB0bKycooPceiwajXO8jbg9n0t1LIQuqy8ARmIW
         l8n8UTHWfEbg0LtaWwkpF7ViFE4IjvgHPekYUWacX3qJdNv+9sGqJJC+sPTz5FrbAdwL
         1V/LOJDloi2KJqdayDz6L8ku8nR84FQ0nBo0md+F5hhH88MC6Ggo7Z1sd1q/6DHbJEXg
         13UbYcXNyqVKWF/N5fiRjlYT970vrc7c5TnNx3fGAm3/gXAkJEX9iPKgue5EIczBgKhK
         /mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Lc6z18HczjeyBdQ1Q4oulGtapxbjDxbdcirMOEsNNRw=;
        b=P+7m/3nSXkzSgmBx4yckPt5rU5rFoiA5k1iuXYFX4LxiN2QitOhVIJw0JgaJJQsOs4
         nmmBQOSeblS+ZFRduQxUo18sB/q0qVl+HkAe7paMPYNXnGRdHvwqSu07nMISpeqUmAiu
         rb7dfFueYeY2ArWVJ3an5CaTs0W/aTlgw4Hj1NHdGCkjD2daWc4fT15G6poHXRKePDZa
         IHW9Hr38pik9swvhpUUY+NoeQEat+1dsuMk/e7CzB+Syexgx0cJ6Xn2HXAsTpG7barkk
         Rn8NSPMhlGc+dZFQqQCmKZRx2a9iZJtlwMj5q9wa8i4sbv4DWR9NOCup/8S95/DZm5tA
         zMQA==
X-Gm-Message-State: AOPr4FVDSP/jX7oChvKNzJPMRqxD2r1/FibNYPPwpAJydxYKleYw5VcR9/tJumtpSa3IYTOH8avltjzAFmfvNw==
X-Received: by 10.50.36.9 with SMTP id m9mr33931749igj.91.1462350522236; Wed,
 04 May 2016 01:28:42 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Wed, 4 May 2016 01:28:42 -0700 (PDT)
In-Reply-To: <CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
X-Google-Sender-Auth: Wv5srKY7QCMcLfPQoP22wxbnhlo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293517>

On Wed, May 4, 2016 at 3:36 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, May 4, 2016 at 12:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Okay, I'll bite: Why is this a good idea? What does it buy you?
>>
>> It's not as if the rewrite is especially faster or more easily
>> expressed in C; quite the contrary, the shell code is more concise and
>> probably about equally as fast (not that execution speed matters in
>> this case).
>>
>> I could understand this functionality being ported to C in the form of
>> a static function as a minor part of porting "git bisect terms" in its
>> entirety to C, but I'm not imaginative enough to see why this
>> functionality is useful as a standalone git-bisect--helper subcommand,
>> and the commit message doesn't enlighten. Consequently, it seems like
>> unnecessary complexity.
>
> It is important to understand that the subcommand is just a
> **temporary** measure.

The commit message seems to be lacking this information and any other rationale.

> Yes, I agree that making it a subcommand increases unnecessary
> complexity. As a part of complete rewrite of git-bisect.sh, I am
> converting one function individually to C. The functionality of
> subcommand is useful so that I can use the existing test suite to
> verify whether I have done the conversion properly. As more functions
> get ported (which I intend to finish this summers), previously
> existing subcommands will be removed. For eg. After this patch, I will
> now convert the function write_terms(). So in that patch, I will
> remove the subcommand for check-term-format and instead use the
> check_term_format() method and then introduce a new subcommand for
> write_terms(). Verifying the function conversion was suggested by
> Stefan Beller[1] and Christian Couder[2] gave a hint of how to go
> about with using the existing test suite. As for the current
> situation, git-bisect.sh calls `--next-all` in a similar way which was
> the hint for me of how to go about with this project.

You're taking an inverted bottom-up approach which repeatedly adds and
removes unnecessary complexity rather than a more straight-forward
top-down approach. For instance, with a top-down approach, as a first
step, you could instead add a skeleton, do-nothing "git-bisect--helper
set-terms" and flesh it out in subsequent patches until fully
implemented, at which point drop all the "terms" code from
git-bisect.sh and have it invoke the helper instead. You get the same
benefit of being able to use the existing test suite without the
unnecessary complexity.

In fact, git-bisect.sh could start invoking "git-bisect--helper"
before it's fully fleshed out. For instance, a partially fleshed out C
write_terms(), might just verify that the two terms are not the same
and then write them out to BISECT_TERMS, and the shell script would
invoke its own check_term_format() before calling the helper.

>>> +static int one_of(const char *term, ...)
>>> +{
>>> +       va_list matches;
>>> +       const char *match;
>>> +
>>> +       va_start(matches, term);
>>> +       while ((match = va_arg(matches, const char *)) != NULL)
>>> +               if (!strcmp(term, match))
>>> +                       return 1;
>>
>> Is it wise to return here without invoking va_end()?
>
> I guess since it already checks for NULL, invoking va_end() will make
> it redundant[3].

Sorry, your response does not compute. Each va_start() *must* be
balanced with a va_end(). (While it's true that you may encounters
platforms/compilers for which a missing va_end() does no harm, such
code is not portable.)

>>> +       va_end(matches);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int check_term_format(const char *term, const char *orig_term,
>>> +                            int flag)
>>
>> What is 'flag' for? The single caller only ever passes 0, so why is this needed?
>
> Well, currently the subcommand does not use this flag but this flag is
> present in the method check_refname_format() so it would be better to
> use it. This flag might be useful in further parts of conversion since
> as I previously mentioned check-term-format isn't a permanent
> solution.

Sorry, again this does not compute. Certainly, you must pass *some*
flags argument to check_refname_format() as 'flags' is part of its
signature, but that doesn't explain why check_term_format() accepts a
'flag' argument. Moreover, check_term_format() is not a general
purpose function like check_refname_format(), so this sort of
*apparent* flexibility adds complexity with no obvious benefit.

>>> +       strbuf_addf(&new_term, "refs/bisect/%s", term);
>>> +
>>> +       if (check_refname_format(new_term.buf, flag))
>>> +               die(_("'%s' is not a valid term\n"), term);
>>
>> Why does this die() while the other "invalid" cases merely return
>> error()? What makes this special?
>
> This is because I felt that if check_refname_format() fails then its a
> fatal error while in other cases, it is not as fatal.

The name of the command is "check-term-format" and that is precisely
its purpose so, from the perspective of the caller, *all* problems
with the term are fatal. It's black-and-white, there is no grey:
either a term is acceptable, or it isn't; that's all the caller wants
to know. Consequently, all problems detected by this function should
be reported the same way (preferably via 'return error()').

>>> +       else if (one_of(term, "help", "start", "skip", "next", "reset",
>>
>> s/else //
>
> Agree since it would be a part of the switch which is not included
> with the check_refname_format().
>
>>> +       else if ((one_of(term, "bad", "new", NULL) && strcmp(orig_term, "bad")) ||
>>
>> s/else //
>
> In the shell script a switch was used, thus `else if` would be a more
> appropriate choice over `if`. Also if the first if statement fails
> then it is unnecessary to go further.

Whether this was a 'switch' statement in the shell script is
immaterial. The body of each of these 'if' statements exits the
function, so no following code will be executed anyhow when the
condition is true. This makes the 'else' pure noise which is why
's/else //' is suggested and good style. The less the reader's brain
has to process, the easier the code is to comprehend.

>>> +               OPT_CMDMODE(0, "check-term-format", &sub_command,
>>> +                        N_("check format of the ref"), CHECK_TERM_FMT),
>>
>> What "ref"?
>
> The ref here means that ref (like HEAD).

Sorry, does not compute. To what HEAD or other ref are you referring?
This command is about checking the name of a bisection term. Where
does 'ref' come into it (other than as an implementation detail)?
