Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C77C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A0B206B5
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFsdNQum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbgKCVVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388425AbgKCVVv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 16:21:51 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87365C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 13:21:51 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id a65so14406971qkg.13
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 13:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c9z6gek4p7IDwiV/cKD0+SJ884JPRkP/kNunMoDCOts=;
        b=bFsdNQumRsu2UMyMa60fJ/NHhHarvjCUwF3kP2oR7u1w+fbO0YGuiCy3WGKSv+PUhj
         upvAKKWU+IYl54XidVEOrFLiMWC8d2ZYku83lmQz6l51UFNiggVGS5Lib/QB3QScLJNK
         Vzm8zvd1bTm1juW76YWFKnftXPLfvrpydi77WcxlWj4VeKyQnoJfdvHCgZhrqj0FaTOf
         0U+DvlLilEuGgnPN5x+T12mI3GuDI1jZJMSfl2LhsL10oLBOYN1+09qBcBCymcrvZAK9
         o08DBvkFD/xAG0kksERSqXR2gqIPL3hPm3y70ywzVgrN685EiJdBDdTWZSYUGPUvYLnY
         AIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c9z6gek4p7IDwiV/cKD0+SJ884JPRkP/kNunMoDCOts=;
        b=HBQCvL6IrtzCmHVsoadb+NdPY5kiZOzpRQcEe6Rguaj+UAGvQ6IrBx5dNViL8ft1E+
         nRsDYBSbrrQzQ5RjCjR+Y2YvHsbO522mNs0fAvQMJfi/QtRitlT7JdhwxC9sv43YYaQ3
         E4cgSSkGwB//NNV7PamYbJ0hAMHe81fDapq5lhQzjRWnMf4Tt/0FkF0bQhkDlw+FuKHz
         zLaL35UsExFLtGTz+QnpaDIBS8OHdn2jrlTwBwjzDDtSxwJNnN3RMrW4oB4WR134FaWn
         IrWIN4RLkidyvCHnPISdnmzmj2rVoEbJmxTClWK150fOKtzKbcZE+vOVulx30vCT3LxZ
         zgpg==
X-Gm-Message-State: AOAM5332VuSd6Q/RXJ3QzKIKBhVUPFAbtMa9RXNF51uQFqOfcuPG/fG2
        KtC+U3i+P2cQlUp/uTUIWVo=
X-Google-Smtp-Source: ABdhPJz8WnqKhvWnRC8J2Sm3AoOUrHIaoPLqpqYcIYXXnvJ9OcE0eRYMfwncQstKZslrSNtodPLQUA==
X-Received: by 2002:a37:bac7:: with SMTP id k190mr21702096qkf.464.1604438510643;
        Tue, 03 Nov 2020 13:21:50 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id a206sm8837126qkb.64.2020.11.03.13.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 13:21:47 -0800 (PST)
Subject: Re: [PATCH 2/3] maintenance: use launchctl on macOS
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <832fdf16872cbfee4a5e15b559b2b40dabd545f4.1604412197.git.gitgitgadget@gmail.com>
 <CAPig+cR1zSqY_y02JBdtjh_+9Pp2dOtGrHHmf-ah5sU6Lhzp6Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e493b759-4565-e7d2-4a19-dee23c651119@gmail.com>
