Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A84C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0F960F0F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhHGHQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 03:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhHGHQy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 03:16:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F425C0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 00:16:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a20so10272686plm.0
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 00:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=xScxK+FF0yj1rjAa6/EixoVzrboXz0MSl1GflehUAg8=;
        b=FnNRdaFroQbixD8mVhHG4ipayvIABCbJLQukmCp7wY7/5MMUlq82amE1thER1tUxlJ
         SaTQH4mgFyNyCfs+fksKjYqwNs424Hqgjr+6hjuDvh+UFPD2nwyCZgiuhfUrR0fKXFWI
         2SubgkKjiekHi40QrDQZkfZRNcN40p7Kg8PP6k9fEz9vjQMZbqkBFxqsgtpQYGFt/CzI
         ddu+wRLoiM0h9nJ1CKkuh/GmfrFrcEFsVjohgF/jdKRdqmd0evqIBsPlv9dN3ZOL3N/p
         8m83nuDegYqK2ikdGLcImfJaYBe0c9F349dOvDAGjR/NzivD7koqttGJ4wHsphQg1dyi
         bWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=xScxK+FF0yj1rjAa6/EixoVzrboXz0MSl1GflehUAg8=;
        b=IAcWvCQveX3nf6aqvmzu0L+qnGDNwWJxUs9EhZz6fnyxPxcIPoGArvMLUYJUfs1wr5
         Eb0EjhPm8BNfLa5IT/fqQU9hT4W4rO2/IEEmKFU8Sl6f6uAqJ3bzUmmlMJOQ/Hq67rbO
         /LCgkQs03jEs8KvpIYhhqkEGJ1/kiQTVSxeC6JxH11Kz51QDRHiEKTGTszSM4K50E2zZ
         94QP3PRDIWf/prygB0dPA+BV20YziBhAkNVp3UuJRjqVE117OCjdf2Sfbiw79Akt8PTc
         8srvBsSium4i/wtf4KT45g8b9SFLpvaZ3fzFeb6nUk3AUf1gxc7H19h7wO78HN4fJTU5
         E7tw==
X-Gm-Message-State: AOAM533A5bETl4VxXVPL5GgHVH770VzCQ4OxmjTWlO51RE3M3iRCnqWa
        7xNOz9WdbWMvw1QOA6dToAo=
X-Google-Smtp-Source: ABdhPJzMyXG6VZx7lRdo5eE2mYn8xmI28p2ccc5z4dWKgNoRqf8S6WJqUUZYIsjO888ENalklm6G5Q==
X-Received: by 2002:aa7:8284:0:b029:312:1c62:cc0f with SMTP id s4-20020aa782840000b02903121c62cc0fmr8679650pfm.75.1628320596616;
        Sat, 07 Aug 2021 00:16:36 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b128sm13617811pfb.144.2021.08.07.00.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 00:16:36 -0700 (PDT)
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210805074054.29916-5-raykar.ath@gmail.com> <xmqqim0jk4qx.fsf@gitster.g>
 <m235rmvnc1.fsf@gmail.com> <xmqq1r76jzsk.fsf@gitster.g>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [GSoC] [PATCH v2 4/9] dir: libify and export helper functions
 from clone.c
In-reply-to: <xmqq1r76jzsk.fsf@gitster.g>
Message-ID: <m2lf5dbu92.fsf@gmail.com>
Date:   Sat, 07 Aug 2021 12:45:37 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Atharva Raykar <raykar.ath@gmail.com> writes:
>
>> Naming things is hard...
>
> Absolutely.
>
>> Maybe the right phrase would be 'target directory'? We are creating a
>> target directory name by looking at the "humanish" part of the Git URL.
>>
>> I think the intention of all callers of this function is to get a
>> "default" directory name which will be used as the target of some
>> operation in the absence of the user providing one.
>>
>> So maybe the name could be: 'guess_target_dir_from_git_url()'
>
> I have no immediate objection to the name.
>
> Just to see how people (including you) may react to a name from a
> completely different line of thinking, let me throw this, though.
>
> How does git_url_basename() sound?
>
> Instead of saying what we'd use it for (i.e. as the name for the
> directory getting created), we say what we compute.  We take a
> URL-looking thing that is used by Git, and we compute something like
> basename() but that is tailored for Git (e.g. unlike "basename
> a/b/c.git" that yields "c.git", we give "c" for "a/b/c.git".
> Likewise "<scheme>://a/b/c/.git" won't yield ".git", we compute
> "c").
>
> Having said that, I think guess_target_dir_from_git_url() is clear
> enough.

Even though the name I suggested is clear enough, I liked your
suggestion a lot more. Not only is it more succinct, but it also opens
up the future possibility that the basename of a Git URL might be used
for purposes other than finding a directory name.

>> This would make sense for any operation now or in the future that wants
>> to reuse this functionality.
>
> That is mostly for you to decide.   I can help you sanity check the
> proposed name(s) with existing callers, but you'd be a better judge
> for callers you'll be adding ;-)
