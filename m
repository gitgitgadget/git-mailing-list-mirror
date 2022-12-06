Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDA2C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 16:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiLFQSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbiLFQSF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 11:18:05 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A179326E1
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 08:15:16 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id v21so5140809uam.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 08:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2xC/76HpHtdBv1vvWd7fdu54x2LJoZ0cbnptpWe0ok=;
        b=S5SVqEsgyTCagkCv4LzS0Ufqnqt7Wn6/d9bPf35tvQ9hMRIhd6qsZZ+Ht1it9y6OHH
         lt69or0WydcOx1GcXyzHrHpWArSRfjFTDOSUfjpN4PgpPF9PdUJBOJju+B8ihmdI/0/N
         sCFN+xX2zbPowbeVr/pQcle5Y0oFd0Y8Cqf/LrOZ/mpgCKA4aq6levi1m4ZVaE++PAwn
         082KNgmroJ4rJzEW7HkWAqJRrxOojGzzBFTIaApg5gwQrirQpdU8ROhDjx7gptAVLXmG
         JKza79HAY4NpIFgah6iQNQujWpu7AYMt3rpipsT+bWt/ONzgzE1S2n65WsGQYqrhW5b3
         Di3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2xC/76HpHtdBv1vvWd7fdu54x2LJoZ0cbnptpWe0ok=;
        b=wGPd7/pvfAIGoWBFRx8bYbCz2qS8Ta2d4lYb08p3vQUTJcwKdOp+XqiXzzTSD1fGua
         wiQI/jjwPcn1G2GvPznFp/2o2bSqXr9XT5OXOJSMagbai0YXnDgpshYBIp8I0OGQdfed
         f0nWOyCqg+RkjJyCfDA2vIBFJIgb5P6eUpEx4e2DG9z9d5juu803rGjdLb5N+5SmMeby
         DYfQ4fDjGYYQ6A8if+Isb15rLCjqWpMrUBl4+ABctOYPARWiQFd9NojBIDdHwl3PvUaf
         inXkZUzJ8JVYzJebLwiqAHx/+oNcwf2mrFele+c2VRrTnpNN7Ww8DpM505boaPnn1M0t
         7AwQ==
X-Gm-Message-State: ANoB5pkfdiJ3Tsx5ujuWvaBJsYuTxXPP/D27qZd1pjXiOi8xnjC7AEDf
        Axxzb1Ko0HCsM1P+c4w45Z88pEqCXl19WpnJY8E=
X-Google-Smtp-Source: AA0mqf5+QvI2zRcLBQ4GLvMy7tEs9PFO3lGLuBslqxRNRY4ytjdSq76AsPjnwBwYFYQhUIHwg4KpH414KuMfHzQVzF0=
X-Received: by 2002:ab0:238f:0:b0:411:968:212 with SMTP id b15-20020ab0238f000000b0041109680212mr53246865uan.107.1670343314444;
 Tue, 06 Dec 2022 08:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20221205190019.52829-1-cgzones@googlemail.com>
 <Y45tGLaJwg3Lt5uJ@tapette.crustytoothpaste.net> <Y46dHWVaU00WFL+f@coredump.intra.peff.net>
In-Reply-To: <Y46dHWVaU00WFL+f@coredump.intra.peff.net>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 6 Dec 2022 17:15:03 +0100
Message-ID: <CAJ2a_DeNQ0KfkKLzhsxA0UtixmLvNxgzR=KC0UjMwVx1WXJMEg@mail.gmail.com>
Subject: Re: [PATCH] setup: avoid unconditional open with write flags
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But it's still no better than the patch here in the happy case, since we
> still have to perform three fcntl() checks to figure out that all three
> descriptors are initialized as-expected (versus just one open() and
> close()).

An alternative to performing three syscalls fot the check one could call
open(2) with O_RDONLY (O_PATH would also work, but seems not
yet to be used in the git source) on a common path ("/", "/dev/null", ...)
and skip the sanitization if the returned descriptor is greater than 2.
This would lead to two (open + close) syscalls in the common case,
same as current.

> If Christian can tighten
> the environment into somewhat unnatural "opening writable FD is a
> failure" way, I suspect such a jail can be augmented to further to
> allow opening /dev/null and other "selected" files writable, so I
> wouldn't worry too much if we dropped this patch entirely.

The seccomp filter only gets the address of the memory where the path
is stored, so simple allow-listing paths is not possible.  And even on
inspection of the path one would need to avoid toctou attacks (the
filter seeing a different memory content at check time than the kernel
at use time).
