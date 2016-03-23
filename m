From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v3] bisect--helper: convert a function in shell to C
Date: Wed, 23 Mar 2016 18:46:37 +0530
Message-ID: <CAFZEwPPDhK1biRLuXtYeBX5fsQGw==fUOLxSOXVaZPghbJQYGg@mail.gmail.com>
References: <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
	<01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<alpine.DEB.2.20.1603231238180.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 23 14:17:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiies-0008RN-65
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 14:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846AbcCWNQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 09:16:40 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35319 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600AbcCWNQi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 09:16:38 -0400
Received: by mail-yw0-f195.google.com with SMTP id w6so1574352ywd.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=u0DGOXpulAgSAhmKvBg+nVqZCxRTAMV37GKGDWXZzac=;
        b=yeQzV3Kusuf3BJi0hW3E+8QEAEu5dc7fImki44KT8lj8wkjVZd5axsKUu4lwW0gV6C
         Naqjf1Sam8CtZLRhqrhNmxjnmjb339A14G4Aa2eAFeGU3qAVtS3FeZldGMG7CZMCVV26
         H0/4GU/g6oIW+vpI9P2lfLYgMw/EJhMmg3IpUnPqPIDCiuMa5YeuvcPmVd7Oky5ue9cX
         WEcoVyuATvGnYcWN8x1PoW0ATb+V0sWVDdw4H4UVC63svMs9a2pkSj7WAEpKRWEiqTbY
         B3KW3pWnd94PKsckcXfgysWF/yGVh5GwDF8RkS4V5llbXozoq9dZapwbG68CsqGoqt+J
         oQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=u0DGOXpulAgSAhmKvBg+nVqZCxRTAMV37GKGDWXZzac=;
        b=FAv3vPlJDKGOA+4P8MKjhqo9/RAfCOFMBJCaHkXGNdmS8UdS140vz93XEjKSZ7GH6f
         N16/xZrTgcsNDTvjQCx6oqc7E7upfvfSI0kyrIP0xteC2wI+TcogA6aixel2FUUB1FtE
         mkmpDg4rwJizur5J+bpF/LMBNMMbfle0865BRRCXtbpseHeQNdc+CJsDewKdT+AO5rAT
         a8pZbv0d+xB0ebopPeVEoJjcbmqeWXx7zcluX219NeDtrZ1A58flTvsHqBLh06NsjyFu
         +FyqQPEWCebRMt/fITkTc1UFDAJjO2cZWhXEUMGG0olF6GceAI1LMg3PM5Jb7YLUXXBA
         2w/A==
X-Gm-Message-State: AD7BkJLigxF6PWFrCq6a9STCjm852c0GMDcvGWJHlnV1OYiuUrruPs7XpLY7qh0Msn+ib+VA9/XwMn+ZoHWtYQ==
X-Received: by 10.129.91.6 with SMTP id p6mr1273160ywb.325.1458738997606; Wed,
 23 Mar 2016 06:16:37 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Wed, 23 Mar 2016 06:16:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603231238180.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289654>

On Wed, Mar 23, 2016 at 5:27 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Pranit,
>
> On Wed, 23 Mar 2016, Pranit Bauva wrote:
>
>> Convert the code literally without changing its design even though it
>> seems that it is obscure as to the use of comparing revision to different
>> bisect arguments which seems like a problem in shell because of the way
>> function arguments are handled.
>
> I still believe that it would make for an improvement to replace
> "revision" by "orig_term".

I missed this. Will do it.

>> The argument handling is kind of hard coded right now because it is not
>> really be meant to be used like this and this is just for testing
>> purposes whether this new method is as functional as its counter part.
>> The shell counter part of the method has been retained for historical
>> purposes.
>
> Well, maybe the argument handling is really meant to be used like this in
> the end? Just skip that paragraph.

Sure.

>> Also using OPT_CMDMODE() to handle check-term-format and next-all
>> because these sub commands are independent and error should be shown if
>> used together and should be handled independently.
>
> As is often the case, after some discussion a single patch becomes more
> than just one change. This is what we see here, too: OPT_CMDMODE() is a
> change that needs preparation of the existing code in
> builtin/bisect--helper.c, and I would highly suggest to split that change
> out into its own patch. It makes for a nicer story, and it is *much*
> easier to review.
>
>> This commit reduces the number of failed tests in
>> t6030-bisect-porcelain.sh and t6041-bisect-submodule.sh
>
> Oh? Which tests are supposed to fail? I do not see any failing tests
> here...

