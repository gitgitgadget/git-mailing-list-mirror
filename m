Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C30C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbjEKUDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 16:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbjEKUD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 16:03:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10CB2134
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:03:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc3a5f462so25317a12.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683835407; x=1686427407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gLT/cv/+SuG4hiV395Kk6mqYyVVpRNE3uKmlwGiiK5o=;
        b=uk3zm6csC+4jCN+gwElKgBpr0Dp9DRckFuUty0/mfs7eLXmSE84nVt6OKqNAN7HmKN
         7S2Qe9lEBpEPUaLY08uxVuBeliJvm4+KsKmtrOAe+BCTQoF5AvSFUB0Sp5bu8/QT09Ec
         PN1c5Mvjm51WW4AlpmzMt+9OrHpt5vk6Bh41jbUWq96lNlT2dias2Xj5MNLnGxr8wbmC
         m1sVsxAf0ZBx48IvElX7so/SoVUB42y4lufcKaIK0khNvDurL/wbF4ao3Fxfy45pduJo
         X0KaxowHTcBi6GNdfM3YDv3Ac8/MuoPPv7Mgjb9J8DzMt0+6tibJtMEhv/c7qU8mmia2
         psQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683835407; x=1686427407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLT/cv/+SuG4hiV395Kk6mqYyVVpRNE3uKmlwGiiK5o=;
        b=cIagO8+/0CRcd+N2+8JrXF+DWCZcT+hRYRv7U5wn0+QiyJ8n8gT7GDCGUAeKkbFCxO
         DNN3KJuzjbBIzMwnwxHDgbTG57E1KGr5b4Y9ub4DWIenvoX/zRC4S23pu5fWhbXDE2cA
         FqlWiWyLb0e6S1uPc9bI0ruTj0TlGPO77vV6P0JxmryNQOxwrJEHtvZ5eZYkyTrEOx+f
         Q3YRMXwVFPeIAy8B5Y59p6vwduan5rBVK+OWA8EH/Ghv7J9Ru6nTGejA6xbeclwIzGG7
         DAR6/oPVTh5ZZV5THcPoHb1rv63yp2N4j15DVB2eV0RA37myerF3w3QyLBf610PbviQ/
         +fog==
X-Gm-Message-State: AC+VfDwuG8Xh6c8nwYs8YJ6z+LhfHz7l640uixgtDCtj8QzSdVfa4mzj
        aH8hXRWq2CByKaPoxcs+o87BD6mrP0Xm9xuVXzHLTQ==
X-Google-Smtp-Source: ACHHUZ51jP/N8Wo4k8cXRcwvWajv4ha7mT4mc4wN7P/RiKANJ4AwCwjgB7dqND9r5b/CCGnX/iXQScaGQGtHC0u8wYo=
X-Received: by 2002:a50:8719:0:b0:502:368:66a8 with SMTP id
 i25-20020a508719000000b00502036866a8mr16790edb.1.1683835406994; Thu, 11 May
 2023 13:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com>
 <20230511194822.1493798-1-calvinwan@google.com> <CAPig+cSTVbvyUOOoVrsTS8t4VSoCbVRoA=i6j0_4KZX5ZTt34Q@mail.gmail.com>
In-Reply-To: <CAPig+cSTVbvyUOOoVrsTS8t4VSoCbVRoA=i6j0_4KZX5ZTt34Q@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 11 May 2023 13:03:15 -0700
Message-ID: <CAFySSZBE9PDyRd+fW25awStc3-0Skjj4gqnR-FZQy23vry1RtQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] strbuf: clarify API boundary
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sorry, I meant to send a follow-up to my previous email[1] but forgot.
> In particular, I wanted to say that I think the second part of the
> above comment (the "however" and everything which follows) ought to be
> dropped since it will become stale once those "older functions" are
> finally removed; it is likely nobody will remember to update this
> comment. So, the above could rewritten something like this:
>
>  /*
>   * NOTE FOR STRBUF DEVELOPERS
>   *
>   * strbuf is a low-level primitive; as such it should interact only
>   * with other low-level primitives. Do not introduce new functions
>   * which interact with higher-level APIs.
>   */

I agree that it'll probably be forgotten about so your suggested
documentation sounds better. If others don't have any more comments
on the other patches, I'll reroll just this patch.
