Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F28C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D263F610E9
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhKHTVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbhKHTVK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 14:21:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0342BC061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 11:18:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so35607127edv.1
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 11:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=yNKZeROnnLEKroX51UgWBlrUCU2/GDeTACfXUUVoZ4s=;
        b=eMZXDViQ9N/HfrBkPojVKqnS4V5Mtun/QeXg41wtaBDP1kVFW2IxX97uXSSg6ik7HJ
         YI47O7nP+ra5CDIFCnkUfyPtRTdLt7jQjvubV92rspCuB4vQxRUlQ+fEEZnPf1YPgmVv
         ZTYzhST7bc7LT6VgWEJvgrUm/127fKmlJxOZgxyDbgSYej40NrcM5Q7rJg8l8bULyZFU
         uZ4spbovm8IqUEBJq8IcEeQ70OxKDnr8LSfvaXKiuQuxF/O3q2jl1bS3v0lhbGJ6e/NB
         trpWerxZSNWa3Bp8ZDrcF7+uj0HrcfNcsJunpNypZORzzGq3k/sV5yTQ0DW4rZo/4CS3
         cC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=yNKZeROnnLEKroX51UgWBlrUCU2/GDeTACfXUUVoZ4s=;
        b=sErBkQRlX+uS2BorLvIGvJibStwngv4+Pol0EwscxKbw9bW6XYSsUPXzIR0kPGg/Sd
         bACYMEtx5icE0bNi1VzIXJ3fQ9k8lc6V/Fif1vMuP6xJ0usgcx2LPDS7lxZvRiD1VVjQ
         Dm7HtC8/TGuKe88U0m/BCAh6MbXPg+FrYbcth9e0O1t+OE+TQ1v+Xw1CespdXmeLhhI6
         sbLhflqtEj/Kr+fy8nMVw3gu4/Dx7+J/ZBTnJ8ntRKLMxiOq0oIR5k+hLX4HyWMoomgi
         hNi/aOmIs8ZSWWzs4SEzy8wP0PejTyVKSq1Y6UmaDcAVjYIQ4WiK9QkxpvmvM6sODNFd
         gTIQ==
X-Gm-Message-State: AOAM530H7K99k5jRRXhaPme8cF2F6VlO+oyYOddiRIjpPG5AXd1xa2Jd
        7b8pvqq1fjpLxtkXIrLxWOs4zatcz50=
X-Google-Smtp-Source: ABdhPJymnD5RpX0V4TJvAvmijWI3suzopoepLKoLJe5n3+4AyPhis2kzBMMbEk62mCxEZZ1skP412g==
X-Received: by 2002:a17:907:d22:: with SMTP id gn34mr1900015ejc.195.1636399104444;
        Mon, 08 Nov 2021 11:18:24 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n16sm9787394edv.79.2021.11.08.11.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:18:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkA9v-001Dum-Bx;
        Mon, 08 Nov 2021 20:18:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Maksym Sobolyev <sobomax@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Maksym Sobolyev <sobomax@sippysoft.com>
Subject: Re: ms/customizable-ident-expansion
Date:   Mon, 08 Nov 2021 20:14:23 +0100
References: <xmqqr1c3e57a.fsf@gitster.g>
 <211101.86fssf3bn3.gmgdl@evledraar.gmail.com> <xmqqr1bzbp69.fsf@gitster.g>
 <CABFYoQA82u8Um6L439_bU4a+WpkdXOcbU8foPjqnVw+4MnNU0A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <CABFYoQA82u8Um6L439_bU4a+WpkdXOcbU8foPjqnVw+4MnNU0A@mail.gmail.com>
Message-ID: <211108.864k8mfocg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 07 2021, Maksym Sobolyev wrote:

> Junio, well it works and passes Occam Razor test. I even added a
> reasonable number of test cases. As I tried to explain at least once,
> having it per-directory might be advantageous, if the project pulls
> sources from all different places where you might "mute" ID
> replacement for certain parts of the tree or use a different one. Most
> of that would have to be thrown away if the feature is to be reworked
> to your liking.

Yes, isn't there also a practical use for this in the source trees of
the various *BSDs who import each other's sources (but I don't know if
it's useful for that).

> Totay I logged into one of our products and got this message:
>
> + sudo chroot /voicelog/src su -l sobomax
> This fortune brought to you by:
> $FreeBSD: 3325fdce090fbf738dcb1f8535d16217789cbe4e $
>
> I did not know such a fortune ever existed, it has probably been
> developed around a long-long time ago before git or even linux
> existed. Just as many other more useful features around the same idea.

This on the other hand looks both neat and a bit scary, so something
that previously left "$FreeBSD$" alone started expanding it? Hrm, I
guess since you need to set "ident" it's no big deal.

But I wonder if we'll see any downstream breakage for people who opt-in
to this, who have code they didn't know about that expects an RCS/CVS
version, and suddenly gets a SHA-1-sized hex string instead :)
