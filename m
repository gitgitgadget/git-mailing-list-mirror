Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA7EC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7AC61212
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhHXQN7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 24 Aug 2021 12:13:59 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:33663 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhHXQN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:13:58 -0400
Received: by mail-lf1-f44.google.com with SMTP id p38so46744610lfa.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WNTrdfdvj/mPpuw2UKDOxzDcjAWS6Xisv0re6z98Q+8=;
        b=dECo/jOGy4O5QcHzR6x0CpXWcAPgeetZ+FkzRrKPcKixmjd+WbNFlrFD5sTdY3ddO/
         uWvKp615XCWHsOQszjTXq84dsmefPz4KytLwWJwJ4/S7O45ERYYkuiEiMAYmK5naKwJv
         Qd/U2bfrjvB0gExepzv+4K0UWSS2FYMh7f9XCF14YiIJ8V0/Q3USnxviiFf9V+gVa9jn
         Ch3Qwj38k5s3hXamJ2epUGFIIqojuh0z8TnBSdGHsV0Uew4GeipmQELf5DugT/eJrBg1
         /kNua8baMd/1DJyPl8ATUCV3IbQkoruqCavKbL42tdmJzkfyktQYowEtC4v4EPDKWZfx
         WO2w==
X-Gm-Message-State: AOAM533YyndX4m0WqCd6hXkW1qYu79XFhi8S+xPilX4n2WOs/Yu+l9R5
        JNVlngokyEoaI0Jz50Uy6r6DxD2TYttg9kGdh0w=
X-Google-Smtp-Source: ABdhPJxWVcgpIoUAXmeKT3Q/UVAuLrxXfxnH3n8DK4xZrWO4R28ZkPxABgdBC3KcxL3tolyoQuhqfDjgefwvjiXvb6g=
X-Received: by 2002:ac2:554f:: with SMTP id l15mr29832711lfk.260.1629821593219;
 Tue, 24 Aug 2021 09:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-3-emilyshaffer@google.com> <87wnoaevbe.fsf@evledraar.gmail.com>
In-Reply-To: <87wnoaevbe.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 24 Aug 2021 12:13:02 -0400
Message-ID: <CAPig+cTzx-eXKFa9UyLd4QW4adcuNFHrp5U+_SC_vyC7L7nANA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] hook: allow parallel hook execution
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 11:06 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Aug 18 2021, Emily Shaffer wrote:
> > +'git hook' run [--to-stdin=<path>] [--ignore-missing] [(-j|--jobs) <n>]
> > +     <hook-name> [-- <hook-args>]
>
> As an aside I wondered if it shouldn't be [[-j|--jobs] <n>], but grepped
> around and found that (x|y|z) means a mandatory pick of x, y or z, but
> [x|y|z] means that, plus possibly picking none, I think.
>
> So this is fine, just something I wondered about...

Indeed, the text is fine as-is.

> > +Specify how many hooks to run simultaneously. If this flag is not specified, use
> > +the value of the `hook.jobs` config. If the config is not specified, use the
>
> s/use the value/uses the value/

As a native English speaker, the text as written (even if a bit
stilted) sounds better than the suggested replacement. A small tweak
might improve it slightly:

    If this flag is not specified, the value of the `hooks.job`
    configuration is used instead (see linkgit:git-config[1]).

but is not at all worth a re-roll or a lot of discussion.

> Also we usually say "of the XYZ config, see linkgit:git-config[1]", or
> something to that effect when we mention config variables. Perhaps we
> should do the same here.
