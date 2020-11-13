Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C614AC55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDB020B80
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f882wURa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKMUmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMUmI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 15:42:08 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E66CC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 12:42:07 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id g17so7701099qts.5
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 12:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7hU1G61rDnaEUDqEiqzl10kzK0im07MkH8MvoncHF28=;
        b=f882wURalhmm54JsX1cposQl4xSmNcLzP8tA0a8uTq18gcLHdQZYz/30xI9MprIFoT
         Udbc+J9tn4OyRXWYhlkgPdjQ+IvpL77c+sdNLlIanHQNnpUhgatGvNvOMMHgWe4zqSZv
         3sfVLkVjqx/ZThU8rWnbHJXFk3eWGeRlFkmDCOhclX3Mg/RjId38Z9zPnR4dBb/jIS0F
         HV+FlozbQP/DW4hW28fBvP/P4aM3Zo2QB1uIGG/r/UaypSefDG145BGvpHJAvq120QM4
         EWofmxAgzTidXd/qET3o5n+eNYaZIi2lnBJ8RAYxQ19l/tak6hoIMqqWmmJ5bXNCTV8e
         n62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7hU1G61rDnaEUDqEiqzl10kzK0im07MkH8MvoncHF28=;
        b=DDKvp8c0KQNlXnB8SxS7O8r4kRmHEe8zeOyDtxLGSzJObH5HFiyZzn+oC/ElRKc5O5
         V952JUrn+uZqjnUVn8yMLqqxjvVWgQpSuqVv1lJks3fSMZx2A3bDF3BOAvcEETeNCJ4Y
         lWg1I6mBWCvC0pKq3CpWHBISVO7DZ+bkMngG0WeU8bdS1h2qgMS/ivqPC5Qf3gUgxXU4
         pj3Sbg5I75kuMkXTTNsHx+KOfeHloLV9F3NI6wMWKxO+lQaZfZLM1G76oKxKIKl3kbqR
         5hBwiFI2Q8tUJsn0MI/NXzmwZN4+Y47PPLb+coQnNq5YIVHAzpTpsfa1MfFLL88GEDIY
         9G2w==
X-Gm-Message-State: AOAM530BMCN9wG7Q3+WUaxpqugCxBWzrO1Op2Wa2RMdybI6NcNCtwnKC
        Q9tsOr2iRvLQMzRK7JhWLjE=
X-Google-Smtp-Source: ABdhPJyN9g/QtBWqiQMkCCSdfIhRQo/6MH923HsGyCfPN1DqX5PLVx0EWYa/GlpPmrg1ibxs6cBkig==
X-Received: by 2002:ac8:641:: with SMTP id e1mr3851279qth.226.1605300126317;
        Fri, 13 Nov 2020 12:42:06 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7082:2419:51dc:d02a? ([2600:1700:e72:80a0:7082:2419:51dc:d02a])
        by smtp.gmail.com with UTF8SMTPSA id y3sm7034021qto.2.2020.11.13.12.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:42:05 -0800 (PST)
Subject: Re: [PATCH v3 3/4] maintenance: use launchctl on macOS
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <1629bcfcf82dbc2ed9889a0e9ea2d08427901c4e.1605276024.git.gitgitgadget@gmail.com>
 <CAPig+cQQrucwE-KSndQ5kCjG9Q1MtjxraAmA95+OQe=6bdks-Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d9c51446-c223-dce9-692a-959f841d506f@gmail.com>
