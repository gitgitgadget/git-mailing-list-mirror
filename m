Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E052CC4708D
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 23:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiLGXUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGXUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 18:20:41 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9885B2AC41
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 15:20:40 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y23-20020aa78057000000b00574277cb386so16235190pfm.16
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h9MYL8y8uanlzjgfJr2Mz52FeNGut1BZPLQuFfG2txs=;
        b=rkqyDZS0PslxWGYieXjXAviDbADf+pUmBM/3HA3tjXeB3pYzkksH8wGps3IEuAdrS0
         v7z+ezhsXyncuJb4U4HceEt79G6L14rxuf1UaulLDTaO6jAPxZT8aBQ4C+eVhyPG3Bql
         J4mpN/5Kyv4g2A91A1lY/86NHhSjIjbfl9RaPbM4S45bfSJZiUqvj9x7ayj+x6TW1aE2
         sdnr0fqzJun8ZccCA5hXwsPHE4QsXdIPPmYsHOSFuKHh4pf0velVM3Q7fPyuRmGy+UjB
         C0//lq4NQxEFjpOlIq6EbLtytnRSvveyP3e9A/aVpsyIDFlihnyyuiuYOlT7OiccTBGQ
         eZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9MYL8y8uanlzjgfJr2Mz52FeNGut1BZPLQuFfG2txs=;
        b=sjSn5XM6+f3BjM5ZVQLCGj0ihzXlDjv89uuUoK61sCtZgEONMdSORQkLRZuhLpBBdj
         4O5o6WwWV2QWQVBTSbOTyGn2OUwxCaMnlUqnY8bwz5YDrEP13TLQG2i3qswYfGN6y6Gt
         MNuhrYfW8dcRqD0YM4o+tYiUTeA91eIfoG1RN75MHiejdsT9Lif5PViLY2w16jI1MOu+
         hb16gyJRrfgLbGSBHt3ubAkh2+OFo7YXT5CKZh3zdEjvI8q40c9yyGncNnPiYzpgs2V6
         hvxQSMdWxwndXp7UkpQPv4LlXb8DMvvgkJj193Y2oUF1EPgOLUJFPdkLzi96shTV6fwG
         c2lQ==
X-Gm-Message-State: ANoB5pmzE5DERFILzqo7HsEqdbUUfRHTjrDYXSbfGLW17c0puMLC4nH1
        Ag9Rvg6UB40/Fcym2dKKw/Pn5dlnAw/1FBrbtNp2
X-Google-Smtp-Source: AA0mqf6nGsGtii5mSj8jnKDxBTx3poEaLoCgDaw+O3nute/+/PYQizlS9CTx4NXkfpeY4/PlKyAbALgAMBWLZf2IpAQH
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:74c6:b0:189:73df:aca2 with
 SMTP id f6-20020a17090274c600b0018973dfaca2mr56500936plt.58.1670455240099;
 Wed, 07 Dec 2022 15:20:40 -0800 (PST)
Date:   Wed,  7 Dec 2022 15:20:34 -0800
In-Reply-To: <xmqqy1rj67dz.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207232035.1438092-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 1/3] object-file: don't exit early if skipping loose
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> > It looks like the only user went away in 97b2fa08b6 (fetch-pack: drop
> > custom loose object cache, 2018-11-12).
> 
> Nice, very nice.
> 
> > So I think we just want to drop it:

[snip]

> This would make Jonathan's change a lot transparent and intuitive if
> it is based on it, I would think.
> 
> Thanks for digging.

Ah, thanks for finding this. I'll make this change.
