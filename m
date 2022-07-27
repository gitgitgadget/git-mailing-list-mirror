Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5140C19F21
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 09:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiG0JOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 05:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiG0JN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 05:13:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97519474F0
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:11:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p5so9581611edi.12
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=hQ00g+ud6VkMxPFbxHkW2076OCnG6saA8jq5ZuhwosI=;
        b=kghgHbDdN0HfHjB6DKZAT6P3b9K/nhHPgS4Xj8RpumO+A1Knd0hV7oIfBuGmSQk7dZ
         qPXUOay9zbLkbTpZcacUmuUGKirCRgGuBz8xMI+wse+wUs8kDdJ6cJ9SYZJbP/JcdSnF
         IHQqH+zDjydxwN6dTAj2NsPKzqgk+Lf8eUOdZ0CbWkG+l0EKPTHIqZiI/0AR4maiOh0H
         U+Glhem+2VdQXyKNRUMR/0brfZDUJN6312k8K3B7sdqfqPwHoy5yiVrxVDd/h+BJwlwC
         dFUwZZHVG47CT+5VxvQZFaOklpVS3Il9aA2XfYjNW9MTWly5ri3w4msFqyQroWzX20e5
         eNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=hQ00g+ud6VkMxPFbxHkW2076OCnG6saA8jq5ZuhwosI=;
        b=Ev8pxu4LVM2Xbs4hvYEz4xj54TJgklpOuDSJRuQkOHAGkmO88A66U3L2R+2q2cDIHh
         AhmHDc8XAKyfVwrYLLkzU513fl7EZiX+uz7wMLZ0diJiHZjz2kYRYQSm8cgYTVfob6uQ
         uP+/hO9zGYCWTpAoYBl9QY3HbHiMPdA5ooHauAekLPR8I95SJS+LhM9RpX861iBShZ82
         88CH49Y/tGwmnpRZtIEnkGHM3eF/+Xhlbr3Xbr+SAre3AyaBlfcmwI8+9jsykGba2TPw
         +7vvFoMflHS+edU+s1srzY1TdxkMWMfIbLZBqQ2lyNzOwBVz0aHh/ylIBlSAFU082JtR
         /B2w==
X-Gm-Message-State: AJIora+HKiliDoakjmVdU3JF4TodRULpglJmeRotbcC13jJaKWnJjO/J
        U/m/VfJW6sFGYdhOxqis09o=
X-Google-Smtp-Source: AGRyM1tO3QltXChIeS3iNjGHFQAyk441uoukB8whrg5lt+XISnEe1B/f6ZZI+OopBgiJWFjuKAi1qA==
X-Received: by 2002:a05:6402:1117:b0:43b:c965:549e with SMTP id u23-20020a056402111700b0043bc965549emr22054362edv.366.1658913091009;
        Wed, 27 Jul 2022 02:11:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906288300b0072f3efb96aasm7376223ejd.128.2022.07.27.02.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 02:11:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGd4j-006axw-Lx;
        Wed, 27 Jul 2022 11:11:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] config.c: NULL check when reading protected config
Date:   Wed, 27 Jul 2022 11:08:36 +0200
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
 <220726.864jz3n0uf.gmgdl@evledraar.gmail.com>
 <kl6lfsinskzm.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lfsinskzm.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220727.86zgguly2m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Jul 26 2022, Glen Choo via GitGitGadget wrote:
