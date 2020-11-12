Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6C5C2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 13:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565D020825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 13:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuQVYhCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgKLNm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgKLNm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 08:42:56 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A56C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 05:42:56 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id h15so5163043qkl.13
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9O/xeKEU+pOHjPyQLTAtZcihlaPei9Lew2vx7IPlpAo=;
        b=BuQVYhCR9hxRX4zSORavpA1kIDHeViqmNhyR9k2X5bv9SF8t3aCesSMeq60LTpe/1q
         ynvVG6V52AI7h5DAuMrbTlmdRVGPijczoPMWDlEEObFydfG9Prkv/QSO/SOJmLmjCQem
         ZgPxkmBfDjVW3p07mjAuCv/GKNN6umWBXPsOdkar07/Ul87HanFg4UKRia6WRUKWQlaU
         cj+fkaPlqXBFCDlZu2d1UoIsQNuO/v/xmoWocY/nY+dPnHtqgf2lrA6DTo+kCDf3T/8/
         OMYNC2XCCvoNDGZKzoVPhboxcHBU7NR6PBJwSIoPnzZ8VdjDKRpvmpgzo3QAPHT8gKQI
         5U3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9O/xeKEU+pOHjPyQLTAtZcihlaPei9Lew2vx7IPlpAo=;
        b=RwNRUcapYqblMLyo4u1cbuoafeABEiRrsc7ZMlw4HAsKw8TczSv0mIoZxn1ZfLOWqw
         mOnBEYU6P6jsWz+f4W49tHWRhiL0hKZODp/37IQFw/LwXZJkhkotI10jyUZbXpAOODX9
         9PDs6XUmzbPQNsjpddO2ECB5SWSFtOL/ipbHyuXziovlBhLL8lHqN0veQfXB5r8k8zG7
         TVF4rTltWYNjTMBaMNjjAQqq2Fe6jE7s3e8Vp+/V/CJSJk6UQatoQYfsoU+Sf+gNImQK
         LHuGncirHCyVJ3LTm0Yn3q/FUBVvNavEVXJ6ldp7TICf4yaJXaf4dYJCNzfCuVe/6XTq
         fORg==
X-Gm-Message-State: AOAM530V5weDhuh7BpaArqP7VbanfND/TKjXP6QsmbsQr3P1CImpEW9U
        nC1PVrE242H8/ksj9WEqWws=
X-Google-Smtp-Source: ABdhPJxXH/EpuTdFIit1SDMCJ1asSb8dKBSFjLCEOzQPgd9W+YY4ORp86+U4nJJKvaC4mhYnH4SXWw==
X-Received: by 2002:a37:84b:: with SMTP id 72mr26187999qki.435.1605188575211;
        Thu, 12 Nov 2020 05:42:55 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id t188sm356563qkd.45.2020.11.12.05.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 05:42:54 -0800 (PST)
Subject: Re: [PATCH v2 3/4] maintenance: use launchctl on macOS
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
 <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <0fafd75d100f343f7cff6471772ed9b12793f81e.1604520368.git.gitgitgadget@gmail.com>
 <CAPig+cT=DytbMH6KkC6ipD3jbWNa7jgW9G0Q76rwJoEsLGn_ow@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5e0307b8-8e63-f82d-b417-7007d4a3a5b3@gmail.com>
