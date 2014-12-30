From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 4/9] receive-pack.c: simplify execute_commands
Date: Tue, 30 Dec 2014 12:33:48 -0800
Message-ID: <CAGZ79kYds-oo-Q0=R6ny=CpZ3ja0__6CDm-wmamnSp3TBWcKdQ@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-5-git-send-email-sbeller@google.com>
	<CAPig+cT9JVkDvUUsbx9HW8HpakCb9SkoQf3LJZc4h3TQTt2ZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 21:33:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y63UJ-0001N4-2b
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 21:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbaL3Udv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 15:33:51 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39556 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaL3Udt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 15:33:49 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so14119890ieb.3
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=u+O1fteKYlgxtw9bUNGo9ZJTjv2rPB/BC2hlO8Q73yo=;
        b=bkRVGzF999WKDoxg0C7tggSD6tOH9KfVsuwyeGfmLhna/R8trRiWcw1BOIWecKFaYl
         fws/k7NHkkMDCo/zeB7sMxSQnZU5DMBv9lq4wpW0BSUQVMSYNSo48lcd4l8lIFFE3pqH
         RtJjOWU0mm48BjQKtpUi15AQNJhJvck7v4acwqPZoykFW/uzP/kEqxA4yrK2I2qaRR0W
         eH6bDBWlQlJhNFb+7qGiPCNzCIsIdLFUDZayU5Ja3h48Bzba+A46yNdFmSTdmbXso6vA
         IAQNgFBRhG7uM8Y1nGihfin20PP8yhNaMTJ45mFVJjpppW/hsaabgG4acZbSZePvz8mV
         yfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=u+O1fteKYlgxtw9bUNGo9ZJTjv2rPB/BC2hlO8Q73yo=;
        b=GhTkTtnfWyvET/wOiT03RuMSeZHYz2GJwKYFG1enRTGnv/X8prZubySqVwTAolM5VN
         8qc84GnHw8VDU7dgFT+WQ+IN58CRg3SLN1fymvWQzZ6sbvJQHNMlCqajzGBPdd5oI0M3
         PI+R70GNw8x9rX1H/ys5mxOh8M7xG+gZBxGqk5DwZA244lcmWOZ1g8emhcCzc3HORenu
         gRI57SraWBRFFUqul3VzacG8j4CH6g0StUQnkLTuQH9jUsytVKnItWmOxT5mrqY/FsO2
         3u4JfCBYq2JfjvhUVXd/qMHs2znKmBkJ1/mZHYMqU0gcNWYLag+w5/TmZJHQeHce2V1A
         mQFQ==
X-Gm-Message-State: ALoCoQlpX/1zxiXR/xNnX2GWA7LhNUFYlmhi54OVjU4RRedMza9PO8giOy7memHRy4pQ/wUBY9wW
X-Received: by 10.107.170.166 with SMTP id g38mr10333539ioj.2.1419971628934;
 Tue, 30 Dec 2014 12:33:48 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 30 Dec 2014 12:33:48 -0800 (PST)
In-Reply-To: <CAPig+cT9JVkDvUUsbx9HW8HpakCb9SkoQf3LJZc4h3TQTt2ZXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261941>

