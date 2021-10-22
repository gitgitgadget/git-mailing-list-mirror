Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC74C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E0C610E7
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhJVEbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 00:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhJVEbY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 00:31:24 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2ACC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:29:07 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y67so3700971iof.10
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MW91CMw5XJ5/fg7fpI3Y0BpYPQ2BPm7MVc6IBpCCeBI=;
        b=4vOvVp5Bd29tg5HondsNC0nKd3u1H8DYlSO1vkkFL2Ox0I3UIT9AU/pCY3UoLhWN1I
         pIRelF6WHlXTTD/LQ12oKKF10rAh9btE7vgZ5NLPa6BWY9dEEx0yWmDBcVhX76k0FgPJ
         tfy/oGB8rV12eJlv7zlMrEScNMxl5fI+p/IPngqxEN29LMmaZKTOhd9b9Mqq6mzWBhOj
         4EGWMO5wkJ5IcPat6rXP28j7N5LHSzWd5x45XmzT7fgM15gAvSn7B44/dbtMMn9oLDm4
         Ocy62Hmtjnjql22fR1dW1G0eKKwi5y1jPzeeer5QVH17Dldc1TdEOBYK0ATaCORK9ohe
         7Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MW91CMw5XJ5/fg7fpI3Y0BpYPQ2BPm7MVc6IBpCCeBI=;
        b=qtmJP1e0C0LGNMWgwdL2YA2idMRkMh3flA0Fw4gbiiAeBt1bcYqIbqGefyb8wZ6YiC
         TM01zryHFQvAeSYWU2wGRu45T3PYzjQHj4Ow5EHUNA0w2UvKNgqCOd8vTjGcet0dYt9z
         abC2cy2GAKziAIGdABdnzZ25JdSNBF5RRLgI1WyzSkRFmicZydQdXEQESIodAAdKNYnM
         1eB4Z4G+WmGJtvCGk9cKNY1f/EyPUBZeGzSsxBKLlvtahf89wA3EmFVpzMULLLf1/QpG
         ZqCsQpYfiiRRb3LRXe1F3la+aD5LophkDJiKQ42ZoM7k3D8IIEX9t6sXFWzQ4lPYQHa6
         J5zA==
X-Gm-Message-State: AOAM532940lz9hcQTAh0OfGid13SewwCz7peh8CuJLd/cW72imVCW/5Q
        4XGyAaoB2qj30qfonEJDJcexiw==
X-Google-Smtp-Source: ABdhPJwfj4Zu/upbCMJCgjcB0FE6fzs5lum/i0pCIHcDxOuGb0Tt5Af9O8qLOdi7MT7e2fmH4FUt4A==
X-Received: by 2002:a5e:c018:: with SMTP id u24mr7026318iol.197.1634876946891;
        Thu, 21 Oct 2021 21:29:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u12sm3627904ioc.33.2021.10.21.21.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 21:29:06 -0700 (PDT)
Date:   Fri, 22 Oct 2021 00:29:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/11] pack-bitmap.c: more aggressively free in
 free_bitmap_index()
Message-ID: <YXI+EbnHcA3W1ZPO@nand.local>
References: <cover.1634787555.git.me@ttaylorr.com>
 <e65ac7deb5973b8209e8d94ad9140e005e22c44e.1634787555.git.me@ttaylorr.com>
 <CAPig+cToh_8x+72-g6cdvt559N4GqKwfmBDE9BxTpkXOFrRbsA@mail.gmail.com>
 <xmqqy26mkz4f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy26mkz4f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 11:32:16AM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Wed, Oct 20, 2021 at 11:40 PM Taylor Blau <me@ttaylorr.com> wrote:
> >> The function free_bitmap_index() is somewhat lax in what it frees. There
> >> are two notable examples:
> >>
> >>   - While it does call kh_destroy_oid_map on the "bitmaps" map (which
> >>     maps) commit OIDs to their corresponding bitmaps, the bitmaps
> >>     themselves are not freed. Note here that we recycle already-freed
> >>     ewah_bitmaps into a pool, but these are handled correctly by
> >>     ewah_pool_free().
> >
> > The parentheses placement seems off; it's not clear what the intent
> > is. Perhaps either move the closing parenthesis to just before the
> > comma or drop them altogether.
>
> Yeah, I think we can do without them and the sentence becomes
> clearer (we can add a comma before "which", too).

Yep, thanks both.

Thanks,
Taylor
