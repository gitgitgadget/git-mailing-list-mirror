Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C6C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 19:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05B822CAD
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 19:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390829AbhAKTTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 14:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732725AbhAKTTM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 14:19:12 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D73C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 11:18:31 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e7so272930ili.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 11:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8xnOye8oSzqFMBrjfukfqBhP2tTqGx4ZUbLJwpdzKVs=;
        b=AYGf8RJAVy99aAE9n8WnvvyOgLbpZRm9xXHadkrnKjAzxDTViZgUd9NDYfZ7FPlvUf
         1ep7HWqQcRPhBRRVHG78u43DKRJHbyQyBRH0GkAen4ld0js7JrcmcGCr5WQqK+RgiqlB
         htHUEjBNaiy5MBOUHD/uSNGD2Vrlzi9TM1dHFDZNuGwg9RmWTYlsZBiv3b7YJ0GTeWyH
         8mQ4jTtDH+HqEW3yNqm2nUbKD1CdlOkT3IKgft3ND7YlsKVK+he0duMP7jMRJJ+Iwwuc
         +msvywUGxBSnhC80oDnzYVh3Shmj7BQoPPzNH+gxUGnrLFvSpJrem/x4OthYKQeZfb4z
         /yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8xnOye8oSzqFMBrjfukfqBhP2tTqGx4ZUbLJwpdzKVs=;
        b=DGKaJgCVhm2Qo5vCwoPIyiBkLjqxuVJIapJtkXYke5XTVDcdvbG+U7POGYqKhE8Sg5
         wi/Z96aSKcj+m2Mw1NlpLAUP5dhfta5tHSZgbQ1q+lK/PP+RPbbma2cwT1RBP0FXJR2N
         JHapzbUieUh9fz4kooQO+pPaPOk++AvRGu5m7ZNX5yvqsVWId0+3qaZVmEiTXEQhfRn8
         MQPLHZQglZ17NKw5EG5fX9dbOmtRgEchgpkf5HqbwdeIDZR0+LddexsFvY4YXOc7VV52
         kWOyoRQtKrQyv6X0Pu5FazblwZuZYMGjueEl7g/F5A/8ngCoOibOLCQdVZI2s7LQ1RK5
         3RUw==
X-Gm-Message-State: AOAM532wMgjoZnckm39Rh34Q0Y0fjcRrEfYJLCiusIFxcTd5U1WlD190
        zol3wXiAXR2L2JngLy7ae9CY7A==
X-Google-Smtp-Source: ABdhPJxXmXy4MjPBKYr/GZQ5puDTDTFLsx5Sp4AKlga2cXBhnDVTRpWmRflMuu29uAZts+YRteDRVg==
X-Received: by 2002:a05:6e02:1a8e:: with SMTP id k14mr598516ilv.308.1610392711066;
        Mon, 11 Jan 2021 11:18:31 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id l9sm282114ilg.51.2021.01.11.11.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:18:30 -0800 (PST)
Date:   Mon, 11 Jan 2021 14:18:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was Re:
 [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
Message-ID: <X/ykg4rEDDpWdZN9@nand.local>
References: <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet>
 <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet>
 <87wnwordzh.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet>
 <xmqqft3cl9rw.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2101081534380.2213@tvgsbejvaqbjf.bet>
 <X/i7zvgMJHfOmyZG@nand.local>
 <nycvar.QRO.7.76.6.2101101306310.56@tvgsbejvaqbjf.bet>
 <xmqq8s90a6li.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s90a6li.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 10, 2021 at 12:18:33PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi Taylor,
> >
> > On Fri, 8 Jan 2021, Taylor Blau wrote:
> > ...
> >> I think that this could be reasonably addressed. When someone opens a PR
> >> (but before the hit /submit), GGG could say:
> >>
> >>     Your change touches these files, and so suggested reviewers include
> >>     X, Y, Z. When you believe your submission is in its last round,
> >>     please also include the maintainer, M.
> >
> > That is an option.
>
> As Taylor created the above suggestion as a counter-proposal, I can
> see that I apparently did not express what I meant very well, when I
> said:

...or that I must have not read your email which quite clearly states
what I was thinking of, too. ;-).

> So perhaps we three are on the same page from the beginning ;-)

I think so.

Thanks,
Taylor
