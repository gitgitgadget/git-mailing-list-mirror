Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03BEC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CACCD20708
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="RnmrwZ7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgGGQxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQxp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 12:53:45 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC6C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 09:53:45 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g13so32244902qtv.8
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jlpHMI8y696u+zVQytjvnhrfthj2k+bGWu3xoRhdn9g=;
        b=RnmrwZ7ba7pMUaz3UEyBC569ATqevMwrCDJtUnkDeYXfo0DBvhedlCyZYLA1rDKxaC
         v5xzRUIc7QnmYjo8lni202b6CBHvFkgm1/ssEX8JwkQygUXzLpQB9p7we6wOyluvZsY5
         5/zU8qBIonRyh4P/MAfkTmcxYW5BYgCjyubc1aSikMOWgv1TcBhbL5vZ1wYQHQ+4YpJ7
         1uLx+MAIQsLgV4QbUVvyrWgqciivsaINdmA2f9JHp02dKy6B4pLP73cCW/6QXvbxrrQn
         VJpRXPw/S2pPF5FkaV0uDKVu5VMMzHTF38J/uSjxnMquhaOC80TFmk87JijYrgZN5q+W
         vvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jlpHMI8y696u+zVQytjvnhrfthj2k+bGWu3xoRhdn9g=;
        b=ZTv53/0ILVXOY70ZITACGsU7v+LmymyfH77MOFRfUGQ1qjgqo88q0Ks4EGu42l86SO
         /GOBmF6wmIjOMCnpcB/7A/0rLOo3iGlEcTU63WBE+oTdL5SFpkvE0Y+Tuc131D+whLbe
         JHjkhnhq6ZfO/pUtDeJH+WejDaFXTCHoF/9TPRx5+y6Xb1seg1ukA3MJZgg8/3rDyQaX
         4Cr36UP+l7/STsNnTEu1gSXM++4xmVrPbrPngoxsmMHuxR/cEpjdLU3eDRKl5Ni1TyXw
         B4t/WsI5kZuV0dLzG5osxNdbnhByYFRhYidwZRx5DzEsYRJxTLLBw5WBnSW34AREbSHL
         bLAg==
X-Gm-Message-State: AOAM5306r6yRt7Gs0UejWoOU5yrzZTxqY/Ks+T8edOMlO5mcAa/H9UiE
        +Tx2xPo1UJfjS38ZGh3KcxnsYDXwHphbag==
X-Google-Smtp-Source: ABdhPJyeOYq+XmwQdv7SkbWRehki9Eeu9jOubUyesQbSEfFGwRlXuNjt2OF49NLtNDYbBiqpodQy0g==
X-Received: by 2002:ac8:4588:: with SMTP id l8mr56360094qtn.189.1594140824480;
        Tue, 07 Jul 2020 09:53:44 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:cc04:7df5:37b0:651d])
        by smtp.gmail.com with ESMTPSA id w18sm24843076qtn.3.2020.07.07.09.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:53:43 -0700 (PDT)
Date:   Tue, 7 Jul 2020 12:53:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] experimental: default to fetch.writeCommitGraph=false
Message-ID: <20200707165342.GB36941@syl.lan>
References: <20200707062039.GC784740@google.com>
 <xmqq8sfv745r.fsf@gitster.c.googlers.com>
 <20200707151735.GA27992@syl.lan>
 <xmqqeepn5kxz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeepn5kxz.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 09:50:00AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> I wonder if we perhaps wnat to add to the documentation for
> >> writeCommitGraph configuration that its use is currently not
> >> recommended in a shallow clone or something (I know it is not
> >> a problem just to use it with shallow but the breakage needs
> >> to involve unshallowing, but by definition those who do not
> >> use shallow would not hit the unshallowing bug, so...).
> >
> > I think this is a good direction if you don't want to take the patch I
> > sent in [1] for v2.28.0. If you do, though, I don't think that this
> > would be necessary.
>
> Good timing.  I didn't know a "fix" was already being worked on ([1]
> is the patch from this morning, right?  I haven't seen it except for
> its subject).

[1] is the fix. Jonathan wrote it a month or so ago, I just added a test
on top. (Independently, I tested it with the reproduction in the
original bug report, and it worked properly).

> We could obviously do both excluding it from the usual experimental
> set and applying your fix, so that those who are really curious can
> help us make sure your fix would be all that is needed.  Let's see
> what Jonathan says...

Either of those sound good to me.

> Thanks.

Thanks,
Taylor
