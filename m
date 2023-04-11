Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94636C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 21:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDKVZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 17:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDKVZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 17:25:16 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7FA1BE8
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:25:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id q5so12557784ybk.7
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681248314; x=1683840314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k97mKFtcW+h3pnwJIzs0ZQjCsH+PsyptdSgmztNf75I=;
        b=V96/jGo5JSi+P89CWxCdIH2LMrEDPQuZARUJdw2Ji8kckSseE5JXHZ6ARBdId5IEoV
         UZgB/JB3REclpQQUxFXwOmXAiFRXV40eolgGFMdYIH2dYo9D9jM/h0jZBy3btO0b0iXu
         s04TXYZs9mXV/pBpZGl2viKQtKVUjpALkQT9uL/D2vChco9TDRFuroBDrXr1MPxvvMFv
         nP2e3UJ8Rb0vXL0382kwQ7zu9t4FSDEyMVlH4fVW1+d1UwC+WdQC0FVfPOKvaKDA8TYz
         ++cM0c6cumjqm2odQN+6j+p4w9BpVj3QC0R170o+l208fItC0QJmY2ma07fYIRFXslIB
         PFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681248314; x=1683840314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k97mKFtcW+h3pnwJIzs0ZQjCsH+PsyptdSgmztNf75I=;
        b=zv81ui5lDPjKHnl5nTFNIHg9BCfJgYnDhEgEKLqQUZGv4jAN0l427nF5ksXx5aomK3
         +J/KmHQi0+oG5mTlzmWr6EhRBEu3ldgkJk0S3GUWa0TxW/i2ht9PFCmICz9rS/X1sLOG
         8f0aNlMG+TcSa9IzZJEa8zNiM1yPI18nZ4mnrMNRYBySzO/wGU9ID9LrELy+4ScV5lK+
         8f1j0aCf/hEk3sdIuYVcl0ZTnLGVJH+JueRuAQNxPVo03JZ7v0X3OVMzvTLEN6Kwb78X
         XSlO6IGDRaqd9eIJ8qq0P9uvpWW8mVS423+ZULSEAyj/LdT8K48b8Gw1U5Giijis6kyb
         tpbw==
X-Gm-Message-State: AAQBX9dM2nCNhC5vNn8uHs18lzfAPMlypAe+KkL5N+VdMfniZWgu5tZo
        BL452eo3LU09FeTq58bSo4Ls3w==
X-Google-Smtp-Source: AKy350aF1nd2I36A1QwDkeStA3t6d1XV5m/epPvGaeR6M/BS05eHvNERPH2F7SPl1tgAtwZN90cqzw==
X-Received: by 2002:a25:5006:0:b0:b86:8209:8671 with SMTP id e6-20020a255006000000b00b8682098671mr551729ybb.12.1681248314219;
        Tue, 11 Apr 2023 14:25:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 128-20020a251586000000b00b7d2204cd4bsm3892769ybv.21.2023.04.11.14.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 14:25:13 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:25:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] pack-write.c: plug a leak in stage_tmp_packfiles()
Message-ID: <ZDXQOIRqHdV7ONcN@nand.local>
References: <cover.1681166596.git.me@ttaylorr.com>
 <18be29c3988295cd58521f8cc4a729897df074c8.1681166596.git.me@ttaylorr.com>
 <423b5c5c-ef86-198a-16f7-c836ed78928c@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <423b5c5c-ef86-198a-16f7-c836ed78928c@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 09:23:31AM -0400, Derrick Stolee wrote:
> On 4/10/2023 6:53 PM, Taylor Blau wrote:
>
> > Instead, simply free() `rev_tmp_name` at the end of
> > `stage_tmp_packfiles()`.
>
> > @@ -568,6 +568,8 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
> >  		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
> >  	if (mtimes_tmp_name)
> >  		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");
> > +
> > +	free((char *)rev_tmp_name);
>
> Just cut off from the context is a "if (rev_tmp_name)", so it might be
> good to group this into that block, since we have the condition, anyway.

Definitely possible, though FWIW it's fine to have this free()
positioned at the end of the function, since we initialize rev_tmp_name
to NULL (making this a noop when not writing an on-disk reverse index).

> But I was also thinking about how we like to use "const" as an indicator
> as "I am not responsible for free()ing this". And this comes from the
> public write_rev_file() method. Based on the API prototype, we could
> think that this string is held by a static strbuf (making the method
> not reentrant, but that happens sometimes in our methods). But generally,
> I wanted to inspect what it would take to make the API reflect the fact
> that it can return a "new" string.
>
> But there are two issues:
>
>  1. The actual logic is inside write_rev_file_order(), so that API
>     needs to change, too.
>
>  2. The "new" string is created only if the rev_name parameter is
>     NULL, which is somewhat understandable but still requires
>     inside knowledge about the implementation to make that choice.
>
>  3. If we inspect the callers to these methods, only one caller
>     passes a non-null name: builtin/index-pack.c. The rest pass NULL,
>     including write_midx_reverse_index() (which then leaks the name).
>
> The below diff includes my attempt to change the API to return a
> non-const string that must be freed by the callers.

I like this direction. I think that all things being equal (and unless
you feel strongly about it in the meantime), I'd just as soon pursue
this as a "fast follow" to avoid intermixing this API change with the
primary intent of this series.

In the meantime, dropping the const via a cast down to "char *" works
fine to plug the leak here.

Thanks,
Taylor
