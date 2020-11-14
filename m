Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D223C63697
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 18:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F57D2224F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 18:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCIVxnzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKNSUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 13:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKNSUs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 13:20:48 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B9AC0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 10:20:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id f20so18556198ejz.4
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 10:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=raNIEZ+7d9o+7UlXECxKnkWinHHfkDe8Z7czd800300=;
        b=ZCIVxnzwVuUR8IYHs2Zm/wnr5HJLoKvlS9wzMc2665oh9y6r0C3cnEq0NiumYvFbt/
         GsOaKYrnF5Ejv0ZFENFhaSHoor+l/60MoubiaVmH8p5Nx6thV6EUsznoukxLYqBbUGK9
         G0QUWOs4T04EclkWzutsGJIv0PmsYWdZebDp3S2VzJOEZqsIyR+vssoYeLqJW6AUY3sU
         9aE3wxGVSHLO42A8sMImmHAV1lCAxrqxUxcdkzaPttwRzcxarUJvMb1SH2Q6C/DpuOgU
         fSMSFgbcirXxZXHBNdViNkeB3zedyDF0rOuAavWmZcctQvzYMmRunMRyo8AmKn859MGy
         AWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=raNIEZ+7d9o+7UlXECxKnkWinHHfkDe8Z7czd800300=;
        b=E8uJcaalxwfLMIk/TE8Jh4CqomZG6RP46wWXJTmEr6QvE/0pd+sDPovfv64Bz5l/Fn
         TGga6ud2KwIRaKKRaVMRCjnZV76MaA333yGKL61wTZoNuZPuWuI8vea3wahjR9wo/7HB
         p4tTnE4drSDUiw560WLntgbQ9UTkf02AVXTgpkeVS0IuvHjAC9PkwDvk6nsEZMKZDFVt
         ACr1vx6W4oDUL7ogrQJzf3wi+qbwZW0/5CT3l11vQ8bS3UvNMnaHGVvd7ibM5uZJ/MY2
         3Hb3uIQ8BH3hzeHdskV8yifuoIaufHnuGqFnvOHUtYTzS4PbjI1pwN7MnMvBK9uRvZVu
         q9vA==
X-Gm-Message-State: AOAM532QJoBdYt7f4Ud31Ld86uxP5VPEvDBAbJEJsrr6DEDZkACyJ7VN
        jaGn0dKdx1NYOKYaQGmBzMx6KIgw7a+1/Q==
X-Google-Smtp-Source: ABdhPJz0WWR5rgnk9W+rB5z2uvkzmYuEe/Rs6iSrWo7jyMq3Yln4hdSZq5x7CngDd2aRN/YZLdtD9g==
X-Received: by 2002:a17:906:7797:: with SMTP id s23mr7356466ejm.312.1605378046500;
        Sat, 14 Nov 2020 10:20:46 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id o17sm4583930edz.10.2020.11.14.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 10:20:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alireza <rezaxm@gmail.com>, git@vger.kernel.org
Subject: Re: Why Git LFS is not a built-in feature
References: <CAD9n_qjKyxNjtd1YrcHzshLg0-vbwXkHRwMveXHAWSOXMWLKAg@mail.gmail.com> <20201114002902.GN6252@camp.crustytoothpaste.net> <20201114162700.cvmxzcs4sdhsxpak@chatter.i7.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201114162700.cvmxzcs4sdhsxpak@chatter.i7.local>
Date:   Sat, 14 Nov 2020 19:20:45 +0100
Message-ID: <87blfzg5qa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 14 2020, Konstantin Ryabitsev wrote:

> On Sat, Nov 14, 2020 at 12:29:02AM +0000, brian m. carlson wrote:
>> Additionally, in many cases, projects can avoid the need for storing
>> large files at all by using repository best practices, like not storing
>> build products or binary dependencies in the repository and instead
>> using an artifact server or a standard packaging system.  If possible,
>> that will almost always provide a better experience than any solution
>> for storing large files in the repository.
>
> Well, I would argue that if the goal is ongoing archival and easy 
> replication, then storing objects in a repository like git makes a lot 
> more sense than keeping them on a central server that may or may not be 
> there a few years down the line. Having large file support native in git 
> is a laudable goal and I quite often wish that it existed.

That native support does exist right now in the form of partial clones,
the packfile-uris support, core.bigFileThreshold etc.

It's got a lot of rough edges currently, but if it's something you're
interested in you should try it out and see if the subset of features
that works well now is something that would work for you.
