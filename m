Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65128C77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 00:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjEIAGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 20:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjEIAGa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 20:06:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B704B7ED2
        for <git@vger.kernel.org>; Mon,  8 May 2023 17:06:29 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-517c06c1a1bso2610547a12.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 17:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683590789; x=1686182789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Dk5WbOelLcxvn113WJ1qXHDnRkpFZlGUQCWQffB7pg=;
        b=K+IegJb2VJLyrF54k24LLeb2CuKFNKwMNh3nYm2LMFoBawpxFZLf7lvcbDo4Ekfyjy
         PyPS/KikjiqYzUoIKm5apXMlkmQvp5Lbhz5wFb40HgpYFw8hKNgqDC+XWPcgQY3w2KKH
         8/G2Jkdu2NvQs2bu8IIWyW3ZgG7PWy2cw2BgXucNov3Gjf/wdufBHAvXD55y98VxPnow
         wPMU2txLz/x7SNHhyAHti6HtugUZeub61JiF95KP3auFvBotcbWhhO1OWt0IuPe2+9m2
         1E7xdwdhyPrs87BYo1gG5BgAZrkvfdjKeXHOu8FaxQMeWpIJ5hURoj2um0u7EOx58wQv
         O3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590789; x=1686182789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Dk5WbOelLcxvn113WJ1qXHDnRkpFZlGUQCWQffB7pg=;
        b=UQHf/baDgDtsgrbvQ8i8Zkpjl74WeuT0HMYSliWKYY+BKwTPLUmb+I/WMlkZYDuIMo
         XHmxJhgPuJd3/uqlEWFJ/nQZVjpgL75JdjqYFLunzsXezDiN2znS/GQI69qcx2ZYcMH+
         UXolMiqUnKv8hYC8hkZuSYw5Yt3PU1wU9kz+HZW7R6MZ2IYSqyMqPc58ZBqBOdyPrIp4
         gYtGD5FKI368K51zE9JeCerWbhfiesyxiv19ofwOuWhhNen9BypsCjs+C7An0TvxaNVd
         N5u+WGtzRQLuWKayIL82nIiXNrIX/dllj28X1DR9zDtZJsyjpbU3xJ+wTL4/CCt5DoG6
         fcYQ==
X-Gm-Message-State: AC+VfDxTgffRtSvt8vJV7LG3MKtlCiFN31VD2sdcgDYyTkYEzi60E5ZH
        EdAnL/97s8Kduv9ShcH58unKMWi20FpyOQ==
X-Google-Smtp-Source: ACHHUZ6A+6XnUUZpXTKwm1M80uxVk/6lx0yysiXAxiC4AjY25NM4rSefGVGfpVM+fS0H/yfhDsgfehukgoy12w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2c1:b0:643:599b:4dbd with SMTP
 id b1-20020a056a0002c100b00643599b4dbdmr3268238pft.2.1683590789297; Mon, 08
 May 2023 17:06:29 -0700 (PDT)
Date:   Mon, 08 May 2023 17:06:28 -0700
In-Reply-To: <cover.1683113177.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1683113177.git.ps@pks.im>
Message-ID: <kl6lcz3a1i7v.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 0/8] fetch: introduce machine-parseable output
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the third version of my patch series to introduce a
> machine-parseable output for git-fetch(1).

This version looks great! I only had minor comments this time, mainly on
docs and tests.

Thanks for your patience and receptiveness, and for the fruitful
discussions :)
