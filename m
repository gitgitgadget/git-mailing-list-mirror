Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2970FC2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024CC619F1
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 08:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhF1IVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhF1IVY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 04:21:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC430C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 01:18:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hq39so28483040ejc.5
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 01:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZPUvr1JXHekZ/aOaAALHNZllpBRnOqQxDVc5E6GEkaI=;
        b=q4Vec01xn/FcxhBfIlyyVTBfwjXQXrgWfj5vRTXYkGHDYWYoevsAWjCiKC0GjHl3v3
         Wv3qK8m2MEAk7dUCUxUaNi3qChbGPBjKrcYKbJbNn0oS5sZkpEyLRzLt6r/bP8TCWpBr
         RTFvsOekKbagwkYpwntouTSPZB4IYe/mZcoJfGkkwTCpbeQ10MjuZWt8eFcCn3tu6aI2
         BxU2dXI7NaaOpVPS1XZfhgbPVIuCBwhWF73RxH1qLXo5DO57NklCFcsWI06BTbciHQ++
         OYIFg0U00NjQEhNzRLeLZwVyriwnIucUdxpBaE4Sb3Pq7FRGIq249eoXJO7Mq17IxXAT
         ZfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZPUvr1JXHekZ/aOaAALHNZllpBRnOqQxDVc5E6GEkaI=;
        b=ndRSijqE3xY5a9H6befXqN5QBkxgaMnpYihgSyK2cX9dSmtHJ7N0g425NefErpj/lN
         wiZ0SUZDuyy7XiikmxTxVn/p6b8zTlTwVO7vbM5VUWwMTWE/AtB6kpBxrlaCDi72wJEx
         IXzGo4W1flYJu7DZj6I9iujA6SgjHvQF5KOTbwQ+PbQ+lhbClu7pdl8BkHVlrTWJFphj
         DYOOAFJhRf6R3aInL/VSkzE7YRRQhi0iivqDjN19++AipGWi2j9V8aVTQAZyDNbMgTuI
         SBMpQcKKsRN88a2/bZKT73JKMDCWXJbpbxGTxsLfdx4Ml97fmk8LZMA0McFXmD5t7Y3I
         /qTg==
X-Gm-Message-State: AOAM533hYwGLeVbkS4t3PlY05NXyQRZ2wpkzmz0A+E7neHkICjkHog2t
        0iKL3po9Mzgor1VsqQFYoyc=
X-Google-Smtp-Source: ABdhPJwXyaDlLF7dDklyeLHZ+WISh5ol+PoiOJgNLj7zVROUd+etjCTCXl5PnFbMPTZACV52xLorrA==
X-Received: by 2002:a17:906:28c2:: with SMTP id p2mr23606089ejd.41.1624868337261;
        Mon, 28 Jun 2021 01:18:57 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id hw6sm1221868ejc.37.2021.06.28.01.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 01:18:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: git-format-patch does not encode lines starting with "From"
Date:   Mon, 28 Jun 2021 10:08:17 +0200
References: <5oq2985q-o266-8p5o-n197-8nq8s6p83oon@vanv.qr>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <5oq2985q-o266-8p5o-n197-8nq8s6p83oon@vanv.qr>
Message-ID: <87sg12wgen.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 27 2021, Jan Engelhardt wrote:

> Summary
> =======
>
> git-format-patch in 2.32.0 fails to quote/escape lines starting with
> "From ", and mbox readers conclude there is an empty mail.
>
>
> Observed
> ========
>
> $ git commit -m 'subject
>
> From ffffffffffffffffffffffffffffffffffffffff Mon Sep 17 00:00:00 2001
> with love.'
> $ git format-patch HEAD^!
> $ head 0001-subject.patch
> From d489071b4855a49b32e9b5ae5addd982d2ed8d7d Mon Sep 17 00:00:00 2001
> From: Jan Engelhardt <jengelh@inai.de>
> Date: Sun, 27 Jun 2021 20:04:20 +0200
> Subject: [PATCH] subject
>
> From ffffffffffffffffffffffffffffffffffffffff Mon Sep 17 00:00:00 2001
> with love.
>
> $ git reset --hard HEAD^
> $ git am -p0 0001-subject.patch
> Patch is empty.
> When you have resolved this problem, run "git am --continue".
>
>
> Expected to see
> ===============
>
> $ head 0001-subject.patch
> From d489071b4855a49b32e9b5ae5addd982d2ed8d7d Mon Sep 17 00:00:00 2001
> From: Jan Engelhardt <jengelh@inai.de>
> Date: Sun, 27 Jun 2021 20:04:20 +0200
> Subject: [PATCH] subject
>
>>From ffffffffffffffffffffffffffffffffffffffff Mon Sep 17 00:00:00 2001
> with love.

"git format-patch --pretty=mboxrd" and "git am --patch-format" should
solve this issue for you.