Date:   Thu, 12 Nov 2020 08:42:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT=DytbMH6KkC6ipD3jbWNa7jgW9G0Q76rwJoEsLGn_ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2020 3:12 AM, Eric Sunshine wrote:
> On Wed, Nov 4, 2020 at 3:06 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> [...]
>> The solution is to switch from cron to the Apple-recommended [1]
>> 'launchd' tool.
>> [...]
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
>> +While macOS technically supports `cron`, using `crontab -e` requires
>> +elevated privileges and the executed process do not have a full user
> 
> Either s/process/processes/ or s/do/does/
> 
>> +context. Without a full user context, Git and its credential helpers
>> +cannot access stored credentials, so some maintenance tasks are not
>> +functional.
> 
> Nicely explained.
> 
>> +Instead, `git maintenance start` interacts with the `launchctl` tool,
>> +which is the recommended way to
>> +https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/ScheduledJobs.html[schedule timed jobs in macOS].
> 
> Nit: I worry a bit about links to Apple documentation becoming
> outdated. It might not hurt to omit this link altogether, or perhaps
> demote it to a footnote (which might allow it to be somewhat usable
> even when Git documentation is rendered into something other than
> HTML).
> 
>> +Scheduling maintenance through `git maintenance (start|stop)` requires
>> +some `launchctl` features available only in macOS 10.11 or later.
> 
> Nit: This leaves the reader wondering what modern features are needed.
> Would it make sense to mention that "bootstrap" is used in place of
> "load" in older versions of 'launchctl'?
> 
>> +Your user-specific scheduled tasks are stored as XML-formatted `.plist`
>> +files in `~/Library/LaunchAgents/`. You can see the currently-registered
>> +tasks using the following command:
>> +
>> +-----------------------------------------------------------------------
>> +$ ls ~/Library/LaunchAgents/ | grep org.git-scm.git
> 
> Alternately (unimportant):
> 
>     ls ~/Library/LaunchAgents/org.git-scm.git.*
> 
> although that would emit "No such file" if you don't have any
> registered, which might suggest:
> 
>     find ~/Library/LaunchAgents -name 'org.git-scm.git.*'
> 
>> +To create more advanced customizations to your background tasks, see
>> +https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html#//apple_ref/doc/uid/TP40001762-104142[the `launchctl` documentation]
>> +for more information.
> 
> I really worry about this sort of URL becoming outdated. Would it make
> sense instead to just point the user at the man page,
> launchd.plist(5)? It's not quite the same, as it doesn't provide the
> range of examples as the URL you cite, but it should get the user
> started.

I shared similar concerns. I'll use the man page references instead.
All of the information should be a short web search away after the
user is given the right terminology.

>> diff --git a/builtin/gc.c b/builtin/gc.c
>> @@ -1491,6 +1491,214 @@ static int maintenance_unregister(void)
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
>>
>> +static int remove_plists(void)
>> +{
>> +       return remove_plist(SCHEDULE_HOURLY) ||
>> +               remove_plist(SCHEDULE_DAILY) ||
>> +               remove_plist(SCHEDULE_WEEKLY);
>> +}
> 
> The new documentation you added says that the plist files will be
> deleted after they are deregistered using launchctl, but I don't see
> anything actually deleting them. Am I missing something obvious?

As mentioned below, this was a change that I made but somehow lost
while juggling multiple copies of my branch.

>> +static int schedule_plist(const char *exec_path, enum schedule_priority schedule)
>> +{
>> +       plist = fopen(filename, "w");
>> +       if (!plist)
>> +               die(_("failed to open '%s'"), filename);
> 
> As mentioned previously, these could be replaced with a simple xfopen().
> 
> In fact, I'm having trouble seeing changes in this re-roll which you
> had planned on making, such as consolidating the repeated code in
> bootout() and bootstrap(), and ensuring that bootout() doesn't
> complain if the plist files are already missing, and so forth. Did you
> opt to not make those changes? (Which would be fine; they were minor
> suggestions.)

No, I definitely made those changes _somewhere_ but I must have
gotten confused as to which of my machines had those changes. I
guess that's part of the risk of testing across three platforms.

Thank you for noticing, and I'll be more careful from now on.

>> +test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
>> +       echo "#!/bin/sh\necho \$@ >>args" >print-args &&
>> +       chmod a+x print-args &&
> 
> Earlier review already mentioned write_script() and "$@". (Not
> necessarily worth a re-roll.)

I'm going to go back to all of your earlier comments to make sure
they are _actually_ applied in v3.
 
>> +       for frequency in hourly daily weekly
>> +       do
>> +               PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
>> +               xmllint "$PLIST" >/dev/null &&
> 
> Do we really need to suppress xmllint's stdout?

It outputs the XML itself. Maybe there is a command to stop that from
happening, but nulling stdout keeps the test log clean.

Thanks,
-Stolee
