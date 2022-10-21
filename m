Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FBCC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 01:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJUBjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 21:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJUBjB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 21:39:01 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5765A23082B
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 18:39:00 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id u2so897183ilv.6
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 18:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EX6u9oCHhoMdG4KgVqZBSGxxEF/oPpfQgOWs1Eh2JYQ=;
        b=uAX9vTYXgCIvdLtdnWong3cNPAuA69aLpwzgI0gQYAOPTs06ad7LxbToC3QRC5JhB0
         bIAOpEh8BXq4SKxLUQTNnE7Eq7ZIxoSup1B2yQyeboxtAkOhENgRBmFSzVlE1ZQVtvM7
         akWC3/VrtTXz9Wk4Va7BFb5xhaXeQYsaGPXF19kb7ASVE9G2V4itVEpso5V/Mi44nIRL
         Lq74SlyjlVCY361MrIusHJGyozEjP2CzMkm3IVGjbeMx+FfvNC3wH8cTlVB45OAzcxru
         8QduZ2ccUnQT4jOyXmWZuknzfzYYpmDL4NeIwj71UUCS4KeNpJ/HY1dRQXM00YpzYbrj
         7k2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX6u9oCHhoMdG4KgVqZBSGxxEF/oPpfQgOWs1Eh2JYQ=;
        b=YWfqylDN8MWqJ/wT4GmaF//IiNzIBLFGz1RvLM49AV8J4QoC7dLIx45UH97YhuEbsx
         TmOw4iNMDmQBtOKOIQhtybFZp0qbbD87rzIJx9aNMXN3VXId0iWN6AAD3axzLSIf0gtA
         Ge5hd01Gz+OzvqyZgSGnOXK7OUytSZJwq5TvyYrQ3LHIMLT2eZfcMvcE+R4aLP9P61hB
         2pXS+Us27UsSdRSc458Ihn1xEu2inSWg1BoR2ng/FbXCIpWpcKyhTbOg4N5QVDBbsd90
         unCBoeOExovMMLWijvHRtjRLn0/gxnl5BcM75wM7Or1vcMgpEYK0U3jR+NDGmFk/RYDD
         /MZg==
X-Gm-Message-State: ACrzQf2ekDNJTSz32i06J+/1fe4NupxXbA5UtB2eS5RprC7ILgCDPsPz
        biS7LLJHi/SrXZkxcvJcBH1hJNXL+UIiJ042
X-Google-Smtp-Source: AMsMyM4KeTqa6PmqbyeWLjMYnA7kouxRCa5UGgyFCsE3p/pnVNSeXRNxk+GlF87czkIoAhDGFDUBkA==
X-Received: by 2002:a05:6e02:1549:b0:2fa:f6e3:e2c8 with SMTP id j9-20020a056e02154900b002faf6e3e2c8mr11614971ilu.252.1666316339732;
        Thu, 20 Oct 2022 18:38:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c10-20020a023f4a000000b00362a6fd6acbsm3692680jaf.32.2022.10.20.18.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 18:38:59 -0700 (PDT)
Date:   Thu, 20 Oct 2022 21:38:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 7/7] shortlog: implement `--group=trailer` in terms of
 `--group=<format>`
Message-ID: <Y1H4MeYXv06mjKg0@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <02adc297e7661cbc25302b9f5659d2356b8b5008.1665448437.git.me@ttaylorr.com>
 <Y0TL8unKev9TPytJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TL8unKev9TPytJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 09:50:42PM -0400, Jeff King wrote:
> Hmph. So that's _probably_ OK, but I have to wonder if this is going too
> far. The resulting code is not that much shorter, and IMHO is actually a
> little more complicated, because of this hack and the extra util bit.

Thanks for a careful analysis, as always. "Additional complexity" and
"slower" are both usually not worth it in isolation, but it's definitely
difficult to advocate for doing both at the same time ;-).

Let's drop this patch and let the `--group=trailer` bits continue to
benefit from your optimizations.

Thanks,
Taylor
