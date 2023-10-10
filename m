Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C84BCD98C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 23:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbjJJXpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 19:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343880AbjJJXpv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 19:45:51 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19823E9
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 16:45:47 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66afd39c8edso26868296d6.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696981546; x=1697586346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yimBGiXd5/QopF8ohxN5AMlDmOxzil9+mJem6ToBDxE=;
        b=RMDwJUCPJ+6sbxYpGFQSJ2OTGbP6vB1PlfeS5qXxfjPzzZso6nNJe3L9GoCbPn0c6b
         MAzhXyniiIFBUL46u01HvultzZcL+PNqBxwc0ZNHrNZ8T9Nu1vnVTlHyqjq1yxlj4fHe
         5VjLsa5NoWkZu5LWaRWJjOxo/GZUr92vjoWx3k7dNQOb79doLV3JKrmsAvX+8OC5fS5o
         zpLPMYkbWJWNzz1dQzeP29XT6HtX7vupyhPXupd/Zo6oHK7rQDYGasnCMryPrEcBPGhi
         Ew8ZZzeVdTLfC7pXRWIxGV2FEp12gLIDFhlUmqxA6DF1FWbptfB93xXbPFvETprSb/EV
         J53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696981546; x=1697586346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yimBGiXd5/QopF8ohxN5AMlDmOxzil9+mJem6ToBDxE=;
        b=DcaFb1t8MCNr2eDTexrnynpd6YJo+6EddIj3Bm/x8SDZkXn3I0nvCStAeSRo6q0ToL
         HFdIJAzpbfGKyCtCyocRLlT1v/d05YdHB4OOGpd6IhKafMerWQr/87YBLIPxtJhGZCng
         vheS90WgU3zp4Me9msvmqGnju0nIw0v9daQ2+x/pW40HrCmtuN38ltumk6E8LFMxN2Zn
         LIbcaUffu92MBBl8J6Y/yfbTK1U6VKhN/U3HrhVm1vmY5aSC8qCNoxqXHgi0BBgMxEc4
         jLqnePbq/nlqjRhAbOwZy/R+teabCDYVWg7uSIjMhUBung5pn8ONu7vv+lPm+3O/XXWt
         9lqA==
X-Gm-Message-State: AOJu0YxO1Za6nrHLycaE2NnJu6DdOR2MAyyfGGzUAEu741VEghLxIQ7X
        L3mkU8K+ElZ/RCT04fZIkJj2jnmHHO9iD8W84Z8pgQ==
X-Google-Smtp-Source: AGHT+IGR4kSHmdhO0IE6s5az9cgTQU+TT/vWlpFdpH3OssRR4AzaNF4v3BwA0fj56T+jtBloftzBxw==
X-Received: by 2002:a0c:cd0f:0:b0:658:4cae:b43a with SMTP id b15-20020a0ccd0f000000b006584caeb43amr9321691qvm.4.1696981546149;
        Tue, 10 Oct 2023 16:45:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g14-20020a0cf84e000000b0066d02f0af01sm365192qvo.72.2023.10.10.16.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:45:44 -0700 (PDT)
Date:   Tue, 10 Oct 2023 19:45:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/20] chunk-format: note that pair_chunk() is unsafe
Message-ID: <ZSXiJZFnmpzAmuwx@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009205823.GA3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205823.GA3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 04:58:23PM -0400, Jeff King wrote:
> There are no callers of the "safe" version yet, but we'll add some in
> subsequent patches.

Makes sense.

> +int pair_chunk_unsafe(struct chunkfile *cf,
> +		      uint32_t chunk_id,
> +		      const unsigned char **p)
>  {
> -	return read_chunk(cf, chunk_id, pair_chunk_fn, p);
> +	size_t dummy;
> +	return pair_chunk(cf, chunk_id, p, &dummy);

I have always disliked functions that require you to pass a non-NULL
pointer to some value that you may or may not want to have that function
fill out. So I was going to suggest something along the lines of
"pair_chunk() should tolerate a NULL fourth argument instead of filling
out the size unconditionally".

But that's (a) the whole point of the series ;-), and (b) unnecessary,
since this function is going to go away entirely by the end of the
series, too.

So I think that the call you made here was the right one. The rest of
the patch all looks good to me, let's read on...

Thanks,
Taylor
