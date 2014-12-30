From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 5/9] receive-pack.c: move transaction handling in a
 central place
Date: Tue, 30 Dec 2014 10:45:32 -0800
Message-ID: <CAGZ79kYufUcj858HGjJPTDGJgmTRv-YVR30zOtAURpP00NWEeQ@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-6-git-send-email-sbeller@google.com>
	<CAPig+cSYD+gBdEZ9TzWdeTEufzH6eJTbt=ZVS5imMJGjWnUFPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 19:45:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y61nW-0006cb-7u
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 19:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbaL3Spe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 13:45:34 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:53752 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbaL3Spd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 13:45:33 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so14081851ier.13
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 10:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WCj88v7aIqPgIqP/z9oqxKrYCjiFeXmAz45Yi0izlQ0=;
        b=BEGfF4cQAsq4dS0B7Wrl7gRM6djK1xw/VwMShv8W9anG8WbPyYeznd2trIhxUCG/21
         d7AYqUc0qdqepeDhUfo29ZrxnlnH7LNyDjG3ze6rlM147i9wVKanLxyQick8aUanu4He
         BgIqeRe1uxPFRqF3ZZrx5MvHVGOsz0mY/Rb0G2T69VHdbZ1ybytg5eqML8NvWtEEXr2D
         EUIfVeDSYifB0KgJx7Ud3VAvLQ75j9nEpJ0htlcHmNyS9vY7RXhTrWlL2My0aOVrslTq
         kqCgHfiGQp7UHYc+vuVd36QXHlX60L2/uMD+wM7SeAgMoWytByK6lcdhTOLZEOW9g/iw
         yIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WCj88v7aIqPgIqP/z9oqxKrYCjiFeXmAz45Yi0izlQ0=;
        b=Tyzj61c7gLO6PeYwIIcV1gMc3WrABrrCC145XV9K4kMoueEVsVeR8q1YVVZhynsv/i
         LAeHDfnefoxSyafSlOcFp1ZNfOMH2Z/oYA/I97+CokfzRuvJVulSKBz2WTHdEFwUAGYJ
         tIqnCxZgrf7ZhwCQIkbd6O2aKj7mPNUCLKPyOXtb6JUOirVkJlK/vL3Tw6v9Ecovu6Pf
         0RmIGHhrP/7hrUaYo93K9pM7htRCbJL7rmyPmWV2Dcy2yLcwi7S45g30yM0OBVVpk3KY
         KijRuQylSIgPtlhJ4SnTWGbI0Bnr9LWOB2iefe6lDj4Z9vSGVkv4JmI6jg+qd5FIW/9K
         tQbg==
X-Gm-Message-State: ALoCoQmMHVEU/G04eG+JRf29MienK7JSZH5vDtdeM8hubNY1r1fHsMTBkbFFXWtG5v/y9NWQ3e4I
X-Received: by 10.43.82.72 with SMTP id ab8mr48748520icc.76.1419965132574;
 Tue, 30 Dec 2014 10:45:32 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 30 Dec 2014 10:45:32 -0800 (PST)
In-Reply-To: <CAPig+cSYD+gBdEZ9TzWdeTEufzH6eJTbt=ZVS5imMJGjWnUFPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261933>

On Tue, Dec 30, 2014 at 12:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
>> Subject: receive-pack.c: move transaction handling in a central place
>
> This is very generic, and doesn't really explain what this patch is
> about. (See below.)
>
>> No functional changes intended.
>
> Secondary information can be demoted to the end of the commit message.

I think this would help in case there is a subtle bug introduced with
such a commit.
If you bisect it 2 years later and then ask yourself if that subtle
behavior was
intentional (can easily happen if the commit message is
short/unclear). This would then
tell you it's definitely a bug introduced. I believe to have seen such
a comment
somewhere in the history, but I cannot find it again. I'll drop it
into the notes for now.

