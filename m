Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941D51F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 05:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfKNF5z (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 00:57:55 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40374 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfKNF5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 00:57:55 -0500
Received: by mail-il1-f196.google.com with SMTP id d83so4220165ilk.7
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 21:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwJVQ6aumDgaK7CgnEfr7uvhJxCize2lk94C8zUJJcU=;
        b=LrjMfpPWtjslqfFjGcF8iC8koS0c6B6RergNqDAguVmDInY5Lp7t6RQU9kd0qxG7FR
         2xADS+OviAhr1ANwbuhxv5dF95NAIzfs5V0GwzqFZV5zwy3PkILNTRbTBm8TASId/O77
         65BgQO3GOttLeP2M8ZJfb5bC4kqUBzFTt1BYIReKAu2bSf5qD5Y94un6OLRGzTsnMxA5
         MHPM9x57dj+ZtS2l8hcrbEUjTMpHJ6tHFIEpmcWppZO7CigjMJOqJj7QJbU04Xqfy0Cj
         rCz3lFBK97/ERUtDNzNckfcOIogmBhYQX4DTZ46Iw1JEFsdZAdYyqYfzPGHAb3pWHl6U
         7Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwJVQ6aumDgaK7CgnEfr7uvhJxCize2lk94C8zUJJcU=;
        b=jVQBbyxU8+G05FH+RwPTBxpa+5knd04k26uU8bxg/zv3s60iF+TVtpXsttFlDp7FTJ
         tY1Ttm+SRKUeZ9pKl0uPCWFGzekyLuwX3AU2W1W8Y1GdORW8Av8t7yVDVETE/reQXYkT
         6IbkNf0e/QPDWK27dpB2NkukaufE85ynRThv0YKf8VC6gSH6AVD6MFSu1h7073+DkjlS
         WNXSQO77MxqXblWVNfx1UU3mZ0kU3atiGevyzqQ8RuK5FnrHKQW8roUSMndfaCPlrbPO
         eb7gpcrDdiw5apRha3qcFs4kryx26CEer2T4u1TeGCcjdOazVico6LcweuxrOJ2jtcze
         SiUg==
X-Gm-Message-State: APjAAAWhpdS9AjwQQXAABitR0B82/+4diVrRmmanWo3aGW1z94sL+I2C
        M2Y2xjjliTxT7XSIKfl+9Gq/S+yI1FYoXXjivHR+4A==
X-Google-Smtp-Source: APXvYqzcWKN2pqiLPLgsUMqgwFJCAXG3hrl6+3QRfZEnltA80gc+Fz0lHxwDjVfeoqIgBibhiX8L/mbQCMLC11CujTU=
X-Received: by 2002:a92:4899:: with SMTP id j25mr8393137ilg.127.1573711073712;
 Wed, 13 Nov 2019 21:57:53 -0800 (PST)
MIME-Version: 1.0
References: <4c5652ab34f0989856aba919ca84b2b091dcad98.1569808052.git.matheus.bernardino@usp.br>
 <20191112025418.254880-1-jonathantanmy@google.com> <20191113052044.GB3547@sigill.intra.peff.net>
In-Reply-To: <20191113052044.GB3547@sigill.intra.peff.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 14 Nov 2019 02:57:42 -0300
Message-ID: <CAHd-oW4PtO2CKpd3HFgrJWmQf3MN+MHt5c7V6OGx33LgU-CrOQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] object-store: allow threaded access to object reading
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Peff and Jonathan

On Wed, Nov 13, 2019 at 2:20 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 11, 2019 at 06:54:18PM -0800, Jonathan Tan wrote:
[...]
> > My concern is that the presence of these "holes" make object reading
> > non-thread-safe, defeating the purpose of obj_read_mutex. In particular,
> > the section quoted above assumes that the window section returned by
> > use_pack() is still valid throughout the inflation, but that window
> > could have been invalidated by things like an excess of windows open,
> > reprepare_packed_git(), etc.

Thank you for spotting this issue!

> > I thought of this for a while but couldn't think of a good solution. If
> > we introduced a reference counting mechanism into Git, that would allow
> > us to hold the window open outside the mutex, but things like
> > reprepare_packed_git() would still be difficult.
>
> I think you could put a reader-writer lock into each window. The code
> here would take the reader lock, and multiple readers could use it at
> the same time. Any time the window needs to be shifted, resized, or
> discarded, that code would take the writer lock, waiting for (and then
> blocking out) any readers.

Great idea, I'll work on that. Thanks!

About the other parallel inflation calls on loose objects at
unpack_loose_short_header(), unpack_loose_header_to_strbuf() and
unpack_loose_rest(): could they suffer from a similar race problem?
FWIU, the inflation input used in these cases comes from
map_loose_object(), and it's not referenced outside this scope. So I
think there's no risk of one thread munmapping the object file while
other is inflating it. Is that right?

> A pthread_rwlock would work, but it would be the first use in Git. I
> think we'd need to find an equivalent for compat/win32/pthread.h.

These[1][2] seems to be the equivalent options on Windows. I'll have
to read these docs more carefully, but [2] seems to be more
interesting in terms of speed. Also, the extra features of [1] are not
really needed for our use case here.

[1]: https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/reader-writer-spin-locks
[2]: https://docs.microsoft.com/en-us/windows/win32/sync/slim-reader-writer--srw--locks
