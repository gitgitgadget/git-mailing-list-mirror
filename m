Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26C2C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 10:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C7A60F6F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 10:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhHDKRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhHDKRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 06:17:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC9C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 03:16:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cf5so2846625edb.2
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ENf+btia4pnMVYz/8CWwBzOYwTUsfEcJ6z1FAkopefQ=;
        b=Z6jjEZhEbky/Tm2i8NWdy5pNmjNZKVN/fFqet7saoHjNJAZ1XLPQZ80Ag77GVBOtts
         fhvA68dE54wPGnNdMa/LydE1Q1sVRC/dWhLh4l38HaLauJ4Z7zMzj6brcXxiJO1yqQNm
         sNu0W/YhwdF8ReiQyEdsTyTYGDzH5Qyi/Ww9e70FHhTsedJos886B3iA6ZY9P6UXOPvC
         Y+e97I9nvcUmg/MriA0dHp9peNGzR5bxfg+qeC/jFXFBzzd71IRrZLwh3NMnXOFjAoRl
         uYDf/xaU5qvEp7gZvpo+//LUWxGq+/V4rqL7tUJEbZr5Sdj3TZXADwEdXjga8Ywo9PbT
         /JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ENf+btia4pnMVYz/8CWwBzOYwTUsfEcJ6z1FAkopefQ=;
        b=K7aB2sxrvGWMFtcl+Y0rXyfdaXjpLWAJLEC362kAWtyNrv1w/aWVWFmgnjbnfW8uNX
         FSrQe288VyvzhOpyFmeJBY+sn2opUwWGSeJcAWuxhq9v4TihE7ZLgA+QUhYscUrQsHV8
         Kg21oXP9b9pAhRJHGB4x+WF56qNRq614qrgMaqNPAOSpA0K/e4SR/+R1fzoMSPnYt7fy
         WB4yz9iFTx/kyFKBXOkE8ifhgkJ+xlQrm7e1JFFbeds9xp9AmpazHQbgxIFBJ9H0k2GQ
         8h3qqUAIUz9RMg3ophgIE368DFBRZcXqqIlWAa0NsNPGpi/BnXzw0/XaM47In8WZJFea
         5t5A==
X-Gm-Message-State: AOAM533wxVDqTkuVYmmjnKyYmMx8rPwPjUIsSlpfshWVxFJHgS//95gR
        IkZEwrPW1qZtmkom223S3iCWtl0ILAJaTg==
X-Google-Smtp-Source: ABdhPJznvRtX85KXJUyPIoYPA+4sGJQlnBoie6wMCIV4NGWN2DxkssUz8qRo9uboOWulsPUGAEMYAQ==
X-Received: by 2002:a05:6402:30bb:: with SMTP id df27mr26708626edb.186.1628072213880;
        Wed, 04 Aug 2021 03:16:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n2sm770872edi.32.2021.08.04.03.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 03:16:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 08/36] hook: add 'run' subcommand
Date:   Wed, 04 Aug 2021 12:15:43 +0200
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <patch-v4-08.36-7cb4a4cb69e-20210803T191505Z-avarab@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <patch-v4-08.36-7cb4a4cb69e-20210803T191505Z-avarab@gmail.com>
Message-ID: <87zgtxms4s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 03 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> From: Emily Shaffer <emilyshaffer@google.com>
> [...]
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> new file mode 100755
> index 00000000000..644df0a583c
> --- /dev/null
> +++ b/t/t1800-hook.sh
> @@ -0,0 +1,133 @@
> +#!/bin/bash
> +

It appears that since at least May 2020 and across N re-rolls of this
topic nobody (including me) has noticed that this should be #!/bin/sh,
not #!/bin/bash.

I've got it fixed up locally, but thought it was not worth another
36-patch re-roll pending further feedback.
