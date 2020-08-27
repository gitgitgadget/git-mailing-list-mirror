Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E42C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9152C2087E
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3ZTwC3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgH0TeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgH0TeI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:34:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC240C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 12:34:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id i13so3176999pjv.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l+JV7NUSbGcMfZ6MGBPDdYonBrxfe0OQTH2UuyWu/mg=;
        b=i3ZTwC3b9n6KaxMIzgQVouKZc8CNye9CS3gnOPrU1/DkRudYMwAFjgoHGdZ8uMVs78
         E0omSZcOPNRBvy3cKfkEWAnPWBLF6bBOF+dL6gyZTkaliZhPlyBwg2TX/OQq8Nd6fmmY
         fPOwpC3JZZq8rJQW5tWYpBDWANhUh6PyXWPO6y3lNtcC30clXtsRs3GQcDIHwqJsUGBv
         Mg3vt2xKcy5JFaTfxxV4Ny1IhdyohXA/CjQ87W8lcXM05XFoHE0DCohiSZMd1w+qNkl4
         ZyRx3VeG/7BBQdXqhizok+6G9coGjn2veH50lluqwZZNDdO8/QuTI5EGG15t8hdexW5Q
         t/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l+JV7NUSbGcMfZ6MGBPDdYonBrxfe0OQTH2UuyWu/mg=;
        b=S0TwMWKs33FMdRACP1L9t5p4VYMzzsAUwplSxS2uWR7X1u1pWwfmKdnpd7RH2JBJmL
         tpBLzGbi7bops7TuNth23FXTd5A9ua7f/EAFOikXW8EXQiGlEhrWLsluo7VcRYFTaZNp
         eO74wgOCHgda7atnf+QJvbUg0rtGHxIdtdMh6Ge0w1l9JpLRhkolb1JSAn01u4hitMPZ
         cUNrlxOZNFX7Z93RPKoHsp/FHXTup1W736hmKcQfxUvj6gqgbKuOTdOgKFUTkgE06BH+
         QSxKxjMuyN0R/BGUH5NRPpj/ItYJo2WN7pQX8u0lEAEaLE3TCbEh9gDN3mdCfSnWQo95
         V66g==
X-Gm-Message-State: AOAM531G2aqb/8kQgQZ2a7yip2Jn3c5OXA3p6hiL0StanVj1FR9kxbXS
        1ElJKgVYflhMzmZC4cIRtN1PDA4Y2P6SxQ==
X-Google-Smtp-Source: ABdhPJzpi9+EBTjhHLxsUFRpKmqN9S8TJFRFggVfuIQJMKemjJhfy+YOHGK5HqOdk0NYYT2ez3wVhQ==
X-Received: by 2002:a17:90a:15c8:: with SMTP id w8mr324746pjd.179.1598556847757;
        Thu, 27 Aug 2020 12:34:07 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id s6sm2912770pjn.48.2020.08.27.12.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 12:34:07 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:32:34 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
Message-ID: <20200827193234.GB63138@Carlos-MBP>
References: <20200827192029.GA63138@Carlos-MBP>
 <C580VF2ZNJ0D.2WFFMIG1B5LO3@homura>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C580VF2ZNJ0D.2WFFMIG1B5LO3@homura>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 03:23:00PM -0400, Drew DeVault wrote:
> I can reproduce both on git 2.28.0 and on github.com/git/git master.

and you use --compose to send an email thread directly instead of
doing first `git-format-patch -o`?

Carlo
