From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 4/9] receive-pack.c: simplify execute_commands
Date: Tue, 30 Dec 2014 00:42:10 -0800
Message-ID: <CAGZ79kYvv_r8TahfoE5g_5nBQhjsAC3tHvxUUBE4PtKLy8sGhQ@mail.gmail.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
	<1419907007-19387-5-git-send-email-sbeller@google.com>
	<CAPig+cQEO+LKZJDzE-sUmo+td=djsOdjx-ouQEMRTTkOBMwzjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 09:42:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5sNc-0006e0-Cq
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 09:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbaL3ImM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 03:42:12 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:46957 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbaL3ImL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 03:42:11 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so12343249igb.3
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 00:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3c4Sy2HGJyCz4IHxQF40lxilN+RswsW1wuBpkC+My4c=;
        b=ZBnoDqOAmS1OMAm428sq6maiBnLOwulTgXrX2eExo3wImTzVHQ2dSitVN8IcJg5KJu
         5btivna1F2oiPljqB0YFDrqcQ9B1sxqZInFcFoGZXVQxf0zjsC3vtYZEva3eP6s0SR35
         M5aUv3zcWdE7mGJeVJ47AccluR4+0R7/OkbPnwRjXan1BoyYsYPG9NwspfOiG4BplDrm
         PultGq/ZCqxVsa3yYeyyJqdS9KL08MwYkwEzir15VjF6NHN+8MtU5+aNoZ5gmaK7uoF5
         ALsqZDykHXhfPbXWymV3oHhmrF6s49orjzrHL2Cn4XVOs/4f3cYswmjtizvf2wmHWPBC
         lFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3c4Sy2HGJyCz4IHxQF40lxilN+RswsW1wuBpkC+My4c=;
        b=Ey4PXopvt8VTQ5bRWDE8crQinSTm20LFPEw/Yhxq9y2Rk/u6U1GoKN6W0dX8xl2+6o
         vysbIErdI8mfjEVgPSlTZEF1SXlyjxvepBqLoD+lBreHzPJlMG7vFVOngt89uwv0YccG
         kfcE51jTsLz0TxV6CF7tsd28soI3mUbr5POpc8kKvubWRk9JBJm2NxrdDf3gVaNVsG5+
         cBTi9hxYlTIwrWdEBT5K9dD60KWKglGiZ/Hqc0i0Nj9Mq+SKTz2ez5P1PubDY7WQAGb+
         fGSqlWL8nOtNth3zxjqzyx0wueZA/mDC0O8Fp0YUazbpwThybnzTaPHNuHba/FB6dkJJ
         KpyQ==
X-Gm-Message-State: ALoCoQnk6nVbnOVJM4wacg0DzhqELdXlLloq/AoiXJDOdtyHQZBH77XWh6xeJCwTtdFoH74kRMFi
X-Received: by 10.107.25.74 with SMTP id 71mr54127719ioz.70.1419928930346;
 Tue, 30 Dec 2014 00:42:10 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 30 Dec 2014 00:42:10 -0800 (PST)
In-Reply-To: <CAPig+cQEO+LKZJDzE-sUmo+td=djsOdjx-ouQEMRTTkOBMwzjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261918>

On Mon, Dec 29, 2014 at 11:46 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Dec 29, 2014 at 9:36 PM, Stefan Beller <sbeller@google.com> wrote:
>> No functional changes intended.
>>
>> This commit shortens execute_commands by moving some parts of the code
>> to extra functions.
>>
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
> Another issue: In the original code, 'si->shallow_ref[cmd->index]' is
> only checked if cmd->error_string is NULL, but here you check it
> unconditionally, despite the commit message claiming no functional
> changes. Did you verify that such a behavioral change is benign? (This
> is a genuine question.)

The error != NULL check is done in if (!should_process_cmd(cmd))

>
>> +                       error("BUG: connectivity check has not been run on ref %s",
>> +                             cmd->ref_name);
>> +                       checked_connectivity = 0;
>> +               }
>> +       }
>> +       if (shallow_update && !checked_connectivity)
>> +               error("BUG: run 'git fsck' for safety.\n"
>> +                     "If there are errors, try to remove "
>> +                     "the reported refs above");
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
