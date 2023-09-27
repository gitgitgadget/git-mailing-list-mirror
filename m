Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5436E7F14B
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 02:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjI0CQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 22:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjI0COK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 22:14:10 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC8F8A7C
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 18:38:56 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59f55c276c3so90429167b3.2
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 18:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695778735; x=1696383535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2hd4XCj5AMOdu3rd+EjHVMPOLvy6xivhs0LSRJ0/I4=;
        b=NBaRa1QpvwLZW2XjibpUqFJc/EzFFYncaxO9KDBxcuUvwkd3oxNziY6yz0TP1lIM7b
         Fj3CStG1f6dLtT1oU+JfjrsJZ6f4Rr781L9lQ3iZ0AeDm6Zx9TlZcQbddPtFzbjde2RJ
         ZQes7MXDuwBAelUNvESmS7lUxXhZCmYyWdMnFojpcpEaqcAaSjjcYEx/UNZBVontpfSL
         8myR1j0QGYSQe8eV4Pf3yNT9uzSMwFRWZnFEZ4EQ4N1gsAanZZmC1pLDAdJpyG7mVx/Q
         BojRanyryEvcBL3iTlN37nXpk/O+xU0/BxgCVeKvtynmDANwfFnW2aU8XQ2Vs+/3jR6k
         RujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695778735; x=1696383535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2hd4XCj5AMOdu3rd+EjHVMPOLvy6xivhs0LSRJ0/I4=;
        b=b4/hfP5qC7v4AM+3EurIQRFCl4l1C7nH5WvRrm0zcoihSxl+8Q+U86eoZOGH4yGy1U
         z5w9HoQDFUdx30xG0tRBHJ0nJFm6xvw8Cxrk0DszzXk3RSA2IliFvszEzOLTGIzWY5Gh
         3RVKS62//Q3H/ilTBMpVivdKJgPNnDJa94jwaVkjFfjx5s0WwR+NGxZ170NLu06zQHzG
         WJf612outiFtpWIPjyIFhiNqQbATfcNaloxJySFCyR2sxhtr+z0urUSHSaeBU2K4nvhJ
         E9+vVb/6GpYFOiN9yZMOL8NLCJL0oNsKcSL+p6INXDsOHNvEiMP8XKxADqXaQtAGWBTV
         aGWA==
X-Gm-Message-State: AOJu0Yy7VzLXESi//B4XGs2QGAIlv10u092RtpphJmmwPpkLEwgR9C2K
        Ebj1SUJrK5NDQlGsYv5j8fxJ3w==
X-Google-Smtp-Source: AGHT+IGpuAm/kiWcSd66DOkrqYz2MtGzbYqyYjdVscZcpWnkJb0rLYkO78FJ6vnKJDbqqJc/CCIuHA==
X-Received: by 2002:a0d:df82:0:b0:583:af98:6fb3 with SMTP id i124-20020a0ddf82000000b00583af986fb3mr698842ywe.15.1695778735123;
        Tue, 26 Sep 2023 18:38:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i7-20020a0dc607000000b005777a2c356asm3342372ywd.65.2023.09.26.18.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 18:38:54 -0700 (PDT)
Date:   Tue, 26 Sep 2023 21:38:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Eric W. Biederman" <ebiederm@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] bulk-checkin: only support blobs in index_bulk_checkin
Message-ID: <ZROHrSmmZOIE6bl9@nand.local>
References: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
 <xmqqr0mtcosy.fsf@gitster.g>
 <87zg1h58xa.fsf@gmail.froward.int.ebiederm.org>
 <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org>
 <xmqqmsx8mwr4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsx8mwr4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 02:48:31PM -0700, Junio C Hamano wrote:
> > Avoid all of those future complications by limiting index_bulk_checkin
> > to only work on blobs.
>
> Thanks.  Will queue.

Hmm. I wonder if retaining some flexibility in the bulk-checkin
mechanism may be worthwhile. We discussed at the Contributor's
Summit[^1] today that the bulk-checkin system may be a good fit for
packing any blobs/trees created by `merge-tree` or `replay` instead of
writing them out as loose objects.

Being able to write trees in addition to blobs is definitely important
there, so we may want to wait on merging this down until that direction
solidifies a bit more. (FWIW, I started working on that today and hope
to have patches on the list in the next day or two).

Alternatively, if there is an urgency to merge these down, we can always
come back to it in the future and revert it if need be. Either way :-).

Thanks,
Taylor

[^1]: I'll clean up our notes in the next day or two and share them with
  the list here.