>
>> This moves all code related to transactions into the execute_commands_loop
>> function which was factored out of execute_commands. This includes
>> beginning and committing the transaction as well as dealing with the
>> errors which may occur during the begin and commit phase of a transaction.
>
> This explains what you're doing, but not why. The purpose of this
> change is that a subsequent patch will be adding another mode of
> operation ("atomic") to execute_commands() which differs from the
> existing mode ("non-atomic") implemented by its main loop. In its
> high-level role, execute_commands() does not need to know or care
> about the low-level details of each mode of operation. Therefore, as
> preparation for introducing a new mode, you're factoring out the
> existing mode into its own stand-alone function.
>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Notes:
>>     This covers the suggestion of patch 2 and 3 by Eric
>>     > patch 2: Factor out the main 'for' loop of execute_commands() into a
>>     > new function. This new function will eventually become
>>     > execute_commands_non_atomic(). At this point, execute_commands() is
>>     > pretty much in its final form with the exception of the upcoming 'if
>>     > (use_atomic)' conditional.
>>     > patch 3: Morph the function extracted in patch 2 into
>>     > execute_commands_non_atomic() by adding transaction handling inside
>>     > the 'for' loop (and applying the changes from the early part of the
>>     > patch which go along with that).
>
> This patch is still rather heavyweight. My suggestion[1] for making
> these particular changes across two patches was quite deliberate. The
> problem with combining them into a single patch is that you're
> performing both code movement and functional changes at the same time.
>
> On its own, pure code movement is easy to review.
>
> On its own, code changes are as easy or difficult to review as the
> changes themselves.

I need to hammer this mantra in my brain. Sorry for messing this up again.

>
> When combined, however, the review effort is greater than the sum of
> the efforts of reviewing them separately. Partly this is because the
> combined changes have a noisier diff. If you move the code in one
> patch, and then change it in a second one, the changes pop out --
> they're quite obvious. On the other hand, when they are combined, the
> reviewer has to deliberately and painstakingly search out the changes,
> which is difficult and error-prone. Combining movement and code
> changes into a single patch also places greater cognitive load on the
> reviewer due to the necessity of keeping a more complex mental
> scoreboard relating to the different types of changes.
>
> More below.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/261706
>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 06eb287..5f44466 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1073,6 +1076,38 @@ static void check_shallow_bugs(struct command *commands,
>>                       "the reported refs above");
>>  }
>>
>> +static void execute_commands_loop(struct command *commands,
>> +                                 struct shallow_info *si)
>
> Style: Indent the wrapped line to align with the text following the
> '(' in the first line.

That's true. I have found this problem myself at another patch by
Michael lately.
If you apply the patch it is correctly aligned. If you view the patch
however it is missaligned.
Because of the leading plus sign the line in which the function
signature starts is
indented by one character. The other lines starting with a tab indent
only to 8 character.

This would explain a difference of only a few chars, but not so many.
I'll check the indentation here.

>
> It's safe to say that the code which you extracted from
> execute_commands() handled the non-atomic case, and it's safe to say
> that this new function implements the non-atomic case. Therefore, it
> would be truthful to call this function execute_commands_nonatomic().
> No need to invent the name execute_commands_loop().

ok.

>
>> +{
>> +       struct command *cmd;
>> +       struct strbuf err = STRBUF_INIT;
>> +
>> +       for (cmd = commands; cmd; cmd = cmd->next) {
>> +               if (!should_process_cmd(cmd))
>> +                       continue;
>> +
>> +               transaction = ref_transaction_begin(&err);
>> +               if (!transaction) {
>> +                       rp_error("%s", err.buf);
>> +                       strbuf_reset(&err);
>> +                       cmd->error_string = "transaction failed to start";
>> +                       continue;
>> +               }
>> +
>> +               cmd->error_string = update(cmd, si);
>> +
>> +               if (!cmd->error_string
>> +                   && ref_transaction_commit(transaction, &err)) {
>> +                       rp_error("%s", err.buf);
>> +                       strbuf_reset(&err);
>> +                       cmd->error_string = "failed to update ref";
>> +               }
>> +               ref_transaction_free(transaction);
>> +       }
>> +
>> +       strbuf_release(&err);
>> +}
>> +
>>  static void execute_commands(struct command *commands,
>>                              const char *unpacker_error,
>>                              struct shallow_info *si)
>> @@ -1107,12 +1142,8 @@ static void execute_commands(struct command *commands,
>>         free(head_name_to_free);
>>         head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
>>
>> -       for (cmd = commands; cmd; cmd = cmd->next) {
>> -               if (!should_process_cmd(cmd))
>> -                       continue;
>> +       execute_commands_loop(commands, si);
>>
>> -               cmd->error_string = update(cmd, si);
>> -       }
>>         check_shallow_bugs(commands, si);
>>  }
>>
>> --
>> 2.2.1.62.g3f15098
