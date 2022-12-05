Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63349C47089
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 23:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLEX5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLEX5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 18:57:23 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3902E1D328
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 15:57:23 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x66so12988505pfx.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 15:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXXlQg/8APyQXBsGr8q/GNF/FUwzI2gm5H1jGeyXMrE=;
        b=hyHNPCTTR3+IN91yQkpFOhZhEgmfB7BLGo9s+2MvVsG4A8dtNmX0nc6lTgk4kYVsR0
         ynwnqjZr0FKU5Uul9GdtFEK4ROaFFfyPDvqRLLeTo9PG8bTo+nQLV1HD6auRD+cqZ4aw
         HbdHRGStC/AMSBZFyWx6+bZsfRfRfnFYK54caTuafym6UHlVJ/HW8aKDuYBLOoWHud4r
         81AKlQrDGZn/OfQSbLU18P1dE1zbD3B624GH2qJTi+Cpes4CM5qAMpshhz5w2d4FGfaF
         CBMEh75iUF5MoYKhYWAKdgNaBr0THtxYbxj97xohD/9HGzvQuJHWztHNltynjPanUgWK
         4L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MXXlQg/8APyQXBsGr8q/GNF/FUwzI2gm5H1jGeyXMrE=;
        b=uAx4YVyw2nSbmdb17vLIG6Iss+Zb4n2QIEB10quDw6xUS8irD2C9UMPbHvyxpvdUBW
         HUI398P0EH17UBrWtsJc5wF5WsyNmXgYDR1jPVQYBqjsZmoLyTzu7G5Dos/gOcx9eXPP
         HsKhyXVg059vE/s8d2j4xO2h/93a01knz6s5dE0naqEqkukpp2kjF2fKZOLzQgZKLFqt
         whAC6XBUzXYNA0pBLHvtf0Fqrg5lK7LJeetQxYf4Br9lMZQix86RVmwqUr49yvSt1lFs
         3fT2CZNo+WrjD4eE5IqGxPr00XDl+2/ziBRXD/ybrsJ9bzMWdbrseSyeXKzA6mhwtWm3
         oNSA==
X-Gm-Message-State: ANoB5pmca6MtEgKQdh/0a/nWvMc2dyDW26GmsUC/liujleAdtcb4H5ri
        99+2ds4BqWLb6pKL13SSpKM=
X-Google-Smtp-Source: AA0mqf6EnKWT8Imu8gxHmj5InxuQ1b/byc/6+9J0WuCvy2C9cxWzFYiIY2NU//2WI7MKNCcsE2aeqg==
X-Received: by 2002:a05:6a00:4307:b0:576:ba28:29a8 with SMTP id cb7-20020a056a00430700b00576ba2829a8mr11163329pfb.47.1670284642590;
        Mon, 05 Dec 2022 15:57:22 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t3-20020aa79463000000b00576b0893ecasm4436355pfq.46.2022.12.05.15.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:57:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
Date:   Tue, 06 Dec 2022 08:57:21 +0900
In-Reply-To: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 5 Dec 2022 13:54:38 -0500")
Message-ID: <xmqqedtdpfoe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In git.git, it is sometimes common to write something like:
>
>     T *ptr;
>     CALLOC_ARRAY(ptr, 1);
>
> ...but that is confusing, since we're not initializing an array.

Given that "man calloc" tells us that calloc takes two parameters,

    void *calloc(size_t nmemb, size_t size);

I personally find CALLOC() that takes only a single parameter and is
capable only to allocate a single element array very much confusing.

It _might_ be arguable that the order of the parameters CALLOC_ARRAY
takes should have been reversed in that the number of elements in
the array should come first just like in calloc(), while the pointer
that is used to infer the size of an array element should come next,
but that is water under the bridge.

