Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AE0C54EED
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 20:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjAXUok (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjAXUoh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 15:44:37 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ABB50847
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 12:44:17 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 207so12056194pfv.5
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 12:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsgXOzz3EbHp2lw/P1v+fKDZo2hav6TTBg558yrAhd8=;
        b=pBSq3CkLx2p4aGKCrvkGkW8c2pS15CrBJc6DGHMBrPbFJseYpOJQ6kEbh3f/aARqpk
         wQ7ABSrnABb8mZ0bdwypIAYYEdENIaGPU2WFpzHdSh/7podq3mipJiWsFUrEG/CZCcQ/
         BjHy2xX64PIBtveMdBmVO50Vjl8TCRcWezIxzhkEw+RQr51tsJiAgMiDI607Qm10B9Cd
         4OD79idKUq+fKM1be69T9I2xS91yEJWUM27EEZB8/IO7ZMN7HZPVRJawaaMU04QMBfcj
         RKGu6nDmfLnhKLEsnWckWz8qkPxxP0GMaTmeI8iLvt6gV0eIH3OzPq6LZfmqn70wWdDG
         I+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsgXOzz3EbHp2lw/P1v+fKDZo2hav6TTBg558yrAhd8=;
        b=innRmlzQLL9OCY3kJIRv+8NhV6DWviBtQhWEw7BUlIYU+QIFPAKDRNZ/Is0zPnbODc
         N5xMwN6OR0slmWnEwaSQbJhcDBWeICxxcZPFxGGkTI8+16iU5uaF7abzx2gWrwYYtctt
         N0/BUn3a0/c2QogNxKq2hfFqwdm2RnZoVGfEVR84JMZ0+qmB0sZMZ5NIrZXAxtoZKVB+
         uTS/TvnVsOd9/y8s8xOG+xUqhVlv/fFV/JTOyrqzkOndyYvE6mLXeOP5wZAX002+lZ7n
         9BTteuPQ4VrSIJCDD83uQFffojAsj2+Ncqtg+JYcM2f3A1ffk0hszffBQ3NASymub6Cy
         ijLg==
X-Gm-Message-State: AFqh2kpxtRHcjVR5YuiakdSrSojSz+OKvjfrsGnsVWdlHmG/kp7yxirY
        gZC7cIro6fDxDgL21zKrZOE=
X-Google-Smtp-Source: AMrXdXtfwzJyNEf3CIamd3Ll54faCZlF1Fz77fr8znOZorrcfo6DaU5OPncDKESePPIXqnMyZZjOxg==
X-Received: by 2002:a05:6a00:1887:b0:58d:c022:d60d with SMTP id x7-20020a056a00188700b0058dc022d60dmr40523774pfh.18.1674593056918;
        Tue, 24 Jan 2023 12:44:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x17-20020aa793b1000000b0058d92d6e4ddsm2050423pff.5.2023.01.24.12.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:44:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] tree-walk: disallow overflowing modes
References: <d673fde7-7eb2-6306-86b6-1c1a4c988ee8@web.de>
        <230123.86a629tzgc.gmgdl@evledraar.gmail.com>
        <b4b48877-5b80-e96f-d09f-2fe275f42950@web.de>
Date:   Tue, 24 Jan 2023 12:44:16 -0800
In-Reply-To: <b4b48877-5b80-e96f-d09f-2fe275f42950@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 24 Jan 2023 19:53:56 +0100")
Message-ID: <xmqqmt67fysf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> ...  It's basically harmless.  Perhaps
> we just need a comment stating that, to contain the urge to "fix" this.

Yeah, especially since fsck finds and warns about bad mode with
FSCK_MSG_BAD_FILEMODE and also FSCK_MSG_ZERO_PADDED_FILEMODE in a
separate codepath, adding another piece of code that checks a
slightly different condition does not sound like a good idea.

Thanks.
