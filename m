From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 4 May 2016 13:06:37 +0530
Message-ID: <CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 04 09:36:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axrMR-0005MB-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 09:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbcEDHgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 03:36:40 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34316 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbcEDHgj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 03:36:39 -0400
Received: by mail-yw0-f181.google.com with SMTP id j74so63047473ywg.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 00:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Sl4F5vD8mFCm72NG6G35YKv0EAv2Is3gpumSdF0Jp/Q=;
        b=Q4+TNvQbTi0PcRIX5gFNmVr/eOcRKMbx1zrmvow0nAdvUz1u3rewKo/9M5tfVBJfHX
         tSkRPCuQqOz1VdVC0oM7PikIXy8Wo8ELaObK3o6zrhz+K7hpqf2Ro4LwuuSzDnLqJOHD
         YYEbhjeX4ZKzVSmHi0mwKDcw2dUgR83Xpb2vRXrVtzXlitSXFAS9CVmL3cLcEk50HWyg
         JcAXgNWTuIv45lP6e4YFZrqevGtgXXfy/O6HXMIk5EIHVn/aJ/6xDsLqR3JXp/LUav9n
         EN6eHwr7gELh3j1nsiubXoVZ1dFbAgOp74+SmhGx5rfkLNTaJBa1+u8/zCOJCs7h6s0U
         PyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Sl4F5vD8mFCm72NG6G35YKv0EAv2Is3gpumSdF0Jp/Q=;
        b=RUHakgio2Y9XbKaEepidEf3andQlIqh77iWSKIoB35hFNfO9D4PyMQji7I9z59lPiz
         srJH+3vXXnr/2CPyu2ScCuPSitdQ/ldvxDhD/M3RGN8EDkFq1MGLOiNAQVdTvR1LUWDi
         eV0N9QN8hzrAruReSpaTqvngrluBUitoUlLDKsmh7wnW5jg0SlT6Tw5VKhNt8n070mFP
         jT2vmK/iSyGU9azy0m/PlIHmBpqnXysNCto5zrdxnLPVc64k3T2LDk8TAXsKwcsWxMvs
         pAfROkmy2NNGlHFborwpbQwhdbLns3gG+3l0d3eGdl5W0/U7IpJoFaXNyfyPSa7wUCnK
         ZZLw==
X-Gm-Message-State: AOPr4FWax6iSPDgFt7uxRq34cDTAsEjmVx8qHvIsG03fXXJcHZOq6A4Rgw5QShJWA4n8XnWXRRtdKkxjig0gsg==
X-Received: by 10.13.235.143 with SMTP id u137mr4415186ywe.20.1462347397925;
 Wed, 04 May 2016 00:36:37 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Wed, 4 May 2016 00:36:37 -0700 (PDT)
In-Reply-To: <CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293506>

On Wed, May 4, 2016 at 12:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> This reimplements the `check_term_format` shell function in C and adds
>
> s/This reimplements/Reimplement/
> s/adds/add/
>
>> a `--check-term-format` subcommand to `git bisect--helper` to call it
>> from git-bisect.sh
>
> s/$/./

Sure.

> Okay, I'll bite: Why is this a good idea? What does it buy you?
>
> It's not as if the rewrite is especially faster or more easily
> expressed in C; quite the contrary, the shell code is more concise and
> probably about equally as fast (not that execution speed matters in
> this case).
>
> I could understand this functionality being ported to C in the form of
> a static function as a minor part of porting "git bisect terms" in its
> entirety to C, but I'm not imaginative enough to see why this
> functionality is useful as a standalone git-bisect--helper subcommand,
> and the commit message doesn't enlighten. Consequently, it seems like
> unnecessary complexity.

It is important to understand that the subcommand is just a
**temporary** measure.
Yes, I agree that making it a subcommand increases unnecessary
complexity. As a part of complete rewrite of git-bisect.sh, I am
converting one function individually to C. The functionality of
subcommand is useful so that I can use the existing test suite to
verify whether I have done the conversion properly. As more functions
get ported (which I intend to finish this summers), previously
existing subcommands will be removed. For eg. After this patch, I will
now convert the function write_terms(). So in that patch, I will
remove the subcommand for check-term-format and instead use the
check_term_format() method and then introduce a new subcommand for
write_terms(). Verifying the function conversion was suggested by
Stefan Beller[1] and Christian Couder[2] gave a hint of how to go
about with using the existing test suite. As for the current
situation, git-bisect.sh calls `--next-all` in a similar way which was
the hint for me of how to go about with this project.

