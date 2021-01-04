Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F8C433E9
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3832F2255F
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbhADX5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhADX5T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:57:19 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD11C061794
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:56:39 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id t15so9685259ual.6
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duMFp/tSE5+35y5mRybveNENS6y2uU/njGWlE9xlO4I=;
        b=B7xIrEkZWm3x5pLSlOIe4Sx583T6F4FhPoJWnYVHZU/QdVOmGWEi0wedsWJJ793mCg
         fa9oEsNp3TMK7W1sY31FAtpsfJPBJOG4YahpNXrLgzLSMcqvIn6h8LU0O64TECtDnJ6B
         WZDR8Q06kCcJBNn8DHpb2f/s7FdtkHvKE0GrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duMFp/tSE5+35y5mRybveNENS6y2uU/njGWlE9xlO4I=;
        b=WEi2PwYHVdZzNB8vtCrkfvhWpl8ztNF/tPZm28wuDuoYQnDkur2bf7OPlpXAyEBUFL
         P+5AFRbaSB9EdDRMZYoFoYTj/b9YXP/Zdooq2rlc9Gb9yfA3snmQMNlLWyK5nmqOe3i/
         0Kh/oWgzBwrvLRtlolHHNjSAFiVSx49txkZjmyhVymodmGKNJogLrO0pvjsPCIe/Ncgh
         +xMgc8LEGWEUQUMNFBzsOcwvQIDEQul6oToOGJifPXypP3X3sv8jdPK+upN78NX0LOTd
         WsX+KuZh9PSmPj3VCM51Zgi8Muo1Rtq5pdOKoVW1WIi/p7HNy3xdIjdTHtlWkFa44l/Z
         A8FQ==
X-Gm-Message-State: AOAM5323WyQChZiQ3ys3yFN4O5O/ca5J+spNebzo2BI6zKjSP3ftstCQ
        WWxa08mkqdL1XiKVYReeBdDQ453ukGGgUuKqRT0IXw==
X-Google-Smtp-Source: ABdhPJzfkLvDaF/Fl680DoII9EYmIVh4zzS1VIsj1f3T3KOA+9phUD3DCNdHwWNWPKBV8lFvCU4e+chI5kMwJwESYHM=
X-Received: by 2002:ab0:59af:: with SMTP id g44mr48351358uad.37.1609804598422;
 Mon, 04 Jan 2021 15:56:38 -0800 (PST)
MIME-Version: 1.0
References: <46b2e5af59c451b816973ba3f2c32a68639298b3.1609796006.git.me@ttaylorr.com>
In-Reply-To: <46b2e5af59c451b816973ba3f2c32a68639298b3.1609796006.git.me@ttaylorr.com>
From:   Nipunn Koorapati <nipunn@dropbox.com>
Date:   Mon, 4 Jan 2021 23:56:27 +0000
Message-ID: <CABVhGpUJhS_uq14p1SuhTt9x5c0rkmB_0sw9uSmce8+4WKATRw@mail.gmail.com>
Subject: Re: [PATCH] p7519: allow running without watchman prereq
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I could do without the 'else' block here, but it seems straightforward
> enough. Likewise, the "ensure no silent error" comment could certainly
> be removed (since 'test_must_be_empty error' makes what is happening
> quite clear), but the fix pursued here is minimal.

This looks great to me. Thanks for fixing - and appreciate the else
clause here for the reader.

--Nipunn
