Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C13DC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 18:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbiATSPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 13:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiATSPs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 13:15:48 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE38C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 10:15:48 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id q3-20020a638c43000000b0034c9c0fb2d2so4090949pgn.22
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 10:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OyRBMAe+TEOr3jC3zyZNjU37iCkCYU9Umphiqk9tt7I=;
        b=XuDofcPWjirXbgORv7p7F4JSr7RlEVIEj1dWUMfnYQxKP+MljSzNZybJmVME7+53zF
         LQJ3qv7Qj1h+JzTLduzRmOJESBN27Oa/RdN8QQpGO85mcAB7gm+rtEmShOmWGYjnKD/g
         woFylDBM5cgSbJaBCkYT3eGwppidri3rW5klyigg/4Ae695IaL343Z5iWQy2wdNymoLw
         SYYH0Mov5xesISddAvTr4jvxwE4EL0/48OQQXzWu0YOWzsslCRPacacVmYXDZm0sXFF3
         H8cD/khXoi+Uc6ZDe3oMUsGd7GpAxdyIbC1pKDKQxlad/epI5GVEZJvFzdmx6AhTJ376
         EDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OyRBMAe+TEOr3jC3zyZNjU37iCkCYU9Umphiqk9tt7I=;
        b=BdT/0MPZ40qXUX9bD9FDP3Wafw/qalkOaPDK7gSOxvXyBt8CXvRxBvAPz0aem/i4P/
         NPAaE6TfsYvA5aNQCP1EwJUuFDoTI1B/ruWxBQxw+eqcYhs8CyDUNqXmlRDg15CfCF8F
         A1v+Md8ajC2IpXHaC2DXnMVAUvEIK3dGism4cvZQVTP2QzmJgSaacB966uyFYoVQtmGk
         PWkyAxwA3H4mZ7UVqhI9h+dKTIjBcsgQHX7V8+tZctPwaTnIofU1OUs/5pfMvGgFIXKk
         MVpph/DkgqmY4veuVWU9b6vYlSxZkwRfV/Bd2uVgQrGbToTRr1NX+Ok9Fn97DncxY5C7
         jFbA==
X-Gm-Message-State: AOAM530c5+qQ9Rq4m8/1bKJK/BPGpUg40ySIUyqEjE+nJRuXnNFCsCp9
        0Nes4W72UswHRvKJixkEHYlYgi2APwi5BkM+8IIl
X-Google-Smtp-Source: ABdhPJxPeyXRn38ukOJ26R9nGPI+aeL4Q1gZ0n5m5ySnVjLQ6GLEbTL9GOHCGsM3Lk1xZ7o5WfNgxTy5Oze2ULJPxiT9
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:ecca:b0:14a:e540:6c76 with
 SMTP id a10-20020a170902ecca00b0014ae5406c76mr12990197plh.20.1642702547599;
 Thu, 20 Jan 2022 10:15:47 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:15:45 -0800
In-Reply-To: <3279e2eb9b7bbfcc930e4ee146a3bd2476ef91eb.1641320129.git.me@ttaylorr.com>
Message-Id: <20220120181545.3104404-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <3279e2eb9b7bbfcc930e4ee146a3bd2476ef91eb.1641320129.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: Re: [PATCH v3 3/9] pack-revindex.c: instrument loading on-disk
 reverse index
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> In a subsequent commit, we'll use the MIDX's new 'RIDX' chunk as a
> source for the reverse index's data. But it will be useful for tests to
> be able to determine whether the reverse index was loaded from the
> separate .rev file, or from a chunk within the MIDX.

As for this patch and all subsequent patches, we (at $DAYJOB) discussed
during our Review Club the idea of not supporting .rev files altogether.
Firstly, because of this bug, we cannot fully trust .rev files anymore.
And even if we decided to trust it (or to trust it after some
verification step that I can't think of), that file would only be useful
for a short time until a regularly scheduled maintenance step
regenerates the bitmaps anyway.

That would also simplify the code slightly and eliminate the need to test a
variety of cases - so we probably wouldn't need the t/lib-bitmap.sh file
introduced in patch 6. I'll hold off on reviewing the rest of the
patches for now, since they may substantially change if we decide to
stop supporting .rev files.
