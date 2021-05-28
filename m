Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DFDC4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 07:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12BCE613B6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 07:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhE1Hpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhE1Hpk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 03:45:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53193C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 00:44:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l3so3971293ejc.4
        for <git@vger.kernel.org>; Fri, 28 May 2021 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y7cG7kgDYQ7ejAqoW+jsRLOWht3EcFUv6GlR6DuZQ1Q=;
        b=Uqm7vA9qRQTzZ9JC+2F1ma8yAO6UOrx75LdHudykpgSMcbCu6/x2UzXIoSINe2M69B
         q6i22xHaM3aapbtknD8/2nx0aJTxJn/FKp2pJvty/s7SjdtfYXTmGgBbccCkvMt19yE5
         ehTqTbjQ+naCITqfPv2iKLd+pT/1/Isl2+k5yQ6fnDP5u3d2xHBOTANRkjVkIbRIKzBn
         jkC0yWXwGQ6Q1Tf67coYPPFq5SBoIZy0YeikRoJLMj+kkTQuCLj+dcX0Bn3Q+3aIs/UH
         ZKWpXSF5+7k2iI9dfnyCMTFAynunvKHdFjUgr6Wvivqqk5ttzh5OWekacfby9M45fffc
         3ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y7cG7kgDYQ7ejAqoW+jsRLOWht3EcFUv6GlR6DuZQ1Q=;
        b=ctFsSiuZ42+pkcakcwtccL+9vNIm5CbkQWh8p5fgr/GxxxF6XxqZCgLBH5zipvQBFS
         KP/nNV7SDM99ygExp1awuwhJiL2JprTU7izYh63BlsZmpqogW89bebK+x8LMct8iu54L
         ELFmLM8MrSF8mhY3GXa9AMv+q1VPBWYpu4l22ZMwiRpzYezL4e6fw09mavDEATe2q2bB
         rKQ1fIx2kxnri+p379GZH9jID3KqINQ+BFBKJe+KQtqyxMpn3JSsgiTlvp25W8yNtXq3
         AK19K9lXXNSQYS6U4yW9L7lI0tNDXao0PAs++PXpBsCxW/Y4728aA+XV06uBzpS0iOm3
         +wXg==
X-Gm-Message-State: AOAM531Sbll685lTKI3Gvlz4jg8OYY/lRqaDO18e3EoxbFBvkb0aE8wn
        lUmA+v2nJgNe2mNVhz7VE+1ovFTYZk4=
X-Google-Smtp-Source: ABdhPJxlRaSXsqb8VVgZZUDBtWLkgYIWbEHlk9pdIoWG1d37HiX5kyEd+PuQdjbjcsrLbY/hXINk0Q==
X-Received: by 2002:a17:906:26db:: with SMTP id u27mr7917582ejc.532.1622187842968;
        Fri, 28 May 2021 00:44:02 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:b0b8:f178:ae9f:6d19? (2a02-8388-e002-8cf0-b0b8-f178-ae9f-6d19.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:b0b8:f178:ae9f:6d19])
        by smtp.googlemail.com with ESMTPSA id kx3sm1955859ejc.44.2021.05.28.00.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 00:44:02 -0700 (PDT)
Subject: Re: git push doesn't use local branch name as default
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
 <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
 <CABPp-BEeqqGwN3=MbWCYnsyryBm3WoaX5GZyXTWy18UiYUT4zg@mail.gmail.com>
From:   Mathias Kunter <mathiaskunter@gmail.com>
Message-ID: <f9f38d42-2b93-0d3b-798b-4c6f44eb111d@gmail.com>
Date:   Fri, 28 May 2021 09:44:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BEeqqGwN3=MbWCYnsyryBm3WoaX5GZyXTWy18UiYUT4zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> you only get the "current" behavior when fetch_remote is non-NULL.

Well, then my suggestion actually is to also use the `current` behavior 
when fetch_remote is NULL - i.e. change

> return (fetch_remote && fetch_remote != remote);

to

> return (!fetch_remote || fetch_remote != remote);

I'd argue that if `simple` pushing is used, then the expected behavior 
of the command

> git push <remote_name>

on a branch without upstream would actually be to use the `current` 
behavior instead of bailing out with an error.


Am 28.05.21 um 09:00 schrieb Elijah Newren:
> On Thu, May 27, 2021 at 11:39 PM Mathias Kunter <mathiaskunter@gmail.com> wrote:
>>
>> Felipe,
>>
>> thanks for your reply.
>>
>>> Sounds like you want to change the default to `push.default=current`.
>>
>> Yes, but shouldn't `simple` pushing also work? The documentation says
>> about `push.default=simple`:
>>
>>> When pushing to a remote that is different from the remote you normally
>>> pull from, work as `current`.
> 
> Perhaps this wording should be clarified to read
> 
> When you have a remote that you normally pull from but you are pushing
> to a different remote then that one, then work as 'current'.
> 
>> If there is no upstream, then there also is no "remote I normally pull
>> from", and thus, according to the doc, `simple` should actually work
>> like `current` in this case. Am I wrong here?
> 
> The relevant code is
> 
>      return (fetch_remote && fetch_remote != remote);
> 
> so you only get the "current" behavior when fetch_remote is non-NULL.
> 
