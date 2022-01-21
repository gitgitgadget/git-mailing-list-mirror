Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B05C433FE
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 12:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380499AbiAUMvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 07:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380502AbiAUMvM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 07:51:12 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E047C061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 04:51:12 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id k31so25727820ybj.4
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 04:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herrmann.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=e9E/wDW5+oVTuix1dZwkVUnx/vlh8EXxZqhN41U5MRw=;
        b=Nw182wUABJ2KtvjgCgwyA8+sIdsIkI1o4RhpWB5mgM2jvawOMdbkWRBWN6R9K5ADj4
         ARFhSAipNvkQOvFBVzOBNA8kMi6kA8jzhndGW3LTSgkAfvT0aaHaqHHI82tVm+ALDasx
         7lUkCUzdFLkqSnBknZFdS1d54nEbH9f4pI7HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=e9E/wDW5+oVTuix1dZwkVUnx/vlh8EXxZqhN41U5MRw=;
        b=qCqep6w+A/ymPn6sWqRkvHKKZW7Lq/iYq8tB18Q25MUCTSANcgGZDOp/XDjAEWcyiQ
         F5Z0CehCizuaIbQFTa5lf5sFa7tRhNNFv51AW6JQ5ji8s8hY+b1gfjiUvYlm8TMqDTCp
         iJWM19/AiheELTuT/YMJXBh4mJGhn1SpAuQOZQjKWM3DWlpM9nNWBezDWczF3iy7zIRU
         rs3GheoOG70B/FzByHdNhr8ok4k+tPRERAA/VeInbv0ctnedE35r1WXsU7LIuFlDOX1Z
         e9KEG/svlO/VSZYfTsAqlbvul5dBp8Q8GrXIIMVBA692f2hgJbIYBXWj3QWc11Xmripi
         Zl2g==
X-Gm-Message-State: AOAM532S+/suw75FsLBUTs68ku1EbEzvUj5+bPrMNlUmL1h5xd0raAVZ
        LZugFT/y5XDRLZz8jN+I4yQ9u0WsOoMeFegGEcAyt4vvMJU74Q==
X-Google-Smtp-Source: ABdhPJyxzZfdPhXnTOb+jsSyVymZHPA0LrSFRXqGUgBj/0J434drf0y01b2VNcCJof8g8quqjTJap5ZkBNVjGd/a/BI=
X-Received: by 2002:a25:e64d:: with SMTP id d74mr5742285ybh.323.1642769471653;
 Fri, 21 Jan 2022 04:51:11 -0800 (PST)
MIME-Version: 1.0
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
 <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net> <xmqqilufl5cv.fsf@gitster.g>
 <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com> <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net>
In-Reply-To: <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net>
From:   Michael Herrmann <michael@herrmann.io>
Date:   Fri, 21 Jan 2022 09:50:55 -0300
Message-ID: <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
Subject: Re: A puzzle: reset --hard and hard links
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Herrmann <michael@herrmann.io>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 20 Jan 2022 at 19:21, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> No, there isn't.  If you need to deal with files that should be linked
> and stored in a Git repository, your best bet is symlinks.

Okay, thank you. I unfortunately do not have a choice over which kind
of link (soft or hard) is used. I will find a workaround.
