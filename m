Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F264C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 15:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9DD20855
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 15:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIg7YtcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgHNPCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNPCS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 11:02:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D23C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 08:02:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k18so4684044pfp.7
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OnBqMre8Dxivv+r677jCQpeQvj6HHPwtPKyp+N/fgOY=;
        b=vIg7YtcK6fvQnVf++EBw2ufQYzuG6kQ7kpeawtI2CeTat8oNyBUqUntJzsAMs0ihi0
         Lln6MrwJCFML27NS/jsW3QXQMZzjH0cR028GLmDpsNZCrx48YfZHpq1DLgGaNczTd8I9
         1gbzk+4pgPVjTHSBQRiAKIf13b0M8xeAVFMsOP7ihT3lKD18mHGnmadeoRqJym2MuaJ2
         Qg6DqyqBFH8MT4UNjcwvD/SpiqZbHHuTkdl1UIfdwRMu3VfCO20X+KP/w1GPH0FGrBDc
         p8LGG2j16pBmQf6/J3KhAOUS1XurrCRJ84ttDYNckoHhkdvTMuj9AL92KEY73IUhUIri
         kWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OnBqMre8Dxivv+r677jCQpeQvj6HHPwtPKyp+N/fgOY=;
        b=UfE/aWx0pdyyX0WOflVy66ntf4CSTK9KQpxlhbV4coW2JoLpt85tKpGomVYsxC8AFg
         t1RZPNQwS8RKBBTdRsiZh9VYQa737uZGekWuDl1ZCSPw5/0ZhO7zKIuD7NWqSqF/tuwO
         3Zh08zmvPty2EsaUCLGDNhq8E55D4LXuAE8fYH03B+yQhuJ1tZZrhs3MnV8yicn2Oo3V
         irNl90ziw6vCETeNVlg77oXAbpuEnNSpBORB3mEYzJrkCPBHbIcJEJEiId18hLtUZjV2
         +cqzHhwNBmyL9FV9OUBiNIn7IKCn2G8yliNbq3TMDtz3cyb66oGY39z6/3vj7LsGAFcZ
         Vylw==
X-Gm-Message-State: AOAM531Ow+p2AscxYEHyn/KKXhDu3bIi0rWBnCYXDe4NW6GgAKLut1P/
        9B9yUbYRWiV/xvR1YTY2XHA=
X-Google-Smtp-Source: ABdhPJxyR76qTqLJqe3KngpjUu/UrcLzEP2yljSx+t33AkrZ0uPIPUyouIpxxW2HB+WUhRHcWri1mw==
X-Received: by 2002:a63:df56:: with SMTP id h22mr2036949pgj.140.1597417337241;
        Fri, 14 Aug 2020 08:02:17 -0700 (PDT)
Received: from localhost ([2402:800:6374:3f71:3e6:8db2:d7ba:5d94])
        by smtp.gmail.com with ESMTPSA id q13sm8924180pjj.36.2020.08.14.08.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 08:02:16 -0700 (PDT)
Date:   Fri, 14 Aug 2020 22:02:14 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Alexander Ost <ost@ieee.org>, Git List <git@vger.kernel.org>
Subject: Re: [BUG] `make install' partly ignores `NO_INSTALL_HARDLINKS'
Message-ID: <20200814150214.GC9518@danh.dev>
References: <CAGNCYk3hGWHuSb4vDzrBE54P5y6Sm+TwfVrCfHD0LnLQWSr9nA@mail.gmail.com>
 <CAPig+cQnGUyM2cwNjDm_zys15B9n82QT6-RD7Lgyz1-XSGp8yw@mail.gmail.com>
 <xmqqimdm1ae6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqimdm1ae6.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-13 14:52:33-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Wed, Aug 12, 2020 at 4:16 AM Alexander Ost <ost@ieee.org> wrote:
> >> Despite installing with `make NO_INSTALL_HARDLINKS=1 install', the
> >> installation process tries to create hard links, and the installation
> >> fails (a quick workaround is `sed -i git-gui/Makefile -e "s/ln /ln -s
> >> /g"').
> >>
> >> make NO_INSTALL_HARDLINKS=1 install
> >> ln: failed to create hard link
> >> ‘/filesystem_without_hardlink_support/libexec/git-core/git-citool’ =>
> >> ‘/filesystem_without_hardlink_support/libexec/git-core/git-gui’:
> >> Operation not permitted
> >
> > Indeed, it appears that the git-gui Makefile does not respect
> > NO_INSTALL_HARDLINKS. The git-gui project is maintained and developed
> > outside of the Git project (even though it gets bundled with Git), so
> > it has its own issue tracker. It would probably be best to re-submit
> > this bug report there:
> >
> > https://github.com/prati0100/git-gui/issues
> 
> Thanks.  Perhaps something along this line (which is totally
> untested), as the top-level Makefile already exports
> NO_INSTALL_HARDLINKS to submakes?
> 
> 
> 
>  Makefile | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f10caedaa7..1cdbf8e504 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -44,6 +44,11 @@ endif
>  ifndef INSTALL
>  	INSTALL = install
>  endif
> +ifdef NO_INSTALL_HARDLINKS
> +	LN = cp

Since both git-citool and git-gui will be installed into same
directory "$(libexecdir)", I think it would make more sense to use:

	LN = ln -s

here instead?

> +else
> +	LN = ln
> +endif
>  
>  RM_RF     ?= rm -rf
>  RMDIR     ?= rmdir
> @@ -57,7 +62,7 @@ INSTALL_X1 =
>  INSTALL_A0 = find # space is required here
>  INSTALL_A1 = | cpio -pud
>  INSTALL_L0 = rm -f # space is required here
> -INSTALL_L1 = && ln # space is required here
> +INSTALL_L1 = && $(LN) # space is required here
>  INSTALL_L2 =
>  INSTALL_L3 =
>  
> @@ -87,7 +92,7 @@ ifndef V
>  	INSTALL_L0 = dst=
>  	INSTALL_L1 = && src=
>  	INSTALL_L2 = && dst=
> -	INSTALL_L3 = && echo '   ' 'LINK       ' `basename "$$dst"` '->' `basename "$$src"` && rm -f "$$dst" && ln "$$src" "$$dst"
> +	INSTALL_L3 = && echo '   ' 'LINK       ' `basename "$$dst"` '->' `basename "$$src"` && rm -f "$$dst" && $(LN) "$$src" "$$dst"
>  
>  	CLEAN_DST = echo ' ' UNINSTALL
>  	REMOVE_D0 = dir=

-- 
Danh