What I meant by this is that before there were 55 out of 70 tests
which failed. After this patch, there are 3 tests out of 70 which
failed.

>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 3324229..ab3891c 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> [...]
>> +static int check_term_format(const char *term, const char *revision, int flag) {
>> +     if (check_refname_format(term, flag))
>> +             die("'%s' is not a valid term", term);
>> +
>> +     if (one_of(term, "help", "start", "skip", "next", "reset", "visualize",
>> +         "replay", "log", "run", NULL))
>
> If I understood Junio correctly, he meant to line up the second line with
> the corresponding level. In this case, as "replay" is a parameter of the
> one_of() function, the indentation would look like this instead:

I misunderstood his point.

>         if (one_of(term, "help", "start", "skip", "next", "reset", "visualize",
>                    "replay", "log", "run", NULL))
>
>> +             die("can't use the builtin command '%s' as a term", term);
>> +
>> +     /* In theory, nothing prevents swapping
>> +      * completely good and bad, but this situation
>> +      * could be confusing and hasn't been tested
>> +      * enough. Forbid it for now.
>> +      */
>
> I see quite a few comments that put the closing "*/" on its own line, but
> do not award the same pleasure to the opening "/*". Personally, I much
> prefer the opening "/*" to have an entire line to itself, too, but I guess
> that there is enough precendence in Git's source code to accept both
> forms.
>
>> +     if (!strcmp(term, "bad") || !strcmp(term, "new"))
>> +             if (strcmp(revision, "bad"))
>> +                     die("can't change the meaning of term '%s'", term);
>> +
>> +     if(!strcmp(term, "good") || !strcmp(term, "old"))
>> +             if (strcmp(revision, "good"))
>> +                     die("can't change the meaning of term '%s'", term);
>
> I am still convinced that
>
>         if ((one_of(term, "bad", "new", NULL) && strcmp(orig_term, "bad")) ||
>             (one_of(term, "good", "old", NULL) && strcmp(orig_term, "good")))
>                 die("can't change the meaning of term '%s'", term);
>
> looks so much nicer.

True. I missed this point.

>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>  {
>> -     int next_all = 0;
>> +     int sub_command = 0;
>>       int no_checkout = 0;
>> +
>> +     enum sub_commands {
>> +             NEXT_ALL,
>> +             CHECK_TERM_FMT
>> +     };
>
> Interesting. I did not think that Git's source code declares enums inside
> functions, but builtin/remote.c's config_read_branches() does, so this
> code is fine.

I didn't notice this before. Since git has the convention of declaring
enums outside function, it will be better to follow the trend rather
than allowing another trend to spread.

> Still, the patch would be easier to review (corollary: bugs would have a
> harder time to hide) if the change from OPT_BOOL to OPT_CMDMODE was done
> in a separate, preparatory patch.

I was confused about this. Now that u mention it, I will make the change.

>>       argc = parse_options(argc, argv, prefix, options,
>>                            git_bisect_helper_usage, 0);
>>
>> -     if (!next_all)
>> +     if (sub_command == CHECK_TERM_FMT) {
>> +             if (argc == 2) {
>> +                     if (argv[0] != NULL && argv[1] != NULL)
>> +                             return check_term_format(argv[0], argv[1], 0);
>> +                     else
>> +                             die("no revision or term provided with check_for_term");
>> +             }
>> +             else
>> +                     die("--check-term-format expects 2 arguments");
>> +     }
>> +
>> +     if (sub_command != NEXT_ALL && sub_command != CHECK_TERM_FMT)
>>               usage_with_options(git_bisect_helper_usage, options);
>
> Personally, I would prefer
>
> - the usage_with_options() code to come before any sub_command processing,
>
> - the sub_command enum to be initialized with -1, or alternatively
>   hardcoding NEXT_ALL to 1,

Oh! I now understand that initializing with 0 can be problematic.

> - to avoid else clauses after an if () clause whose block returns or
>   die()s,

Sure

> - to order the clauses of an if/else in ascending size, i.e.
>
>         if (argc != 2)
>                 die(...);
>         if ...
>
> - to avoid checking argv[i] for NULL when i < argc (it is the contract
>   that argv[0..argc-1] are all non-NULL, so checking for it is unnecessary
>   churn),

I wasn't aware of this.

> - use a switch() on sub_command instead of unrolled if () statements, and
I just browsed through some other parts and found that subcommands are
put in switch case

> - wrap the code at 80 columns/row (interpreting tabs as "up to 8 spaces").


> The rest of the patch looks good.
>
> Ciao,
> Johannes

Thanks!
