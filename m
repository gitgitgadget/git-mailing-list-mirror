Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E02C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbhLGLFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhLGLFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 06:05:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BB6C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 03:02:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x6so55220885edr.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 03:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3ODtdTcTkmEFkWmipSOp0ApieyZ/0sAQcfbc0YkxN1Y=;
        b=lP0Qldz3qreQWCntZJ93jwX/vo2RWM6w2xzELlimAipbrFcYvp+9E/mPAgmTLq9tG8
         C4RLmIPrMGcQAJvjSWpnr1KIPmwfVpOBAOk/+W9GRZ6Q0mterZrVw+sBXA6zHXzQnLl3
         JIdzsqSNC3BgBcodCCBtWdq3PHHYZ+UCbpO0c7/odQ6Axeewwn2/u61zrXnSrwXlg4VC
         zVMnJM2VXfoi4NriQ8bBRPtDnXa7NTgWLSMibDgO4CEqRBWKHhmeagtT2enrzUNtttlL
         ExgTWdMpn9NtVoc46sTEbjYcy1EJLJ+FRcQhnw94PPJQvesY/pB3xxp8IuhB1gaU+OjY
         sQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3ODtdTcTkmEFkWmipSOp0ApieyZ/0sAQcfbc0YkxN1Y=;
        b=yteA4gak+Rwk5SaPzLjvuG9gEndrIPolOWt2D4nVbpg0Tocai7KfdxZSJAX6UBv6G2
         EqEipLbumXPYFU0/+3EUzpCM8lucWlL9AgcXD7yYCw7H7rcNwP5zGjX1bZ1dgzigQN9W
         0nfcmLA0us5y4PqazilA2r/X/P4IacKvRus61d+nIu0fSm0+dwKYIroqaSOa/ESCwTW2
         Sbsr47lxcJiCePUJUCLzeTaIzCnG1cbMxRu1N7LTlUaGZzHYSpHnOfH5KOXEUpUadkvx
         GIgekq5Tow/CNHtsZZcg4rg+aqdKoX9eJe8VSa9PtKCvyy1Zu1fxqpMrFg4iygL7m4Ge
         bYWA==
X-Gm-Message-State: AOAM532VIJ+ZOYax2n4fp0G2IYSrnvbwSypdf3mfSKMZHjWJ5Rv5tS27
        BGJwASmSVckNEarOrqs3fwQ=
X-Google-Smtp-Source: ABdhPJzqa0t2pAoQS7cVGeTEOBX1fGLF9avjOUBkZtrYOQ8deF4nFqs+zCwxDe8eLa3G34r4q05+Mg==
X-Received: by 2002:aa7:ca4f:: with SMTP id j15mr7782841edt.178.1638874920352;
        Tue, 07 Dec 2021 03:02:00 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m25sm10056633edj.80.2021.12.07.03.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 03:01:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muYER-0016Lq-AA;
        Tue, 07 Dec 2021 12:01:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] replace die("BUG: ...") with BUG("...")
Date:   Tue, 07 Dec 2021 12:00:42 +0100
References: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
 <xmqqv901fu8m.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqv901fu8m.fsf@gitster.g>
Message-ID: <211207.86a6hcptjs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 06 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> A trivial clean-up to change a couple of die() uses to BUG() where
>> appropriate.
>
> Makes sense.  I wonder contrib/coccinelle/ can help us maintain
> them, though.

I tried to come up with a rule for this after browsing around in linux's
sources & coccicheck's own test cases, but didn't find any example I
could adapt. It's rather thin on string munging like that, and I don't
know spatch well enough.
