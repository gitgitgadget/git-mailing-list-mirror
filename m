Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C69FC2D0A8
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 07:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487962075F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 07:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmNuBBS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgI3Her (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3Heq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 03:34:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87624C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 00:34:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gr14so1377560ejb.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 00:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ltBvfQsocKo/CIe7ptFzZUr+Drc+dEd5uBChDmR5psg=;
        b=fmNuBBS6gxvcJc+rS6HmO01b4uFAkSD5QFXhI2sk/BiNanpsK1xmXjiizWP4XRNvyX
         3wOxsO5nHxg8ux0+NVib+eWiqQLtZ2Hi/Ux1bbmyIheHKCzuXVzsX+XY1OqiS9ujB+Ot
         T360xn0l1bXB2OOYMVXFOEfs24CbrNIWZ5/64muX2fLs8Z4JPwvgxX0gnmNMy02+JX59
         0B89urgU3EOnGjcHPMjX9exwsyBhQb5j4KSfBWvgoD61kFsnlM2/LVzgP4GgHBpr/tg9
         Q11zS6LTJQcrefb5QKUhYERl+rGQ81XhcJgQep4XzXs1eOR1rea2/3EpXq1F/poyY6PB
         9zdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ltBvfQsocKo/CIe7ptFzZUr+Drc+dEd5uBChDmR5psg=;
        b=IfJrLxtvNkJjOhmNOGDLoESuxbsOIZrRIUsDBKfHomIndk09Ql4YOfIz63okNUmVYL
         7qHZeeD75f96mr5xB8E7atO0qmSrAbBOENdsIhv4pxtvszgKN0IAh7QrIaAI1NZRw199
         +3vdzVVxtbE+hn2ArBWIpx5basvOPwrZsRQImplbgtwHLE8bMGdK1093cntS1Ou8sm0x
         5JsFw1J+uWV6LkJ7OV+luZyWsvFY2p8pWA6fTihyUB7miwErZDakBqZcCAnEjqUAVgeL
         ec2wTVtezugcl41f1gHRxn+oysX122CdnD5uuX+BldmVylIplLw7mKK7ShNiXeKAZ9Um
         WOTA==
X-Gm-Message-State: AOAM531a66ST+OVUakBkAlQyySuchGJGidGM0azGZP0KhMHbWwpodp0O
        ReF5eqIa1UXUv/uwrpU6XgijRwdBnYC1
X-Google-Smtp-Source: ABdhPJy72WTeHKKKfU7YG/cQrRWCp6Ef6WHMbUyFbMBDdOy5RDvsWk8bcYftgk/3JsiHGPf/ZWzShg==
X-Received: by 2002:a17:906:6a52:: with SMTP id n18mr1497360ejs.58.1601451283503;
        Wed, 30 Sep 2020 00:34:43 -0700 (PDT)
Received: from [192.168.73.147] ([212.55.198.55])
        by smtp.gmail.com with ESMTPSA id nm7sm792234ejb.70.2020.09.30.00.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 00:34:42 -0700 (PDT)
Subject: Re: GIT_DIR output from git worktree list
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <CAA9rTudStQOK7kRa6jYJHE3D3grnFF3idQe65h9t6oJB30xa1A@mail.gmail.com>
 <CAPig+cTwNwt+_f4FYDqy5xVsDVU3pqfKXtK6GKtWLLqbU6Y8Vg@mail.gmail.com>
From:   =?UTF-8?Q?Gabriel_N=c3=bctzi?= <gnuetzi@gmail.com>
Message-ID: <335b6e6a-9527-5444-da80-08faf43db606@gmail.com>
Date:   Wed, 30 Sep 2020 09:34:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTwNwt+_f4FYDqy5xVsDVU3pqfKXtK6GKtWLLqbU6Y8Vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.09.2020 um 07:33 schrieb Eric Sunshine:

> On Tue, Sep 29, 2020 at 1:31 PM Gabriel Nützi <gnuetzi@gmail.com> wrote:
>> When you do move the .git folder somewhere else:
>>
>> git init Test && cd Test && mv .git .git-b
>> git --git-dir=.git-b --work-tree . worktree list
>>
>> the output is :
>> ..../Test/.git-b  0000000 [master]
>>
>> Why is the output a .git Dir and not a worktree. I expected `.../Test`.
> Because the implementation doesn't really look for or know where the
> main worktree is. Instead, it's taking the path of the repository and
> stripping off "/.git" if present, and reporting that as the main
> worktree. Under normal circumstances this works just fine because
> either (a) the repository _is_ the .git directory within the main
> worktree, or (b) it's a bare repository and there is no main worktree,
> thus it reports the repository path instead of the non-existent main
> worktree.

Ok, it's kind of sad that as far as I understood, there is probably always only this heuristic about stripping ".git"
because the main worktree path is not registered inside the .git dir or somewhere else.
I mean you can technically name the git directory what ever you want and in that case how is that stripping than going to work?
But of course when you do so, you probably need to set either GIT_DIR, or or use --git-dir

Also what I realized is, isn't the doc a bit inexact about GIT_DIR:

> GIT_DIR is the location of the .git folder.

Shouldn't it read: GIT_DIR is the path of the .git folder. Location could mean its the parent folder? Hm...

> I suppose one way to fix this would be to specially check if
> --work-tree or GIT_WORK_TREE is specified and use that value as the
> path of the main worktree. (This special case would only be used when
> computing the main worktree path; it would not be used when computing
> linked worktree paths.)

Probably, --work-tree, GIT_WORK_TREE or core.worktree.

Thanks Eric!
BR