>>
>>> From: Glen Choo <chooglen@google.com>
>>>
>>> In read_protected_config(), check whether each file name is NULL before
>>> attempting to read it. This mirrors do_git_config_sequence() (which
>>> read_protected_config() is modelled after).
>>>
>>> Without these NULL checks,
>>>
>>>  make SANITIZE=3Daddress test T=3Dt0410*.sh
>>>
>>> fails because xdg_config is NULL, causing us to call fopen(NULL).
>>
>> FWIW a lot more than that fails, that's just the test I focused on for
>> the bug report, the others ones (I didn't check out all of them) all
>> variants of that.
>>
>> See https://github.com/avar/git/runs/7519070124?check_suite_focus=3Dtrue
>> for the current failing run with that "[2]" patch you quoted. We fail a
>> total of 14 test files (and many more tests within those files).
>
> Ah thanks, I'll amend the message accordingly.
>
>>> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>> Signed-off-by: Glen Choo <chooglen@google.com>
>>> ---
>>>     config.c: NULL check when reading protected config
>>>=20=20=20=20=20
>>>     This fixes the SANITIZE=3Daddress failure on master, That was intro=
duced
>>>     by gc/bare-repo-discovery. Thanks again to =C3=86var for the origin=
al report
>>>     [1] and for proposing a way to catch this in CI [2].
>>>=20=20=20=20=20
>>>     [1]
>>>     https://lore.kernel.org/git/220725.861qu9oxl4.gmgdl@evledraar.gmail=
.com
>>>     [2]
>>>     https://lore.kernel.org/git/patch-1.1-e48b6853dd5-20220726T110716Z-=
avarab@gmail.com
>>>
>>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1=
299%2Fchooglen%2Fconfig%2Ffix-sanitize-address-v1
>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1299=
/chooglen/config/fix-sanitize-address-v1
>>> Pull-Request: https://github.com/git/git/pull/1299
>>>
>>>  config.c | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/config.c b/config.c
>>> index 015bec360f5..b0ba7f439a4 100644
>>> --- a/config.c
>>> +++ b/config.c
>>> @@ -2645,9 +2645,12 @@ static void read_protected_config(void)
>>>  	system_config =3D git_system_config();
>>>  	git_global_config(&user_config, &xdg_config);
>>>=20=20
>>> -	git_configset_add_file(&protected_config, system_config);
>>> -	git_configset_add_file(&protected_config, xdg_config);
>>> -	git_configset_add_file(&protected_config, user_config);
>>> +	if (system_config)
>>> +		git_configset_add_file(&protected_config, system_config);
>>> +	if (xdg_config)
>>> +		git_configset_add_file(&protected_config, xdg_config);
>>> +	if (user_config)
>>> +		git_configset_add_file(&protected_config, user_config);
>>>  	git_configset_add_parameters(&protected_config);
>>>=20=20
>>>  	free(system_config);
>>>
>>> base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
>>
>> Re your claim in
>> https://lore.kernel.org/git/kl6lzggwsyh1.fsf@chooglen-macbookpro.roam.co=
rp.google.com/
>> I tried testing this, and came up with the below.
>>
>> I wonder if we should work in here for general paranoia, but I'm not too
>> familiar with the this part of the config reading, maybe we're confident
>> enough that these are invariants within the process.
>>
>> This will BUG() out if these variables change within the process, which
>> would mean that our caching assumptions are no longer true, which would
>> cause you to return the wrong data here.
>>
>> Of course you'd have segfaulted or similar before, but this should
>> demonstrate that not only are these sometimes NULL, but that they stay
>> that way.
>
> Interesting, this is worth proposing, but I suspect that the
> conversation will be long enough for this to be its own thread. Surely
> someone must have given some thought to this, especially for long-lived
> processes (git-daemon?).
>
> There's also the general question of config cache freshness, e.g. what
> if another git process writes to a shared config file? (We don't worry
> about the single process case because the process will invalidate its
> own cache).
>
> Perhaps we should also worry about that (probably more common) case in
> addition to this one? At any rate, that seems like a bigger topic than
> this fix here.

We can leave it for later, I've run it as a one-off and didn't have any
failures.

But FWIW I think it's tied up in this fix here, i.e. your original code
both added caching, and implicitly assumed that these were never NULL,
so it was "obvious" that it didn't need such assertions.

But now we have 3x if's in a code path that's cached, and the cache is
*not* guarded by the same 3x checks.

So we can leave it for later, but it really seems worth adding some
self-documentation here sooner than later.

This BUG() method I came up with is one way, another would be to strdup
it and use a "static" variable in the function, i.e. stick with whatever
value(s) we start out with.

But in any case, this fix seems correct, and fixes the current issues
SANITIZE=3Daddress is spotting for us, thanks!
