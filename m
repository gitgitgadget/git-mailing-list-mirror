Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18682C3437C
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4E424756
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHS9HZ8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfLMN0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:26:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39775 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfLMN0w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:26:52 -0500
Received: by mail-ed1-f65.google.com with SMTP id v16so2034250edy.6
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 05:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JI36f0MRto2WOdeYoIVa6IxVCPcj0OqOx90+F5xC42c=;
        b=AHS9HZ8VjRCnuQJRbuw/v9OiMp993Xdc/txjQnYR404jbW7rOGOjwdpaP9SVrhCUrI
         +8yAfJE8OanPtguXUon1/d9DJqdlG+rAKM+wIyH4nVSSv4Hko/ZPEqvXIyhPJUir/7u6
         nyJ4tTIU5qI+nlnyJsXP6lbKCtAJC3RH1Ix5USEMr9PewoYQJeqIMlBhKC5mz3YFfXZR
         OPa09m2qP9bBohFGc/9KlhHfczM4ANCvnk3TVraGQLIAP0N4cgS4Wu+x1nAPkui2SjkK
         OOg0/6kD8UkUGn65jJYC8KZPULUX0p2pj+Ljh0IMtBu9p1wEXg9+Mt3HG0/14evZl88z
         +rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JI36f0MRto2WOdeYoIVa6IxVCPcj0OqOx90+F5xC42c=;
        b=YMc5lh3wFr5rg1dPXlI0O//sqbcBnpnlL2BlhYEZjKgptPeFIZMKK2jpoEC/xxx0xX
         kfafVOp69mGPZRYArAQVsZvgOrggdGgweHfhdkTlEPcGYOPJ1nQ5vXyesw+2LBco76hh
         5uB43yIfJXgeYzu2w9NoeAh+kR2pW1QgSU7iV6vn/umkAA2228wM4u9V/6wBDFMx+aay
         qh5CS5oNpHtg/WWSZiNVOE6XloKrIJ2KBixgQV8LVQS0ODOk+eBpPIlFKHHMFEOztju6
         PScrpVS6hA894m2NfwzOTljjYG357dkQw2RbKhytJuRNvzat6ipWQKgpISFP25msfSV3
         uDrg==
X-Gm-Message-State: APjAAAVVwnxGQ9lVtbp12YZB2Dz9BQSqVRKnHjN0VGjNzJswZE2WKM1d
        8TpkJPABAEC8AuTS9YT9hUO3Uf//ojIZnI3q6Ro=
X-Google-Smtp-Source: APXvYqzO4M/7fKznptobEhFvcbTMX2nS0GcSVIJq7FcVhMC5itU8E89g+G5Hux/O0WEyBUV+NssLuctRjFBPZ3SvGgg=
X-Received: by 2002:aa7:c714:: with SMTP id i20mr15601163edq.110.1576243611062;
 Fri, 13 Dec 2019 05:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-5-chriscool@tuxfamily.org> <20191209064740.GD40570@coredump.intra.peff.net>
In-Reply-To: <20191209064740.GD40570@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 13 Dec 2019 14:26:39 +0100
Message-ID: <CAP8UFD12rj9xhc64DVWTrXb+Vdh5FS_pNt1E2-_dmFDOqdzKiw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] pack-bitmap: don't rely on bitmap_git->reuse_objects
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 7:47 AM Jeff King <peff@peff.net> wrote:


> I think by dropping these hunks now, the state of the code at this point
> would mean that we might write the objects twice. We'd mark them as
> "reused" and send them as part of write_reused_pack(). But we'd also
> send them to pack-objects via the show_reachable_fn callback, and it
> would add them to the usual packing list.
>
> And indeed, t5310.10 fails at this point in the series with:
>
>   Cloning into bare repository 'clone.git'...
>   remote: Enumerating objects: 331, done.
>   remote: Counting objects: 100% (331/331), done.
>   remote: Compressing objects: 100% (111/111), done.
>   remote: Total 662 (delta 108), reused 331 (delta 108), pack-reused 331
>   Receiving objects: 100% (662/662), 53.14 KiB | 17.71 MiB/s, done.
>   Resolving deltas: 100% (216/216), done.
>   fatal: The same object 00c1d3730931e66eb08dabe3a3c9fa16621d728a appears twice in the pack
>   fatal: index-pack failed
>
> and then starts working again after the final patch.

Yeah, I thought I had tested this, but anyway I squashed this patch
into the final patch to avoid failures.
