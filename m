Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA73C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 12:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKBMNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBMNe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 08:13:34 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE256233B7
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 05:13:30 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id ml12so12335553qvb.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP8ytSdPNEQzss2FSvu6At6FqJvLUH9Fmoo4zTDD6uE=;
        b=cidLOqXnws6QW+ADgPM0ChpNDoNYkiEQt1xPvbi9gIvJ6NaztzlqnL81GZGFLMyVf1
         S9Oq3gmT2OmIFW49VvxKDPMUH6Uotu0uBgIdVcQkFnDg8smYFE0LmVWbF8f6R+02CkWi
         S/0Qmfl/biKbj6VJTD3bkKNIG6RXPeOthneRJJrCalOM83lCOBDfE6ni6lXt5a5GY3K5
         wGChZsTbvhcwaGks3UiapkxbhmX6owKr0FTAhqtm45FZMmHXdwyOF+/33ir1EVVjvEK+
         TgC/BL6R74AqBBS+JoDypB7FR91XmbOEEfw2XpRWb49Wk6OhUXX5bazXg/XASSIiBdcg
         e6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KP8ytSdPNEQzss2FSvu6At6FqJvLUH9Fmoo4zTDD6uE=;
        b=qDFLcqNrZxJ5v2eVHLnYNmuYjYlYpnuc4qA2ZW7qHjY2S5K/IVxZzamFNHUb42bpfr
         tQ8coNa6gei923UWwtEOVknkwBGesPK5tVahxEGzNzdBemXguAuuwKf0VNdGai/dQZeB
         BFCf+o+PidRV2AmTuBzfO8yJ0sHAT/iN9I8ziyfQ9tzD+WLyjwXSFcvBypts+vY6GPJk
         e8Rw52DtVyexiu1OqUU9NtaZA7CO1fzp6CmJAdMLdWWx41iSlwDEU9MX6YfGhvuK5l7A
         KQcVF7Xq+BkckS4BG8wa+u1kJ6u3BPJYEtx0uA4nHhxV/xI/CLOf5jR1bOH42sU77QxO
         A9Og==
X-Gm-Message-State: ACrzQf3jKNLNH0WPlLw4+qbSG+5aseP03/yH2Ybs6x7m8bvc4TzKhHev
        wwp2ezGyC6LgLKlI/WwQsySzWW6aNF8=
X-Google-Smtp-Source: AMsMyM60gcLx5J2+jRWxgJwxQ+hSlsfua+rkvo1GzszOpk0P5Q2lbv/Fu1RBttEUdeZSq3V0IbIw2g==
X-Received: by 2002:a05:6214:f03:b0:4bb:64f5:7855 with SMTP id gw3-20020a0562140f0300b004bb64f57855mr20673110qvb.17.1667391209691;
        Wed, 02 Nov 2022 05:13:29 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a290800b006ce40fbb8f6sm8583492qkp.21.2022.11.02.05.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 05:13:29 -0700 (PDT)
Subject: Re: Git Bug Report: out of memory using git tag
To:     Jeff King <peff@peff.net>
Cc:     Martin Englund <martin@englund.nu>, git@vger.kernel.org
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
 <Y2EPgICMsmzKvCC8@coredump.intra.peff.net>
 <38d50c30-c6a3-5989-6e01-47c5467d9d6b@gmail.com>
 <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <49e1eec2-0567-f75e-7d0d-0f2d00ac472c@gmail.com>
Date:   Wed, 2 Nov 2022 08:13:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

Le 2022-11-02 à 03:39, Jeff King a écrit :
> 
> After sleeping on it, I think I fully understand what's going on. There
> are actually _two_ bugs, but they are closely related. ;)
> 
> Here are patches which fix them both. I may be setting a new record for
> the ratio of commit message lines to changed code. But it took me a
> while to figure out what was going on, so I wanted to explain it fully.
> 
>   [1/2]: ref-filter: fix parsing of signatures without blank lines
>   [2/2]: ref-filter: fix parsing of signatures with CRLF and no body

I read both patches and I concur with Eric, very well explained. I'm sorry
for letting that split through at the time; thanks a lot for the fixes.
I'm sure it took you less time that it would have taken me!

The new code is even clearer with this additional 'else if' removed.

One thing I think that is not mentioned in your commit messages is that 1/2
would also apply to a CRLF-using tag with no blank lines, i.e.

  this is the subject^M
  -----BEGIN PGP SIGNATURE-----^M
  ...some stuff...^M
  -----END PGP SIGNATURE-----^M

Parsing this tag correctly is fixed by 1/2, right?

Anyway thanks again for the fixes,

Philippe.