Date:   Tue, 3 Nov 2020 16:21:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cR1zSqY_y02JBdtjh_+9Pp2dOtGrHHmf-ah5sU6Lhzp6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/2020 1:45 PM, Eric Sunshine wrote:
> On Tue, Nov 3, 2020 at 9:05 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> maintenance: use launchctl on macOS
> 
> A few comments below (not necessarily worth a re-roll)...
> 
>> The launchctl command needs to be aligned with a user id in order
>> to initialize the command environment. This must be done using
>> the 'launchctl bootstrap' subcommand. This subcommand is new as
>> of macOS 10.11, which was released in September 2015. Before that
>> release the 'launchctl load' subcommand was recommended. The best
>> source of information on this transition I have seen is available
>> at [2].
> 
> It's not clear whether or not this is saying that git-maintenance will
> dynamically adapt to work with modern and older 'launchctl'. A glance
> at the actual code reveals that it knows only about modern
> 'bootstrap'. Perhaps this could be a bit clearer by saying that it
> only supports modern versions, and that support for older versions can
> be added later if needed. (For those of us who are stuck with 10-20
> year old hardware and OS versions, 2015 isn't that long ago.)

Yes, this is a strange place to be. How far do we go back to support
as many users as possible? How many users will be simultaneously
stuck on an old version of macOS _and_ interested in updating to this
latest version of Git? Is that worth the extra functionality to detect
the the OS version and change commands?

The good news is that this patch doesn't lock us in to the
boot(strap|out) subcommands too much. We could add in load/unload
subcommands for systems that are too old. However, I did think it
was prudent to take the currently-recommended option for fear that
Apple will completely _delete_ the load/unload options in an
upcoming release.

This makes me realize that I should update the documentation to give
pointers for how to view the schedules for each platform:

- Windows: Open "Task Scheduler"
- macOS: 'launchctl list | grep org.git-scm.git'
- Others: 'crontab -l'

>> +static int bootstrap(const char *filename)
>> +{
>> +       int result;
>> +       struct strvec args = STRVEC_INIT;
>> +       char *uid = get_uid();
>> +       const char *launchctl = getenv("GIT_TEST_CRONTAB");
>> +       if (!launchctl)
>> +               launchctl = "/bin/launchctl";
>> +
>> +       strvec_split(&args, launchctl);
>> +       strvec_push(&args, "bootstrap");
>> +       strvec_pushf(&args, "gui/%s", uid);
>> +       strvec_push(&args, filename);
>> +
>> +       result = run_command_v_opt(args.v, 0);
>> +
>> +       strvec_clear(&args);
>> +       free(uid);
>> +       return result;
>> +}
> 
> The bootout() and bootstrap() functions seem to be identical except
> for one string literal. Code could be reduced by refactoring and
> passing that string literal in as an argument.

Good point. Or a simple boolean value for "add" or "remove".
 
>> +static int remove_plist(enum schedule_priority schedule)
>> +{
>> +       const char *frequency = get_frequency(schedule);
>> +       char *name = get_service_name(frequency);
>> +       char *filename = get_service_filename(name);
>> +       int result = bootout(filename);
>> +       free(filename);
>> +       free(name);
>> +       return result;
>> +}
> 
> The result of get_service_name() is only ever passed to
> get_service_filename(). If get_service_filename() made the call to
> get_service_name() itself, it would free up callers from having to
> remember to free(name), thus reducing the likelihood of a possible
> leak.

You're right. In an earlier version I thought I needed to add the
name in the XML, but it turns out I did not.

>> +static int schedule_plist(const char *exec_path, enum schedule_priority schedule)
>> +{
>> +       plist = fopen(filename, "w");
>> +
>> +       if (!plist)
>> +               die(_("failed to open '%s'"), filename);
> 
> You can replace the fopen() and die() with a single call to xfopen().

Thanks! I'll use that in several places and try to remember next time.

>> +       /* bootout might fail if not already running, so ignore */
>> +       bootout(filename);
>> +       if (bootstrap(filename))
>> +               die(_("failed to bootstrap service %s"), filename);
> 
> I'm guessing that 'launchctl bootout' won't print a confusing and
> unexpected error message if the plist is not presently registered?

You're right, it does. It also returns with a non-zero exit code.
Along with your later suggestion to clear the .plist files, we will
want to have several conditions to not error out during a case where
the task is not scheduled.

>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> @@ -389,12 +389,58 @@ test_expect_success 'stop from existing schedule' '
>> +test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
>> +       echo "#!/bin/sh\necho \$@ >>args" >print-args &&
>> +       chmod a+x print-args &&
> 
> Note that $@ loses its special magic if not surrounded by quotes, thus
> acts just like $*. So, either use "$@" or $* depending upon your
> requirements, but in the case of 'echo', it's just not going to matter
> at all, so $* is fine.
> 
> To construct the script, you can do this instead, which is easier to
> read and handles the 'chmod' for you:
> 
>     write_script print-args <<-\EOF
>     echo $* >>args
>     EOF

TIL. thanks.

>> +       for frequency in hourly daily weekly
>> +       do
>> +               PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
>> +               grep schedule=$frequency "$PLIST" &&
>> +               echo "bootout gui/$UID $PLIST" >>expect &&
>> +               echo "bootstrap gui/$UID $PLIST" >>expect || return 1
>> +       done &&
> 
> My gut feeling is that this would be more robust if you manually
> determine UID in the test script the same way as the git-maintenance
> command itself does using '/usr/bin/id -u' rather than relying upon
> inheriting UID from the user's environment.

Yeah, you're right. Thanks!

>> +       # stop does not remove plist files, but boots them out
> 
> Is this desirable? Should git-maintenance do a better job of cleaning
> up after itself?

Yes, let's clear up these .plist files.

Thanks!
-Stolee
