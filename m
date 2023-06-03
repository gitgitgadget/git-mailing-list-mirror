Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A766FC7EE29
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjFCB4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjFCB4P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:56:15 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC1E47
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:56:14 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3980f2df1e7so2248941b6e.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 18:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685757373; x=1688349373;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vx7KuetPDhqbssjQgjGPScyoTynyEmLkUeFsaDBeJwU=;
        b=H6KJholjY3gHcJg9fszeUUM9e7idfQC0R3XP0qasePvvaEJ7l7HQ2SnhlKy4gOv3Lx
         cdotuzzAXQNNKowm3OUgUU5dXIm7fs9D1uOhmjvtwR8YIo4+Bz6HpPWS6C2g6ctQk56S
         fWYziEcAsyv/YcEjUxwvdj+b3X/+lXWQu2VXeT2l2Js4QNEAX1LW8e3GR+C5ioWY1ov+
         sbyy3te8ViV0ci1483qFnL5o1EIRjSftX57kM9/xdNvcGXHwng6Xtg9ilf3wMEWmDl9f
         ZNtLgnYYGfBme5X88tjAt6eAh3vDupN2mYfuaZZkmDZiho8ePhpNxUav/2/68bHTAOkZ
         Me4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685757373; x=1688349373;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vx7KuetPDhqbssjQgjGPScyoTynyEmLkUeFsaDBeJwU=;
        b=cUQHH7/Hl5HALs58Nu84ihUXKyizU43LMSHjXCkZ5T/6L4foutCWtLGoq15Z8QrIS8
         ch1MsBlen+mz6ovBbD3mPri4PM16YhFeXUTKiDdhrMimaR6+bSn5ubWbN8yhu7OrNzDs
         44Zr1VkwusuQLUzQWSPmd7QPFQzjgAIuujuWQkybsAezZ4lpIZ17R27oL+x/n/pYEoPW
         JY/A+enuTPAA4YSdi/9ZEcPCQpFErtqAjp0z0DIZc84xJ1lZ4hF3i7yPFBpesh38cXcb
         EOLjvLkqwrHaa9l8w4YW85O43cRlGZh+hC6uXI2OrzBA2yEVi0isZd/4L0bOU+4OX0F9
         deGQ==
X-Gm-Message-State: AC+VfDxCX31EtVX/qlVNDwHMya9MeVV0mpcLQyZX+V+52QvGxoqYmkxz
        xXJxOKLZ9b+r49OzIMOpHic=
X-Google-Smtp-Source: ACHHUZ5gORXuDMmjeAeDsBbkz7Z+3lDDoCJQy1XROrIkMzhfONzzkPRySbsvnMxdFSBM6gSzHSn+ZA==
X-Received: by 2002:aca:f18:0:b0:398:2a8a:1e02 with SMTP id 24-20020aca0f18000000b003982a8a1e02mr1846301oip.45.1685757373372;
        Fri, 02 Jun 2023 18:56:13 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ce8300b001ae365072ccsm1989342plg.122.2023.06.02.18.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 18:56:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Alejandro_R_Sede=C3=B1o?= <asedeno@google.com>
Cc:     asedeno@mit.edu, git@vger.kernel.org, newren@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH] statinfo.h: move DTYPE defines from dir.h
References: <CALVMLfLw4P=VnBOYA-WbHRNPZiAiO05h4k+cSvPJuaqkjgp5ew@mail.gmail.com>
        <20230602192700.1548636-1-asedeno@google.com>
Date:   Sat, 03 Jun 2023 10:56:12 +0900
In-Reply-To: <20230602192700.1548636-1-asedeno@google.com> ("Alejandro R
        =?utf-8?Q?Sede=C3=B1o=22's?= message of "Fri, 2 Jun 2023 15:27:00 -0400")
Message-ID: <xmqqilc571hf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alejandro R Sedeño" <asedeno@google.com> writes:

> From: Alejandro R. Sedeño <asedeno@mit.edu>
>
> These definitions are used in cache.h, which can't include dir.h
> without causing name-hash.c to have two definitions of
> `struct dir_entry`.
>
> Both dir.h and cache.h include statinfo.h, and this seems a reasonable
> place for these definitions.
>
> This change fixes a broken build issue on old SunOS.
>
> Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
> Signed-off-by: Alejandro R Sedeño <asedeno@google.com>

This is a bit unusual; do you want to publish both names (I am
assuming that they are the same single person)?

I thought somebody in the earlier discussion identified the topic
that was problematic by bisecting.  It is a shame to lose that.
Perhaps it is a good idea to rephrase the beginning of the proposed
commit log message to mention that, like

    592fc5b3 (dir.h: move DTYPE defines from cache.h, 2023-04-22)
    moved DTYPE macros from cache.h to dir.h, but are still used
    by cache.h to implement ce_to_dtype(); but cache.h cannot
    include dir.h because ...

or something?

Why does name-hash.c end up with two definitions?  Aren't we
properly guarding against multiple inclusions with 

    #ifndef __DIR_H__
    #define __DIR_H__
	...
    struct dir_entry {
	...
    };
    #endif

or is there something funny going on?

Thanks.
