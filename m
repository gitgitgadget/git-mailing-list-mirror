From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 11:43:10 +0530
Message-ID: <CAFZEwPOx-ixKn63Mt9tuF3XWhgY2aztVRESrDJOQK8Q5jGG2CQ@mail.gmail.com>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
	<CAGZ79kZveu07h_vERFpJekp4ayJwytwoNVG0LbhiaCnt4u-jRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 07:13:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiFZG-000112-UM
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 07:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbcCVGNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 02:13:16 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35646 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbcCVGNM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 02:13:12 -0400
Received: by mail-yw0-f179.google.com with SMTP id g127so242128679ywf.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=XV3Oxx1i0MZaUMY80kYJHZTaIiV+QpkEqhr99VwuGdQ=;
        b=QYgnow8d8LDqLRt8xyr3hsrBa4g33Gh0HOmcuOcXsgC+mn0g3LzAUqSxJdfOpjcjwR
         eWKtL0B0TIvl9f+eZSCOIjpF/zhGFtGTBLyF52PKOEKJI72NEgcoyEI5+fzcoBzUxg2c
         20PduoHVFebzVdTZOiuFmh/rsI5KEAt5t9CQILuGEg972d6A7ABO5S7F/hFGnq+wcIiP
         Fwna6pGfDHEBsSWccnHzS2IeYnHz6Jfz0cNByX9mAV9yXYDovjW5M5LhCri04q3sWTzs
         Mk9LhBtdhwOhhh+9GGX7sZqbtpWFrztA9cNaWOszsqRLcRpFzT3NLHiCAgwF75xCTlNU
         gjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=XV3Oxx1i0MZaUMY80kYJHZTaIiV+QpkEqhr99VwuGdQ=;
        b=CX9YSUmQtp4IKXrYsOeR9mNBdCwpYBjdU4ZbbsalB1x5IEyZJBeWIAleWgDw419ibT
         iHbW8TNpxFCjZYhXGyj9Vw7U4JTo1tUyJV31vaJX+yoJoV87Er8pDBd8LoggCGaWPmd7
         Rq19b173741wiO1uiwbe4CsKaD0PQlYEav8FJrpkxCfnhhZx1ihs0G3RzQqucxHdYHau
         yNsk8PQDoEWRjDaUQuwbfPlBEpRYtEUVD2ERbFmLoLPz3VFN4iSfU6fMEIWxGP9nm7KN
         CzRpY0aDGek+CUjidcHpAkC52v5p/11pYTnJe7lSx+Ssglo6Q7GE/rbxoh/3bjpNhT5K
         04cg==
X-Gm-Message-State: AD7BkJJN82wD//CCotSLP/v/yhNUwzlncXmPluNtC1/bXt/p9JJlPPHJPzOFEqT+or1+HvjExK4miYN9PqhvMg==
X-Received: by 10.129.9.214 with SMTP id 205mr15208844ywj.53.1458627190640;
 Mon, 21 Mar 2016 23:13:10 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Mon, 21 Mar 2016 23:13:10 -0700 (PDT)
In-Reply-To: <CAGZ79kZveu07h_vERFpJekp4ayJwytwoNVG0LbhiaCnt4u-jRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289488>

On Tue, Mar 22, 2016 at 5:58 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Mar 21, 2016 at 12:00 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Convert the code literally without changing its design even though it
>> seems that its obscure as to the use of comparing revision to different bisect
>> arguments which seems like a problem in shell because of the way
>> function arguments are handled.
>
> How would I use the C version instead of the shell version now?
> I'd imagine you'd want to change calls in git-bisect.sh from
>     check_term_format <term> <bad/new>
> to be:
>     git bisect--helper check_term_format <term> <bad/new>
> and "git bisect--helper" would then call the new static method?
> Once you have the C version working (do we need additional tests
> or can we rely on the test suite being enough for now?),
> you can also delete the shell version.

I have to yet think about this. Currently, I just called this function
from cmd_bisect__helper().

> Thanks,
> Stefan
>
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>>  builtin/bisect--helper.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 3324229..61abe68 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -2,12 +2,35 @@
>>  #include "cache.h"
>>  #include "parse-options.h"
>>  #include "bisect.h"
>> +#include "refs.h"
>>
>>  static const char * const git_bisect_helper_usage[] = {
>>         N_("git bisect--helper --next-all [--no-checkout]"),
>>         NULL
>>  };
>>
>> +static int check_term_format(const char *term, const char *revision, int flag) {
>> +       if (check_refname_format(term, flag))
>> +               die("'%s' is not a valid term", term);
>> +
>> +       if (!strcmp(term, "help") || !strcmp(term, "start") ||
>> +               !strcmp(term, "skip") || !strcmp(term, "next") ||
>> +               !strcmp(term, "reset") || !strcmp(term, "visualize") ||
>> +               !strcmp(term, "replay") || !strcmp(term, "log") ||
>> +               !strcmp(term, "run"))
>> +               die("can't use the builtin command '%s' as a term", term);
>
> "terms" is missing?
>
> eval_gettext would translate into C as
>     die (_("translatable message"));
>
>
>> +
>> +       if (!strcmp(term, "bad") || !strcmp(term, "new"))
>> +               if(strcmp(revision, "bad"))
>> +                       die("can't change the meaning of term '%s'", term);
>> +
>> +       if (!strcmp(term, "good") || !strcmp(term, "old"))
>> +               if (strcmp(revision, "good"))
>> +                       die("can't change the meaning of term '%s'", term);
>> +
>> +       return 1;
>
> Why 1? Usually we use 0 for success in C. die(...) returns with non zero,
> so having 0 here would help us in the shell code to see if the C version
> died (or not).

Sorry I forgot to change the value. I had initially kept it to 0 but
then to do some tweaks, I changed it to 1. I had to do manual tweaks
as I am still scared to use gdb for big projects. I am trying to get
more comfortable with it. Also reading the patch again, I seem to have
forgotten the function declaration statement also.

[1] : http://thread.gmane.org/gmane.comp.version-control.git/289299/focus=289364
