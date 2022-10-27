Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAF3FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 19:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiJ0Tne (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbiJ0Tnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 15:43:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE0680BCA
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:43:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pb15so2576466pjb.5
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnOWPXwxltF0+X7TPHBsVy0L8ufKZqNunrOFVI5P1BY=;
        b=adk8KFOZGF7N2RYSJQQSYwMviByb6bhqYeRjbZ1ZMhJtxUxXLrgq3E1QwNOzbhlmKP
         78w68I5pormXrRATuvFRDm/0c+fOzJapvYOrCucHgQpStg7W0BDHIMwI3bBzVCYiBtzh
         2MltChKRPaUHK/9HfILlsORzfl9npuJ6bUv7omw1jkSxQd5B14tbYql3jnPEjtbYeTJs
         izfDg2601Pm89L0zjZQUlfzS1oSnEHUr5/P6/OjGGiuR23cptaTQVvOtjyjLr+AyJ1Br
         +T5DQ8/juDz64boXZ/JbmkmvhWM9q2dRiIXkg9jK3ea+ZsjqCS4NK2zp1zTPdJ99DBJz
         TDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnOWPXwxltF0+X7TPHBsVy0L8ufKZqNunrOFVI5P1BY=;
        b=sGs82JkTQBW8ct1soQXzDPuPfp3EvVxsxoLbWPyUP7NImcZ7kYZfCUt2YEZClpfK/l
         0H8aatbDi0hiHhIFfxatMUrAfhm471sEJFfmdVZlxzuHxO0pjAOuBM2MaUa9BVxPQJd9
         DY/JboRbQ9N3K2Wi1DCOsueQSo0kmuOgxUWTR9DTeuGcAFpDcQuYA4K0/uGPm1B8r8Xo
         39tWPxkKWcB+pJJWN71OjSwhiRpRQ1MlBl8cRasIwHVMFDiYZJakQGD2MMBhfr1JZzYO
         yKanT48p86dH9P2vx+SR331ZW2EM4LdX3UJutiyEGHajmM3MgaLUpKDoh88uBry5Szm6
         is/A==
X-Gm-Message-State: ACrzQf0LapBrY+9/oX57EJUwyvi4sgugiyQ8mYl5L6WonXs6RNQguXOG
        Uhj0+1Id/8LGU17Iu00fi5U=
X-Google-Smtp-Source: AMsMyM77c+QHR9mugIPXM9P8QwV+RlfxO7k0V90R/0W2fH1REq5h6w8G0SIuyiYcsgZSh4m2gKQVkg==
X-Received: by 2002:a17:902:dac3:b0:186:a437:f4b9 with SMTP id q3-20020a170902dac300b00186a437f4b9mr23497697plx.29.1666899809642;
        Thu, 27 Oct 2022 12:43:29 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v1-20020aa799c1000000b00565b259a52asm1547937pfi.1.2022.10.27.12.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:43:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 08/10] config tests: add "NULL" tests for
 *_get_value_multi()
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
        <patch-08.10-e7568dbe6fe-20221026T151328Z-avarab@gmail.com>
Date:   Thu, 27 Oct 2022 12:43:28 -0700
In-Reply-To: <patch-08.10-e7568dbe6fe-20221026T151328Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 26 Oct
 2022 17:35:21
        +0200")
Message-ID: <xmqq8rl1kq73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> A less well known edge case in the config format is that keys can be
> value-less, a shorthand syntax for "true" boolean keys. I.e. these two
> are equivalent as far as "--type=bool" is concerned:
>
> 	[a]key
> 	[a]key = true
>
> But as far as our parser is concerned the values for these two are
> NULL, and "true". I.e. for a sequence like:
>
> 	[a]key=x
> 	[a]key
> 	[a]key=y
>
> We get a "struct string_list" with "string" members with ".string"
> values of:
>
> 	{ "x", NULL, "y" }
>
> This behavior goes back to the initial implementation of
> git_config_bool() in 17712991a59 (Add ".git/config" file parser,
> 2005-10-10).
>
> When the "t/t1308-config-set.sh" tests were added in [1] only one of
> the three "(NULL)" lines in "t/helper/test-config.c" had any test
> coverage. This change adds tests that stress the remaining two.

Good.
