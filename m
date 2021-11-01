Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4E7C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98CB60E52
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKAUJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 16:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhKAUJL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 16:09:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C89C061764
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 13:06:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m14so15220485edd.0
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+yiK2UFGV+HvWdjSEF15/YUTJlmzCqGlxByGCmoV0bA=;
        b=SAqdHf1Ve3I1U0ADlwR7ybJgQL44KkvGiL/mydze2pXlvxjMW8/zw/MUZduPVWUwSm
         my7tVYAImwbQEFHLh45wR4yYii/YzlIYYN14T2LpC/I97UJQfySfKNFuEk1cdIuPRMOF
         ts9uj+fBam8jhmcwMosQEKlOJ5CWuxP7HxYxELHjZUMxEhBqVeMHGFY6e9+W6zXkbh/X
         iGCZrgJsnaSFiduda4E5YQWNweDqfhuBJcnsQrpNdNOpkHepYwaDoFLG8GMBsfkiqw9G
         ZrBw0kMKsU2GFe2+Tr8YUVCm5iXWsnY6aNYqQtEKw0i0Q+BL8sQDsnQTaHlVUG0kM0FJ
         I6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+yiK2UFGV+HvWdjSEF15/YUTJlmzCqGlxByGCmoV0bA=;
        b=AF4mlyhmXn++4HIoJ9CG05feI2r0h+NjGJjiCY+e+EsjPAjAR2f0cbWkBm0KZwncRc
         GRwE3BruqIw9wu22DmvMtPu5L0vlDVfbDeDeXc32bW0WFZhvtVEXYbyXaMxhydJwh3wU
         kiODnnrqWeQ0gE9plcWdOpLS8TO0NvLjX7Nt9/BXwiUZKE2ysLLQAhfe+nv8G5kR/hU1
         k0WL6+YFc9ToQRGK6sFEBD90AX6gpnpiMwCGtQQFAq0nIsmLxSTIfhNOZIs2bpRQjkra
         udN1tW4FlV0UfqrJdv2cM2/F/NLt8757f5nZr/zlGNTqMeBC5nWNXer8tzVYXwI+2WZo
         pK8A==
X-Gm-Message-State: AOAM530rXsYmobhL2agCGFN9EVsgpH4ezHf2HNytbRpku72JvzIUc1FX
        13I14Yaixvo84KRQiMXLH2zK9OYkC35A78tR
X-Google-Smtp-Source: ABdhPJyK3Tnlc8fSk5JI0x4NpzfqYNv2m9HYO8fmIbiMd2MeBYCAgJhk94tUEH82jeLEoZ5NKdnpZg==
X-Received: by 2002:a17:906:5a98:: with SMTP id l24mr22105404ejq.557.1635797195715;
        Mon, 01 Nov 2021 13:06:35 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gb3sm7385014ejc.81.2021.11.01.13.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 13:06:35 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhdZi-002Bwq-Um;
        Mon, 01 Nov 2021 21:06:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     paul@mad-scientist.net
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: replace most hardcoded object lists with
 $(wildcard)
Date:   Mon, 01 Nov 2021 21:06:24 +0100
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <f5807fd2eb0c16ab0400e8f3138a90f564fd303c.camel@mad-scientist.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <f5807fd2eb0c16ab0400e8f3138a90f564fd303c.camel@mad-scientist.net>
Message-ID: <211101.867ddr3ak5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 30 2021, Paul Smith wrote:

> On Sun, 2021-10-31 at 00:32 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 wrote:
>> +LIB_OBJS +=3D $(patsubst %.c,%.o,$(foreach dir,$(LIB_OBJS_DIRS),$(wildc=
ard $(dir)/*.c)))
>
> Another way to write this would be:
>
>    LIB_OBJS +=3D $(patsubst %.c,%.o,$(wildcard $(addsuffix /*.c,$(LIB_OBJ=
S_DIRS)))
>
> I don't know that there's any reason to choose one over the other.  I
> don't think there's any real performance difference although one could
> imagine this version to be VERY SLIGHTLY faster.  Also this one is a
> little more "Lisp-ish"... that might be a pro or a con depending :).
>
> Just kibitzing while waiting for dinner to arrive...

Thanks. I changed it to use that in the v2.
