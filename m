Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAD5C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 02:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJSC2e convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 18 Oct 2022 22:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJSC2c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 22:28:32 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA880DFC37
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 19:28:25 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id r142so13359079iod.11
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 19:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FDlS9fyiFmMwtrs+vD2671tK5MCkZNIK3C8+QAFrWM=;
        b=UbBpziypjIHPOoAwH2R3j1tlZLDBNjbbgF7gYusxxR1MHJWzJ5sJ6bx0aN6MLA4pX+
         lqCfVcbgNvuXrvij1950HNDj8wFr8FOnq+wPUKYQfNgxtXsuDnpQlCRvAxp6LERRJBEZ
         69V+lo2cn4dKE0D+x3m386Iq4AQQ8fY1MW/h/FRjy6Dvq2Z8LwgOoIHzT9IIYGXIoQfq
         xAw1bG0Sku0jhAvlGteXyBgTgvoBXz9VcH3ycdXntLJr7KV8HIi/viazefRx7YRXJAYQ
         6KaiYGSxnQPj0nqBEdysg11eM+fHThI86/KjoinuXWvqBUwr4OTHYBWNKo7OHWw7jXj6
         H3iw==
X-Gm-Message-State: ACrzQf22BrfxHCab0I8ZtuYZuuhRRa8bkyzLQQdM1dHQynvf6fbX+x4l
        0PQETVKwyxoQ8Wo4Y/uLnO38pQwRG3Myf9go64Y=
X-Google-Smtp-Source: AMsMyM6upovuqRXeoXdFiZPKDWRxeftkv7H71DIwsm3ZJYCJDWRZbA0wp/alC5t5mXmMCElQRwL/qEf3/+jQabJeF2s=
X-Received: by 2002:a05:6638:408a:b0:363:e307:8433 with SMTP id
 m10-20020a056638408a00b00363e3078433mr4216153jam.221.1666146505139; Tue, 18
 Oct 2022 19:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com> <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqo7u9wyt7.fsf@gitster.g> <kl6l4jw1yshm.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221019.86bkq8hake.gmgdl@evledraar.gmail.com>
In-Reply-To: <221019.86bkq8hake.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 18 Oct 2022 22:28:14 -0400
Message-ID: <CAPig+cRi8RVdmPbDdTzDCpXKjUsbOJNc5Pr+d02OQ9jENHUjfQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2022 at 9:22 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Oct 18 2022, Glen Choo wrote:
> > I'm not too familiar with the CI, but I took a quick peek at ci/lib.sh
> > and noticed that none of the jobs build with sha1dc, not even the Linux
> > or Windows ones, so..
>
> All of our jobs except the OSX one build with SHA1_DC, because it's the
> default.
>
> Per my just-sent
> https://lore.kernel.org/git/cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com/
> the blind spot has been lack fo SHA1_DC on OSX, for others it's the
> reverse, we don't test e.g. BLK_SHA1.
>
> In practice we've been catching SHA-implementation specific code early
> because the OSX implementation was different, but in this case it's
> OSX-only code, so it only supported the Apple Common Crypto backend.

I don't know how germane it is to the current thread, but previous
discussions[1,2,3,4] favored dropping use of Apple's Common Crypto
altogether since it doesn't seem to buy us much (or anything) and is
incomplete; it doesn't support all of the OpenSSL API Git uses.

[1]: https://lore.kernel.org/git/CAPig+cTfMx_kwUAxBRHp6kNSOtXsdsv=odUQSRYVpV21DnRuvA@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAMYxyaVQyVRQb-b0nVv412tMZ3rEnOfUPRakg2dEREg5_Ba5Ag@mail.gmail.com/T/
[3]: https://lore.kernel.org/git/20160102234923.GA14424@gmail.com/
[4]: https://lore.kernel.org/git/CAPig+cQ5kKAt2_RQnqT7Rn=uGmHV9VvxpQ+UgDPOj=D=pq6arg@mail.gmail.com/
