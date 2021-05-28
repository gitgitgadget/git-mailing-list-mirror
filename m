Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20942C2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 16:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B1061184
	for <git@archiver.kernel.org>; Fri, 28 May 2021 16:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbhE1Qbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhE1Qbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 12:31:46 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44FC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 09:30:09 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id q17-20020a4a33110000b029020ebab0e615so1059751ooq.8
        for <git@vger.kernel.org>; Fri, 28 May 2021 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=X4f6+Yk3e0EPc8R+rLe0eEw2w8uy4JzjaT6jcfpl9T0=;
        b=Jaaa33vGGstqtbwQ8J3U8EkyMSmN5w0NPjqv3JtJy7NQM3Qtv7S/kpcx0jDExwGBsX
         GsVCcRW3h+1x70J4In+aI06WQCaAS43N8aQ7LZPmAYjCyC0pH6AR4SQhj1vllqod8/I0
         4yxSEYiGq3BX+uXdw8TyoHEIktD7UKYYlNJeX/yTcOnaG/8VDWeNnJtVFvPDK5gqOTeE
         RfCrijJFa7wpnW45kLusOmV7/DjtzOk6A8JpKyXB7Abbv2ww92ELpVorI8FFPJ2RkuTA
         BAMT4pWhxgc5pYw05Ic4lSk1aU4eDua1o+usj24B24J8P/VXJS1dAecd6bcOmNtztZ7b
         CARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=X4f6+Yk3e0EPc8R+rLe0eEw2w8uy4JzjaT6jcfpl9T0=;
        b=fY7hjtt8F7Ub/n2SUUnidH+2PB/00SxW8s+Fe34Y2prNqtp1KjRPSpmMvc+4hndkCG
         YkRTKGr5wgVnEBxrr8o+OymFgfqjX3x3pdR3KyM95icdYrZngY6UY9lbzv+B+rltekHi
         CFAbhgwDh4nFHraSng3fYtsdljnPUs39RCMm2LBPGj6bIOt+MhqfWmbRNzJVAE+oblxn
         2YWtrhSB/MX6b3q0t/ITy6c48gsDvEtwhA4+vhyip0YVbQhFuDFQx1raC6TyvxEzSzYu
         ouIxm0XMivo63lWcRcMOb/fGAu7GwhUDg/zRG6ixShtZdHPde0wlb7rjitxBN7QHupwr
         aC9g==
X-Gm-Message-State: AOAM532j8jwGSzjqBe0+1r0EXDjE1t5sPy9P81/YPn3rXFphV/+lGEWD
        pgvkhi/ELKJjK2G/PJqmen4=
X-Google-Smtp-Source: ABdhPJxKxTnhNg9SNNwjKp7m6EjTSpWJz2zJdTtDvmdUGueccXUm5urAzUNmOdsTQXSYbiNDKvrzgg==
X-Received: by 2002:a4a:b98e:: with SMTP id e14mr7621165oop.82.1622219408612;
        Fri, 28 May 2021 09:30:08 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w198sm1185947oie.26.2021.05.28.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:30:08 -0700 (PDT)
Date:   Fri, 28 May 2021 11:30:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <60b11a8e323ce_4b032208ad@natae.notmuch>
In-Reply-To: <CAOLTT8RbVsZuAwUZ-yn_Wwnvq7qyziA=4z=skMoGdPCTdQ5KPw@mail.gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <60afca827a28f_265302085b@natae.notmuch>
 <CAOLTT8RbVsZuAwUZ-yn_Wwnvq7qyziA=4z=skMoGdPCTdQ5KPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu wrote:
> Sorry for the weird, unclean `memcasecmp()`, I referred to memcmp()
> in glibc before, and then I was afraid that my writing was not standard
> enough like "UCHAR_MAX <= INT_MAX", I can't consider such an
> extreme situation. So I copied it directly from gnulib:
> https://github.com/gagern/gnulib/blob/master/lib/memcasecmp.c

Yeah, I imagined you copied it from somewhere, but when you do that you
need to transform the code to the style of the project. I've seen GNU
code, and in my opinion it's too verbose and redundant. Not a good
style.

But more importantly: at the header of that file you can see the license
is GPLv3, that's incompatible with the license of this project, which is
GPLv2 only (see the note in COPYING).

You can't just copy code like that. You need to be careful.

And if you do copy code--even if allowed by the license--it's something
that should be mentioned in the commit message, preferably with a link
to the original, that way if there's trouble in the future with that
code, we can follow the link and figure out why it was done that way.

Also, it's just nice to give attribution to the people that wrote the
original code.

> > Check the following resource for a detailed explanation of why my
> > modified version is considered good taste:
> >
> > https://github.com/felipec/linked-list-good-taste
> 
> OK. I will gradually standardize my code style.

It is not a standard, it is my personal opinion, which is shared by
Linus Torvalds, and I presume other members of the Git project.

The style is not something that can be standardized, you get a feeling
of it as you read more code of the project, write, and then receive
feedback on what you write.

It's like learning the slang of a new city; it takes a while.

Cheers.

-- 
Felipe Contreras
