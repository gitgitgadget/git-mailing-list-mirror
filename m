Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAD6C7618E
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 02:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDWCkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 22:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDWCku (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 22:40:50 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931482100
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 19:40:49 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b980e16b27bso2039993276.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 19:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682217649; x=1684809649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cvNdgR37G1gXQprsUrA28aq21wWgeoHL582+V9P4+9w=;
        b=r9i92EHylpjcM1nL15a6sKpzi/47J9ieEtIEffvevrVe2NYLVxXdmAARiiN8qWOAJK
         pOnhNU/BeFdgKD364AX0M7D1PAV7pVWtYXS2mZprzHVu1mdnvOHUT73hyXx888R43Kb7
         8nYY+V1vA8sXBjk3wSmnrRBoDSljyuFwHDhkwOUiMZBgLskrn3nb8KkLFR3GlV2D3mP/
         meBlI/72RvGGd9W+rgcgLXFLr9Zf+DKkcB5aGyz3dEjJ0YcMaXN+prcoE3pMAL1B8Cr7
         LRPkw4KsvkDHKNoWkrx9zXgvf3HP6cBlPR57HOkJGwZLGnrdO2Cfs3f0hWPlErw1m7T1
         /HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682217649; x=1684809649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvNdgR37G1gXQprsUrA28aq21wWgeoHL582+V9P4+9w=;
        b=HbwXStkeYhyEqYibWS+FX7kmtmp4VSw137rB4QqIIkXr16H0zzNK4NoX1eLZPy93fq
         C2N4qz6aKBivMpyv/suuXUcA4WJCeTyHe7xHKOruoaS0olOEiZLPXHmCJHQ4gzZISvn0
         USrCA4wDSHH5Wk8oObtdJdFGC2cXczQpYV66P00hOYQBY8bRClebftgsazrh3CHlTNbs
         bhrfmdqRRg+hjtxkaA+4eKQHJe/Tfo6RzTkspB/F/SeWfAJ+1IMJN8HhJV7G2nI5VpdU
         vyPFDkXgteJtqzeWjjRFP9f2aNFSsXe60Y/ARw6wWsdCvQw4evFnB5jBRymI1lwDPE9W
         9VXQ==
X-Gm-Message-State: AAQBX9cstdFrbw+KxuCismxkuif37Iad1fDROakmsFlKaHQQ5c0UvKzI
        n2+BLVZnlveHsm6+CZS7xpFBkQ==
X-Google-Smtp-Source: AKy350ZuOSDqyjjXmqTlpmYW8kdbLNjZDBJYE+oZJKe+IcfcspCoB+EI/IP7PiZuJYaXcp3KtMkhew==
X-Received: by 2002:a25:c74d:0:b0:b99:7ef4:b452 with SMTP id w74-20020a25c74d000000b00b997ef4b452mr156676ybe.0.1682217648777;
        Sat, 22 Apr 2023 19:40:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v9-20020a816109000000b00552f7767803sm2027012ywb.58.2023.04.22.19.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 19:40:48 -0700 (PDT)
Date:   Sat, 22 Apr 2023 22:40:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] string-list: introduce
 `string_list_split_in_place_multi()`t
Message-ID: <ZESaryIvTOPiKWZK@nand.local>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
 <6658b231a906dde6acbe7ce156da693ef7dc40e6.1681845518.git.me@ttaylorr.com>
 <20230422111213.GB2969939@coredump.intra.peff.net>
 <ZESaFXMcP6mhtBOv@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZESaFXMcP6mhtBOv@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2023 at 10:38:13PM -0400, Taylor Blau wrote:
> > Obviously one solution is to add the "runs" option to all variants. But
> > I'd be hesitant to burden existing callers. So I'd propose one of:
> >
> >   1. Make your _1() function public, with a name like _with_options() or
> >      something (though the function name is sadly already quite long).
> >      Leave string_list_split_in_place() as a wrapper that behaves as
> >      now, and have the few new callers use the with_options() variant.
>
> I think that in general I'd prefer (2) to avoid polluting the list of
> declarations in string-list.h, but in this case I think that in this
> case it is the right thing to do.

Oh, nevermind. I just read René's solution below and it is much cleaner.
I take it back ;-).

Thanks,
Taylor
