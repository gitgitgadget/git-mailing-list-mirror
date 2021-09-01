Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FB8C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736BC60BD3
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbhIANrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244277AbhIANrN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 09:47:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3ACC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 06:46:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g135so1925363wme.5
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=P2A/KF8v+/wF00S9R9R1zVprLJ9MI6GyCMnRgDZlp8c=;
        b=gij5tR5cPvZlWHDNIEkioHSSyJ7y7qqlS8AbzClmPv0KUhxmyyz6Flh3jyeH9HaGXv
         an+Dp1TF3l4D02Y7gbKjAQbZKF880jTGzK4/4xp7bfO279sbfV0EcxryJ1CSENcELC+c
         0V9FesHaw7ZrPpGcs3ih79i6Gn+MGQ6Gvpt7HlA9cLnueRyVMfpDgBEp8MNg8ANtmEwb
         Kk1jyVwLs+Xd28wHuVbuJU+0kWQIiwTc1eZnW6yeUAaTjC3jaqJHAW+Rq24xah9pBto3
         MLWjVn7jL7gBcWOozHaz95ue+Ac36E3wQCZgUwmFZ6VWqIo0mxsdlHXL7ovQfQi0Tqlp
         t43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=P2A/KF8v+/wF00S9R9R1zVprLJ9MI6GyCMnRgDZlp8c=;
        b=ltRQEomqNkOa7lUmk1qap9v1Zmzg5YGidAQlBoa2Q0YBYFekOlRPXMxyf2Vif8D3lA
         YAVQIwIoOyedSGyVoAk4g2Eac32E9PrHURD70rXg2TYAAuKEXhFUXD0v4ya1ZtopCcAE
         dw/wp26KviOVPYxDuPA1Fqm390IaPrFsmlpnsvGvhvF93lk77jbpiYY8h/oz+7Kz1Gov
         rEfB/HCGMyBgC51n9hoTMazzACn79PJUSmYGBtVd754BsHa1IsCwSBMB9s9XZ9dK1tP4
         R/QPfSVLcpWZ9JwSjwPp2leKeDWSE/EMmaVcjDvRkpItpIcY1D+OTrQAj4pIcDJz/2rf
         o3nw==
X-Gm-Message-State: AOAM530Uqaz0+9mFoJ0saC0HFaZtIL4ViY1oT8xeBPUQsCCIQwO8Q6Ze
        eeOjYIzKSBkTTEFZM+4ohSPSnB1kCbGvFg==
X-Google-Smtp-Source: ABdhPJwLYF67lULCmn78fOIaKuqSjuSaKqR1HcFFEr/zE9yyeJITHqhuORvSe5BrYoISugk7QdkQhw==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr9631084wmh.129.1630503975518;
        Wed, 01 Sep 2021 06:46:15 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b12sm24948263wrx.72.2021.09.01.06.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 06:46:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
Date:   Wed, 01 Sep 2021 15:37:06 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
Message-ID: <87r1e8v26x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:

> In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (which w=
as
> included in v2.22.0), we officially deprecated the --preserve-merges
> backend. Over two years later, it is time to drop that backend, and here =
is
> a patch series that does just that.
>
> Changes since v1:
>
>  * Rebased onto v2.33.0

I'm very much in favor if this series.

I independently came up with pretty much the same at the beginning of
last month before finding your v1 in the list archive. The comments I
left inline are based on the diff between our two versions, i.e. I found
some spots you missed (and your version has spots I missed).

You're also leaving behind a comment in builtin/rebase.c referring to
PRESERVE_MERGES. Perhaps we should just turn that into an "else if"
while we're at it (the "ignore-space-change" argument won't need
wrapping anymore then):

builtin/rebase.c-       } else {
builtin/rebase.c:               /* REBASE_MERGE and PRESERVE_MERGES */
builtin/rebase.c-               if (ignore_whitespace) {
builtin/rebase.c-                       string_list_append(&strategy_option=
s,
builtin/rebase.c-                                          "ignore-space-ch=
ange");
builtin/rebase.c-               }
builtin/rebase.c-       }

I do find the left-behind "enum rebase_type" rather unpleasant, i.e. we
have a REBASE_UNSPECIFIED during the initial parse_options() phase, and
after that just REBASE_{APPLY,MERGE}, but some of those codepaths use
switch(), some just check on or the other, and it's not immediately
obvious where we are in the control flow. Ideally we'd take care of
parsing out the option(s) early, and could just have an "int
rebase_apply" in the struct to clearly indicate the rarer cases where we
take the REBASE_APPLY path.

But I wasn't able to make that work with some quick hacking, and in any
case that can be left as a cleanup for later.

Ideally with the code comments I left addressed, but either way the
correctness of the end result isn't affected in terms of what the
program ends up doing:

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
