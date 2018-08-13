Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36421F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeHMXvU (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:51:20 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:39735 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbeHMXvU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:51:20 -0400
Received: by mail-wm0-f54.google.com with SMTP id q8-v6so10191217wmq.4
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2wn7s5Xrui+q7mRbKU0LZrzoJpdiI/BmG8Z/n71FeHw=;
        b=dZZJz0E6WDTjv+I3vjg+PZCfTbUfZ9T/Ha9Qr5xV6zbEalc2S87V+kWMU5ETxYV3Tq
         qJEymkUnW8/P77iN0IyFL+KgOy8ZKAWRAwDmhVVrj0f36J5z6vbahO3P7LYZltXwvQtt
         fagnAIs1T88rU0o4MFTIuLRbDndE4HjJBpoJxNOJtSHfNd0ShG7lafeHkEXXjd97yMaZ
         ls16p0ZotvXs6Pq/3sB+NXAh5vLDUxoSZrE04cu8oPiACiTGVlQI3NEGcQO+mm+796C7
         NIYr72svQYkyShIQNCLi4rEcgGb4hct7jKNBAYf39hMQpxNu4GhvI8su1ZIEbsTgUjTu
         /6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2wn7s5Xrui+q7mRbKU0LZrzoJpdiI/BmG8Z/n71FeHw=;
        b=IY5ogVAsuSQRr+M8dx3HhywsJmciee0FIrl7BJwDVqJua0rq/ZxDoiTGGWEbsRvdQ5
         c6X/kgPt5IYN2YoKld1qq3FIU0mmCND9CJWbiAZEaQurLd10aPeq0cBfbW+wmwPeqrIm
         imilMms+yDgJtUimz5HTyRl0vDd2+VQcs6tCjasEpHltne6LFzPFGwnpWwyAShHEKkbK
         90RN1EaJpWxERMw8s7u1q/maK7lwnXalaNMZow+qJk3ONPs4JSMQlC8MBFGYZpA5VBlq
         bEat1Umb4HrK/jznHIa9MfdNcPR/YGih+4MgoxTTvfZsNwG0fQYmjKqGlhX6pPDBzqjW
         Gd9Q==
X-Gm-Message-State: AOUpUlEA5k5VjhjSLpUvQ2SRr7XSlMnx/XZTIIV8ICSkYxIlA3qdGY7D
        YqE8AS6+r3F5Fr0s/niyfDk=
X-Google-Smtp-Source: AA+uWPwv4xz+UcfszhuLyNvr+Pb9F0aF/8hkGd0VTnAmy3WqXOdXyd/OV44Sn8ydC8pYFg3xzXQTrA==
X-Received: by 2002:a1c:6d9a:: with SMTP id b26-v6mr8412774wmi.74.1534194443961;
        Mon, 13 Aug 2018 14:07:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h14-v6sm22723922wro.15.2018.08.13.14.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 14:07:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
        <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
        <xmqqmutq5cpo.fsf@gitster-ct.c.googlers.com>
        <49564417-fac3-ede2-7fd1-e3a5a03e4cfe@web.de>
Date:   Mon, 13 Aug 2018 14:07:22 -0700
In-Reply-To: <49564417-fac3-ede2-7fd1-e3a5a03e4cfe@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 13 Aug 2018 22:26:22 +0200")
Message-ID: <xmqqd0um3rhx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> the mailing list [1], nor on the web interface [2].  The latter shows
> extra spaces on the context lines of the first hunk, though, which I
> can't see anywhere else.  All the lines look fine in the citation of
> Ramsay's reply [3].  So I don't know where these extra spaces are
> coming from. :-/

Hmph, interesting.

https://public-inbox.org/git/54a5367f-f832-402c-f51b-3225c92b41ad@web.de/raw

has "Content-Type: text/plain; charset=utf-8; format=flowed".  That
page's rendition is more faithful to the bare text.

The funky " -" one I showed was what Gnus/Emacs came up with as the
result of its best effort to make the format=flawed into something
closer to "text", I think X-<.  

In any case, I do not think format=flowed can be reverted reliably
(or can it be?  If so we should teach mailinfo to repair them).
