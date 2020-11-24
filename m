Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F120C56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022C520729
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgKXAxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:53:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37945 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKXAxD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 19:53:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id y4so19060728edy.5
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 16:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZ1nMkrSN/UYiewdxrGG+8Nre+h83PVYY6gCH+vn2W0=;
        b=NKPqWTTHL9Ibs1ejPXPObmi9aP9PCKUlngJp3573Flsxn31hTViEcpcqxm4yV/wb2R
         JD5ambSpDh4QlvMiYztigmqA+h+q4h2itlfEtY6pCFczd1pbpVXpUT/CLixSCvlXdeZM
         IOkK/UUVnW+6QVtV9Av4x8msCougZlekKTqlZl1sqqYwAXs4GhLAvMT42/+FROh+gu4N
         DvBGzN/mS3Fwx3cZaiTCYUxb+X3wP+UdF7V8z72qJaYHfKS+RcBQ0WbzzKzhFDpV/OgB
         fb4QMBzjATk67WWnLT8h/+0INW78qyP3o6xG65bK83ZJWiZhrNbGoRNJAJ/gatnnzN4/
         NKMw==
X-Gm-Message-State: AOAM532QUkRh620In8iEK2+Nee6zGuTpQevVCaKvgGJLdZtuDu2mDMmO
        uizIoMa8HQy1WNO6kxshrii9NPQ2uTG2aOO5c7A=
X-Google-Smtp-Source: ABdhPJymP8ynF0uETXMomXrwAyi61bqgPnkOxOv+u7sH24kMb+Sj7DziXT2WzaeqqtR2WVjzmmdKbsQt4rpIL3oKDJ0=
X-Received: by 2002:a05:6402:1358:: with SMTP id y24mr1663719edw.291.1606179182060;
 Mon, 23 Nov 2020 16:53:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com> <39718048cd8f5be053a13ff73f531e3400b80b25.1606147507.git.gitgitgadget@gmail.com>
 <20201123222123.GE499823@google.com>
In-Reply-To: <20201123222123.GE499823@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Nov 2020 19:52:50 -0500
Message-ID: <CAPig+cR_FBT+kYPW2pGJmHCVFUB=cC=Z8DfaE+R4Oy5iabnr0g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] config: plumb --fixed-value into config API
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 5:22 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> On Mon, Nov 23, 2020 at 04:05:05PM +0000, Derrick Stolee via GitGitGadget wrote:
> > +     printf "fixed.test=bogus\n" >expect &&
> It is jarring to me to see a printf here when everywhere else we use
> heredocs. 'git grep' tells me it's not unheard of, but it looks like
> those are cases where the whole file doesn't use heredocs.

For creating a one-line file, the verbosity of a here-doc may be
overkill. At any rate, `echo` would be more idiomatic than `printf`:

    echo "fixed.test=bogus" >expect &&

(Though, this alone is likely not worth a re-roll.)
