Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E05EC433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 02:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3BF20838
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 02:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="pgxRoZgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgIGCbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 22:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgIGCa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 22:30:59 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D4C061573
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 19:30:58 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so11573571qke.8
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QD+nDNHGlQmsp08zmli/8j0goUAOENPNLc1ie++y4t8=;
        b=pgxRoZgqaNrPIg+eFnTk1w7BQ+NllGnmM8cWi1d2Mda6h3UUbVYLijosMCYj68FJEJ
         ttAD657d3ajdW0Kc23zuQNBLxDLglazdcfIK/L5ku2b9kEWoa5XYTMMFeumYPUmy1drF
         oWNDI2K3hsYd89F3bisFeg8ZmEZDeTszr5Esztt8l6Wbnu4P3G0Q2l9wFY+s79Cm1Shf
         2QyHOrgCUvxjS7oww17d4TBXMTXLM6uqlpe39tPMIDJLx6rD2xGMaZtlH+lOQI9CnF4G
         GiklrzaqNsQap7CJusnUF7IubR/Oe9uNvPVkgPYmhWDxq7W/x0O4paeRSGitrwLc+aCc
         gohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QD+nDNHGlQmsp08zmli/8j0goUAOENPNLc1ie++y4t8=;
        b=IOu+5i7S9Ed/zzguYlvdlm0AO/5A8TVtsfVFa2rZAP7A9BLBEF9um43efEzqUtr2l+
         PZR+jOHfT9fi1OY/YxrGrxiFwHA5lkeQS0su2y27OYz0hxullGOu9nmG+929UtDC8Dlz
         RdfHvFCriTf15KD6DoCIguaHC/1M11VwQY2FqwUOOkfgC1Mhbix8Nzf5/tQtDS53V6ut
         yJTpKHrBHcdVR+w8uQER4PEZNqFCwvTD0Opx5E7L63aoqEydE5MdUA1a7uctKlKCsUvS
         aGc+UhRTn+xJJabXbOMz1AEw/eWZMcC/Hx11mZI4DClEVMGL/xhrdHTa9urxasgGeFgh
         P+Cw==
X-Gm-Message-State: AOAM533SxgplStFL/aV8XHkaznLmFTJ4YUmEixn7QdSnLU5l2ctIzGIU
        Bu2Tzmm0bY6dX6UM9enfwPKjQA==
X-Google-Smtp-Source: ABdhPJyoNji1tDS4GdfqOmuslK0B3vyOfMRgrkxfhtXrjgZf1ndyWqWEVORuaUAVPBiF+58aSRa0sg==
X-Received: by 2002:a37:7182:: with SMTP id m124mr16836700qkc.37.1599445851051;
        Sun, 06 Sep 2020 19:30:51 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2928:8cf2:b0f6:adfd])
        by smtp.gmail.com with ESMTPSA id t1sm5500881qkf.68.2020.09.06.19.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 19:30:50 -0700 (PDT)
Date:   Sun, 6 Sep 2020 22:30:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-bitmap-write: use hashwrite_be32() in
 write_hash_cache()
Message-ID: <20200907023047.GA16196@nand.local>
References: <1143b9e0-3adf-095f-78cf-2f8d8c2bd368@web.de>
 <20200906190235.GA6146@nand.local>
 <20200907022340.GA1208024@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200907022340.GA1208024@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 06, 2020 at 10:23:40PM -0400, Jeff King wrote:
> On Sun, Sep 06, 2020 at 03:02:35PM -0400, Taylor Blau wrote:
>
> > On Sun, Sep 06, 2020 at 10:59:06AM +0200, René Scharfe wrote:
> > > -		uint32_t hash_value = htonl(entry->hash);
> > > -		hashwrite(f, &hash_value, sizeof(hash_value));
> > > +		hashwrite_be32(f, entry->hash);
> >
> > This is an obviously correct translation of what's already written, and
> > indeed it is shorter and easier to read.
> >
> > Unfortunately, I think there is some more subtlety here since the hash
> > cache isn't guarenteed to be aligned, and so blindly calling htonl()
> > (either directly in write_hash_cache(), or indirectly in
> > hashwrite_be32()) might cause tools like ASan to complain when loading
> > data on architectures that don't support fast unaligned reads.
>
> I think the alignment here is fine. We're just writing out an individual
> value. So in the original entry->hash and our local hash_value are both
> properly aligned, since they're declared as uint32_t. We pass the
> pointer to hashwrite(), but it doesn't expect any particular alignment.
> After the patch, the situation is the same, except that we're working
> with the uint32_t parameter to hashwrite_be32(), which is also properly
> aligned.

Ack; I would blame it on skimming the patch, but this is far too obvious
for that. The bug is on the *reading* end in GitHub's fork, and in a
(custom) extension (which it looks like you describe below).
Embarrassing.

> > So, I think that we could do one of three things, depending on how much
> > you care about improving this case ;-).
> >
> >   - leave your patch alone, accepting that this case which was broken
> >     before will remain broken, and leave it as #leftoverbits
>
> So I think this is what we should do. :)

Yep, this patch is correct as-is.

> >   - change the 'hashwrite_beXX()' implementations to use the correct
> >     'get_beXX' wrappers which behave like htonl() on architectures with
> >     fast unaligned loads, and fall back to byte reads and shifts on
> >     architectures that don't.
>
> Likewise, I don't think there's any reason to do this. hashwrite_be32()
> gets its parameter as a value, not a pointer. So even if it were coming
> from an unaligned mmap, it's actually the _caller_ who would have to
> use get_be32() when passing it.

Right.

> > Credit goes to Peff for finding this issue in GitHub's fork. For what
> > it's worth, we were planning on sending those patches to the list soon,
> > but they are tied up with a longer series in the meantime.
>
> There is a bug in our fork, but I don't think it's upstream. [...]

Agreed with all of that, too.


Taylor
