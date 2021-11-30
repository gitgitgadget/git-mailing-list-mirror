Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A8C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhK3LNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbhK3LM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:12:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D10C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:09:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o13so43411484wrs.12
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i+uGDBasPeOWTwE3YemBgpCPycWGtPoYQVrFRVFwkuA=;
        b=i4QYMhJos2fjztWWIG4UHGJcO/RUCl981AfcCyeiqPidsqdpwXVKhR9s1uDBH9XsSc
         DJvt1rTSxy4+tXABMqKhMBnERLk4KJQ4poecoEiftRzviZAZcvNPtsFxUYQrItQJPGQj
         yCjqJzteZuwzXgRSEfBwqw6oSDUbh6K8dg+yeORDp7gWx+XVFTDzSj8yTBNPCkySO+Ms
         SaZYUyLtiRrJj9MDfYp6TlE34b/XysDYoMgQ6CUy5EA+eeLU3C8u6C3xS4nTUn0VtUfY
         iiuy7TbUBlYLXVR8LOxg/3DUxwkOhLVmSWDNwkChGj7Qr1F0QFKkADzccvQGA4YaLarg
         TtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i+uGDBasPeOWTwE3YemBgpCPycWGtPoYQVrFRVFwkuA=;
        b=epHm34adXuViFtquZ8LAHU1cRMQriKaXLJjbzFS3JSOhn8Ol+jN4bByKdItVl0vrDt
         TJPTQmkUrrRzBOh16RljFKkJulHPQhsev2LMVE7u6JiRgbrVirR3oLo7wsXdF+SSm09e
         y1D6SAHitytWLFpeOImzMyz7XF70xckNGeGvRoOXjxcV+Q6xuEOkosiki3aLCqFnp4KZ
         aXvWR2d8ZqUgucQDVdlZWUVcUQjpbtE9u2BenUt4YZrQJZXl2Cz4xFFst1TT11lS2Nf6
         5ifM66Tcn4TtVI2AlhDMb0NWhX46UJlYw3ezW98YYRGAyocqceOEDrcZXVQ17w+K2EyS
         aLMA==
X-Gm-Message-State: AOAM532fBUiT3f7vXIfEPiVZlnkf1SXf1ovTfEAxZnt9x3nrKG/dewKu
        gjFWWbFsNCMcKDGz5UVHdKGteoThzB8b/g==
X-Google-Smtp-Source: ABdhPJxi74eJzLhLQC1rk/2tPHR0MB8pKlI3tS0mipOZhpzRO7AahiE+ch80l6ho6VVE0DUg7sIHXg==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr39666322wrj.589.1638270575282;
        Tue, 30 Nov 2021 03:09:35 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id e3sm16361024wrp.8.2021.11.30.03.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 03:09:34 -0800 (PST)
Message-ID: <e22ef3c3-ee3e-d700-720c-71339abc19c0@gmail.com>
Date:   Tue, 30 Nov 2021 11:09:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG REPORT] `git rebase --exec` shouldn't run the exec command
 when there is nothing to rebase
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Nikita Bobko <nikitabobko@gmail.com>
Cc:     git@vger.kernel.org
References: <CAMJzOtyw78-8gt3oGscN7KUzpzRRWtAQuGfcJ+R_Fjoom9Lexw@mail.gmail.com>
 <211129.868rx7gnd5.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <211129.868rx7gnd5.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/11/2021 12:07, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Nov 26 2021, Nikita Bobko wrote:
> 
>> Steps:
>> git rebase HEAD --exec "echo foo"
>>
>> EXPECTED: since 0 commits are going to be rebased then I expect "foo"
>> NOT to be printed
>> ACTUAL:   "foo" is printed
> 
> I don't think this is a bug, but explicitly desired behavior. When you
> do:
> 
>      git rebase -x 'make test' BASE
> 
> You expect to run 'make test' for all of BASE..HEAD inclusive of
> "base". E.g. for HEAD~1 we'll run 'make test' twice, and you know both
> your HEAD~ and HEAD passed tests.

I don't think we run 'make test' for base in that case, only after each 
pick and base is not picked by the rebase.

Best Wishes

Phillip

> So why wouldn't doing the same for HEAD make sense?
> 
> That being said perhaps some users would think an option or
> configuration to skip the injection of "exec" after "noop" would make
> sense in that case.
> 
> But does this really have anything per-se to do with --exec? Wouldn't
> such an option/configuration be the same as rebase in general dying if
> there's no work to do?
> 
> And wouldn't such a thing be more useful than a narrow change to make
> --exec a NOOP in these cases?
> 
> E.g. if I've got a "topic" that has commit "A", that's since been
> integrated into my upstream and I have a script to "make test" on my
> topics, won't simply dying (and thus indicating that the topic is
> dead/integrated) be better than noop-ing?
> 

