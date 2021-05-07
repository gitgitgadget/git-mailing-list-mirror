Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A950C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 12:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BDF61460
	for <git@archiver.kernel.org>; Fri,  7 May 2021 12:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhEGM2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 08:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhEGM2O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 08:28:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68E9C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 05:27:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b15so7516515pfl.4
        for <git@vger.kernel.org>; Fri, 07 May 2021 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sJZDS32xPbVqM+tkV8H509NEAGeV4YQ+eXYdTfPpAAc=;
        b=olSOMgXI1awLVn5vSSL22tCuz9+E7Ct3s/Q5ru/w6Zhq5OwC+BrxlOlBxHXDulFlS0
         X5FFkGL0DeT1oS7Bda4a6bR6jMhb7m6ThRPF4QPzGwayVxb+04o8GuqQFbBF3dEh/QNu
         shUxc7srodB3cJvuUIw7k7MBZSVqXYFNvIsuMjoGtwwAKZr2NHhosuiLBKMsHpOMW3Qd
         MiduGB9kUawETVnU0yt4flzqOum0Tmo59nt5D0f0sQBy4FGiYgO9NsTO07nBV6kdcr2c
         ReBC9GY+G7kiwddp2+7DTLhN+kiBu5/2aPIV4PWyoTCqjJV3B4KNBsYgy8tYZU2I5rhY
         8uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sJZDS32xPbVqM+tkV8H509NEAGeV4YQ+eXYdTfPpAAc=;
        b=V7X1RU++YSHXwd1qWRNDQqoEc4qpauJGIh/wZtYRahgdQTGW+VmT7/e+IEJu9gRoCd
         6uJlfzNnjDQGu4W2aKkgfDXDFooz15giWg2QLTw4C1OrKRs6CAA48rZMWJhSElEHWTWF
         HbW+zXM0q+9rChIvT/SiQObCBDakFtNZuO9YnlnKd8Najefdd7TVG3EIHORUOVIm3sMZ
         qCA3sNc0N8BI565asw41JBtGrrXuCeCiCEQsDG096lC09qZ9ChiF6hjER2HavuBbYFTI
         BnwDmzRH+0XJgnjaQTBRCZJQ/N5CnJyU0D+M8BYk+Ghn6gNvcsSRFqt7ZGBJIBNXXrv+
         sO6Q==
X-Gm-Message-State: AOAM5321tGUyfGTLGMkdob95P5ivGqu/0oPTFv3QsyucKiKPiWNjXUtw
        Kg0fDO6bTbjwtoFVfau1m4Fd3SAjRLIOQw==
X-Google-Smtp-Source: ABdhPJyiCHrnXyOKLzPWERJaxtNhOAfbKg3yLqE7bp3i3F2h1FApdLoE3FFd+2fUeUS1gZwiOXTgaQ==
X-Received: by 2002:a62:75c3:0:b029:27c:d30f:66a6 with SMTP id q186-20020a6275c30000b029027cd30f66a6mr10329819pfc.0.1620390433417;
        Fri, 07 May 2021 05:27:13 -0700 (PDT)
Received: from localhost ([113.185.84.38])
        by smtp.gmail.com with ESMTPSA id a65sm4993494pfb.116.2021.05.07.05.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 05:27:13 -0700 (PDT)
Date:   Fri, 7 May 2021 19:27:10 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJUyHkYAIth0W9dY@danh.dev>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-07 13:06:31+0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Hi,
> 
> Asciidoctor has support for directly generating manpage, see [1].

While I'm impressed with this news.

> We support using Asciidoctor as drop-in replacement for original
> Asciidoc, but currently we need to use xmlto together with Asciidoc(tor)
> to produce manpages. However, most users don't inclined to install
> xmlto toolchain, partly because they had to download more than 300 MB
> of data just to install xmlto and its dependencies (including dblatex
> and texlive).

I'm pretty sure xmlto doesn't depend on dblatex and/or texlive.

I'm building Git and Git's documentation on different Linux boxes with
asciidoc, most of them don't have dblatex and/or texlive.
In fact, I only have texlive installed in my laptop.

I guess you're using Debian or one of its derived distribution?
Debian puts dblatex as xmlto's rec. [2]

I think you can use:

	apt install --no-install-recommends xmlto

to avoid those recommendations.

> So completely migrating to Asciidoctor can eliminate xmlto requirement
> for generating manpage.
> 
> What do you think about above?

Hm, I'm pretty sure Ruby (asciidoctor's language) is very hard to port.
Last I heard, it's buggy on some platforms.

I think we're better to do like this:

* If we're using asciidoc, we will use xmlto
* If we're using asciidoctor, we will generate man-pages with
  asciidoctor directly

> [1]: https://docs.asciidoctor.org/asciidoctor/latest/manpage-backend/

[2]: https://packages.debian.org/sid/xmlto

-- 
Danh
