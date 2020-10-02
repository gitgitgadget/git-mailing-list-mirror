Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E53AC4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF07206DC
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pc9RCLdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgJBGCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 02:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgJBGCE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 02:02:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4DAC0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 23:02:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p187so642167ybg.14
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 23:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=w+7x12mI8OUL2Hvra75x+ejCef1Ad4Y/B6q21sWSNZA=;
        b=Pc9RCLdxC63TCWyrBb3/y5rQqWlE+3yrk69on2gwiySvwJPEaJb5O4zMy3aIOvNA+V
         Gm1SuQ7hDAmGeCkTWSPfmOf+D+n7sNGw2JAKtk/9gBTsdIg3qwOnWfDnuF5k/wvUVy0G
         8zSrkGa76KKvqcEFg+e/6UDK3V7649eT/4wyI2C4C8zOmnT080a01yorBI7OVBYzYzod
         44Vb+gzNXXm8+D8WUUvOfdwQuH/fNXoeHrdlMY7Vbt7bL6Ydgjk79xpB2xs7guXjjZeI
         ykkHS5Ya2p3QpVeyh9uJPkLyHXbWz9JSH4jwg8+POpvBSG7DRsjSfCmUG1fHbbbDYfRQ
         1JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w+7x12mI8OUL2Hvra75x+ejCef1Ad4Y/B6q21sWSNZA=;
        b=amxe5qBV5I8fXZQUtKk+rXt4sQ7nH9hBKY4cv0sBsrM6u5LA/uWJak0tGjlkAwBeDr
         t7Ce6+6ISesFXi4oUKDnUK6rn5z5ytD1BI6f0Q9j/6JbJECtdMPV6aB7E/wAySoFfj4e
         7YrQdpuzSrXIjGqYk/HV+3w+YdwO9gu1CpcuS1AQG5zeNJhX416RTQB/pFVmMzjx74Iv
         Yd/WCz/ko3ee3isCNthIZR/OcAwaBleH4Zm1UAwHe/8KR6cXyniuizvPLcjflVhK/R1Q
         q/zlju2Vh0qEeklI3FPTtVnTmsDEcg/fJf0tcPsIvQztSkLkqg12u0nnjdV9YU75NNzx
         PD9Q==
X-Gm-Message-State: AOAM532mooPX+w+xr59R5mYufqzeD9L4tvWzRybU0PzFDdpaLiK4CqbW
        q5hfo1yjlK0cvGA6JdfHfQlHBE9kGBW1
X-Google-Smtp-Source: ABdhPJxqi534ksCcEXYaJDNAiKjMPFPRgvglalCkrlA+LNFo7biM5yryBE8mORAW4psJl7aGCCbTur/72tjQ
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a25:874b:: with SMTP id
 e11mr778066ybn.48.1601618522310; Thu, 01 Oct 2020 23:02:02 -0700 (PDT)
Date:   Fri,  2 Oct 2020 06:02:00 +0000
In-Reply-To: <xmqqpn62essa.fsf@gitster.c.googlers.com>
Message-Id: <20201002060200.4073817-1-shengfa@google.com>
Mime-Version: 1.0
References: <xmqqpn62essa.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
From:   Shengfa Lin <shengfa@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the comments.

Junio C Hamano <gitster@pobox.com> writes:

>> Users requested hiding location in the world from source control
>> trail. This is an implementation to read user.hideTimezone in
>> cmd_commit and set timezone to UTC if it's true.
>>
>> Added a brief explanation of the new field in Documentation
>> and added tests for true/false and reset-author
>>
>> Signed-off-by: Shengfa Lin <shengfa@google.com>
>> ---
>>  Documentation/config/user.txt   |  4 ++++
>>  builtin/commit.c                |  5 +++++
>
> There are many ways other than running "git commit" for a commit to
> be created, including but not limited to "git merge", "git rebase",
> "git pull" (with or without "--rebase").

I overlooked on this.

>> +user.hideTimezone::
>> +  Override TZ to UTC for Git commits to hide user's timezone in commit
>> +  date
>
> One level of indentation in this codebase is a single HT.
>
> Unterminated sentence.

What does HT stands for? I will change the indentation to 8 spaces.

> This only affects "git commit" and no other command (which I think
> is a mistake), yet is placed in the "user.*" namespace?  That does
> not make any sense.  I can sort-of understand if it were called say
> "commit.useUTC" though.

I don't think this is a recommendation to implement commit.useUTC instead
since it makes more sense to support more than just the commit command.

>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 42b964e0ca..fb1cbb8a39 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1569,6 +1569,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>  	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
>>  	s.colopts = 0;
>>  
>> +  git_config(git_default_config, NULL);
>
>Declaration after statement is not tolerated in this codebase.

If I use the DEVELOPER=1 flag in config.mak and call make again, would the compiler
catches this as an error?

>> +  int hide_timezone = 0;
>
> Unnecessary initialization.
>> +  if (!git_config_get_bool("user.hideTimezone", &hide_timezone)  && hide_timezone)
>

Is it unnecessary because I am checking the return value from git_config_get_bool so
that the uninitialized value won't be used?

>> +        git add file &&
>> +        # unset GIT_AUTHOR_DATE from test_tick
>> +        unset GIT_AUTHOR_DATE &&
>> +        TZ=Europe/Istanbul git commit -m initial &&
>> +        git log -1 > output &&
>> +        grep "Date: .* +0300" output
>
> Do they not have DST over there, and is it guaranteed that they will
> never have one?  Would we see this test fail about half of the year,
> when timezone rules change over there in some future year?  After
> all, they changed in 2016 last time, which is fairly recent.

I looked up the timezones and find one without DST without considering
the possibility of timezone rules change which would cause the test
to fail.

> This test attempts to establish the baseline, but I do not think it
> is a good idea.  I think it is better *not* to unset GIT_AUTHOR_DATE
> like this.  Instead, make sure it is set to some timestamp in some
> timezone that is not UTC, and the timezone of the resulting commit
> author date is in that timezone.  But that must have already been
> done in basic tests on "git commit" that we honor the environment
> variable, no?  Which means there is no need to add yet another extra
> baseline test here.
>

I am not sure if this test has already been done in commit basic tests.
Will remove this test.

>> +'
>> +
>> +test_expect_success 'commit date shows timezone offset +0000 even TZ setting says otherwise' '
>> +        git config user.hideTimezone true &&
>> +        echo test2 >> file &&
>> +        git add file &&
>> +        # TZ setting corresponding to -0600 or -0500 depending on DST
>> +        # unset GIT_AUTHOR_DATE from test_tick
>> +        unset GIT_AUTHOR_DATE &&
>> +        TZ=America/Chicago git commit -m test2 &&
>
> This one is a borderline meh, compared to a test with explicit
> GIT_AUTHOR_DATE getting overridden by the configuration.  It is not
> all that wrong, but I do not see a point in adding cycles to the
> already big testsuite.
>

Will remove this one as well.
