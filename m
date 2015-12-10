From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v5] blame: add support for --[no-]progress option
Date: Wed, 9 Dec 2015 22:20:09 -0600
Message-ID: <CAOc6etYM5NA8sPw49yioa9u3SwvDB-w4mcWzrLaR3FkFdNGoJA@mail.gmail.com>
References: <1448426165-5139-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTQdnrHZWJDD6fqu_mQSJQv3oTz9_0Cu8j1aksUiq0FbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 05:20:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6siH-0000ak-Lv
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 05:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbbLJEUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 23:20:12 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33394 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbbLJEUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 23:20:10 -0500
Received: by pfnn128 with SMTP id n128so41090248pfn.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 20:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=chXbmG3UsS0xyg4NfImzF7TCvIzQA1+Dcp8GEVo1Nx4=;
        b=Rsl0s8ludzU4K/PsVvfnGNE3Qd/Oh559YXf3wsOkUWJAh+pFMv+PBxoUGQZHFPQY4B
         sJONpWYit+MJG8ZGjZ8WoupwJaWFePSY20ksY1sdVA4G+d1Bc/cXcIwvxCVzQOIODFej
         YulqB+lfGKgpjhQ5SIsbNSXt0skOtqWxk/72DzI2OrFPPzNRbpRaz0hgjhxooXTEX8Xa
         1+oo4h/SDKEIzNAFs6/Hwxy7Wk0Ny/8HVpaRgPRQnLwCXTIJaVhvSwYU4gQAxXLd5j9r
         V9fWvr2ZHyCzoCc+dfqyKRReM1Dzg7sfHVNn9JkLDpDLGdn9vqVDOIRShq4mXMD7N94C
         YBpg==
X-Received: by 10.98.1.6 with SMTP id 6mr3701126pfb.132.1449721209687; Wed, 09
 Dec 2015 20:20:09 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Wed, 9 Dec 2015 20:20:09 -0800 (PST)
In-Reply-To: <CAPig+cTQdnrHZWJDD6fqu_mQSJQv3oTz9_0Cu8j1aksUiq0FbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282211>

Hey, Eric!

On Tue, Dec 8, 2015 at 2:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Nov 24, 2015 at 11:36 PM, Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
>> * created struct progress_info in builtin/blame.c
>>   this struct holds the information used to display progress so
>>   that only one additional parameter is passed to
>>   found_guilty_entry().
>
> Commit messages typically are composed of proper sentences and
> paragraphs rather than bullets points. Also, write in imperative mood:
> "Create progress_info..."
>
> In this case, though, the information in this bullet point isn't all
> that interesting for the commit message since it's a detail of
> implementation easily gleaned by reading the patch itself. There's
> nothing particularly tricky about it, thus it doesn't really deserve
> to be called out as special in the commit message.
>
> What might be more interesting and deserve mention in the commit
> message is how this new option interacts with porcelain and
> incremental modes and why the choice was made.
>
> More below...

Ok

>
>> * --[no-]progress option is also inherited by git-annotate.
>>
>> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
>> ---
>> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
>> @@ -69,6 +69,13 @@ include::line-range-format.txt[]
>>         iso format is used. For supported values, see the discussion
>>         of the --date option at linkgit:git-log[1].
>>
>> +--[no-]progress::
>> +       Progress status is reported on the standard error stream
>> +       by default when it is attached to a terminal. This flag
>> +       enables progress reporting even if not attached to a
>> +       terminal. Progress information won't be displayed if using
>> +       `--porcelain` or `--incremental`.
>
> Is silently ignoring --progress a good idea when combined with
> --porcelain or --incremental, or would it be better to error out with
> a "mutually exclusive options" diagnostic? (Genuine question.)
>

