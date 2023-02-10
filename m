Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05E1C636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 19:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjBJTiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 14:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjBJThn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 14:37:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4382761D37
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:37:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u9so7551914plf.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNN7HzhCwOw+oBv9lzo7sC+Zlit0jeC/lCG5ESfsbcY=;
        b=qpYXzYOHb/qZMqFS1VDw84eOHi+lvtY1w3jNfSy9VNQ5CxyVEoo7ZPCVe0bQirjjqP
         NIJYb1BqpnmfaJyVK9kflolbCdRTYfBADf3BuK8U1qTWnp3HtIPTcDhCOpmwTKYCQvhX
         nhGomuL0VG79CUS/kKhyDnpX42g+q8unL9ai6VeyRFlFPn7OlV7eZwLzQl7QqLRAa4CL
         n9jtJgYHdSBNUa2irjHqlzvDndnFU4OvsiCfx0VjphDVyiA2ZEwt2zOqa81+6zxTwhXv
         qPEGCE0QCD7z4unCkum1QbVf8fsMf+j8CBZTGcgNCiYqJviQwzMdox3wPcUr7IAmX/gV
         XPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNN7HzhCwOw+oBv9lzo7sC+Zlit0jeC/lCG5ESfsbcY=;
        b=bRSdxROwrT5um4grb6VoTmuvbkL6CSn2aCuJyzH0PY+yq2UGvPhwv16sq5BNcG8dCU
         KzT9OvAmSx2gtrgchp0sqS4iZFRQ8ocHXCOc8ns93MzluIKIy1UC38W+aK1ITkcgfiMK
         tPl1RHhiL7CHP3pQEeNTbkprD2IQtWrejJCXlMAqq2WjOrJlnGOJXYYTQ114Th14S9gU
         M1w4nTJZpVB/xuw5QzcgiSMqMWSp1CegKUmIJ1wEDAcdUw80fQQNnd+K5ii6R0XmIBQ3
         pfoAq5v4hAK67yOeIR/8wgWzD49Kz8o1Bi6T3K05GfbQ8zGInOzIdj55fPYaTYDcaj5+
         mbVw==
X-Gm-Message-State: AO0yUKXImOxMsvo9CU0iOIP31A8+0SGeqUEW8j8wWntqavHhhODjHB4Y
        mlhICtWLkyDP01WN06OE92I=
X-Google-Smtp-Source: AK7set87YDC9rPSoZjl18Xrkk6FtgDgBYO6YPKygZZjOhyepaf/nLBdUg5sXKPbMnu2YWOTzwaFw2A==
X-Received: by 2002:a05:6a21:99a2:b0:bf:8aea:c555 with SMTP id ve34-20020a056a2199a200b000bf8aeac555mr19459772pzb.13.1676057839280;
        Fri, 10 Feb 2023 11:37:19 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id k128-20020a633d86000000b004d09bbd023csm3322319pga.88.2023.02.10.11.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 11:37:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/6] cocci & cache.h: apply pending "index_cache_pos"
 rule
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
        <patch-v2-3.6-3e9d97dbff2-20230210T102114Z-avarab@gmail.com>
Date:   Fri, 10 Feb 2023 11:37:18 -0800
In-Reply-To: <patch-v2-3.6-3e9d97dbff2-20230210T102114Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Feb
 2023 11:28:36
        +0100")
Message-ID: <xmqq5yc9ia6p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> -				int dst_pos = cache_name_pos(dst, strlen(dst));
> +				int dst_pos = index_name_pos(&the_index, dst,
> +							     strlen(dst));

This is not wrong per-se, but open coding what cache_name_pos() did
does not reduce the reliance of the singleton default instance of
the in-core index data structure.

What may have more value may be passing the pointer to an in-core
index structure through the codebase, which may help more parts to
be made callable as if they were library functions, but that would
be a much larger task and won't belong to this "finish the
conversion" topic.  But doing this change will not help us to get
closer to such a longer term clean-up, I am afraid.

Will queue.