On Mon, Dec 29, 2014 at 10:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
>> No functional changes intended.
>
> This is useful to know but is of secondary importance, thus should be
> placed after the explanation and justification of the change.
>
>> Subject: receive-pack.c: simplify execute_commands
>> This commit shortens execute_commands by moving some parts of the code
>> to extra functions.
>
> The _real_ reason for moving these bits of code into their own
> functions is that you intend to introduce additional callers in
> subsequent patches. That is what the commit message (including
> subject) should be conveying to the reader.
>
> The claimed simplification is questionable and not of particular
> importance; and it's misleading to paint it as a goal of the patch.
> Consequently, you could drop mention of it altogether.
>
> More below.
>
>> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 4e8eaf7..06eb287 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1043,11 +1043,40 @@ static void reject_updates_to_hidden(struct command *commands)
>>         }
>>  }
>>
>> +static int should_process_cmd(struct command *cmd)
>> +{
>> +       if (cmd->error_string)
>> +               return 0;
>> +       if (cmd->skip_update)
>> +               return 0;
>> +       return 1;
>
> Alternately, depending upon the polarity of your brain, you could
> collapse the entire function body to:
>
>     return !cmd->error_string && !cmd->skip_update;
>
> or:
>
>     return !(cmd->error_string || cmd->skip_update);

I did not want to change the structure of the code when moving it around as
you noted in another email that helps on reviewing.
And having the exact same conditions in an if and then return instead
of continue
makes me think it is easier to review than if I also introduce that shortening?
I can do so in a follow up.

>
>> +}
>> +
>> +static void check_shallow_bugs(struct command *commands,
>> +                              struct shallow_info *si)
>> +{
>> +       struct command *cmd;
>> +       int checked_connectivity = 1;
>> +       for (cmd = commands; cmd; cmd = cmd->next) {
>> +               if (!should_process_cmd(cmd))
>> +                       continue;
>> +
>> +               if (shallow_update && si->shallow_ref[cmd->index]) {
>
> Here, inside the loop, you check 'shallow_update'...
>
>> +                       error("BUG: connectivity check has not been run on ref %s",
>> +                             cmd->ref_name);
>> +                       checked_connectivity = 0;
>> +               }
>> +       }
>> +       if (shallow_update && !checked_connectivity)
>
> And here, after the loop, you check 'shallow_update'.
>
> But, if you examine the overall logic, you will find that this
> function does _nothing_ at all when 'shallow_update' is false (other
> than uselessly looping through 'commands'). Therefore, either check
> 'shallow_update' just once at the beginning of the function and exit
> early if false, or have the caller check 'shallow_update' and only
> invoke check_shallow_bugs() if true.
>
> Also, since nothing happens between them, the two conditionals inside
> the loop can be coalesced:
>
>     if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {
>
>> +               error("BUG: run 'git fsck' for safety.\n"
>> +                     "If there are errors, try to remove "
>> +                     "the reported refs above");

That's a good idea. I'll definitely add that. But as said above, I
also feel that this
should rather go in a follow up patch as it twists the logic and this
patch is all
about moving the code.

>
> In v6, you considered this a fatal error in the atomic case, which
> caused the entire transaction to be rolled back. However, in this
> version, this error has no effect whatsoever on the atomic
> transaction, which is a rather significant behavioral departure. Which
> is correct? (This is a genuine question; not at all rhetorical.) If
> failing the entire transaction is the correct thing to do, then this
> is going to need some more work.
>
>> +}
>> +
>>  static void execute_commands(struct command *commands,
>>                              const char *unpacker_error,
>>                              struct shallow_info *si)
>>  {
>> -       int checked_connectivity;
>>         struct command *cmd;
>>         unsigned char sha1[20];
>>         struct iterate_data data;
>> @@ -1078,27 +1107,13 @@ static void execute_commands(struct command *commands,
>>         free(head_name_to_free);
>>         head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
>>
>> -       checked_connectivity = 1;
>>         for (cmd = commands; cmd; cmd = cmd->next) {
>> -               if (cmd->error_string)
>> -                       continue;
>> -
>> -               if (cmd->skip_update)
>> +               if (!should_process_cmd(cmd))
>>                         continue;
>>
>>                 cmd->error_string = update(cmd, si);
>> -               if (shallow_update && !cmd->error_string &&
>> -                   si->shallow_ref[cmd->index]) {
>> -                       error("BUG: connectivity check has not been run on ref %s",
>> -                             cmd->ref_name);
>> -                       checked_connectivity = 0;
>> -               }
>>         }
>> -
>> -       if (shallow_update && !checked_connectivity)
>> -               error("BUG: run 'git fsck' for safety.\n"
>> -                     "If there are errors, try to remove "
>> -                     "the reported refs above");
>> +       check_shallow_bugs(commands, si);
>>  }
>>
>>  static struct command **queue_command(struct command **tail,
>> --
>> 2.2.1.62.g3f15098