I think it makes sense (and so it's documented so people can know what
could be going on but detecting mutually exclusive options and
erroring out could also make sense. Who could give some insight?

>> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
>> @@ -10,7 +10,8 @@ SYNOPSIS
>>  [verse]
>>  'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
>>             [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
>> -           [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
>> +           [--[no-]progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>]
>
> Hmm, is [--[no-]progress] common in Git documentation? (Genuine
> question.) For the synopsis, I'd have expected to see only
> [--progress] and leave it to the more detailed description of the
> option to mention the possibility of negation (but I haven't
> double-checked other documentation, so my expectation may be skewed).
>

Hmmm.... hadn't noticed that. Will remove it from this part.

>>  DESCRIPTION
>>  -----------
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> @@ -127,6 +129,11 @@ struct origin {
>> +struct progress_info {
>> +       struct progress *progress;
>> +       int blamed_lines;
>> +};
>> @@ -1746,7 +1753,8 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
>> -static void found_guilty_entry(struct blame_entry *ent)
>> +static void found_guilty_entry(struct blame_entry *ent,
>> +                          struct progress_info *pi)
>> @@ -1758,6 +1766,8 @@ static void found_guilty_entry(struct blame_entry *ent)
>> +       if (pi)
>> +               display_progress(pi->progress, pi->blamed_lines += ent->num_lines);
>
> This is updating of 'blamed_lines' is rather subtle and easily
> overlooked. Splitting it out as a separate statement could improve
> readability:
>
>     pi->blamed_lines += ent->num_lines;
>     display_progress(pi->progress, pi->blamed_lines);
>

Ok.

>>  }
>> @@ -1768,6 +1778,16 @@ static void assign_blame(struct scoreboard *sb, int opt)
>>  {
>>         struct rev_info *revs = sb->revs;
>>         struct commit *commit = prio_queue_get(&sb->commits);
>> +       struct progress_info *pi = NULL;
>> +
>> +       if (show_progress) {
>> +               pi = malloc(sizeof(*pi));
>> +               if (pi) {
>
> xmalloc(), unlike malloc(), will die() upon allocation failure which
> would allow you to avoid the "if (pi)" conditional.
>

Ok.

>> +                       pi->progress = start_progress_delay(_("Blaming lines"),
>> +                                                           sb->num_lines, 50, 1);
>> +                       pi->blamed_lines = 0;
>> +               }
>> +       }
>>
>>         while (commit) {
>>                 struct blame_entry *ent;
>> @@ -1809,7 +1829,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
>>                         suspect->guilty = 1;
>>                         for (;;) {
>>                                 struct blame_entry *next = ent->next;
>> -                               found_guilty_entry(ent);
>> +                               found_guilty_entry(ent, pi);
>>                                 if (next) {
>>                                         ent = next;
>>                                         continue;
>> @@ -1825,6 +1845,11 @@ static void assign_blame(struct scoreboard *sb, int opt)
>>                 if (DEBUG) /* sanity */
>>                         sanity_check_refcnt(sb);
>>         }
>> +
>> +       if (pi) {
>> +               stop_progress(&pi->progress);
>> +               free(pi);
>> +       };
>
> Style: drop semi-colon following closing brace
>

Ok.

> Overall, use of malloc/free for the progress_info struct seems to
> makes the code more complex rather than less. It's not clear why you
> don't just use a 'struct progress_info' directly, which would lift the
> burden of freeing the allocated structure, and allow you to drop the
> conditional around stop_progress() since NULL progress is accepted. In
> other words, something like this (completely untested):
>
>     struct progress_info pi = { NULL, 0 };

I like it! I'll adjust to not use the pointer.

>     if (show_progress) {
>         pi.progress = start_progress_delay(...);
>     ...
>     found_guilty_entry(ent, &pi);
>     ...
>     stop_progress(&pi.progress)
>
> which is more concise and less likely to leak resources. The code
> within found_guilty_entry() is also simplified since you can drop the
> "if (pi)" conditional entirely. This works because it's safe to call
> display progress with NULL):
>
>     pi->blamed_lines += ent->num_lines;
>     display_progress(pi->progress, pi->blamed_lines);
>
>>  }
>>
>>  static const char *format_time(unsigned long time, const char *tz_str,
>> @@ -2579,6 +2606,11 @@ parse_done:
>>         DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
>>         argc = parse_options_end(&ctx);
>>
>> +       if (incremental || (output_option & OUTPUT_PORCELAIN))
>> +               show_progress = 0;
>> +       else if (show_progress < 0)
>> +               show_progress = isatty(2);
>> +


Officially, I think not a single line of the patch survived. :-D

Thanks, man... I'll go through the stuff and let's wait for feedback
about the detection/error-out in case of using "mutually exclusive"
options.

Cheers!
