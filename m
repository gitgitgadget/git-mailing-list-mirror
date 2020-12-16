Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAB8C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D824223343
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgLPHpZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 16 Dec 2020 02:45:25 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:36023 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLPHpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 02:45:25 -0500
Received: by mail-ej1-f52.google.com with SMTP id lt17so31331730ejb.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 23:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m3WPRIdjRoy/D0ClzwXWIE0ESKd+jINRPSeyXiRTBTc=;
        b=Iz3NQL5s6swKMyXHSSZRMj/uW57tkCzbCeZbYKkBSB3hFV6KxXdQAEX0CIFAW8jSDw
         qgAGS2Nl/kf/spOiSzBpmL8zumuHHsJupHugD5mBsEz7xPh7tMbbpRGPkGy4F7vvpeA9
         t46jzu7JJZw3Jm7u2AdBjuNxnxg0LdtH4xYZCe7fWQFpbuDNmh6SEEpQyH3HYHfa1Ibc
         YYIm4Noain4w662O5RkHcfurYhjJJqV+oVcP5aXJC0wYuWLNYOhuWctWXLKiGRMPii97
         0rRqfXPybl8Qvj5eiA72I1NY81GoIrfd02s6oJJ1YZxarzqI8X4NJE+iypce2+zha+4r
         YjQA==
X-Gm-Message-State: AOAM533kjPWViMbgo46FeY2i/Y0bH8PcnOwSyEPgOMclyPS859vlaVJM
        2hFqkmpA9a7NR/fpjPpBEIvY9ZX826lykyJnq7YH9Ozt5kw=
X-Google-Smtp-Source: ABdhPJycdl3UPlTAf5CqBR7D2MoMA8/kUbRuPRnskA+0j5jjBeW3pgKvt7BWH8x+b8ju1fmJsfE7pDIUfX5QzvATNR4=
X-Received: by 2002:a17:906:c289:: with SMTP id r9mr28693380ejz.311.1608104683045;
 Tue, 15 Dec 2020 23:44:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHjREB6QrR-FQzwOphgw1z1Rba=o7gNvEwomHc60aNH3EkQg5A@mail.gmail.com>
 <fde32488-97e7-55f3-86d5-25f525492844@gmail.com>
In-Reply-To: <fde32488-97e7-55f3-86d5-25f525492844@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 16 Dec 2020 02:44:31 -0500
Message-ID: <CAPig+cSh0L3RniJpEs3oddkzPGUyw5Ud39SAbYFoxwtBowLiaQ@mail.gmail.com>
Subject: Re: Perf lib sanity tests fail on OSX
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Sangeeta <sangunb09@gmail.com>, Git List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 9:19 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
> Le 2020-12-15 à 14:08, Sangeeta a écrit :
> > The performance test, p0000-perf-lib-sanity.sh[1], is failing on my
> > local OSX machine due to an error in the test_export of the foo
> > variable. [...]
>
> It is not the export per se that fails (that would be very bad news
> indeed), it is the shell magic in the 'test_run_perf_' function in
> 'perf-lib.sh' that uses a non-portable sed(1) invocation:
>
> As you might already know, since macOS has some BSD background/ancestry,
> most POSIX utilities are closer to the OpenBSD/FreeBSD versions than to
> their GNU/Linux counterparts.
>
> I do not know sed syntax enough to fix the invocation to make it
> portable (nor do I know if it's possible).

A patch fixing the problem (correctly diagnosed by Philippe as
non-portable `sed` usage) has been posted[1].

[1]: https://lore.kernel.org/git/20201216073907.62591-1-sunshine@sunshineco.com/
