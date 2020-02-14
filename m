Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C56C3B195
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 08:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041DE222C2
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 08:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiKdPSiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgBNIt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:49:58 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:46043 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgBNIt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 03:49:57 -0500
Received: by mail-qk1-f176.google.com with SMTP id a2so8433294qko.12
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GWOFwA1wx1Df5LdfvUM7pJQhr8pcQzybJp1EQ7jYLKM=;
        b=MiKdPSizt+znPHi0pJVrvl2Rs3+ZUB6UcYyTX+GlIAV8tPXvWazEkWlHk3a5WWxZR9
         00GANpd2hQ0qLpMGR8mtFXFXRI8RM+x0pb/u4vvQrsDp2XjYKuUSEKINOLz4nsyBc5ZD
         j8aj86azf76DP65g5r2fAQxdJXZKIVoj2wOq2Um3dm7w31tfCOX+sWI09+Xr1sWgdZZk
         hSsAIVrMz67h32Guey3qp/m3NjXLwNxJ41+d1AqeSm+4UfWY2vaIvIDLydDnAARM/3uV
         4PativYKWXRtjwfA7zqZD3Ds1JI01TLrl/q5o6C6cAlqKE2VHYLpBEZfFRgl1SZhIbP0
         WrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GWOFwA1wx1Df5LdfvUM7pJQhr8pcQzybJp1EQ7jYLKM=;
        b=gV+cXPFfGF7Nc0mWAd7YQFBjmpKUJY5kY5ybjMOajtP88aQWPPzWJcpE3u4OhVbrjV
         IMSdMWzm8SIcCy1avv+usgKjE3xenPiDS5ydjRt1bue9cRjt+GPSdd8Kmv/Q0wjac2S2
         RxMH+5tAJGpbyGF0xIMp5Jj9aQvXm4CSURzjrgK5xfgvc7vme7T7J3UEpwcVfdPd87iJ
         +ssvDPzqlk7gCSYIJtaSVEaVWvDjZ7VzhZi+cjG3vsHbqMJRrVi6izvKoQxK8ky4IzAN
         s0G03xHsKR/l5Nrc2Cqj3Q+AaKeYZ1jsUTYDh6H1lloiBcOyTLFC1QHSGr34wRBPagLS
         cNiQ==
X-Gm-Message-State: APjAAAWUKy94YBCkVVTSN5dg2HF5C0pVpNJJOuNcDR9Qa7Q0/qjO0uue
        lS0/FsZuDw/Lrs4Muc3QPc8=
X-Google-Smtp-Source: APXvYqxIIeRXmlAPH0jW7EkWUhZATorCsyAhc8sr1MWqf/lKx2jzpqr0WhdmS4CnI4GjQfv+20d0Lw==
X-Received: by 2002:a05:620a:20db:: with SMTP id f27mr1349213qka.78.1581670196432;
        Fri, 14 Feb 2020 00:49:56 -0800 (PST)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id x4sm2808487qkx.33.2020.02.14.00.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 00:49:55 -0800 (PST)
Date:   Fri, 14 Feb 2020 03:49:54 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Robear Selwans <rwagih.rw@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC][GSOC] Microproject Suggestion
Message-ID: <20200214084954.GA5878@generichostname>
References: <CALH1-Xr_pK02j6_51EnZN=ZrSz6dijt9tn0ANJ21331GzAmBdQ@mail.gmail.com>
 <xmqqy2t6osht.fsf@gitster-ct.c.googlers.com>
 <CALH1-XruJ8UnHTN+xi=NOPtoP-p_F2OCmkLai8kjzsLObg=AvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALH1-XruJ8UnHTN+xi=NOPtoP-p_F2OCmkLai8kjzsLObg=AvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robear,

On Fri, Feb 14, 2020 at 09:29:33AM +0200, Robear Selwans wrote:
> That was actually the only idea that I could come up with till now. I
> am open to suggestions, though. I don't really mind if it is too big,
> as I am also interested in contributing to git.

Even though Git doesn't have an offical issue tracker, one good place to
look is GitGitGadget's issue[1]. It's pretty well-curated and has a lot
of tiny cleanup issues that you could get started on.

Another thing you could do to find inspiration is to search for
#leftoverbits on your Git mailing list archive of choice (most people
seem to use lore.kernel.org/git).

Hope that helps,

Denton

[1]: https://github.com/gitgitgadget/git/issues
