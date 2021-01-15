Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5F6C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE1A23436
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbhAOJmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 04:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbhAOJmm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 04:42:42 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F79BC0613C1
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 01:42:10 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ga15so12412055ejb.4
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Zv71JaPcb8SRktKgG4Hbmyn+UYswiUDjPhxufDUqm8w=;
        b=jXN5WVa//k+2xGW+r/dyjutD6mSWn/8neSsEYhwRpq+LdiqfDMs5eQ5K2RlTIU89Ok
         bPUPPbxtJ5v0g8IHPMKV+dQbjkMx3YsWfkeHrC+gBtxnEwPbMBgJcbPVc/+YDIothVcz
         ddsPxPY6PZmL+0aSlFYnZTGQ6uYWT6KRARaAl/G38tC6AlrYTSnRDclJ+ZdM7aONXqBl
         Diqn6UF4AwqtlJqMvJWJyeknwllsdbp6rrK81+phedDHfaAZtCKImp8pstQTbPY8MD0N
         GxS9MoN7l3dr9g6Sp1ayQWXpr+ogZYIh+5OHssqm+tjJGdDa6gI4FqYT4rmgDf23asEp
         jWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Zv71JaPcb8SRktKgG4Hbmyn+UYswiUDjPhxufDUqm8w=;
        b=WWV/c8LN53jdClj0ZvvCcEg4fZzkjGq48XjIQYCdwKH5+t8j5o+GOc1oDpQ0TPxeq6
         SKiSHtIn3dUuHyaAAzZOp3HBdJlw70uuMVAQe/fmSI5ZU7A55WNx446uuk/s5Kfs4eMH
         BdkVF98OgS+ypvZgp1wEPWQJI8oz4uR1MGeXSyr++kq3TVhG5EWdXy9dxc5eWfl0CskO
         uRXN9Bkk2AouY0nsMrB0QtTlqpY0yS+LHc/aIrfpGJq5B1Y5pEWSaWidPNwqBYbppfF4
         xSsCuKDzKVLgdqMa6+YaVZgJ+df/s7L6ZkFDeo6+OybdnmB/0eDMyK0AIFPbz3aVYRJZ
         56Kg==
X-Gm-Message-State: AOAM533rqlH9kYvYHS58VRrMWRNwYR2+xDh5jGw1aaz6nAocDz8c/Xw8
        3bx3c4XoY7RsJ0+W9UTSTWLWqnRqdzCkuA==
X-Google-Smtp-Source: ABdhPJz+eXEH8wNlmDnGS+fwRZ3JR7FphdocVEm+d8miR1UvvgrXaRj72Ej6dkk4f1yhMIyNiBY2/Q==
X-Received: by 2002:a17:906:19c3:: with SMTP id h3mr8192623ejd.429.1610703728693;
        Fri, 15 Jan 2021 01:42:08 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id a11sm1567718edt.26.2021.01.15.01.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 01:42:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/6] tests: split up bash detection library
References: <20191115040909.GA21654@sigill.intra.peff.net>
 <20210114233515.31298-6-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20210114233515.31298-6-avarab@gmail.com>
Date:   Fri, 15 Jan 2021 10:42:07 +0100
Message-ID: <87lfcu4jv4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 15 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> +TEST_SH_IS_BIN_BASH=3D
> +if test -n "$BASH" && test -z "$POSIXLY_CORRECT"
> +then
> +	TEST_SH_IS_BIN_BASH=3Dtrue
> +	export TEST_SH_IS_BIN_BASH
> +fi

I haven't been able to find from bash's documentation & sources whether
this really is the right thing here. I.e. in test-lib.sh we've got an
existing test for checking $BASH_VERSION. As far as I can tell it's not
documented, but that variable doesn't appear in bash's /bin/sh mode,
just in /bin/bash mode.

And then there's $POSIXLY_CORRECT, does that make it 2 modes in total,
or 4 (or 3)? I didn't look too carefully, and in any case this worked
for all the cases I threw at it of running the tests with /bin/sh or
/bin/bash, but it would be a nice follow-up patch to unify this & the
other $BASH_VERSION check in test-lib.sh if we could...
