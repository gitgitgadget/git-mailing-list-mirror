Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F5BC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 11:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D842072E
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 11:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUDYoNw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgIQL6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 07:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgIQL6b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 07:58:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E32C061756
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 04:58:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w1so2244099edr.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 04:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=oYGv2Gjr3O553L+c7GBhYeylt0IsoVcwmknfgVjYnrE=;
        b=OUDYoNw91NFO46ogWSdadXJkk/wF99SxRhn9deT/8lIO6QJ13GSDPrPnBxeMbv7hMx
         yJtlM03t1dHMCeKk1UgL7TR55HfNwlr+kBs5Lyq6kM/X71HAMR3PCmrK3+FS8pWkFLgg
         rU7GyyYlLA6uV9o5kttqe/qzskaV2bSg44JSzXRKexc4Y7Lrn4BB5ShkHUE4/3J3H/Mf
         c82mEkTwLXKU4AxcDkh2tZb5lSOOUBhpi42zkvPAhE5adpqLahu3HD0Vh1H+Zh4gzjJJ
         6N8ipGE2IPbD003gg5wzO6Nt9Mvm0qA9VsnG0sHlTf50if+A6boymyq/x1FYduMR5Ur8
         5jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=oYGv2Gjr3O553L+c7GBhYeylt0IsoVcwmknfgVjYnrE=;
        b=DYy2RVcWc/x+SVeabMf/CO5xBkYnFaJRSg2R2yMSU5xuDMipqI7qCHkkcyqcU080PL
         zoyRkHZH7nbkCJ+3uRV1cqJ0na+IY6M2vADIAd9AcdN3ES3jgS4N7tutSbaGiQQEmxAC
         j1MorJQZK/6bn40X71FdAbKkzW0F2z6f4D9SBpNhVYoMvzwLvwHSuTWenYv1ZLmuaj4I
         tJzomJ6FW6W8cbr8Apsn9rM1TGajyCDIOTnxEA/oaV/IISHBRRCQsJ8RUbQqI4dI7m4r
         pcydHz6/FO1a7qskd8Sy6fV7JyNSOZlLKYvE7xcUZL19o9kfLclmj4mc4Q5XlHKdU04m
         /jwQ==
X-Gm-Message-State: AOAM5318qlRfVB++a0TJwAFHfwoAQ93mMufcqgb+hQHCscUxMRByVvmN
        +09cIS5I9WyVfiLrcTv6eOU=
X-Google-Smtp-Source: ABdhPJy5vCw6vybg3y0QVOIwhtIxm5nYuTvWJ1RMjXR7FYLPdK1+/3oaw2VQf66dDESDdKdoOV75pw==
X-Received: by 2002:aa7:c419:: with SMTP id j25mr33090681edq.109.1600343895967;
        Thu, 17 Sep 2020 04:58:15 -0700 (PDT)
Received: from evledraar (dhcp-077-248-252-018.chello.nl. [77.248.252.18])
        by smtp.gmail.com with ESMTPSA id b13sm16817096edf.89.2020.09.17.04.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:58:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: approximate_object_count_valid never set?
References: <4a018cb9-da40-a98f-a1b9-73be30ae79ec@rasmusvillemoes.dk>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <4a018cb9-da40-a98f-a1b9-73be30ae79ec@rasmusvillemoes.dk>
Date:   Thu, 17 Sep 2020 13:58:14 +0200
Message-ID: <87pn6khay1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 17 2020, Rasmus Villemoes wrote:

> Hi,
>
> While poking around the code, I noticed that it seems
> ->approximate_object_count_valid is never set to 1, and it never has
> been, not even back when it was a global variable. So perhaps it can
> just be removed and the logic depending on it simplified? Or am I
> missing some preprocessor trickery.
>
> Nobody seems to have noticed the lack of caching - and actually setting
> it to 1 after the count has been computed might be a little dangerous
> unless one takes care to invalidate the cache anywhere that might be
> relevant.

There's some previous discussion about this in
https://public-inbox.org/git/20180226085508.GA30343@sigill.intra.peff.net/
