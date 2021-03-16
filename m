Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD5C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2672565012
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhCPFiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 01:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCPFho (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 01:37:44 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD27C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:37:43 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id f8so8040480otp.8
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ik7uKrGxwGuiJ+Ji0bkHgv2YOFL1MnovWFbwTGGId9I=;
        b=l9rE3LMYmccPxhiT8H43dI7hMM5Njp0XWvfq0ueP/FPBW+59AD0SIOdoxMwB2frTk5
         9PzdpEjMWcaM/V7J39p5Z2NaeWg0REjKUD5gt3nIg1cAWuPjXFb9oO0LYm7WlmbGthmC
         ygUs53qbJpt2BF7ngx06O01zz05zOy+0GE/Q+qP+GDUihH3/CYj6feOgXA8pwTXj2Xqy
         Kn3ZSE1RKuaU5HReJIX7Z70Lx2CSOkHEzj/5undOjpUmxsVwfX35SXv49mVABWRs1/NR
         y9zJCQUiRiI9Y2pOSP3PtJUk9sqn/4Ednamt4/QeF+o6gd+4ZHPmtpIwg+sjnLtdmlTS
         Fl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ik7uKrGxwGuiJ+Ji0bkHgv2YOFL1MnovWFbwTGGId9I=;
        b=YkCBvu1JTF0ctPIz6YrB6ZD5ccuR2UYvjhge0XEMgwIosxMHgbOH7omyE2M8KA+r6W
         6gv8RYtUX2VB60Wx5KMC+AshwnAF11b3UtTlzz753BTBoA5W6x4VaJZwBOXobDQeBWdE
         4B+XpSwHqtpOASGB4k/63CWL7D8GJ9zXbYx6B4hwBo5DY4RD9708uzLZmNIkfaWs+lyC
         mczbHbBoSpSDw+qhr4NL685nTj0KjwBgQSAc0EHj2UHgoTMQvSOzdjETK8fps1aHtRW3
         Bh5DwJcv4cZ5Z0r5348p6NBj7RS6pSLqn+2F9QlqfX1SiNVzrjqkrYbD0SfQx6A8uYq7
         E9YA==
X-Gm-Message-State: AOAM531lSVFraBpu7zHrgy09dSBaYvz22N4Wx3Dxx5FnkKhdlsSmD560
        TgUBgLD4x9TshmuVn++m5+SRQGhq46mWWLTnam38eITz0rE=
X-Google-Smtp-Source: ABdhPJw9As+dlHU5G65grqt3dAX8TB1rbzpxOi6t+Zh9qTlX1eJo59EK5yv/zSy5843oBKOgobeQVl3G+vdWr9YISIo=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr2148838otf.316.1615873063366;
 Mon, 15 Mar 2021 22:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210315234344.28427-1-avarab@gmail.com>
In-Reply-To: <20210315234344.28427-1-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Mar 2021 22:37:32 -0700
Message-ID: <CABPp-BHWDffkqXsisp9E-FJPR4PmByPWuxWkAir24WpqUu43Lg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] read_tree() and read_tree_recursive() refactoring
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 4:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> A v3 of a refactoring of tree.c. See v2 at
> https://lore.kernel.org/git/20210308022138.28166-1-avarab@gmail.com/
>
> This brings back pretty much the old read_tree_recursive() under the
> name read_tree_at() as suggested in
> https://lore.kernel.org/git/xmqqft106sok.fsf@gitster.g/

Patch 8/9 was a bit harder for me to read; I'm not sure if that means
the patch needs improvement or just reflects a personal failing.  :-)
But ultimately, it's minor and the rest of the series looks good.
With or without a few tweaks to that patch:

Reviewed-by: Elijah Newren <newren@gmail.com>
