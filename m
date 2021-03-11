Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7327C433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F9664FF6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhCKRXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKRW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:22:56 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02173C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:22:55 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id u10so5816666pfm.11
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dxOEnZaexAd4Xa/lu68rN0SkVDm+gGBLE65+5V/OuhA=;
        b=AQyic5mNyxlUgFqMuM7J4RzwWXPgtHoKqMI906vEq/lO8H9Nf4uFzI1HnqEb4SruGe
         7sAfzwHSrSDt+C8Y/XzdeUzo1EVjp1/nIeBjWePaeQcTzWjp/Ku1iuOhjm3X/RjhW0wS
         B2N2foho4ZHNYjQtzj/9DxNCJ4rLL0MhlxWIQUa7mtS0N1/ojatmyhLXwnuJO3Q+7/xF
         asTxbE3enMBlaZC0SauX9snRZKPp/+kWsk1NQeLy8/mLbBu5+vZgqBMfBRwRRI5U8TuK
         UaoB9ApgY1Sup9iIhYdQLL8E1NWZ/2dAuoAe/r1PuQGEXbAtVXLjhKtG32Xosw0hn7qm
         Uy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dxOEnZaexAd4Xa/lu68rN0SkVDm+gGBLE65+5V/OuhA=;
        b=gNY8LNjCEgRC+yvtN1In6RxcTQLA8DWruTsbOPxjlM8sVsDOIGaQpr0B6Qubx2wdZZ
         A3DK7kBhwz5f5ogZ7643h+O0eN24Evvc7QVNEU76R+xvIlH30Xtdp89aSjRJtx/HU9o0
         Vp40bFPj32sokb1PMBaOY5TY3uwSBIZhvR9J1vkB9L33ez/MPispxXcLaqnKLqPYpOAq
         ZEovFGwtPvAiELKXMhOQQGRFYLVuOKrZ/8U2cRYD/rasetIQPHd/QnACH+Gc0cjYoGrV
         Xehc3Rz5OLClkztoA22S4cTsHvKHZvQWznqijHiUz7468c4LTUwWLtYdnHqP39auM60P
         OPYg==
X-Gm-Message-State: AOAM533rYp23oikrvaE0MlnFPs5+frFfPIkyprCPfOo9qMSJRIDzlREV
        eOWMQ2F06z89BHoIyBs+a0LVFjnRx0beqJAOi0p9
X-Google-Smtp-Source: ABdhPJxi0GwPayDpUfm+umcfwWxnIzbkuupVP7gDWJpk+U6JLRDbfLuN6fIPb1PkYXptJf6YPMrDM3rOCeuG2ZMkwHAp
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:768b:b029:e3:fb85:1113 with
 SMTP id m11-20020a170902768bb02900e3fb851113mr9326168pll.3.1615483375386;
 Thu, 11 Mar 2021 09:22:55 -0800 (PST)
Date:   Thu, 11 Mar 2021 09:22:51 -0800
In-Reply-To: <xmqq4khih3gj.fsf@gitster.g>
Message-Id: <20210311172251.2307015-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq4khih3gj.fsf@gitster.g>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        nmulcahey@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > This probably means that fetch-pack.c itself (instead of
> > finish_http_pack_request(), currently being called from a separate
> > http_fetch process) should call index-pack for the out-of-band
> > packfiles, which is conceptually reasonable. This means that
> > finish_http_pack_request() will need to be able to refrain from running
> > index-pack itself and instead just return where the pack was downloaded.
> 
> The HTTP downloading for packfile specified via the packfile URI
> mechansim is so different from the rest of the HTTP codepaths in
> nature, isn't it?  It is a straight "download a static file over the
> web, and we could even afford to resume, or send multiple requests
> to gain throughput" usecase, which does not exist anywhere else in
> Git (eh, other than the dumb HTTP protocol nobody sane should be
> using anymore).

Yes - and I also noticed that finish_http_pack_request() is also used in
http-push.c, but I'm not familiar with that.

> Since we are not in the business of writing a performant HTTP
> downloader, if we can update the codepath not to rely on our http.c
> code, and instead spawn one of the command line tools written
> specifically for the "download a single large file over HTTP"
> usecase (like curl, wget or aria2c), wait for it to do its thing and
> then concentrate on the processing specific to Git (like running
> index-pack with various options), it would take us closer to the
> "make clone resumable" dream, wouldn't it?
> 
> Thanks.

We would have to figure out how to communicate any Git HTTP config
variables to curl/wget etc. (and also declare a dependency on such a
tool), but that could be done.
