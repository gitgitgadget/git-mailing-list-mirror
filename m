Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EA3C433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98B064EBA
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhBRSwW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 18 Feb 2021 13:52:22 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:42779 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhBRREv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 12:04:51 -0500
Received: by mail-ed1-f53.google.com with SMTP id z22so5221697edb.9
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 09:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=89eE5LozzPDKVQVnKSoj+e9wC+EImvNvB48XRAKv2a8=;
        b=gIp6s96vkFeHK+3ESFdXNntHdwA0ish7Ec81Cn1zrptpXcHLB+eBkhtDNI0zdiDobK
         zJjP4aGqp18TwxV96oj+V9cCevZM/m2d2khLA+5MCYy7BtMvdbQ60RtTGf2CPJbdpyUw
         5pLdyNKEzlMdAGNR/oajshLMebnOY2SGaGIbQ5lJ9b4rNRLoQrub4QEnqYZ5v4iGnw5W
         QYQdzTCOvA743b/7kXi4PSpu5WZiYGm28CfMckOZ6tzk4eBqXPh9aUe9oOz1L09cpW5e
         smhHkTewdHblxs/LpQcmqLWZvYE/dVLK4EsxCUCIdUKft3w5ZeATuNEnU3tucsd8SMQL
         dgVw==
X-Gm-Message-State: AOAM530FUC66bSTSvOngDVtLACOzQ6tvx+AXAbcd0Y2HlBRcsm5OIJ4X
        UuQ6eyYE5lcCn3Vgv0dC8m1ooVOoTWqRZjbgK6UsosiW9fE=
X-Google-Smtp-Source: ABdhPJyqyOWIVKrPSPld1oQ3L2ervrVvJBXIJLEkwCgpZ3ByKVo+UJC4FDNluJYgh+ECZ/dgJDCPv1nDqM2XxkuutLI=
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr4989628edu.163.1613667847020;
 Thu, 18 Feb 2021 09:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20210218095750.939746-1-rv@rasmusvillemoes.dk>
In-Reply-To: <20210218095750.939746-1-rv@rasmusvillemoes.dk>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Feb 2021 12:03:55 -0500
Message-ID: <CAPig+cRhvh2TpSZ-bzjiuCf-Vaf-wr1umb6EAFna3uQxU=oXyw@mail.gmail.com>
Subject: Re: [PATCH] test-lib-functions.sh: update comment on generate_zero_bytes()
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cc:+æver]

On Thu, Feb 18, 2021 at 7:22 AM Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> Commit d5cfd142ec (tests: teach the test-tool to generate NUL bytes
> and use it) changed the implementation of this helper, but didn't
> preserve the magic meaning of the word 'infinity' - in fact, since
> strtol() returns 0 when presented with that string, it ends up
> producing no output at all. Instead, the C implementation interprets
> lack of optional argument to mean infinity.
>
> Since the last and only user that actually passed 'infinity' vanished
> with d99194822b (Revert "t5562: replace /dev/zero with a pipe from
> generate_zero_bytes"), just update the comment to match the
> implementation, and while there, short-circuit "forever or X" to just
> X.

Makes sense, but note that generate_zero_bytes() is going away
entirely[1], and that the patch series which removes it is likely to
be merged to "master" soon[2].

[1]: https://lore.kernel.org/git/20210212132942.17325-5-avarab@gmail.com/
[2]: https://lore.kernel.org/git/xmqqr1legm5v.fsf@gitster.g/
