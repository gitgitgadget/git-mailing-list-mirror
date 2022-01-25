Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AD2C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 21:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiAYVpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiAYVpD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 16:45:03 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496D4C06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 13:45:03 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id z4so2860215ilz.4
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 13:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ACpUdSui0lGbur2CzTW762vimNdvAgvOo6/m7KDEHVg=;
        b=kLW4r+/ZmrUuB5cz5E5op8Ftddv5aXX8zpuFwEZEz0mj+NDn8BT6hTOEPE8KvTz8+k
         uu0AJe6cPIE/yyq8ENr3JTr2VPbUrFuQbiVJTjRTbbnfUs4aJ1qYyCRgutYTb9KjFlDK
         3PEPaJ0Ep6oYJtquM0Dk6NOxygH8ZSOwuMOul7d8OnAjjgDRMfXrlsthfN73j1liJSnC
         IyBUjESrPbWtwR8Yn/qbNfaprnymgNSKqPOPlf0r7giVvEOxkjCh4/IRtfWPzKY+W0GA
         GFcD5FeWUWrFrABxDU9oI40230t1L8heFlSE8IuvLeVBCYOLUO0WoLe3v8bRcU6g/ax5
         qPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ACpUdSui0lGbur2CzTW762vimNdvAgvOo6/m7KDEHVg=;
        b=6NVtEdEvQtJw73VxGfBTQ1F+U6G2Iv9ZtLpgkvYBsNxQDdQic2N0jkI6KVIh4/Un7i
         97LX+xisB1skZ901DPG4/YWHF1Wnn2CRBTXEt8IEadA0phbvRfjIV1TpLXWw5FuvN3hp
         wwyfjgIp7oHSOkGELwq3dWGuHFnJ6RXTAgYNhQxWrygd0ViYXsb9s+9JEKSB+is1Z4VP
         L7JKUgG9YfVlwtDlZT18phq5ljbMGXWXmLzGzm3fOhjvWlx4tmEE3FjN29Gh5GunSOwJ
         feAj2LZpk/VaaoFqZff0u2q+yGG4ZwmcxURmtdOr0K1PCBWa9+hjoh3xC/cpwWHF9FMj
         8hmA==
X-Gm-Message-State: AOAM533IsVhrAmJTQu6qVq+/6CZH5qdSGUU72j8q/IOJQk4Ns/U4LOub
        lQCEcWn3rjHMVgBYUGV6+KhyDTrLk6wk3A==
X-Google-Smtp-Source: ABdhPJwzoFct8NIdReCOyAqQx1S95x0+5KAcn9wQ96L52z1AkMijd/P42m3HTzxK5AsE++kafP9GRg==
X-Received: by 2002:a92:cd87:: with SMTP id r7mr13225963ilb.192.1643147102668;
        Tue, 25 Jan 2022 13:45:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r9sm1300797ill.52.2022.01.25.13.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:45:02 -0800 (PST)
Date:   Tue, 25 Jan 2022 16:45:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH v3 8/9] midx: read `RIDX` chunk when present
Message-ID: <YfBvXS841To7ZXcp@nand.local>
References: <55aa69de12c5f82a66836e829f915363cc73b421.1641320129.git.me@ttaylorr.com>
 <20220124192702.2452750-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124192702.2452750-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 11:27:01AM -0800, Jonathan Tan wrote:
> > Note that we have two knobs that are adjusted for the new tests:
> > GIT_TEST_MIDX_WRITE_REV and GIT_TEST_MIDX_READ_RIDX. The former controls
> > whether the MIDX .rev is written at all, and the latter controls whether
> > we read the MIDX's RIDX chunk.
> >
> > Both are necessary to ensure that the test added at the beginning of
> > this series continues to work. This is because we always need to write
> > the RIDX chunk in the MIDX in order to change its checksum, but we want
> > to make sure reading the existing .rev file still works (since the RIDX
> > chunk takes precedence by default).
>
> Could we disable the beginning-of-this-series test when the MIDX .rev is
> not written instead? Then, we can test what the user would actually
> experience (no reverse index in .midx, reverse index in .rev) instead of
> simulating it by skipping over the reverse index section in .midx.
>
> If we can't do that, then I would agree that the approach in this patch
> seems like the best approach.

I considered it, i.e., by having the two knobs be:

    - GIT_TEST_MIDX_WRITE_REV
    - GIT_TEST_MIDX_WRITE_RIDX

where the pair (true, false) would correspond to what a corrupt
repository would look like before this series. But I dislike that it
allows the caller to alter the MIDX's checksum by controlling whether or
not the chunk is written.

So it's really looking at the same problem from two sides: do you make
the RIDX chunk disappear by not reading it, or by never writing it in
the first place? And although the latter is more "accurate", it did
allow me to sidestep a lot of gory details like the ones I outlined in
the second patch.

I don't remember everything fully, since some time has passed since I
originally wrote this, but I remember encountering some of the races
where you'd read the old bitmap in the new object order, and other
annoyances.

Thanks,
Taylor
