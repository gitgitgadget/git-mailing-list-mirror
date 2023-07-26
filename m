Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552E9C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 19:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGZTpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 15:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGZTpi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 15:45:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88AB1727
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 12:45:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so1822311fa.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690400733; x=1691005533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UfTD6MZFIXTpSOsVZuuElhcbnA9lcS4HRmYJ+SOqffM=;
        b=hd2QuStumhpqItnxBZYp6PX/Sb+SLhmy6DXpgbO1zEqQt79csHJgUYddiw5E2f4Xuu
         b3xmACCL545PnB0I1UJpVLGciObJeNfAQE690adDKmTcD8tDMDAyc3AaTV4HO5gnxMAa
         rlpY5GlZJt4wA6MGm3Q1jrO9MuXH9LO7wm6jriGJty1YIxQTh/ZQeW/NiQBSt1Bg4rfS
         fUi4gVU16jR9WSunOQvielQbDXMMz3XJrsIyNOIy2QyOzAk2git34xK5xwTEUJOhAIYh
         GkYmWMWJ2GDTv7lUc6nj/BQO14HuQGhvJ4IZNH8yph9awafZYCsRGFCsMmDMUoYCeqle
         4BTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690400733; x=1691005533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfTD6MZFIXTpSOsVZuuElhcbnA9lcS4HRmYJ+SOqffM=;
        b=hJqos51UZ8WKyZECwLeuc22R7ZU4ggVdeHPwrEOVczGQiMPWNYhaSyMr53DHTWMI6W
         gkRjihpXnJIFBJCg3CbKLK2qSS1LtfrUnemu/3TkgVuKnjiIydPpTda+EeDrl1eASQla
         nEjZ92yKV0jk5mNS9oL7c1N8I829bmBb0qIOEAiyAPdBgQvzMsr42LwHLTA7jvmAMPux
         liWxRYBbReJI6y76YFVtOL0yN8BAq0oB6dxHoqLj+jiZONtnNUH0aBzfTo/ZBOhQGr9L
         B9QaYMN2PzyEx5X62mjnNeVeC2KemcjwYVwShi8BvrgAECBXNj3Jv6iDVNY9cUeN0Z1c
         1f+A==
X-Gm-Message-State: ABy/qLYqaHOSVxPldaEw4mM7byly8T2gskTp+seR3y1fScebdeDwkVUt
        LVd2cUH0b9ItvyTAokrYi4ui3fKUt8XT2iUym+I=
X-Google-Smtp-Source: APBJJlFiUd/omfrKIBPVAVF6zxVnnd0lmd/u/BXYJkVcENtpC7C2NCDPxt1WMuWdm0Ck2vL4G3RnMgcOjt/8LwONfy4=
X-Received: by 2002:a2e:9cc6:0:b0:2b6:da64:734f with SMTP id
 g6-20020a2e9cc6000000b002b6da64734fmr61093ljj.47.1690400732837; Wed, 26 Jul
 2023 12:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1527.git.git.1687591293705.gitgitgadget@gmail.com>
 <pull.1527.v2.git.git.1690387585634.gitgitgadget@gmail.com> <xmqqzg3id27e.fsf@gitster.g>
In-Reply-To: <xmqqzg3id27e.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Wed, 26 Jul 2023 20:44:56 +0100
Message-ID: <CAGJzqskUL23Grv84uuFpm0kJFvNQE1PvR=67WLDt6bAA2OxmXw@mail.gmail.com>
Subject: Re: [PATCH v2] credential/libsecret: erase matching creds only
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 26 Jul 2023 at 18:15, Junio C Hamano <gitster@pobox.com> wrote:
> This was still confusing for a patch that does not touch anything in
> t/, but after re-reading aeb21ce22e and the above a few times, I
> think I get it.  Adding the following
>
>         , when t0303 is run with GIT_TEST_CREDENTIAL_HELPER set to
>         "libsecret".
>
> at the end may help, but perhaps it is too obvious for folks who are
> ready to actually review this change---presumably they are familiar
> with how t0303 is to be used and read that without being told from
> the context?

Good idea, the clearer the better. I'll add this in patch v3.
