Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9AAC433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 00:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiAOA7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiAOA7k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 19:59:40 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0DDC061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 16:59:40 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i14so9751371ila.11
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 16:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XV7lUgfAM01dDNS4VtYNHmsVElpTlfDCTYLxsQvD1iU=;
        b=hF5mOSQ6U3ukl6hUCWNSrKZ/oTN1TgQPHlbAFQM0fbktpumUftCUli4EVXRm86JFCY
         G5YZFiz0jYIYTZyCKHPerFNvqk5qAs+8hoL5sGFSZedoyTGCifgAthtJbH0G5v3mlK+n
         YpnozVLRKRzeJgcEj4i5SpVFjIpasaKzGrE/qNH09SSTwcp9SNXD829giM2K3/9VzCvJ
         8tow6kZ4gdyJ/Y51+EwIrwIxti5YcbUWmmHSR+lzdhMisLZUPO57yeaBbdud7dkDs/Id
         EQuo7RnakMVwZYB+Rir10ZTFEGqD92hpqd4i6PnEjvX1uWBLAJ3lateMxRvL1V+9KJWF
         lRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XV7lUgfAM01dDNS4VtYNHmsVElpTlfDCTYLxsQvD1iU=;
        b=iSZFlX8slYzhYc2Wc2aloKKI+cqxu3kpCd4Vl+56H4FK1/PMxM++FNZQRtb85zOHfw
         CWX0rr4qGWpDw7tnqDFFN5jgY/VYXmU8A2UZtIexV2zKRI7hKUPXeCwAu6IX7kIOunSs
         RVN4Dalg5l6TI3PuQaPxc3IbZNRwU3znURmFiR1j7xUn7jaiDSA75qdnHgkjNY10XctI
         BChG5bQp/5uQETjr8lQxoSVTnim/I+ogGMhahcocNOTGPKRzRPwNqFfSZmX8YdXneZwR
         z/bNuGA/0Tagr0scKHGq+AM69Z94kr5KRUnFQtIPlYbNHZv82yUu0uFhswhHmhQaYi/a
         iU2A==
X-Gm-Message-State: AOAM5332cERfZpyRYGn670bV7lZQh6zeJ3kJT+SMZ5qFCqgLQGF6h16x
        ywcyd1DVHNAI0w23uFSWRL/U94ULUdNJRQ==
X-Google-Smtp-Source: ABdhPJyvDV2aW5h1zGGppNl2njPGrsnaBEImCP2v7soC0aBhXNYH+zgOs3oNyZEQCjwzUahRSSB4ug==
X-Received: by 2002:a92:c547:: with SMTP id a7mr5613897ilj.116.1642208379878;
        Fri, 14 Jan 2022 16:59:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j3sm5297436ilu.64.2022.01.14.16.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:59:39 -0800 (PST)
Date:   Fri, 14 Jan 2022 19:59:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v3 2/9] midx.c: make changing the preferred pack safe
Message-ID: <YeIcem4bDgmQhs7+@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1641320129.git.me@ttaylorr.com>
 <7d20c13f8b48d2aef45c2c8c40efb6ecdb865aa8.1641320129.git.me@ttaylorr.com>
 <xmqqwnj29f1v.fsf@gitster.g>
 <xmqqsftq9en8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsftq9en8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 01:43:55PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> >> ... It's likely we were using
> >> finalize_object_file() instead of a pure rename() because the former
> >> also adjusts shared permissions.
> >
> > I thought the primary reason why we use finalize was because we
> > ignore EEXIST (and the assumption is that the files with the same
> > contents get the same name computed from their contents).
> >
> >>  	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
> >>  					midx_hash, WRITE_REV);
> >>
> >> -	if (finalize_object_file(tmp_file, buf.buf))
> >> +	if (rename(tmp_file, buf.buf))
> >>  		die(_("cannot store reverse index file"));
> >
> > Doesn't your new code die with it if buf.buf names an existing file?
>
> Ah, scratch that.  rename() discards the old one atomically, so as
> long as tmp_file and buf.buf are in the same directory (which I
> think it is in this case), we wouldn't be affected by the bug that
> is worked around with "Coda hack" in finalize_object_file(), either.

Exactly. In this case, we really did want to overwrite an existing .rev
file with the same name. That's because prior to this patch, we didn't
store the object order in the MIDX itself. That made it possible for us
to change the object order, but leave the MIDX checksum alone.

Then we'd keep the old .rev (with the old order, but the same name) in
place, if we used link(2) in order to try (and fail) to overwrite the
existing .rev with the new one.

Indeed, the temporary file created by write_rev_file_order() is written
in the pack directory, which is where the .rev file and MIDX will
ultimately live.

This code is going to be hidden behind a test knob in a few patches
anyway, but verifying all of this is good nonetheless (especially if you
just want to apply these first two patches into the v2.35 tree).

Thanks,
Taylor
