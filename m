Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4371C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 21:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBBD2072C
	for <git@archiver.kernel.org>; Thu, 21 May 2020 21:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgEUVul (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 17:50:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35207 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgEUVul (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 17:50:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id n5so7934194wmd.0
        for <git@vger.kernel.org>; Thu, 21 May 2020 14:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtvXStvRGACDaSKUQ/lw+faAcIynA+/W4CkCC56qV80=;
        b=h8j7F6OfnALgNOat9PZc4myuaP8odkJDeHDdaBpr67hTkGWCCtTYdaSYvID8QK6xYC
         L0W5SDw6VchRU4S8+fJ6H3xbC9PmuEDhc0Fke/Osx6qXriuCDdAQdz8jSGElsCl/BiNv
         N8cXpJmbJxVcxlDxtsD899ytlknmU6Pd85EWEF/4D/H/wK7nUVRLiKxggiQVjwNYX1gn
         9HsvRLXUzCUcHvcK71sVGwhTKTPUG91nS6qiZirVgOwwsqZjc3VFd+4yTnQzhfDQyVNr
         9u2g33n9qlklBRriKACByErVOGzXuXZLqlS3T7ARGNZzZToAX1FUKXSB5y2APpzgkzm3
         WxUA==
X-Gm-Message-State: AOAM533BvEszfNj7uuiIf1AP2EooOLeybP/Z4VDoZ9M2Z8JkJDmsH/xe
        O152g6LCFQ3xGHYHGOkOuqKR0bpAo8D8ufw8pq+v/Wpm
X-Google-Smtp-Source: ABdhPJyE+OsCuWsCTMpBM0LyXnb5w1tJbjHpRgmSyxNv73eqIdl8IrPdN9BZUGK6LbQm9dhMzeIOIlp47/a9VhaOUS8=
X-Received: by 2002:a1c:8049:: with SMTP id b70mr658641wmd.53.1590097839076;
 Thu, 21 May 2020 14:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200521214544.8784-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200521214544.8784-1-luc.vanoostenryck@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 May 2020 17:50:28 -0400
Message-ID: <CAPig+cQsYSE30ab9qQO7V+CzAdUodpw64sCnZH+1s3oD-P6msg@mail.gmail.com>
Subject: Re: [PATCH] sparse: allow '{ 0 }' to be used without warnings
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 5:46 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> In standard C, '{ 0 }' can be used as an universal zero-initializer.
> However, Sparse complains if this is used on a type where the first
> member (possibly nested) is a pointer since Sparse purposely wants
> to warn when '0' is used to initialize a pointer type.
>
> Legitimaly, it's desirable to be able to use '{ 0 }' as an idom
> without these warnings [1,2].

s/idom/idiom/

> An option have now been added to Sparse to turn off such warnings.
> So, add this option to the SPARSE_FLAGS variable.

Do you have a reference to the commit or Sparse release notes which
mention this new option? It might be nice to include it here in the
commit message. Also, should this minimum Sparse version be mentioned
somewhere in documentation so that people invoking the "sparse"
makefile target aren't greeted with an error about
-Wno-universal-initializer being an unrecognized option (assuming that
older Sparse would complain about it)?

> [1] https://lore.kernel.org/r/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com
> [2] https://lore.kernel.org/r/xmqqd07xem9l.fsf@gitster.c.googlers.com
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
