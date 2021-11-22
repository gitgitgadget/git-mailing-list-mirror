Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C9FC433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 11:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhKVLSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhKVLSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 06:18:44 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C7EC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 03:15:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so75109151edd.9
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 03:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oRqkha2zcPXobexX3TvHdiE0oDyP9V6kVplNE0USsfg=;
        b=Hz4gNo0HKaAhDHntamm5wp/OUGRH0yQdQq5MSuDQvJBNh5lt6JRw9/ChT3djtzLaSp
         fzG5QzG7IugYC76KYJq/UkSrioAvgEiefpXc8jamtjpE4nJiS4X9UOlPn/aW+O0ipO1F
         jmmd/55WhVmugD8RzVLBk4uixgA+6Clj6t0U3jlV8piA8Nq+GSvtOZPO7kd3Z76lGT2w
         /CIKl0FvWw/oCX1TIszubyMAqbppsdMHTdantBCmVIUnXW1rF6rBewiDtuf5o5einzoN
         KrYxi46ssMoxcYAxBKh7vwrsY50A4V5NkIL1Xzg6xrVhVIOLdBVY5gF5J8IJWTicsZtd
         24uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oRqkha2zcPXobexX3TvHdiE0oDyP9V6kVplNE0USsfg=;
        b=yWaBnp4/u+tTocg+ISEUvuIYcjUcIlFCp3wd1yyklaw56gOAd6P3iYQtYe8QhBuxwQ
         4EDQSn4fPrnQHQlcz+Ld6R9ZDxyT48WLswie2UTkTzmBUmEpUgmTiBQYQtAGuNHw/uLq
         5f7c+OHm+U+M5w8b5TH4LESSQI59SorID9gyurD9BDBFK7iifAl/eanJo3nDyGDF+dLu
         k6eiaXn14SxW/NZWGReh93s5hDShfilcLvc4VIz+8T6Wzn2ggxDSNIUxef2i6ZPokNqL
         5K/jB6ENz8QiQ2M+uzUWEgfAn1QEThLWHe35gvOFW9cUtaA+HcQFIB4sZ2dh0fxcUVvW
         lkGA==
X-Gm-Message-State: AOAM532nGhztwmLhwMPISsuhAgjZ04Mam3kCCA0sGZLVQZtd2ZhaQbH3
        5Vzem8NkUTPP7GanjcJnDQohPCjCTO0=
X-Google-Smtp-Source: ABdhPJyTfEUAS2en1H1f5vVD1FMej/Az3RplE4JA9A67AE/s7CnY28FFDSut/6ivuf6bFWTf5srkig==
X-Received: by 2002:a05:6402:1450:: with SMTP id d16mr64898960edx.144.1637579736098;
        Mon, 22 Nov 2021 03:15:36 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ga37sm3200038ejc.65.2021.11.22.03.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 03:15:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mp7IM-000zHv-Fq;
        Mon, 22 Nov 2021 12:15:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     congdanhqx@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH v2 1/1] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
Date:   Mon, 22 Nov 2021 12:14:14 +0100
References: <211119.86wnl42ri2.gmgdl@evledraar.gmail.com>
 <20211122074538.87255-1-dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211122074538.87255-1-dyroneteng@gmail.com>
Message-ID: <211122.8635no1lwp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Teng Long wrote:

> On Fri, 19 Nov 2021 14:30:52 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n wrote

>> just cut -f1 instead of awk? Also don't put "git" on the LHS of a pipe,
>> it might hide segfaults. Also applies to the below.
>>
>
> Will apply, and could you please describe the problem with more details?
> (appreciate if there is an executable example)

Run this in a terminal:

    git stawtus | cat; echo $?;

The LHS of the pipe fails, but the exit code of that command is
hidden. So we prefer:

    git stawtus >out && # fails
    [...]



