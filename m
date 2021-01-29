Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C03CC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D889E64DE2
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhA2BP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhA2BPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:15:25 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E99FC061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:14:45 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id w20so3425365qta.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BgRWo90UcTBr1HcrYe5wK6DCgXE+IlUo9vnhc/Mgigo=;
        b=TTx5T2v1d9EIXIQR6xmNOEOQXRhZSD8zWvapsO9E9te5S20FCIc0jsB5z/fCoTA5j7
         6CrE9DEeatSSH2c2RQv2s58oRYq7FCLcXgv4huEyWMTuJT+PWi+yVYZ/pCEwfcbFK1At
         P2q8KijF5iJUzPlTR7XcrAdd5g2zk0fvKrPBcUjoSWuXx3ilH5lk8pdDUCmDOvo/s4aP
         lPeEo7ulDzHSSZwQ62EQoU2ChfxfDmDMIyTBFMJQTtNppGkzXlLhgAWC9bqCRveRMCl6
         rxhu8Wo9xdecK5+t0FZ3J0D9iBBPZRKBWnVx/+5QQFIvzg62OYdghu5n1qgrka16k+mP
         qmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BgRWo90UcTBr1HcrYe5wK6DCgXE+IlUo9vnhc/Mgigo=;
        b=MDPOkTvDBf13WmlHEayokP3Bgr5g3BX9t7czryiAY3+1Yoc9yMzBO+TAZk02VQR0wT
         wGWfBMddMG6VBBlkX62bnjBlcSJ1vCKzp3pyT9h4rdCB0kxjS4iwd0hILpj7QVrQOD9g
         V8wwGwkEOT5+Gp4xniBT1GeIPd4kpN0CtQQBHAofsr1D6Te5CzbXs3K9fWkMEhSIV/0m
         9fl8BMoqmtJZyWnH3ha7t01qDwDYNslKTETJhSzZXwTNRPQ18ErMEwS6acbiSpdwPHf+
         6y07T3yzOR4C8zz43m3oUs0CGv+U25fxglo396rsHLtiob1esgyH58a+ieRT+UD3vUgB
         I+wA==
X-Gm-Message-State: AOAM533bq3lIzdLEYEJJrZzeJE+hwD0BKE/1l4V/mR6dF27f8dNzQFRh
        5BsUUu/wCfMQy4KCefnS+12w3g==
X-Google-Smtp-Source: ABdhPJwPY9Xu5VHt+GhKF+986Me8vSXJpvIN0TDL2JSTWl4wMgiC9jArzTzKuJsBY8vdNfwvtZKTbA==
X-Received: by 2002:ac8:5ac4:: with SMTP id d4mr2389286qtd.38.1611882884495;
        Thu, 28 Jan 2021 17:14:44 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5d6b:9c45:5e60:e7b4])
        by smtp.gmail.com with ESMTPSA id y67sm4763985qka.68.2021.01.28.17.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:14:43 -0800 (PST)
Date:   Thu, 28 Jan 2021 20:14:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 01/10] packfile: prepare for the existence of '*.rev'
 files
Message-ID: <YBNhgX1urWjnziEZ@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <6f8b70ab276c0579c957c315743fdab63462a605.1611617820.git.me@ttaylorr.com>
 <YBNWXU8xzw0087DC@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBNWXU8xzw0087DC@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 07:27:09PM -0500, Jeff King wrote:
> I guess this technique was pulled from the .idx code paths, but IMHO we
> should avoid this kind of struct-casting. It relies on the compiler's
> struct packing, and I'm not 100% sure it doesn't violate some weird
> pointer-aliasing rules.

Yeah, that's exactly where it came from. I briefly wondered about this
myself, but decided not to worry since (a) it closely follows an
existing pattern and (b) no compiler should ever pad anywhere but the
end of this struct since all other fields are aligned without padding.

> OTOH, as long as we do not ever care about sizeof(revindex_header), this
> is likely to work in practice, since every field is at least 4-byte
> aligned (but there is probably an extra 4 bytes of padding at the end).
>
> The "right" way is probably something like:
>
>   const char *header = data;
>   if (get_be32(header) != RIDX_SIGNATURE)
>           error...;
>   header += 4;
>   if (get_be32(header) != 1)
>           error...;
>   header += 4;
>   ...etc...

Makes sense.

> I thought we had helpers to read and advance the pointer, but it looks
> like those are specific to the bitmap code (e.g., read_be32(), though it
> uses a separate offset variable).
>
> I dunno. Maybe I am being overly picky. The .idx code already does it
> like this, and I believe the index (as in .git/index) does, too. We have
> run into problems (as in b5007211b6 (pack-bitmap: do not use gcc packed
> attribute, 2014-11-27)), but that was due to a more odd-sized struct, as
> well as using sizeof().

How about a set of follow-up patches to address all of these spots at
the same time? That would allow us to move forward here (which is safe
to do, as you note), and address all of these instances together
uniformly.

Sound good?

Thanks,
Taylor
