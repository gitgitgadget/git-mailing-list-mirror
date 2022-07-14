Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF84C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 23:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiGNXPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 19:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbiGNXPj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 19:15:39 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060E470E53
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 16:15:37 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id r21so1972883qtn.11
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FsJfvIRiC7rhmAOKVYuZrAnaA3thiToH/Jg/VwsdKyQ=;
        b=ZVAx40BBbewYso0KA7r5dEV8VAyi/Evv+QqYdhAmjCAfqoEIdWjjdm1xVN/6Hj4l8o
         bQey8PILrNWQZ7vPAnnqIFD408hj+6OFhPz9XwRYibPc8SLJus4l76wf9VnkrYxYoan4
         PB0hhw2ynkrLiD1KBkXjEDGg3E+T1OuFbO2KnEotBe4Pw1yHyUE3+baEKKu/yuTnbbQ4
         d/nB5XoNIW8lxZyDSMCNw4MzQFLvbf8yoAnYRdMxXCpizbRWEvUNWh/tO+0ebX+OmPLa
         OpJ5lpJULam5NjZ1KJfMOC//FqYJFU/snr+IVbrJiMPm4V/CDH7zaBn6vSjAhLY+F7nw
         QpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FsJfvIRiC7rhmAOKVYuZrAnaA3thiToH/Jg/VwsdKyQ=;
        b=mMspCpVNEtknxb2dvpGcAqLtMK1JIPiBo6yNBESkl5LVtaTrDQe5LeebrkzwZD+vN8
         YuXFz1QhBqaaXTHUHXLBH3kyqkONuVDH7q8d3fXCmyy43vYrB9DyBlZtxTGsAFahXKYU
         n7lTChX/y+yX9Qtka1ISnd/2ERtCtgk0GNwHB1rzOtCf4jkT4QzB4RNrDq3WwglmYibf
         r2fZ9D1RQ0cpBA/sn8A3/gpKcwtqTKnIVjVNSBVvxPFiTAAILbNfgA59D3ImxyA5HOYN
         Qv4HnzrncsYPbKw++737Bg5CeC3gfBqIvwgNmNggZfxyBfI2AtJ5qs50ok7dbGfUoA5n
         D9FQ==
X-Gm-Message-State: AJIora/+1kCfn7ZKcAVNGYWLLbP9et46qHDLhQYhNAMrEjPJMRpY2sD8
        SsEo3IQgT/02d/TT6FEraRQ1XfYAcUuQtQ==
X-Google-Smtp-Source: AGRyM1vzrPCvp7xbSgzhEJ/mCMSNhsiZ/ksoj6barnWibZOaAW6cRUp0PgDOsTe+XHZnnbtqqcDYog==
X-Received: by 2002:a05:622a:188b:b0:31e:d1f5:bb4c with SMTP id v11-20020a05622a188b00b0031ed1f5bb4cmr4820777qtc.496.1657840536083;
        Thu, 14 Jul 2022 16:15:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b006a6d20386f6sm2606274qkn.42.2022.07.14.16.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 16:15:35 -0700 (PDT)
Date:   Thu, 14 Jul 2022 19:15:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/6] Documentation/technical: describe bitmap lookup
 table extension
Message-ID: <YtCjlkPdA3CUn/Aw@nand.local>
References: <ac52cfea-edb0-b68b-36e2-ab45d2959727@iee.email>
 <20220709075310.83848-1-chakrabortyabhradeep79@gmail.com>
 <d70a4505-60ef-82c4-5497-499ac788782a@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d70a4505-60ef-82c4-5497-499ac788782a@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10, 2022 at 04:01:11PM +0100, Philip Oakley wrote:
> >> Not sure if this is new in this extension, but should there be a link or
> >> two to the basics of XOR compression and some of the bitmap look up
> >> techniques?
> >>
> >> It's not always obvious if these techniques are 'heuristic' and only
> >> have partial commit data, or they have all the commits listed, Nor
> >> how/why they work. My point is more about giving new readers a hand-up
> >> in their understanding, rather than simple implementation details for
> >> those who already know what is going on. For example, are there any
> >> external articles that you found helpful in getting started that could
> >> be referenced somewhere in the docs?
> > As this series is only about adding a lookup-table extension (and not
> > about bitmap itself), I am not sure whether it's good to include those
> > things in this series.
>
> Thanks for the clarification. I must have slight misread some of the
> discussions and falsely thought it was the XOR compression (which is a
> technique I wasn't really aware of), that was being provided by the
> extension - Where would it be best for me to look up the background to
> your "extension" project?

Yeah, Abhradeep is right that the XOR compression isn't new, we already
serialize bitmaps with optional XOR offsets. The gist is that we give an
offset of some previous bitmap that is used to compress the current one
by XORing the bits in the current bitamp with the previous one. These
XOR-compressed bitmaps are often sparse, so they compress well and
reduce the overall size of the .bitmap.

A slightly more detailed overview can be found in
Documentation/technical/bitmap-format.txt under the bullet point reading
"1-byte XOR-offset".

Thanks,
Taylor
