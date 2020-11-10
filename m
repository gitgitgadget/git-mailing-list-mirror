Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B21C4741F
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1744620789
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1octlgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgKJAoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 19:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKJAo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 19:44:29 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C45C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 16:44:29 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id f16so10873890otl.11
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 16:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjMY3PprRSUPIF3wXdpETwmvDVej7HRzMGqstpI6t1Y=;
        b=M1octlgkz4YkahZw6IB0R/0Bu1hlsHNZx4Eaa55eDBl0dGr8C6YSaUKP+SxL5gEzNv
         eV+akYvfE8AZOz20V5B3qq7GbfuKLyhMVMCoZd3WFAt5OsM3A5Cd8V1WZrbexMRUc6q2
         Ud0mQwUH1vl8/iBJBDZPS3uTULIC7r0HtKGnzEbpetwWoA62R+MuzP95fDsgbTOsIpqz
         EkHSzdV/Ttny8aSqZD04u3fK6ZFFTQ0X8x1jIa1gPEdVfLX/CUfyBnoyVVPXfyHXeWEV
         CDWaohDpyD3Zpl63U971OinMUix84BfDfb4iIALjW4wy+gpiQAE8VB/SRf3fvluzTbrj
         LItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjMY3PprRSUPIF3wXdpETwmvDVej7HRzMGqstpI6t1Y=;
        b=FhzUq0e+xbJC60k2qEh2D8OtdjqfDuyM4Qp+99dxC5kGvbDSdueF5bgIcrq01yw7dB
         +7MRnJkkX/swrydrQpOzjyezdKB57DTWk/0LJ/PGO0nW0EMPEu8Wh1J8c+JYfOPuF0Jx
         Dp6Za1gSaumUew6fjTfPPvfEp8CUEndfOw2eLC7Yi5x5Eu3ea601S2Yh92ZK+iUAOb0n
         VJKPDOiOfrlpIq2ewSYLD34IvZC/m5cn0gXQfWAUVASDuYcJA6bsXFv4j3PZMcQFs9hq
         McUdlk28My6Sp7qED3A5DhO+zoT1ed79kk4z6PicOVLpCit4lrUGQJr33Tt8p2iK4SUe
         B6fw==
X-Gm-Message-State: AOAM532pelVLrwz90Xes5NuKwwoIlEjj1O4kDjHXz3Q5G9tXZoDMrrua
        vAkRB8lZm8qp1o8sX8BQLujSZCC0OYeHDFd6CnQ=
X-Google-Smtp-Source: ABdhPJymLJmXhw0gvYZQRyCsYmenRzucBZQyPE0JSecYvjO4heVJ+ooF+A9Puy6zjqafs4zdeNU28N1MbPewUyOWxyw=
X-Received: by 2002:a05:6830:12c2:: with SMTP id a2mr12510506otq.162.1604969068662;
 Mon, 09 Nov 2020 16:44:28 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Nov 2020 16:44:17 -0800
Message-ID: <CABPp-BGtO5bgoinmjc3=WwW+w7G4Js14iGvO_qQ6oF3EcQt7xQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2020, #02; Mon, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 9, 2020 at 3:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/strmap (2020-11-06) 15 commits
>  - shortlog: use strset from strmap.h
>  - Use new HASHMAP_INIT macro to simplify hashmap initialization
>  - strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
>  - strmap: enable allocations to come from a mem_pool
>  - strmap: add a strset sub-type
>  - strmap: split create_entry() out of strmap_put()
>  - strmap: add functions facilitating use as a string->int map
>  - strmap: enable faster clearing and reusing of strmaps
>  - strmap: add more utility functions
>  - strmap: new utility functions
>  - hashmap: provide deallocation function names
>  - hashmap: introduce a new hashmap_partial_clear()
>  - hashmap: allow re-use after hashmap_free()
>  - hashmap: adjust spacing to fix argument alignment
>  - hashmap: add usage documentation explaining hashmap_free[_entries]()
>  (this branch is used by en/merge-ort-impl.)
>
>  A speciailization of hashmap that uses a string as key has been
>  introduced.  Hopefully it will see wider use over time.
>
>  Will merge to 'next'?

Yes, please.  Peff went over the series in detail and said it looked
good to him as of v4 (he also seemed fine with the extra change in v5
that I made in response to your request).  I'm not aware of any issues
or further requests, and believe it is done.  I'll CC Peff just in
case he wants to change his mind and request any more changes here...

However, you have an extra 'i' in your spelling of 'specialization'
when describing this series.  You might want to fix that when merging
to next.
