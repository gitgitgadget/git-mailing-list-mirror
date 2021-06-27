Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26F8C48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 17:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC2E619F1
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 17:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhF0RES (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 13:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhF0RER (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 13:04:17 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314B8C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 10:01:52 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v6-20020a0568300906b0290464d9be9510so4353268ott.12
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2HMfaRtH7BeEcUOmamEXmOMpqGaqfU6ovaXg3B6V2l8=;
        b=OnH3BNN8S2YSwYRL7ORa9i5gqyd1SM56YegT3Re1L3GJ727i1di6iXfwMPJLOFtv3U
         kVMuUVfzx+/QRm9dckzq2S7u+aK3tUne+o/UTmlwp8EoXbGVeHLQQ2MKFHOqbPpVodvY
         EylGL3xjh/SPP8RsJq3aUwglZSncDnqPC2HUUu0zu/OsdHycrqWPoiIkhPfJnTUZXT7Q
         nmFosnogvcZFHTb/XS1EpHiZF4CeD684vADMj9hbmZ5fW0/fnLPmcqAzEfITWp+E97CF
         nvLO62lKWu6MUigr0mHCHz996eUaj8TRAcfdEWT9wIlE/6QJpo/RwfJbM6PNWkOjI1y8
         X6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2HMfaRtH7BeEcUOmamEXmOMpqGaqfU6ovaXg3B6V2l8=;
        b=NNs9PbLuP8m9t5NOXqMkUndo6fofsPmJxSOU4uxVvnwpInNtP5k9fgmYV2HJF2ah1Q
         t0DCXhcEWInTwuWc9uNzgUvPgFYs35q6NfKVNNog7939f2SxtF8zDNaYqQtyCLvNRYeY
         bbL4disVuKjule7UURDCfr32yF6xvKnBtrI2SCdhwxT5QmHqd4nSU9NyopJX8ajGSRHj
         k5HA3xsvHMFqYo9IZnq4E9zp1R5/AjBPBfGnkGlDrbgN4TEKaL9BWDq4WVVmXvkC0QSV
         RBlI1KGPkqD/UOX2WgfashYCe6TcVu5LhDZxdhy7+6iZESdMpJ8d+UVz9BR0bY8IpA9z
         fd7Q==
X-Gm-Message-State: AOAM532/PGTXHrrNMZwXkafWJWNghn7W3n8OaFtOw9Gbsw9wzolEiOnV
        UDPjrUKJCUxrg6SWT+sB09k=
X-Google-Smtp-Source: ABdhPJw/ON4poMQvVWVp7NCOIXAP6gcyZT7Y0aJRqgD1BtZ6tnzvDf9H6oTGHS9gWvI8dcsF970LVA==
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr18101777otl.8.1624813311560;
        Sun, 27 Jun 2021 10:01:51 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id o71sm2110472ooo.7.2021.06.27.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 10:01:51 -0700 (PDT)
Date:   Sun, 27 Jun 2021 12:01:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <60d8aefdb7f1a_ba9f3208ca@natae.notmuch>
In-Reply-To: <4E38928E-A98D-4F57-8866-8A237B31DDE0@gmail.com>
References: <4E38928E-A98D-4F57-8866-8A237B31DDE0@gmail.com>
Subject: =?UTF-8?Q?RE:_[GSoC]_My_Git_Dev_Blog_=E2=80=94_Week_6?=
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar wrote:

>   * Reflections:
>     - How does Git even start?
>       (https://atharvaraykar.me/gitnotes/week6#how-does-git-even-start)
>       This was just something I was curious about, not really important
>       to my project. If anyone knows the answer to what I asked in that,
>       section, it would be nice to know!

They are not all linked together.

Take for example shell.c, which will be used to generate shell.o, which
is used here:

  PROGRAM_OBJS += shell.o

PROGRAM_OBJS is used here:

  PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))

This means shell.o will be used to generate a program called git-shell.

But the "git" program will not use PROGRAM_OBJS, therefore it will not
link shell.o.

Cheers.

-- 
Felipe Contreras
