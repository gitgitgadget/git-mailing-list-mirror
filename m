Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE19DC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiLLWwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiLLWwP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:52:15 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600CBDB
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:52:14 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id b6-20020aa78706000000b00579e3853125so778476pfo.6
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4N2wwqQFKcOOwYXyYUCvKewwT6W8koawo+eUtuQ+1fg=;
        b=ZZ3i+w44//4yJEXVfLn3GyjeUBeZZ2m8lTNAoyYBUsNuWiEXR//tySrVaWM+4wWxA4
         kozjJ2aRsjlKgzJZEBVkfPO94H4XNrFRxA0xQFP9CPch481TWlDG6dRuHBsh/nkouRVL
         qdU61ZVsdR19WuQNM6o66cmOQUnodPZHOxLvrnqVWNJ5MqF0ca1enuFwjHUxRF1bRAPM
         wTkZlfJRN1QJ9z2hRxbZQ++JQDcbnBwTWJtbXyTChw4jpNehJLdzoONqd50BAJXhuerX
         C0zyLMjv8vtqnhwkJmcbfp97Z65PsrOgccRbInQHGr1qZ6iDCYGHMBPOJ0AVpOUpDcwN
         S6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4N2wwqQFKcOOwYXyYUCvKewwT6W8koawo+eUtuQ+1fg=;
        b=olwNBkTfq8Zi0d7+r4NY1iiOepaaRoZQCeNwhvozqTd2XE1CpkbKcRBiQJI+75wDyE
         kFe/MQm7136wp5xOFeVUqJz8oAZJRmirUjCuMuu9gNbjcjBfo5O24av09XuMvPGT/LH1
         hPrnautdIl4AzO9OzRCap9wg1CJCAt4bDnATJTDmUMN3v8AxioySXVvYARY2bmwxILdB
         t3dVUp4lp6GmTaeyyb7UrTqkvcduGyqEq/P8x5PEBgOKrTfOMT3q8+bGYkovG+WsALf6
         QTCMrDPl4tWwQKRkR8yEkyUaznmvcWo5Gd2UtqVdToFUsrZU/kYjEiwYApNeI7P/3TkJ
         l94w==
X-Gm-Message-State: ANoB5pkMgDTug9rCoXZtkyQrZ/hxT1oVwHvVPu6gZ6Okir/XSo0gm6c3
        wUHGpALWXh4eMGbZggxIoWKyAu59HM+wR2LSeVXH
X-Google-Smtp-Source: AA0mqf7rwnRkMqPHdhoOWIWd6ImFOQoC081xNN8hlJvcJCaWSmpJc/g8ZH7uvAlJVQlQipvTM1yRAUOkd2drbFMZzfPQ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:216e:b0:56e:7b62:bba with
 SMTP id r14-20020a056a00216e00b0056e7b620bbamr78996189pff.55.1670885534423;
 Mon, 12 Dec 2022 14:52:14 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:52:12 -0800
In-Reply-To: <Y5ebC1qwJi5VwnCh@coredump.intra.peff.net>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212225212.2556886-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/4] object-file: emit corruption errors when detected
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> On Mon, Dec 12, 2022 at 12:59:55PM -0800, Jonathan Tan wrote:
> 
> > > And possibly put a comment above open_loose_object() that "path"
> > > is only guaranteed to point to something sensible when a non-negative
> > > value is returned.
> > 
> > Junio made a point that there could, for example, be no path when the
> > odb list is empty (maybe in the future) so I don't think this would be
> > sufficient. But there is already a comment there pointing to a comment
> > in another function that states "path ... (if any)" so this is something
> > that callers should already take care of. In my changes, I'll initialize
> > it to NULL and whenever I use it, I'll check for non-NULL first.
> 
> If we return a non-negative value, then we opened something, so by
> definition, don't we have a path of the thing we opened?

Hmm...are you saying "path is guaranteed when there is no error; when
there is an error, the caller must check"? If yes, I think we are in
agreement. In any case, to make things more concrete, I've just sent a
new version [1].

[1] https://lore.kernel.org/git/cover.1670885252.git.jonathantanmy@google.com/
