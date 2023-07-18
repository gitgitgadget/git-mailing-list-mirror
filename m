Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC3AEB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 21:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjGRV7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 17:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjGRV7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 17:59:13 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B03F198E
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 14:59:13 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-cf284f4d7afso292915276.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689717552; x=1692309552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiCTR6QbhLcNZ6zn/2g93a7CFdYZ1CWPYgY0qqYjdCA=;
        b=LoBsRpoQgDnaByM00i7r5uA0eATvdpOuXsuY2aZXqT1hax2IOG8ZGKt2bzX5xzS0I5
         /5tfTDiPPyircdArcLzBcIqx6LcsX+Pi951NiKJ1mWqsZd2E0V1KCYp5LSeCmKxPGv/b
         aG4pBXp1k3yEs2X0CPvfwiiWSDU0rZZB2wABk4gxfKQDCcMYS6dCpRI84fPKJAVK+hgy
         liEUrAJ8vgh8mlxGGhdFXvfJ4ITx+LcIbfDOrdUkGR+4vlS9iwUX34LiZMl4jpY1HaE+
         DKHG6tuj4zwWEaeenjdRLqvEXTdUmblpPoUcTq68MCMzW3LSRU47fKlacmFW1jM8Gm69
         IYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717552; x=1692309552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiCTR6QbhLcNZ6zn/2g93a7CFdYZ1CWPYgY0qqYjdCA=;
        b=AH3FTl+HmNlsRnCk/lVNPh1/sNi6GTPNtZmWDORtaL7pLjqFn/UPZcRdXGYM0pFR7g
         //LHFHHwVgskpQ608bT8mheKwro3PiL4E7FIiO0nXMRKcYdWG9gnJVw2pf5NnJuWgnpr
         5qjaLzeaRpeL4GQYo1Fl9jwVJdRW58Kl08aXFKLmPXplBT2CFFFZ3/2PpstGt3i9aOAc
         O6VTVdOZriRif4cpVUD2gnYk8KD6C8khTZgBL6bQ1VO/2pN6sfm/abZ/tjvilQh+w1xU
         XH6znCWs9bngwyDDJdy9ahzzKEY9UPbqg2ztWvqqZSldVShpssZLz5uRB+wYQDTcNXne
         lYlA==
X-Gm-Message-State: ABy/qLa9eY/oEnNANtaorJJlc41rAR0fygNN3nqxuJXQdGudWwmBioZl
        1ORIEhpzjbvC+sUT592te+RA8BB0mIJHpNUGFVgf2Q==
X-Google-Smtp-Source: APBJJlG396rpBqDalfR1c2B0zmw2uhOWz5fgnq5pR4US97elpf78aadGK+nG2L/n/Hb/EWhfSmGvaw==
X-Received: by 2002:a25:68cf:0:b0:cef:bc0b:11b with SMTP id d198-20020a2568cf000000b00cefbc0b011bmr874945ybc.51.1689717552253;
        Tue, 18 Jul 2023 14:59:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z63-20020a254c42000000b00c61af359b15sm608313yba.43.2023.07.18.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 14:59:11 -0700 (PDT)
Date:   Tue, 18 Jul 2023 17:59:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: reject --no-ipv[46]
Message-ID: <ZLcLLGet7GDmqfRb@nand.local>
References: <xmqqjzuwgaza.fsf@gitster.g>
 <xmqqedl4gag8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedl4gag8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 18, 2023 at 02:45:59PM -0700, Junio C Hamano wrote:
>  parse-options.h       |  8 ++++----
>  t/t5516-fetch-push.sh | 11 +++++++++++
>  2 files changed, 15 insertions(+), 4 deletions(-)

The first patch is an obvious improvement, and the same is true of the
second one. Both of these look good to me.

Thanks,
Taylor
