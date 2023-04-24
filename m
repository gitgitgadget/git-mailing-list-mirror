Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDF8C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 23:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjDXXAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 19:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDXXAW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 19:00:22 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D46E82
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 16:00:21 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b8f5276baa3so3763646276.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 16:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682377220; x=1684969220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jys5HQ+1Pz9I+/kFVk1eQcys4JvJOt4FyzUqSyqQ7cg=;
        b=mn42NZpZebpZFxjmRQ5anwkojBUYbR15KYN0vDwlVvHJ2P4P/MPXfq4Fx8xkOZdOfu
         Igi/18ObbY5remdGhFymaoyW0vqiBNucqsdLA0taGYJVQpbFiefs/Ka14T/TJ0zgxkqE
         e52O2KjLJF0SePxEtMw//C8nxJpI44mhmj8vbaVFpSLp1PQ7feSrxp0qBI4RfpDptS1A
         2DhP8Pmiypq0PF54s9Cfq0QnkeyCfXZHh9zaz5vlzvLHJ5DdaCR9XFt4XzW5GV7FPBZX
         brapHk9oMH9XuyRPChjEWM8a+A8brKXSjSiC5PJwo95mKBQGsGrVvmBXYB04scxVlq2u
         3SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682377220; x=1684969220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jys5HQ+1Pz9I+/kFVk1eQcys4JvJOt4FyzUqSyqQ7cg=;
        b=FU5b/A6GXUG6m6KYOIidT//YcdYcNucmsB0ADv/S07991usoW+TSjkTAak8OX4QfMd
         sozcihOfnyL3nxmD7kI9FGlpodJ45YIFu7EzRvn65UpvFpS11M83s69CiESy9p7lWFuL
         gpfIzeeFOvQyzB34e1ddHNpn3DQ95PcMy2V1KMagkHustHjzcAhbCOVtMmFKbEs28Khm
         OR95O4O/Qo1If8R0lBArWfp9TXkAGuPwv4bZFGFlutaPBlZP8Bi4Dnat1fLAjpCT6JN/
         xvCOnubfeJmtcqyMY3SvX7cxwLDMeEgO367/YlVlg2LGJfQ8bgKET3NyCEszYJnkxllW
         QEfA==
X-Gm-Message-State: AAQBX9c8jJgWNGNpMsgseNrTMwnBeK+F3MvuK1S+OhMQ+72X20WIxN0S
        2pifPkehLm7FEg78pKO9gukHvQ==
X-Google-Smtp-Source: AKy350ZjS65B9KwvM1ooL3gRDu9JyLnEyUpNVhdzydHXpTQWigXeh480jEnDppvE6SC2uy7fNlXIcw==
X-Received: by 2002:a0d:d541:0:b0:54f:cbaf:36d with SMTP id x62-20020a0dd541000000b0054fcbaf036dmr8187503ywd.35.1682377220528;
        Mon, 24 Apr 2023 16:00:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r6-20020a0de806000000b0054c055b8ffcsm3226582ywe.41.2023.04.24.16.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 16:00:20 -0700 (PDT)
Date:   Mon, 24 Apr 2023 19:00:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 6/6] banned.h: mark `strtok()` and `strtok_r()` as
 banned
Message-ID: <ZEcKAzwtOUKF14nV@nand.local>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
 <da896aa358eab65f2629f85189c5be4ad9cec635.1682374789.git.me@ttaylorr.com>
 <CAPx1GvdHWBdA8XZu8ZHf3PO3QC5qVpb9UdNMG9Xegyk_9ZtHwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx1GvdHWBdA8XZu8ZHf3PO3QC5qVpb9UdNMG9Xegyk_9ZtHwg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 03:25:55PM -0700, Chris Torek wrote:
> I eyeballed the whole thing (not the same as real tests of course)
> and it looks good, but there's one typo (missing-word-o) here of note:
>
> On Mon, Apr 24, 2023 at 3:20 PM Taylor Blau <me@ttaylorr.com> wrote:
> ...
> > But there are no instances of this in Git's tree which are more
> > well-suited to `strtok_r()` than the friendlier
> > `string_list_in_place()`, so ban `strtok_r()`, too.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
> Missing `split_`. Probably not worth a re-roll...

Oops, thanks for noticing.

Thanks,
Taylor