Date:   Fri, 13 Nov 2020 15:42:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQQrucwE-KSndQ5kCjG9Q1MtjxraAmA95+OQe=6bdks-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13/2020 3:19 PM, Eric Sunshine wrote:
> On Fri, Nov 13, 2020 at 9:00 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> [...]
>> The solution is to switch from cron to the Apple-recommended [1]
>> 'launchd' tool.
>> [...]
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> @@ -1491,6 +1491,200 @@ static int maintenance_unregister(void)
>> +static int boot_plist(int enable, const char *filename)
>> +{
>> +       struct child_process child = CHILD_PROCESS_INIT;
>> +       child.no_stderr = 1;
>> +       child.no_stdout = 1;
>> +       if (start_command(&child))
>> +               die(_("failed to start launchctl"));
> 
> Not necessarily worth a re-roll -- in fact, it could be done atop this
> series to avoid holding this series up -- but this too-succinct error
> reporting won't help users diagnose the failure. An alternative would
> be to capture stdout and stderr and only print them if the command
> fails. Perhaps something like this:
> 
>     struct strbuf out = STRBUF_INIT;
>     struct strbuf err = STRBUF_INIT;
>     ...
>     if (pipe_command(child, NULL, 0, &out, 0, &err, 0) {
>         if (out.len && err.len)
>             strbuf_addstr(&out, "; ");
>         strbuf_addbuf(&out, &err);
>         die(_("launchctl failed: %s"), out.buf);
>     }

We would also want to pass a "die_on_failure" into the method, since
in the 'git maintenance start' case we don't want to report a failure
when 'launchctl bootout' fails before we call 'launchctl bootstrap'.

> By the way, won't this die() be a problem when schedule_plist() calls
> boot_plist() to remove the old scheduled tasks before calling it again
> to register the new ones? If the old ones don't exist, then it will
> die() unnecessarily and never register the new ones. Or am I
> misunderstanding? (I'm guessing that I must be misunderstanding since
> the test script presumably passes.)

This die() is only if the process cannot _start_, for example due to
launchctl not existing on $PATH. The result from finish_command()
would be non-zero when we bootout a plist that doesn't exist.

>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> @@ -389,12 +389,54 @@ test_expect_success 'stop from existing schedule' '
>> +test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
>> +       write_script print-args "#!/bin/sh\necho \$* >>args" &&
> 
> write_script() takes the script body as stdin, not as an argument, and
> you don't need to specify /bin/sh. What you have here works by
> accident only because write_script() takes an optional second argument
> specifying the shell to use in place of the default /bin/sh.
> Nevertheless, it should really be written:
> 
>     write_script print-args <<-\EOF
>     echo $*
>     EOF
> 
> Patch [4/4] uses write_script() correctly.

Ah. Sorry for misunderstanding. That explains why it works this way
on macOS but it did _not_ work that way on Windows.

>> +       rm -f args &&
>> +       GIT_TEST_CRONTAB="./print-args" git maintenance start &&
>> +
>> +       # start registers the repo
>> +       git config --get --global maintenance.repo "$(pwd)" &&
>> +
>> +       # ~/Library/LaunchAgents
>> +       ls "$HOME/Library/LaunchAgents" >actual &&
> 
> Not sure what the comment above the `ls` is meant to be conveying.
> Could be dropped but not itself worth a re-roll.
> 
>> +       cat >expect <<-\EOF &&
>> +       org.git-scm.git.daily.plist
>> +       org.git-scm.git.hourly.plist
>> +       org.git-scm.git.weekly.plist
>> +       EOF
>> +       test_cmp expect actual &&
>> +
>> +       rm expect &&
>> +       for frequency in hourly daily weekly
>> +       do
>> +               PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
>> +               xmllint --noout "$PLIST" &&
>> +               grep schedule=$frequency "$PLIST" &&
>> +               echo "bootout gui/$UID $PLIST" >>expect &&
>> +               echo "bootstrap gui/$UID $PLIST" >>expect || return 1
>> +       done &&
> 
> This is still relying upon $UID picked up from the users environment
> (as far as I can tell), which seems fragile. As mentioned in my first
> review, it probably would be more robust to compute UID manually the
> same way git-maintenance itself does.

Sorry, I missed this comment from v1 when reapplying the changes for v3.

>> +       test_cmp expect args &&
>> +
>> +       rm -f args &&
>> +       GIT_TEST_CRONTAB="./print-args" git maintenance stop &&
> 
> Minor: No need for the quotes around ./print-args (though they don't
> hurt either, and certainly not worth re-rolling just to drop them, and
> it's subjective so don't drop them just for my sake).

Thank you for your continued attention and patience.
-Stolee
