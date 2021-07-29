Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0A4C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46FA608FB
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhG2Td3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhG2TdY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:33:24 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96CDC061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:33:20 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id a13so8583104iol.5
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IE00Lo/8fV13UNS87shISqCqOMxJbswsCBKLOVS0XjY=;
        b=zIWGWr4mS57ayrc5ln86HaR4WEBNgPr2E439duQp0BWQvO3itt55p5LYNwRL8IZZD8
         yxe383T2DpbUbIUHHTltVsHMyJPkHfWWkzmEDIC+LEy1LS3cCWuoQ51cUbqRcanbljjV
         XF/SZNZPqazMB4DwMaW5eb0D8n6IEyJ1Byiq2/jq1hO+Kn/a6sexQnlwndKb35bWmyUZ
         pV41GIlBJUBXqPsjERr75ptNbeDPBSC8Pwqgj7urfZdrlT44Ts+D2qa9sakvcB7JEs+B
         e6asHQJgWenRDJjf2DPkgs9igSqGMXXtI9UzWuktri5v8a7MTrjuKoFqH6aFR3QbrGin
         TWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IE00Lo/8fV13UNS87shISqCqOMxJbswsCBKLOVS0XjY=;
        b=WKXvtkgkJDJmqsVsdZ3gbMNfdf5OIDayvJEdbFAzb9km6R0Smz2U9AhLlrYfIbNH8R
         +oU/Kbhiy37U8Y6kDPYBGP7FOo8QDw3X4IjEZpaj8vzZYuqqaSzfGEaeSTopWuSxHqOv
         biqy1dDN08qPw4FEFT4C9gjqi9dLRUQFfDq5fSZcWHTdIIF7B005aJmZcA+uMK3N9yX7
         XUIEqb/PNUgwOfL+VakypwsrmAO5IaUgzsf1e1rcw/DzpMxbVlVN+V0GjyZ1NiGsxYOb
         PV4bVfG/MDul/VNn+pajjBj6v8TmQDP9ufTP28z11inK6MNoRT/sO1QVWhGCK05kLqt7
         3pHg==
X-Gm-Message-State: AOAM533K+woGFCwjHeoaLibCELxZMLaw+ZjGCb8woJ3gLIrGnYS8kEh1
        yy9uvMgAkl2LMmIKo0BzNYhjBg==
X-Google-Smtp-Source: ABdhPJzL/jrGqFKoUl0avSXeyx14yTDCLgPMG1APDngkgILbB+aPa39AERJ0VBKFRyWMzVihIlBlfQ==
X-Received: by 2002:a5e:c803:: with SMTP id y3mr5346257iol.107.1627587200083;
        Thu, 29 Jul 2021 12:33:20 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:46df:20:8c6c:2d4b])
        by smtp.gmail.com with ESMTPSA id r16sm2339854iln.30.2021.07.29.12.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:33:19 -0700 (PDT)
Date:   Thu, 29 Jul 2021 15:33:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 14/24] pack-bitmap: write multi-pack bitmaps
Message-ID: <YQMCfnlr6BAXC/c0@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
 <YPgObwXjt/tzAJvV@coredump.intra.peff.net>
 <YP77DiffrCrxunvg@nand.local>
 <YQA+PaWb7tweEKuk@coredump.intra.peff.net>
 <YQBtfRP0svLL6VDl@nand.local>
 <YQGZZTXjSuZkHJgm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQGZZTXjSuZkHJgm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 28, 2021 at 01:52:37PM -0400, Jeff King wrote:
> On Tue, Jul 27, 2021 at 04:33:01PM -0400, Taylor Blau wrote:
>
> > > It's interesting that your earlier iteration didn't call
> > > open_pack_index(). Is it necessary, or not? From your description, it
> > > seems like it should be. But maybe some later step lazy-loads it? Even
> > > if so, I can see how prepare_midx_pack() would still be required
> > > (because we want to make sure we are using the same struct).
> >
> > It's only necessary now (at least for determining a preferred pack if
> > the caller didn't specify one with `--preferred-pack`) because we care
> > about reading the `num_objects` field, which the index must be loaded
> > for.
>
> I guess I'm a little confused about "now" in your sentence. I understand
> that it's not necessary before your series to have loaded all of the
> index files ahead of time. But didn't we need to do so in v2 of your
> series, which has the preferred-pack logic?
>
> If so, then was the v2 version buggy, since it only called
> prepare_midx_pack() and not open_pack_index()? And then v3 is fixing
> that? Or is something else opening the pack index for us?

In earlier versions of this series, I don't think we needed to have the
indexes loaded by this point, since (before v3) we didn't care about
ignoring the empty packs when finding a default preferred-pack.

But now we do, and so we need to call open_pack_index() ourselves.
Confusingly, we only need to do that on packs that *are* included in the
MIDX, since prepare_midx_pack() doesn't do it for us, but
add_pack_to_midx() does.

Thanks,
Taylor
