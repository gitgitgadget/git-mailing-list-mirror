Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F52C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 18:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiJMS11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 14:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiJMS1E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 14:27:04 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A5419423A
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 11:22:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id x16-20020a63b210000000b0045f5c1e18d0so1396823pge.0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=er+nPnEFqlukJaH0xjZZpKKDO0ZDQ9g/NmPUmd+zWo4=;
        b=mnwYeAGNj3U1yExi+62SgTRZ+7kDsmPvmg0eaSGbJ2sRQuWEV7497Nyr06OYwKyGma
         fhJgrmFIGm9F0j8AvYGr3+dSfy1rPPpz0n1/wys/zvp3NZIHtJ2JBNv97VKwad8LXKWQ
         EikucJw1sukAg+FEnGfpjVRNC71aApyDV5B0w1WPPzVuHHjHRoJSD4kvyio1DaxDqHdX
         bSHBYa91/NBvzicROIPRowY17i8ffWC9fGZuK69MWJ3gUwviSoLGS9DnVVuzx7NlxQDn
         LjZFwaBT7HHJVC22FIZ3xxgJu7NxU9wp8EDQ/H6IlOuKXiSmZ2kj3sXm9GXyQu2fd971
         LdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=er+nPnEFqlukJaH0xjZZpKKDO0ZDQ9g/NmPUmd+zWo4=;
        b=jnoO8kDZ9p8cqFS/YpJJjMhcVVZrIzl3yszWPCw1pixfomyH2qAfF+NMHmsz8JbnRu
         ceWSEudHjUTLHfgQc1XSwz+9m34Q8lpVOop/jjVkgY0MUwqPQXxH1ZFUImRNjxktc15D
         WxTwgDlRjBDp50hoWRuhKo7Vkd9oQRF82yVfsx0jGLG/HLHhJ3Ojli+XOFc60+QBJIHx
         X4PEWcJlz4hDzYEAO0FDLbl1H5R4b0IJRjh+gKQwvAzjIp1saORNvp9zUn+sRhxLUtTf
         9hjNtQsVLVXpTWjAqkqhP7jJj6lSLuwLQ8NYypmzwZFd8783PFX+i+RQ+UAkTiiUcGg/
         7qHA==
X-Gm-Message-State: ACrzQf3nkrAch2kUn1u23ozJNd3cG8yCTbhGYVsnsR2ihEe/Ctm3jJQT
        XecxSqSAggKQ9lxSDsWz9JySMzC4WFKesA==
X-Google-Smtp-Source: AMsMyM4GFYYI3oNTpOZf+Be2GJzkN7LS3pBYHeqWGxY3oNUEZaOny3qZewf6TMQmKVuQLTuoKTzSj8xNYx9bew==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:41cb:b0:183:1648:be0f with SMTP
 id u11-20020a17090341cb00b001831648be0fmr1184472ple.18.1665685263496; Thu, 13
 Oct 2022 11:21:03 -0700 (PDT)
Date:   Thu, 13 Oct 2022 11:21:02 -0700
In-Reply-To: <pull.1360.v2.git.git.1665683027912.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com> <pull.1360.v2.git.git.1665683027912.gitgitgadget@gmail.com>
Message-ID: <kl6ly1tjzisx.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2] config: respect includes in protected config
From:   Glen Choo <chooglen@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Cc: Derrick Stolee derrickstolee@github.com Cc: Taylor Blau
>     me@ttaylorr.com Cc: Johannes Schindelin Johannes.Schindelin@gmx.de Cc=
:
>     Junio C Hamano gitster@pobox.com Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bja=
rmason
>     avarab@gmail.com

Ack, cc-ing folks again. I was quite certain I got it correct this time
though...
