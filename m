Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0739420248
	for <e@80x24.org>; Mon,  1 Apr 2019 08:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfDAIsn (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 04:48:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38544 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfDAIsm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 04:48:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so10317136wmc.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 01:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=m5EdTbt1S2uzCTtbi+bhhav7Bjecr0sNHEQb/nd4oA8=;
        b=G+yql1ROy2uSf+X6td9gMrCf7vrrORHkLtZ0pfYePpFUip3EmROiWsg6Xgcx2Apc0a
         D0QGpuaK3mxDArBSLNw0gCFd5z9r+/w3/6q84/Vdh2CCNrRS3IiCp5mBMzH+gYioDuSU
         mw+ipcVhns5YMN0cGqZTikJczGhFRhVu6NH0tGRmP/RF2iSJT8x2Egjt8hNDLAN/b385
         jm763Ig/WTam9lwjxF1TI9WTc9UjUGVTo854KWi3kqb3k/ROU4hKIsDk6txWzzDtzjp+
         pXDunrqahBSrUGFCNQzj7lJfHv/NEs3UZlAmP7lmqnJx9sM/XeMdpn3i+ekU87euCk70
         4YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=m5EdTbt1S2uzCTtbi+bhhav7Bjecr0sNHEQb/nd4oA8=;
        b=fKBK+PYsKVeaCCSLusXLGs+z++xv9I8ZVBiyDz3n7hHespIDSpDUwsrBP6dgwzc+jL
         NRuTikuUN68Nb9Q9B8SvEeOV76cWR84X3PgsBkI62Bu2GAIkkGkPnDQLuwJZTznywAh/
         r8ZOg2FK6RIrR73jhdJO4/e0akFaVPF4KUz8UjOtcLIX5ql2K2Lqm0aP/9/PzLs/g1ws
         LCvWa4wrnTPIzlklYjv7OvE3lYVNTRAxbPcSjibNos6joUFuV02n4nlKxr/vxZ5bmMMu
         tsWUYKgt2aSFjzuUBa1CE79rlBl28Ryr9+hFZc5UAH+JLukUlKHb3sNXySNaFJ8DCjVO
         42MA==
X-Gm-Message-State: APjAAAWj5slI/e3BSpsV29AABqqBwxhbT53d89wrSJnX2ZdA6OQETqiY
        XfDSnlkJEhvYbHkpOquCNrA=
X-Google-Smtp-Source: APXvYqwJSPwujQ/IB4GSZMUtYgQM8ACjRpckBmz8fBkpkUjtlPQ0mGxiZs9zekIVYe1XKtnDiq1uVw==
X-Received: by 2002:a1c:6c17:: with SMTP id h23mr11576884wmc.122.1554108520568;
        Mon, 01 Apr 2019 01:48:40 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b10sm12857679wrt.86.2019.04.01.01.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 01:48:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Andreas Schwab <schwab@suse.de>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/4] replace: fix --graft when passing a tag first
References: <20190331134659.28808-1-chriscool@tuxfamily.org>
        <20190331134659.28808-5-chriscool@tuxfamily.org>
Date:   Mon, 01 Apr 2019 17:48:39 +0900
In-Reply-To: <20190331134659.28808-5-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 31 Mar 2019 15:46:59 +0200")
Message-ID: <xmqqmulaxg9k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> When passing a tag as the first argument to `git replace --graft`,
> it can be useful to accept it and use the underlying commit as a
> the commit that will be replaced.

Yeah, another plausible fix would be to make it an error, but the
message for the error would most likely tell the user to peel the
tag, so peeling it ourselves would make sense.

