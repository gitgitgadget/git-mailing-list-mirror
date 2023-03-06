Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE539C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 17:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCFR2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCFR2i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 12:28:38 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF214449F
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 09:27:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so9426017pja.5
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 09:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678123662;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0WBGDuCnxYTCqqVpUGUkqWXI2I4ILu3mSDK5rRfKVI=;
        b=n89WYMIrQHw6bk93cHw9LaIeI3A0AsOfzvVjCv72P7ZFACr1xpKhUFAY4nj7tv3McN
         ytygbH/RfqIu4kDpZllb3vocW1H6TV7exrplI8Ek0wBTZ/MoVw+Ri+nLR9OzxoXEeC4L
         IR6PC08oCOGcu//s5x7KHH6hhsZV3L/iTcwMmFGnE0Trky9CAyK1jd+kzomBoeegW8Uz
         GXlouEsjg7sOXZjhihzynut69f3d5KyB+6+xvn2D9XoGP6qQ7d9WKx2u6IoX3vGPw5XC
         vzIA/NLQpWSjtFoHxp2R6hr49HBDmE5B2zIFsK4JFj3ySAlZpywXOZ2WkjiDaUCUJwqH
         ANBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678123662;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0WBGDuCnxYTCqqVpUGUkqWXI2I4ILu3mSDK5rRfKVI=;
        b=T+NgI5IaYoe/jvzp3ma140BFLc98Go1oDshEsHKQEc7BM7eSzUrK/w0wso11CeN5zF
         w543GsgOUTuRdU6QXQUPEb2+pl+VdwbOvJLx0kkyZ38HyRtJEluJSaI+FLROSMWa0kRS
         tB4qMzcSWOnyn+qVth41IHJ0V11Dm1YwpoFeetJuynel/45fH4fa2zmeUQ02i9y56Bp8
         P15jdD8EaBQSeijuwCjR8kK4UJM0u6EiQ2+rT7K36uhvCEVypvkMPtplDYOr5xmvFPS9
         maKtOAov3bo8wgTvxkG+5dNcNCHNPLiXj3mGxZqrr0SnyQonoKCutc2mh5nY8vfhdiq8
         11cA==
X-Gm-Message-State: AO0yUKVWi+4U+FzGTeVxuuTZbJPj29HFtbW1WnVBFwAeG2VmZNjIHrfY
        TrfKXIxZsbhzTzdhfYeXnHFI8t2QB8w=
X-Google-Smtp-Source: AK7set8bc3Zx5Zi0le66sX31ye+JbSQ6rFwTVKQbkP0I/C8HBy6AM65zndqci5EiPqeeTV0wsijHCA==
X-Received: by 2002:a17:903:187:b0:199:1996:71ec with SMTP id z7-20020a170903018700b00199199671ecmr14123633plg.16.1678123661893;
        Mon, 06 Mar 2023 09:27:41 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id bh9-20020a170902a98900b0019b0937003esm6972411plb.150.2023.03.06.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:27:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org
Subject: Re: Bug in git archive + .gitattributes + relative path
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
        <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
        <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
        <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
Date:   Mon, 06 Mar 2023 09:27:41 -0800
In-Reply-To: <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 4 Mar 2023 14:58:40 +0100")
Message-ID: <xmqqcz5lbxiq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Subject: [PATCH] archive: add --strip-components
>
> Allow removing leading elements from paths of archive entries.  That's
> useful when archiving sub-directories and not wanting to keep the
> common path prefix, e.g.:
>
>    $ git archive --strip-components=1 HEAD sha1dc | tar tf -
>    .gitattributes
>    LICENSE.txt
>    sha1.c
>    sha1.h
>    ubc_check.c
>    ubc_check.h
>
> The same can be achieved by specifying a tree instead of a commit and
> a pathspec:
>
>    $ git archive HEAD:sha1dc | tar tf -
>    .gitattributes
>    LICENSE.txt
>    sha1.c
>    sha1.h
>    ubc_check.c
>    ubc_check.h

Another way I am not sure is working as designed is

    $ cd sha1dc && git archive HEAD . | tar tf -
    .gitattributes
    LICENSE.txt
    sha1.c
    sha1.h
    ubc_check.c
    ubc_check.h

I didn't check if the attribute look-up is done on the correct path
or export-subst kicks in in such a use, though.
