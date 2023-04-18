Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9072C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 14:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjDROzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjDROz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 10:55:29 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F378A27A
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:55:02 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54fbee98814so212908007b3.8
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681829701; x=1684421701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHBruOAHSJJ0f1JX8XQTEVYiFOA2PJL41lxU9zeXIM0=;
        b=VuQWkelZ/l24WvGr+ggQXnls0/qnt+R9B6GRnXD4ORwN9CNHs3hAhOFgufGR2iFiro
         aIJWQm4p0mcBQe8suLKpZqxTWENrabecwIHTSlTxeemtZI72PdWx/gv/g2GwMzwh6kbG
         owqQwME3NWIvHGmGhaT2GTvIuhG/XdfR/yvhtV66s3PAdYLVOQFuy4sSYGQNYIrqVkZv
         yKU/SUvLpFiQtMzEawFB1EcvzFvCUEv7GvUtz54zhnK2hjvQu7R2AGB30ABI1k6v1ceZ
         QPDGFfPL7gnluSRt0CQ95q9YD+tLrz9uXCzYQPEuXxEEnNiJmlHKMY1l4ZIgLYzL3Dc2
         45Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681829701; x=1684421701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHBruOAHSJJ0f1JX8XQTEVYiFOA2PJL41lxU9zeXIM0=;
        b=GT6IdzpS0dl5jGu6TWl7+Jd+jdSYxXNmg++RbbILxDdmEs4329hO6oJvjyPxCcelll
         4mP9+KOfPDy+cADJRwZWkrRTiJ8E4SqZo5eS2UQfjk7CmZ9Z8B/qdRjhR8oga22MHxhs
         dJItvQyq0z2/VNFy37T4MawFJSygZNp6d9v5jV3R47CbLBgirDiwouiyAFY0hUACCfXA
         Hmxq4Gg5cukGE5jAPUcEaXj3yUldpsm+wvzXeH1hjEAtHlvQrYEZyyeCfG7FWPsv9ZMx
         5WCNyMduEmujxLjy/e2w5jMNAHfeuYZ+h69SCZM0lfRo5ob4pbzwRWyzMS5JIIQPgejI
         9ofQ==
X-Gm-Message-State: AAQBX9fDaxVvRHJrYcnX0nanuIp7qj76hOpxs679KZPj0YMx9U5Za3y6
        FEJGrU66wkKNMQC3PNlGUeWASg==
X-Google-Smtp-Source: AKy350ZX/iMAqrkWxEq+aOMf7otiffU1prSCoEFlkjsUX6kFE5hPTJHXVLJA6bvH28kyg14HWSNzcQ==
X-Received: by 2002:a0d:fdc7:0:b0:54f:1b51:f4e8 with SMTP id n190-20020a0dfdc7000000b0054f1b51f4e8mr104780ywf.11.1681829700723;
        Tue, 18 Apr 2023 07:55:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id by7-20020a05690c082700b00545ef25cec6sm3810924ywb.105.2023.04.18.07.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 07:55:00 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:54:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: tb/enable-cruft-packs-by-default (was: Re: What's cooking in git.git
 (Apr 2023, #05; Mon, 17))
Message-ID: <ZD6vQ2wro8aQ/g+y@nand.local>
References: <xmqqfs8xfw25.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs8xfw25.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 01:12:34AM -0700, Junio C Hamano wrote:
> * tb/enable-cruft-packs-by-default (2023-04-17) 10 commits
>  - repository.h: drop unused `gc_cruft_packs`
>  - builtin/gc.c: make `gc.cruftPacks` enabled by default
>  - t/t6501-freshen-objects.sh: prepare for `gc --cruft` by default
>  - t/t6500-gc.sh: add additional test cases
>  - t/t6500-gc.sh: refactor cruft pack tests
>  - t/t9300-fast-import.sh: prepare for `gc --cruft` by default
>  - t/t5304-prune.sh: prepare for `gc --cruft` by default
>  - builtin/gc.c: ignore cruft packs with `--keep-largest-pack`
>  - builtin/repack.c: fix incorrect reference to '-C'
>  - pack-write.c: plug a leak in stage_tmp_packfiles()
>
>  source: <cover.1681764848.git.me@ttaylorr.com>

Peff took a look through this series in detail and made a handful of
suggestions. In [1] he suggested that none of these were significant
enough to warrant a reroll.

But if we're going to do it, let's do it right ;-). I'll send a (small)
reroll today that should be ready to go.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20230418110424.GD516715@coredump.intra.peff.net/
