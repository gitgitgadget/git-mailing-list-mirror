Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE43C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F245601FC
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhFVDsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFVDsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 23:48:03 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B98C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:45:48 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c23so525017qkc.10
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RfwAQ72WiGWOr1jqtffh8LT5WdnFVdkDre78lxD9FZs=;
        b=oBqc7xZXnU1RvvHNALnarzA+F+55hcS4k9Ne0UBYVaTnAmOD+QVeQEF3TzZLfYlzh6
         NK84WMytVt6tJslR5hhNqhJd1j4HdAefaijJQI46P1Buevnze00BrS+hsV1n5Hlwx1M9
         K+KW5byK/sd5Tn9bTdeMlN1HgEM6A02FRErFvrXgRzONr5qAkxNkmOqNssfnacb/gvAb
         ERAPzepCEtIa3tCeiZo/OlNZLCaFoYOt35FMBh4r3qTkuRDObPk75pJqBSIvpRwrwEkW
         OqaabHUp55tZlBENIjjDbn+itPD5CrxzDttbaR6PJsjS4pwEZUBealyHuXlKVGPX6jdT
         zjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RfwAQ72WiGWOr1jqtffh8LT5WdnFVdkDre78lxD9FZs=;
        b=H8VrRZZAov3A4ETe/pYgpNspFBqrkvIv/RAgEAaM4fGOsxqTZ7VfnnxYBIMyMeYMTz
         q70NvGx3tipuBV+CuRvIaq4ikwbCj9VPVc5CZhCKwEnpd9Yp4/BHRrxqiK4bjxI3Ctk4
         9JowsU8BD9upCDMkToCXnH5gAe2TiU1y+lom9S83IiKLSLqhQE/e2uvuTkR6YOLw1JeJ
         uU+sk3ZrcQ7JhCvkKWy982MfPWiXxEtt53RZwk3gEsPFtbYoUlXAgxrBcUtUcJ3fE9Tf
         fh/av5sBVDjEvYSVSRoimt6kLUkc5GsP02MKCBxGrT/MoqmXjJ7SCl4hgYGv6wdZX0KI
         EbRg==
X-Gm-Message-State: AOAM5337NYhfDlkkJunKWA4zDo3fe5r0e+WBxj4to5VzgqJK07bJdir2
        Ob/ft8w1R4MAMcztOu3SPOw=
X-Google-Smtp-Source: ABdhPJy76WE2GclTKQzWqosai06HE0HkmhKuAeZYECFmhReWGsmoQ50xE17FrdqlYRPPNhJZA+yg2g==
X-Received: by 2002:a37:9d93:: with SMTP id g141mr2139309qke.350.1624333547209;
        Mon, 21 Jun 2021 20:45:47 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id b7sm912678qti.21.2021.06.21.20.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 20:45:46 -0700 (PDT)
Subject: Re: [PATCH] submodule: mark submodules with update=none as inactive
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Rose Kunkel <rose@rosekunkel.me>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <YMvgRjwyrwyLz4SC@camp.crustytoothpaste.net>
 <20210619214449.2827705-1-sandals@crustytoothpaste.net>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <56b5c722-8baf-9f9c-cc9f-5b5ed49d7fc3@gmail.com>
Date:   Mon, 21 Jun 2021 23:45:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210619214449.2827705-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

Le 2021-06-19 à 17:44, brian m. carlson a écrit :
> When the user recursively clones a repository with submodules and one or
> more of those submodules is marked with the submodule.<name>.update=none
> configuration, the submodule will end up being active.  This is a
> problem because we will have skipped cloning or checking out the
> submodule, and as a result, other commands, such as git reset or git
> checkout, will fail if they are invoked with --recurse-submodules (or
> when submodule.recurse is true).
> 
> This is obviously not the behavior the user wanted, so let's fix this by
> specifically setting the submodule as inactive in this case when we're
> cloning the repository. 

I'm not sure we want to fix it only at (recursive) clone time. The original bug report
was with 'git clone --recurse-submodules', but a non-recursive clone
followed by the usual 'git submodule init && git submodule update' (or
in one step 'git submodule update --init') would also lead to the same
bad experience (I'm not sure I want to call it a bug per se... it's certainly
a UX bug :)

> That will make us properly ignore the submodule
> when performing recursive operations.
> 
> Note that we only do this when the --require-init option is passed,
> which is only passed during clone.  That's because the update-clone
> submodule helper is also invoked during a user-invoked git submodule
> update, where we explicitly indicate that we override the configuration
> setting, so we don't want to set such a configuration option then.

I'm not sure what you mean here by 'where we explicitely indicate that we
override the configuration setting'. For me, as I wrote above,
'git clone --recurse-submodules' and 'git clone' followed by
'git submodule update --init' should lead to mostly [*] the same end result.

If you mean 'git submodule update --checkout', that indeed seems to sometimes override the 'update=none'
configuration (a fact which is absent from the documentation), then it's true that we
would not want to write 'active=false' at that invocation. As an aside, in my limited testing
I could not always get 'git submodule update --checkout' to clone and checkout 'update=none' submdules;
it would fail with "fatal: could not get a repository handle for submodule 'sub1'" because
'git checkout/reset --recurse-submodules' leaves a bad .git/modules/sub1/config file
with the core.worktree setting when the command fails (this should not happen)...

In any case, that leads me to think that maybe the right place to write the 'active' setting
would be during 'git submodule init', thus builtin/submodule--helper.c::init_submodule ?
This way it would lead to the same behaviour if the clone was recursive or not,
and it would not interfere with 'git submodule update --checkout'.

[*] I say 'mostly' because in the first case you end up with a 'submodule.active=.'
configuration, and no 'submodule.$name.active' configuration for each submodule,
whereas in the second case, there is no 'submodule.active' setting and
'submodule.$name.active' is true for each submodule.

> 
> Reported-by: Rose Kunkel <rose@rosekunkel.me>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   builtin/submodule--helper.c |  5 +++++
>   t/t5601-clone.sh            | 24 ++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)

I think that such a change would warrant a mention in the doc, in
gitsubmodules [1], git-config [2], and probably git-submodule [3] if we agree that
'git submodule init' is the right place to set the 'active=false' flag.

Thanks for proposing a patch!

Philippe.

[1] https://git-scm.com/docs/gitmodules#Documentation/gitmodules.txt-submoduleltnamegtupdate
[2] https://git-scm.com/docs/git-config#Documentation/git-config.txt-submoduleltnamegtupdate
[3] https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-init--ltpathgt82308203
