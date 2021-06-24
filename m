Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE81C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25E2613EE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhFXTZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhFXTZp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:25:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620BEC0613A2
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:23:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r3so203667wmq.1
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SGGWU0PPKqDGfkN26MfaDYRTkxBPDE3Au9bB8xP8iOY=;
        b=Kj8uG9A+eyk4exU/He1oxhOnrH176NwUIzAQLbV8ZPOF/Ty0iF52m9nPsGOQZAo5yC
         eVeOmgsZ+My5ML+r60qPPo7co9u+wo1tWlypMBbHQO3cNuMdefVnX+s350z5OZNsFmGt
         4hyV6JmPltOEUSlVctrVhq1qmidp9YaK54qvFYGy1+NIhoMr6ca/NR2MD6slY1Cha2ve
         SqsSeRXdfObKvAg5/4pr3VBjtfRvcREe5sEMABMLRJRd4ZIq1nP7dFmqdPA2mAoiDj0O
         FcuiopkOVDwTVvMjqmGcNyJAAozxuOacppj60GpqluVRhce4UhnO1ZZfIPBvALmH0ajn
         O1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SGGWU0PPKqDGfkN26MfaDYRTkxBPDE3Au9bB8xP8iOY=;
        b=KkjApG6fY93tUgdrJSHH86seRvLBtiO/5SOPLSdULl+Qkdpp7c1Mcd+voy5PBhhRae
         k8AX8Oo780e5TV6bCiWBrl3875p3dLYOpQ3aBtVSjeU9LOV7TZCfRo69PNBz6z006UuL
         74wnA7I7M+IvaPgL1gJHmXy8rDK4SFug7GDE7aZzCJ3Upu2PMp2VPJeBzr/CqaRQT3rS
         l6fxsuwdjRCNRFwiSYehQjTm78tPF72Is24DYwzqm/2faeNny9r+IlMlFS+TGKis27hy
         QQO2DCShNQRdcbi/LV7LAFC1k8lC3SC+tXeDb3F0Y8PVm34pHJzZpCeCoJfFeI7itjDo
         +M9A==
X-Gm-Message-State: AOAM530qt3luboaa/SxGV3ccexA7O31ia6bNavi3p70FeepDF+q0A3QS
        FqsI7Yt4KI6bNjwUwfGO4K0=
X-Google-Smtp-Source: ABdhPJyQPZptpHy3AzBdodo8UsJCR9pGXeekvZvGM8rIvBc8wkstazAXw54sxsZZFofOJLqcLHnXTg==
X-Received: by 2002:a05:600c:1c87:: with SMTP id k7mr6207101wms.168.1624562598002;
        Thu, 24 Jun 2021 12:23:18 -0700 (PDT)
Received: from [10.17.18.5] ([46.246.3.237])
        by smtp.gmail.com with ESMTPSA id e8sm3965411wrq.10.2021.06.24.12.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 12:23:17 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] test-lib-functions: introduce test_line_count_cmd
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
 <20210619013035.26313-2-congdanhqx@gmail.com>
 <54bf7756-5578-4fe4-dbe5-f63b368c4d63@gmail.com>
Message-ID: <6ad6ac5a-18ac-102e-29dc-3c0987de08e7@gmail.com>
Date:   Thu, 24 Jun 2021 21:23:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <54bf7756-5578-4fe4-dbe5-f63b368c4d63@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/06/2021 11:08, Andrei Rybak wrote:
> On 19/06/2021 03:30, Đoàn Trần Công Danh wrote:
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index f0448daa74..e055a4f808 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -845,6 +845,86 @@ test_line_count () {
>>       fi
>>   }
>> +# test_line_count_cmd checks the exit status, and the number of lines in
>> +# the captured stdout of a command.
>> +#
>> +# SYNOPSIS:
>> +#
>> +#    test_line_count_cmd <binop> <value> [!] cmd [args...]
>> +#
>> +# Expect succeed exit status when running
>> +#
>> +#    cmd [args...]
>> +#
>> +# then, run sh's "test <# of lines in stdout> <binop> <value>"
>> +#
>> +# OPTIONS:
>> +# !:
>> +#    Instead of expecting "cmd [args...]" succeed, expect its failure.
>> +#    Note, if the command under testing is "git",
>> +#    test_must_fail should be used instead of "!".
>> +#
>> +# EXAMPLE:
>> +#    test_line_count_cmd -ge 10 git tag --no-contains v1.0.0
>> +#    test_line_count_cmd -le 10 ! grep some-text a-file
>> +#    test_line_count_cmd = 0 test_must_fail git rev-parse --verify 
>> abcd1234
>> +#
>> +# NOTE:
>> +# * a temporary file named test_line_count_cmd_.out will be created 
>> under
>> +# $TRASH_DIRECTORY/.git/trash iff $TRASH_DIRECTORY/.git/ exists.
>> +# Otherwise, created in $TRASH_DIRECTORY. This temporary file will be
>> +# cleaned by test_when_finished
>> +test_line_count_cmd () {
>> +    {
>> +        local outop outval outfile
>> +        local expect_failure actual_failure
>> +        local trashdir="$TRASH_DIRECTORY"
>> +
>> +        if test -d "$TRASH_DIRECTORY/.git"
>> +        then
>> +            trashdir="$TRASH_DIRECTORY/.git/trash" &&
>> +            mkdir -p "$trashdir"
>> +        fi &&
>> +        if test $# -lt 3
>> +        then
>> +            BUG "missing <binary-ops> and <value>"
> 
> Nit: s/binary-ops/binop/ for consistency with documentation comment
> above.  Also, technically the invocation of test_line_count_cmd could be
> missing any of its required three parameters, including "cmd".  How
> about something similar to the call to BUG in test_i18ngrep:
> 
>      BUG "too few parameters to test_line_count_cmd"
> 
> ?
> 
>> +        fi &&
>> +        outop="$1" &&
>> +        outval="$2" &&
>> +        shift 2 &&
>> +        outfile="$trashdir/test_line_count_cmd_.out" &&
>> +        if test "x$1" = "x!"
>> +        then
>> +            shift &&
>> +            expect_failure=yes
>> +        fi &&
>> +        if test $# = 0
>> +        then
>> +            BUG "test_line_count_cmd: no command to be run"
>> +        else
>> +            test_when_finished "rm -f '$outfile'" &&
>> +            exec 8>"$outfile"
>> +            # We need to redirect stderr to &9,
>> +            # and redirect this function's 9>&2
>> +            # in order to not messed with -x
>> +            if ! "$@" >&8 2>&9
>> +            then
>> +                actual_failure=yes
>> +            fi
>> +        fi 8>&1 &&
>> +        case "$expect_failure,$actual_failure" in
>> +        yes,)
>> +            echo >&4 "error: '$@' succeed!" &&
> 
> It seems that function error() could be used here and below instead of
> "echo >&4".

After spending some time reading t/test-lib-functions.sh, now I don't
think that using error() is a good suggestion.  Closest relatives of
test_line_count_cmd -- test_line_count and test_must_be_empty -- both
just use "echo".  Other usages of error() in t/test-lib.sh and
t/test-lib-functions.sh suggest that error() is not meant to be used
for reporting test failure messages, but internal failures. For example:

	error "You haven't built things yet, have you?"

and

	error "Internal error: $stderr disappeared."

> s/succeed/succeeded/ --- it might be worth borrowing wording from
> test_must_fail().  Something like:
> 
>      error "test_line_count_cmd: command succeeded: '$@'"
