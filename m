Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630E6C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 04:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352413AbiA2Ez3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 23:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352399AbiA2Ez1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 23:55:27 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB3EC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 20:55:26 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id s5so23039210ejx.2
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 20:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAo8Rd6H0/EFEJ2gUfDGQ9wBB4EjnA4AaLxWI6MNEbY=;
        b=cGQhlxKavV7pPMyUkPB+kCDU7vQ+9MNnYWAtF90SYw0ebdGwMVKD1MCygfuJY3BQUz
         ubdeqb0Vf9iu2wUqvRXUUp2jlObLK2SC62+phf6K1jFCN2zl77YI9O97PGQ2uchjz5nc
         NyJPAwY4prljT1PHbRbd19qUDtbXM/4B8YlVaRGm/mlkIwpQ1rWg7R7zjmgWtHwq2qfp
         fMxfTKD/rg+sAmOjsch5n06z8Hl+1m37/vmMHWxPPsWE9CH5PlbNIgZMvrOQkFZMsQo8
         8Q5gUNWg8xaAZJmMKM8PnED4+tRiBmrCuGgSTXSLbwqVN4QcW1IcUtshmgmjDKbvfiiy
         Xe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAo8Rd6H0/EFEJ2gUfDGQ9wBB4EjnA4AaLxWI6MNEbY=;
        b=fS0eXL+sercD7Euk7X4Wvb/YVLQzAbWUnJy5Q/68S8br0qkSE1mvl+QeSBAon9O+R1
         vsKpNqC+AQ3o2Wvt6huTQgq/IJuKVOvMfH59Hw9jKujfyUfw67Fgqwi0Mj92pTPfqPfn
         XcfVO6WT3Ji8FyTBU1k1URn/aZvO4+QehaGY4ie0GFLHpofvF49JOv/IitB92eeAidCn
         AVAyFZiUaFn6GPWCH4OtzPX2zxcmweYIXi2mnRnYnL5jWySSYGSk+Sy0PV2knKye4uzQ
         gBaXNjW71/gUkwjD3rcQGnpoY77PddzhE8jWOoIq+Z0o5ZN+bHR/GygUHnaKUKdYoPb6
         0YPQ==
X-Gm-Message-State: AOAM531S4h+CbcSo2esJoyou8u7OyakXp6D/hnOmfgxABqoooUMCpLx4
        Gc8nwKlk/7N2AgLQWrei9b3cQUyJk+J6WbNnYHY=
X-Google-Smtp-Source: ABdhPJwrn23SX8VHc3ZIHCIoO16Yj5yv7YiIdBCxmn9q/qwFR1C3XNfTDpei66wvBRSU5vIiShVprmvNU1pfswtXdbo=
X-Received: by 2002:a17:906:4c47:: with SMTP id d7mr2410103ejw.192.1643432125122;
 Fri, 28 Jan 2022 20:55:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <CAP8UFD0+ui2uJtyNSQ3Cq4k+9SPpjT08=CBhMFNJ0ni2tLQQPw@mail.gmail.com>
In-Reply-To: <CAP8UFD0+ui2uJtyNSQ3Cq4k+9SPpjT08=CBhMFNJ0ni2tLQQPw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Jan 2022 20:55:13 -0800
Message-ID: <CABPp-BFPDLQ8SQ3QhM+KPpkyKatckroBrGQJugpZ+z5CUwD_JA@mail.gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 2:55 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> > After a merge, this function allows the user to extract the same
> > information that would be printed by `ls-files -u` -- conflicted
>
> This made me wonder if "-- conflicted" should be part of the `ls-files
> -u` command. Maybe "by `ls-files -u`, which means" would make things a
> bit clearer.
>
> > files with their mode, oid, and stage.

Yes, I like that wording better.  Thanks!