>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -2,16 +2,66 @@
>>  static const char * const git_bisect_helper_usage[] = {
>>         N_("git bisect--helper --next-all [--no-checkout]"),
>> +       N_("git bisect--helper --check-term-format <term> <orig_term>"),
>
> Could this be shortened to --check-term or would that be undesirable?

I guess --check-term-format would be more appropriate and as this is
temporary, it wouldn't matter afterwards.

>>         NULL
>>  };
>>
>>  enum sub_commands {
>> -       NEXT_ALL = 1
>> +       NEXT_ALL = 1,
>> +       CHECK_TERM_FMT
>>  };
>>
>> +/*
>> + * To check whether the string `term` belongs to the set of strings
>> + * included in the variable arguments so as to make the code look
>> + * clean and avoid having long lines in the `if` statement.
>> + */
>
> Is this a (long) sentence fragment? Code cleanliness is an obviously
> desirable trait, thus talking about it in the comment adds no value;
> it's just noise.

I will keep the initial part of the comment.

>> +static int one_of(const char *term, ...)
>> +{
>> +       va_list matches;
>> +       const char *match;
>> +
>> +       va_start(matches, term);
>> +       while ((match = va_arg(matches, const char *)) != NULL)
>> +               if (!strcmp(term, match))
>> +                       return 1;
>
> Is it wise to return here without invoking va_end()?

I guess since it already checks for NULL, invoking va_end() will make
it redundant[3].

>> +       va_end(matches);
>> +
>> +       return 0;
>> +}
>> +
>> +static int check_term_format(const char *term, const char *orig_term,
>> +                            int flag)
>
> What is 'flag' for? The single caller only ever passes 0, so why is this needed?

Well, currently the subcommand does not use this flag but this flag is
present in the method check_refname_format() so it would be better to
use it. This flag might be useful in further parts of conversion since
as I previously mentioned check-term-format isn't a permanent
solution.

>> +{
>> +       struct strbuf new_term = STRBUF_INIT;
>
> 'new_term' is being leaked at every 'return' statement in this function.

I will have to free this memory.

>
>> +       strbuf_addf(&new_term, "refs/bisect/%s", term);
>> +
>> +       if (check_refname_format(new_term.buf, flag))
>> +               die(_("'%s' is not a valid term\n"), term);
>
> Why does this die() while the other "invalid" cases merely return
> error()? What makes this special?

This is because I felt that if check_refname_format() fails then its a
fatal error while in other cases, it is not as fatal.

> Also, drop "\n" from the error string.

Sure!

>> +       else if (one_of(term, "help", "start", "skip", "next", "reset",
>
> s/else //

Agree since it would be a part of the switch which is not included
with the check_refname_format().

>> +                       "visualize", "replay", "log", "run", NULL))
>> +               return error("can't use the builtin command '%s' as a term\n", term);
>
> This should be wrapped in _(...). Also, drop the "\n".
>
>> +       /*
>> +        * In theory, nothing prevents swapping
>> +        * completely good and bad, but this situation
>> +        * could be confusing and hasn't been tested
>> +        * enough. Forbid it for now.
>> +        */
>
> This would be a bit easier to read if re-wrapped to fit within 80
> columns rather than 53 or so.
>
>> +       else if ((one_of(term, "bad", "new", NULL) && strcmp(orig_term, "bad")) ||
>
> s/else //

In the shell script a switch was used, thus `else if` would be a more
appropriate choice over `if`. Also if the first if statement fails
then it is unnecessary to go further.

>
>> +                (one_of(term, "good", "old", NULL) && strcmp(orig_term, "good")))
>
> This can be more efficient by doing the strcmp() before the expensive one_of():
>
>     if ((strcmp(...) && one_of(...)) ||
>         strcmp(...) && one_of(...)))

Nice. Will include this.

>> +               return error("can't change the meaning of the term '%s'\n", term);
>
> This should be wrapped in _(...). Also, drop the "\n".

Sure

>
>> +       return 0;
>> +}
>> +
>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>  {
>>         int sub_command = 0;
>> @@ -19,6 +69,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>         struct option options[] = {
>>                 OPT_CMDMODE(0, "next-all", &sub_command,
>>                          N_("perform 'git bisect next'"), NEXT_ALL),
>> +               OPT_CMDMODE(0, "check-term-format", &sub_command,
>> +                        N_("check format of the ref"), CHECK_TERM_FMT),
>
> What "ref"?

The ref here means that ref (like HEAD).


>>                 OPT_BOOL(0, "no-checkout", &no_checkout,
>>                          N_("update BISECT_HEAD instead of checking out the current commit")),
>>                 OPT_END()
>> @@ -33,6 +85,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>         switch (sub_command) {
>>         case NEXT_ALL:
>>                 return bisect_next_all(prefix, no_checkout);
>> +       case CHECK_TERM_FMT:
>> +               if (argc != 2)
>> +                       die(_("--check-term-format should be followed by exactly 2 arguments."));
>
> Drop the period. Possible reword:
>
>     --check-term-format requires two arguments

Seems better

>> +               return check_term_format(argv[0], argv[1], 0);
>>         default:
>>                 die(_("bug: unknown subcommand '%d'"), sub_command);
>>         }

[1]: http://article.gmane.org/gmane.comp.version-control.git/293489

[2]: http://article.gmane.org/gmane.comp.version-control.git/293489

[3]: http://article.gmane.org/gmane.comp.version-control.git/293489
